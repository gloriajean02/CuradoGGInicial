/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.albarregas.controllers;

import es.albarregas.beans.UsuarioLogin;
import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author gloriajean
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

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

        HttpSession session = request.getSession(true);

        String url = "";

        String accion = request.getParameter("accion");

        switch (accion) {
            case "Login":
                UsuarioLogin usuario = new UsuarioLogin();

                String nombreUsuario = "Jesus";
                String claveUsuario = "1234";

                Boolean error = false;

                Enumeration<String> parametros = request.getParameterNames();

                while (parametros.hasMoreElements() && !error) {
                    String nombreParam = parametros.nextElement();
                    String valorParam = request.getParameter(nombreParam);
                    if (valorParam == null || valorParam.trim().isEmpty()) {
                        error = true;
                    }
                }

                if (!error) {
                    String nombreInput = request.getParameter("usuario");
                    String claveInput = request.getParameter("clave");
                    String telefonoInput = request.getParameter("telefono");

                    if (nombreUsuario.equals(nombreInput) && claveUsuario.equals(claveInput)) {
                        usuario.setUsuario(nombreInput);
                        usuario.setClave(claveInput);
                        usuario.setTelefono(Integer.parseInt(telefonoInput));

                        session.setAttribute("usuarioLogin", usuario);

                        url = "jsp/logout.jsp";

                    } else {
                        request.setAttribute("mensaje", "Login incorrecto");

                        url = "jsp/login.jsp";
                    }
                } else {
                    request.setAttribute("mensaje", "Todos los campos son obligatorios");

                    url = "jsp/login.jsp";
                }

                break;

            case "Logout":
                session.removeAttribute("usuarioLogin");
                url = "jsp/login.jsp";
                break;

            case "Volver al inicio":
                url = "index.html";
                break;

            case "9. Login":
                if (session.getAttribute("usuarioLogin") != null) {
                    url = "jsp/logout.jsp";
                } else {
                    url = "jsp/login.jsp";
                }

                break;
        }

        request.getRequestDispatcher(url).forward(request, response);

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
