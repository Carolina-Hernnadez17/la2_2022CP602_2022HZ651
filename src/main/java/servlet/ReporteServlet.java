package servlets;

import clases.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "ReporteServlet", urlPatterns = {"/ReporteServlet"})
public class ReporteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();

        // Recuperar listas de la sesión
        List<Paciente> pacientes = (List<Paciente>) session.getAttribute("pacientes");
        List<Enfermedad> enfermedades = (List<Enfermedad>) session.getAttribute("enfermedades");
        List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");
        List<Diagnostico> historial = (List<Diagnostico>) session.getAttribute("historial");

        if (pacientes == null) pacientes = new ArrayList<>();
        if (enfermedades == null) enfermedades = new ArrayList<>();
        if (sintomas == null) sintomas = new ArrayList<>();
        if (historial == null) historial = new ArrayList<>();

        int totalPacientes = 0;
        for (int i = 0; i < pacientes.size(); i++) {
            totalPacientes++;
        }
         int totalEnfermedades = 0;
        for (int i = 0; i < enfermedades.size(); i++) {
            totalEnfermedades++;
        }


        // ============================
        // Estadísticas Generales
        // ============================
        int numPacientes = pacientes.size();
        int numEnfermedades = enfermedades.size();
        int numSintomas = sintomas.size();
        int numDiagnosticos = historial.size();

        // Conteo de enfermedades más diagnosticadas
        Map<String, Long> conteoEnfermedades = historial.stream()
                .collect(Collectors.groupingBy(Diagnostico::getEnfermedad, Collectors.counting()));

        String enfMasDiagnosticada = conteoEnfermedades.isEmpty() ?
                "Ninguna" :
                Collections.max(conteoEnfermedades.entrySet(), Map.Entry.comparingByValue()).getKey();

        // Conteo exactos vs parciales + promedio confianza parciales
        long exactos = historial.stream().filter(Diagnostico::isExacto).count();
        long parciales = numDiagnosticos - exactos;

        double promConfParciales = historial.stream()
                .filter(d -> !d.isExacto())
                .mapToDouble(Diagnostico::getConfianza)
                .average()
                .orElse(0.0);

        // ============================
        // Conteo por Paciente
        // ============================
        Map<String, Map<String, Long>> conteoPorPaciente = new HashMap<>();
        for (Diagnostico d : historial) {
            String nombrePaciente = d.getPaciente().getNombre();
            String enfermedad = d.getEnfermedad();

            conteoPorPaciente.putIfAbsent(nombrePaciente, new HashMap<>());
            Map<String, Long> enfermedadesPaciente = conteoPorPaciente.get(nombrePaciente);

            enfermedadesPaciente.put(enfermedad,
                    enfermedadesPaciente.getOrDefault(enfermedad, 0L) + 1);
        }

        // ============================
        // Guardar en request
        // ============================
        request.setAttribute("numPacientes", totalPacientes);
        request.setAttribute("numEnfermedades", numEnfermedades);
        request.setAttribute("numSintomas", numSintomas);
        request.setAttribute("numDiagnosticos", numDiagnosticos);
        request.setAttribute("enfMasDiagnosticada", enfMasDiagnosticada);
        request.setAttribute("exactos", exactos);
        request.setAttribute("parciales", parciales);
        request.setAttribute("promConfParciales", String.format("%.2f", promConfParciales));

        request.setAttribute("conteoPorPaciente", conteoPorPaciente);
        request.setAttribute("enfermedades", enfermedades);
        request.setAttribute("sintomas", sintomas);

        // Redirigir al JSP
        request.getRequestDispatcher("reporte.jsp").forward(request, response);
    }
}
