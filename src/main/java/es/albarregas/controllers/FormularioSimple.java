/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gloriajean
 */
@WebServlet(name = "FormularioSimple", urlPatterns = {"/FormularioSimple"})
public class FormularioSimple extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Entrada</title>");
            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\">\n");
            out.println("<link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap\" rel=\"stylesheet\">");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Formulario Simple</h1><br>");
            
            //Extraer datos nombre
            String valorNombre = request.getParameter("nombre");
            out.println("<h2>Nombre</h2>");
            out.println("<p>" + valorNombre + "</p><br>");
            
            //Extraer datos fecha
            String valorFechaNac = request.getParameter("fechaNacimiento");
            //Se formatea la fecha a formato español
            LocalDate fecha = LocalDate.parse(valorFechaNac);
            DateTimeFormatter fechaFormateada = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String nuevaFecha = fecha.format(fechaFormateada);
            out.println("<h2>Fecha de nacimiento</h2>");
            out.println("<p>" + nuevaFecha + "</p><br>");
            
            //El salario solo se imprime si es más de 0
            String valorSalario = request.getParameter("salario");
            //Cambia la coma por punto si es necesario
            valorSalario = valorSalario.replace(",", ".");
            if (valorSalario != null){
               float floatSalario = Float.parseFloat(valorSalario);
                if (floatSalario > 0) {
                   out.println("<h2>Salario</h2>");
                   out.println("<p>" + floatSalario + "€</p><br>");  
                }
            }
            
            //El número de hijos solo se imprime si es más de 0
            String valorHijos = request.getParameter("hijos");
            if (valorHijos != null){
               int numHijos = Integer.parseInt(valorHijos);
                if (numHijos > 0) {
                   out.println("<h2>Hijos</h2>");
                   out.println("<p>" + numHijos + "</p><br>");  
                }
            }
            
            //Las preferencias solo se imprimen si hay alguna seleccionada
            String[] preferencias = request.getParameterValues("preferencias");
            if (preferencias != null && preferencias.length > 0) {
                out.println("<h2>Preferencias</h2>");
                out.println("<ul>");
                for (String preferencia : preferencias) {
                    out.println("<li>" + preferencia + "</li>");
                }
                out.println("</ul><br>");
            }

            out.println("<a class=\"enlace\" href=\".\">Volver</a>");
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
