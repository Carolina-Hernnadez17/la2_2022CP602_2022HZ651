/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import clases.Enfermedad;
import clases.Paciente;
import clases.Sintoma;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author gutie
 */
@WebServlet(name = "PacienteServlet", urlPatterns = {"/PacienteServlet"})
public class PacienteServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        List<Enfermedad> enfermedades = (List<Enfermedad>) session.getAttribute("enfermedades");
        List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");
        List<Paciente> pacientes = (List<Paciente>) session.getAttribute("pacientes");
        if (pacientes == null) pacientes = new ArrayList<>();

        // Datos del paciente
        String nombre = request.getParameter("nombre");
        int edad = Integer.parseInt(request.getParameter("edad"));
        String id = String.valueOf(pacientes.size() + 1);

        Paciente paciente = new Paciente(id, nombre, edad);

        // Síntomas marcados por el paciente
        List<String> sintomasPaciente = new ArrayList<>();
        for (Sintoma s : sintomas) {
            // CORRIGIENDO EL PARÁMETRO: debe ser "sintoma_" no "paciente_"
            if ("on".equals(request.getParameter("sintoma_" + s.getNombre_sintoma()))) {
                sintomasPaciente.add(s.getNombre_sintoma());
            }
        }

        // Diagnóstico
        String diagnosticoExacto = null;
        Map<String, Double> probables = new LinkedHashMap<>();

        for (Enfermedad e : enfermedades) {
            // Obtener síntomas que la enfermedad debe tener (true)
            List<String> sintomasEnfermedad = new ArrayList<>();
            for (Map.Entry<String, Boolean> entry : e.getSintomas().entrySet()) {
                if (entry.getValue()) {  // Solo los síntomas que están presentes en la enfermedad
                    sintomasEnfermedad.add(entry.getKey());
                }
            }

            // Verificar coincidencia exacta
            boolean esCoincidenciaExacta = sintomasEnfermedad.size() == sintomasPaciente.size() &&
                                          sintomasEnfermedad.containsAll(sintomasPaciente) &&
                                          sintomasPaciente.containsAll(sintomasEnfermedad);

            if (esCoincidenciaExacta) {
                diagnosticoExacto = e.getNombre();
                break;  // Encontramos coincidencia exacta, no necesitamos seguir
            } else {
                // Calcular porcentaje de coincidencia parcial
                int coincidencias = 0;
                for (String sintomaPaciente : sintomasPaciente) {
                    if (sintomasEnfermedad.contains(sintomaPaciente)) {
                        coincidencias++;
                    }
                }

                if (coincidencias > 0) {
                    double confianza = ((double) coincidencias / sintomasEnfermedad.size()) * 100;
                    probables.put(e.getNombre(), confianza);
                }
            }
        }

        // Asignar diagnóstico al paciente
        if (diagnosticoExacto != null) {
            paciente.setDiagnostico(diagnosticoExacto);
        } else if (!probables.isEmpty()) {
            // Ordenar por porcentaje y quedarse con los 3 mejores
            List<Map.Entry<String, Double>> lista = new ArrayList<>(probables.entrySet());
            lista.sort((a, b) -> Double.compare(b.getValue(), a.getValue()));
            if (lista.size() > 3) lista = lista.subList(0, 3);

            Map<String, Double> top3 = new LinkedHashMap<>();
            for (Map.Entry<String, Double> entry : lista) {
                top3.put(entry.getKey(), entry.getValue());
            }

            paciente.setDiagnostico("No concluyente");
            paciente.setProbabilidades(top3);
        } else {
            paciente.setDiagnostico("No se encontraron coincidencias");
        }

        pacientes.add(paciente);
        session.setAttribute("pacientes", pacientes);

        response.sendRedirect("historialPacientes.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}