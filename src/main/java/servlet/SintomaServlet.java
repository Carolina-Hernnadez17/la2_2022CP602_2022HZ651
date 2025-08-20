/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import clases.Sintoma;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SintomaServlet", urlPatterns = {"/SintomaServlet"})
public class SintomaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Solo muestra la página
        request.getRequestDispatcher("registrarSintoma.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");
        if (sintomas == null) {
            sintomas = new ArrayList<>();
            session.setAttribute("sintomas", sintomas);
        }

        String accion = safe(request.getParameter("accion"));

        switch (accion) {
            case "agregar":
                agregarSintoma(request, response, sintomas, session);
                break;
            case "buscar":
                buscarSintoma(request, response, sintomas);
                break;
            default:
                // Si no viene acción, simplemente vuelve a la página
                request.getRequestDispatcher("registrarSintoma.jsp").forward(request, response);
                break;
        }
    }

    private void agregarSintoma(HttpServletRequest request, HttpServletResponse response,
                                List<Sintoma> sintomas, HttpSession session)
            throws ServletException, IOException {
        String nombre = safe(request.getParameter("nombreSintoma")).trim();

        String mensaje;
        String tipoMensaje; // "success" o "error"

        // 4. El nombre del síntoma debe tener al menos 3 caracteres.
        if (nombre.length() < 3) {
            mensaje = "El nombre del síntoma debe tener al menos 3 caracteres.";
            tipoMensaje = "error";
        } else {
            // 5. No se deben registrar síntomas duplicados (ignorar mayúsculas/minúsculas).
            boolean existe = sintomas.stream()
                    .anyMatch(s -> s.getNombre_sintoma() != null
                            && s.getNombre_sintoma().equalsIgnoreCase(nombre));

            if (existe) {
                mensaje = "El síntoma ya está registrado.";
                tipoMensaje = "error";
            } else {
                // Registrar
                sintomas.add(new Sintoma(nombre));
                session.setAttribute("sintomas", sintomas);

                // 6. Mensaje de confirmación
                mensaje = "Síntoma registrado con éxito.";
                tipoMensaje = "success";
            }
        }

        // 7. Mensaje de error si no es válido (o success si se registró)
        request.setAttribute("mensaje", mensaje);
        request.setAttribute("tipoMensaje", tipoMensaje);

        // Volver al JSP manteniendo los atributos en request
        request.getRequestDispatcher("registrarSintoma.jsp").forward(request, response);
    }

    private void buscarSintoma(HttpServletRequest request, HttpServletResponse response,
                               List<Sintoma> sintomas)
            throws ServletException, IOException {

        String query = safe(request.getParameter("buscar")).trim();
        List<Sintoma> resultados = new ArrayList<>();

        if (!query.isEmpty()) {
            // 10. Buscar por nombre (contiene, ignore case) o por identificador (posición 1..N)
            for (int i = 0; i < sintomas.size(); i++) {
                Sintoma s = sintomas.get(i);
                String nombre = s.getNombre_sintoma() == null ? "" : s.getNombre_sintoma();

                boolean coincidePorNombre = nombre.toLowerCase().contains(query.toLowerCase());
                boolean coincidePorId = false;

                // ID visible es i+1
                try {
                    int idBuscado = Integer.parseInt(query);
                    coincidePorId = (idBuscado == (i + 1));
                } catch (NumberFormatException ignore) {
                    // No numérico: no coincide por id
                }

                if (coincidePorNombre || coincidePorId) {
                    resultados.add(s);
                }
            }
        }

        request.setAttribute("resultados", resultados);
        request.getRequestDispatcher("registrarSintoma.jsp").forward(request, response);
    }

    private String safe(String s) {
        return s == null ? "" : s;
    }
}
