/*
 * DiagnosticoServlet.java
 */
package servlet;

import clases.Diagnostico;
import clases.Enfermedad;
import clases.Paciente;
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

        HttpSession session = request.getSession();

        // Recuperar enfermedades y síntomas de sesión
        List<Enfermedad> enfermedades = (List<Enfermedad>) session.getAttribute("enfermedades");
        List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");

        if (enfermedades == null) enfermedades = new ArrayList<>();
        if (sintomas == null) sintomas = new ArrayList<>();

        // Síntomas reportados por el paciente
        List<String> sintomasPaciente = new ArrayList<>();
        for (Sintoma s : sintomas) {
            if ("on".equals(request.getParameter("paciente_" + s.getNombre_sintoma()))) {
                sintomasPaciente.add(s.getNombre_sintoma());
            }
        }

        List<String> resultadoExacto = new ArrayList<>();
        List<Map.Entry<String, Double>> resultadoParcial = new ArrayList<>();

        // Evaluar cada enfermedad
        for (Enfermedad e : enfermedades) {
            boolean coincideExacto = true;
            int sintomasCoincidentes = 0;
            int total = e.getSintomas().size();

            for (Map.Entry<String, Boolean> entry : e.getSintomas().entrySet()) {
                boolean presenteEnfermedad = entry.getValue();
                boolean presentePaciente = sintomasPaciente.contains(entry.getKey());

                if (presenteEnfermedad && presentePaciente) {
                    sintomasCoincidentes++;
                }
                if (presenteEnfermedad != presentePaciente) {
                    coincideExacto = false;
                }
            }

            double confianza = total > 0 ? ((double) sintomasCoincidentes / total) * 100 : 0;

            if (coincideExacto) resultadoExacto.add(e.getNombre());
            else if (confianza > 0) resultadoParcial.add(new AbstractMap.SimpleEntry<>(e.getNombre(), confianza));
        }

        // Ordenar resultados parciales y limitar a top 3
        resultadoParcial.sort((a, b) -> Double.compare(b.getValue(), a.getValue()));
        if (resultadoParcial.size() > 3) resultadoParcial = resultadoParcial.subList(0, 3);

        // Guardar resultados para diagnostico.jsp
        request.setAttribute("resultadoExacto", resultadoExacto);
        request.setAttribute("resultadoParcial", resultadoParcial);

        // Recuperar historial desde sesión
        List<Diagnostico> historial = (List<Diagnostico>) session.getAttribute("historial");
        if (historial == null) historial = new ArrayList<>();

        // Recuperar paciente actual
        Paciente paciente = (Paciente) session.getAttribute("pacienteActual");

        // Guardar diagnóstico en historial
        if (!resultadoExacto.isEmpty()) {
            historial.add(new Diagnostico(paciente, resultadoExacto.get(0), true, 100));
        } else if (!resultadoParcial.isEmpty()) {
            Map.Entry<String, Double> mejor = resultadoParcial.get(0);
            historial.add(new Diagnostico(paciente, mejor.getKey(), false, mejor.getValue()));
        }

        session.setAttribute("historial", historial);

        // Guardar último diagnóstico en sesión
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

        // Guardar paciente en la lista de pacientes
        List<Paciente> pacientes = (List<Paciente>) session.getAttribute("pacientes");
        if (pacientes == null) pacientes = new ArrayList<>();
        pacientes.add(paciente);
        session.setAttribute("pacientes", pacientes);

        // Guardar estadísticas generales
        int numPacientes = pacientes.size();
        int numEnfermedades = enfermedades.size();
        int numSintomas = sintomas.size();
        int numDiagnosticos = historial.size();

        String enfMasDiagnosticada = "";
        int exactos = 0, parciales = 0;
        double sumaConfParciales = 0;

        if (!historial.isEmpty()) {
            Map<String, Integer> conteo = new HashMap<>();
            for (Diagnostico d : historial) {
                // Conteo enfermedades
                conteo.put(d.getEnfermedad(), conteo.getOrDefault(d.getEnfermedad(), 0) + 1);
                // Exactos o parciales
                if (d.isExacto()) exactos++;
                else {
                    parciales++;
                    sumaConfParciales += d.getConfianza();
                }
            }
            enfMasDiagnosticada = conteo.entrySet().stream()
                                        .max(Map.Entry.comparingByValue())
                                        .get()
                                        .getKey();
        }

        double promConfParciales = parciales > 0 ? sumaConfParciales / parciales : 0;

        session.setAttribute("numPacientes", numPacientes);
        session.setAttribute("numEnfermedades", numEnfermedades);
        session.setAttribute("numDiagnosticos", numDiagnosticos);
        session.setAttribute("numSintomas", numSintomas);
        session.setAttribute("enfMasDiagnosticada", enfMasDiagnosticada);
        session.setAttribute("exactos", exactos);
        session.setAttribute("parciales", parciales);
        session.setAttribute("promConfParciales", promConfParciales);

        // Redirigir a diagnostico.jsp
        request.getRequestDispatcher("diagnostico.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que procesa síntomas y genera diagnóstico y estadísticas";
    }
}
