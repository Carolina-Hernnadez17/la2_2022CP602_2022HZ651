/*
 * DiagnosticoServlet.java
 */
package servlet;

import clases.Enfermedad;
import clases.Sintoma;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DiagnosticoServlet", urlPatterns = {"/DiagnosticoServlet"})
public class DiagnosticoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recuperar enfermedades y síntomas de sesión
        HttpSession session = request.getSession();
        List<Enfermedad> enfermedades = (List<Enfermedad>) session.getAttribute("enfermedades");
        List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");

        List<String> resultadoExacto = new ArrayList<>();
        List<Map.Entry<String, Double>> resultadoParcial = new ArrayList<>();

        // Síntomas reportados por el paciente
        List<String> sintomasPaciente = new ArrayList<>();
        for (Sintoma s : sintomas) {
            if ("on".equals(request.getParameter("paciente_" + s.getNombre_sintoma()))) {
                sintomasPaciente.add(s.getNombre_sintoma());
            }
        }

        // Evaluar cada enfermedad
        for (Enfermedad e : enfermedades) {
            boolean coincideExacto = true;
            int sintomasCoincidentes = 0;
            int total = e.getSintomas().size();

            for (Map.Entry<String, Boolean> entry : e.getSintomas().entrySet()) {
                boolean presenteEnfermedad = entry.getValue();
                boolean presentePaciente = sintomasPaciente.contains(entry.getKey());

                // Contar solo los síntomas que la enfermedad tiene y el paciente reporta
                if (presenteEnfermedad && presentePaciente) {
                    sintomasCoincidentes++;
                }

                // Si algún síntoma de la enfermedad no coincide con el paciente, no es exacto
                if (presenteEnfermedad != presentePaciente) {
                    coincideExacto = false;
                }
            }

            // Calcular porcentaje de confianza
            double confianza = ((double) sintomasCoincidentes / total) * 100;

            if (coincideExacto) {
                resultadoExacto.add(e.getNombre());
            } else if (confianza > 0) {
                resultadoParcial.add(new AbstractMap.SimpleEntry<>(e.getNombre(), confianza));
            }
        }

        // Ordenar resultados parciales y limitar a top 3
        resultadoParcial.sort((a, b) -> Double.compare(b.getValue(), a.getValue()));
        if (resultadoParcial.size() > 3) {
            resultadoParcial = resultadoParcial.subList(0, 3);
        }

        // Guardar en request para mostrar en diagnostico.jsp
        request.setAttribute("resultadoExacto", resultadoExacto);
        request.setAttribute("resultadoParcial", resultadoParcial);

        // Guardar en sesión para uso en PacienteServlet
        if (!resultadoExacto.isEmpty()) {
            session.setAttribute("ultimoDiagnostico", resultadoExacto.get(0));
            session.removeAttribute("ultimaProbabilidad");
        } else if (!resultadoParcial.isEmpty()) {
            Map<String, Double> probabilidades = new HashMap<>();
            for (Map.Entry<String, Double> entry : resultadoParcial) {
                probabilidades.put(entry.getKey(), entry.getValue());
            }
            session.setAttribute("ultimaProbabilidad", probabilidades);
            session.removeAttribute("ultimoDiagnostico");
        } else {
            session.removeAttribute("ultimoDiagnostico");
            session.removeAttribute("ultimaProbabilidad");
        }

        // Redirigir a la vista de resultados
        request.getRequestDispatcher("diagnostico.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que procesa síntomas y determina diagnóstico con porcentaje de confianza correcto";
    }
}