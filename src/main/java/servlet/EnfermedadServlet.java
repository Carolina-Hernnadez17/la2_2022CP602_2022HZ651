/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import clases.Enfermedad;
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
import java.util.List;

/**
 *
 * @author gutie
 */
@WebServlet(name = "EnfermedadServlet", urlPatterns = {"/EnfermedadServlet"})
public class EnfermedadServlet extends HttpServlet {

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
        List<Enfermedad> enfermedades = (List<Enfermedad>) request.getSession().getAttribute("enfermedades");
        if(enfermedades == null) enfermedades = new ArrayList<>();

        List<Sintoma> sintomas = (List<Sintoma>) request.getSession().getAttribute("sintomas");
        if(sintomas == null) sintomas = new ArrayList<>();

        String nombreEnfermedad = request.getParameter("nombreEnfermedad");
        if(nombreEnfermedad != null && !nombreEnfermedad.isEmpty() && enfermedades.size() < 10) {
            Enfermedad e = new Enfermedad(nombreEnfermedad);
            for(Sintoma s : sintomas){
                String valor = request.getParameter("sintoma_" + s.getNombre_sintoma());
                e.addSintoma(s.getNombre_sintoma(), "on".equals(valor));
            }
            enfermedades.add(e);
        }

        request.getSession().setAttribute("enfermedades", enfermedades);
        response.sendRedirect("registrarEnfermedad.jsp");
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
