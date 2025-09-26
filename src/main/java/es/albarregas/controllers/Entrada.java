/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gloriajean
 */
//Esto devuelve el contexto 
@WebServlet(name = "Entrada", urlPatterns = {"/Entrada"})
public class Entrada extends HttpServlet {

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
//        Se le indica al navegador que lo que se va a devolver es HTML en UTF-8 (para que se vean bien acentos, eñes, etc.).
        response.setContentType("text/html;charset=UTF-8");
//        out es un objeto que te permite escribir texto dentro de la respuesta.
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
//            Aquí se está construyendo el HTML de la página que se va a devolver al navegador.
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Entrada</title>");
            out.println("</head>");
            out.println("<body>");
//            request.getContextPath() devuelve el contexto de la aplicación (/CuradoGGInicial)
            out.println("<h1>Servlet Entrada at " + request.getContextPath() + "</h1>");
//            request.getMethod() devuelve el método HTTP usado (GET, en este caso)
            out.println("<h2>M&eacute;todo de llamada es " + request.getMethod() + "</h2>");
//            Crea un link que apunta al directorio actual (.), básicamente "volver al inicio"
            out.println("<a href=\".\">Volver</a>");

            Enumeration<String> parametroStr = request.getParameterNames();
//            Enumera todos los nombres de parámetros que venían en la URL

//            hasMoreElements sirve para saber si hay parámetros en la petición
            if (!parametroStr.hasMoreElements()) {
                out.println("<p>Esta llamada no incluye par&aacute;metros.</p>");
            } else {
                out.println("<p>Esta llamada incluye estos par&aacute;metros:</p>");
                while (parametroStr.hasMoreElements()) {
                    String nombreParametro = parametroStr.nextElement();
                    String valorParametro = request.getParameter(nombreParametro);
                    out.println("<p>Nombre par&aacute;metro: " + nombreParametro + ", Valor par&aacute;metro: " + valorParametro + "</p>");
                }
            }

            out.println("</body>");
            out.println("</html>");
        }
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
        response.setContentType("text/html;charset=UTF-8");
//        out es un objeto que te permite escribir texto dentro de la respuesta.
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
//            Aquí se está construyendo el HTML de la página que se va a devolver al navegador.
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Entrada</title>");
            out.println("</head>");
            out.println("<body>");
//            request.getContextPath() devuelve el contexto de la aplicación (/CuradoGGInicial)
            out.println("<h1>Servlet Entrada at " + request.getContextPath() + "</h1>");
//            request.getMethod() devuelve el método HTTP usado (GET, en este caso)
            out.println("<h2>M&eacute;todo de llamada es " + request.getMethod() + "</h2>");
//            Crea un link que apunta al directorio actual (.), básicamente "volver al inicio"
            out.println("<a href=\".\">Volver</a>");

            Enumeration<String> parametroStr = request.getParameterNames();
//            Enumera todos los nombres de parámetros que venían en la URL

//            hasMoreElements sirve para saber si hay parámetros en la petición
            out.println("<p>Esta llamada incluye estos par&aacute;metros:</p>");
            while (parametroStr.hasMoreElements()) {
                String nombreParametro = parametroStr.nextElement();
                String valorParametro = request.getParameter(nombreParametro);
                out.println("<p>Nombre par&aacute;metro: " + nombreParametro + ", Valor par&aacute;metro: " + valorParametro + "</p>");

            }

            out.println("</body>");
            out.println("</html>");
        }
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
