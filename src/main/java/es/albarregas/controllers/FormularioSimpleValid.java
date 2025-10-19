/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gloriajean
 */
@WebServlet(name = "FormularioSimpleValid", urlPatterns = {"/FormularioSimpleValid"})
public class FormularioSimpleValid extends HttpServlet {

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

            //Enumeramos los parámetros del formulario
            Enumeration<String> nombresParametros = request.getParameterNames();

            //Mapeamos siendo los nombres de parámetros la key y los valores los values
            Map<String, String[]> mapaParametros = request.getParameterMap();

            //Creamos un ArrayList donde vamos a guardar todos los parámetros sin valor
            ArrayList<String> nulos = new ArrayList<>();

            for (Map.Entry<String, String[]> entry : mapaParametros.entrySet()) {
                String nombreParametro = entry.getKey();
                String[] valorParametro = entry.getValue();

                //Si el campo no es preferencias y está vacío, se añade al ArrayList nulos
                if (!nombreParametro.equals("Preferencias")) {
                    for (String valor : valorParametro) {
                        if (valor.trim().equals("")) {
                            nulos.add(nombreParametro);
                        }
                    }
                }
            }

            //Iniciamos el HTML
            out.println(pintarCabeceraHTML("Formulario Simple con Validaciones", "css/style.css"));

            //Si el ArrayList nulos NO está vacío, pedimos rellenar estos campos vacíos y además recordaremos los llenos
            if (!nulos.isEmpty()) {
                //Lanzamos alerta de campos obligatorios
                out.println("<div class=\"formulario\">");
                out.println("<p class=\"alerta\">Los campos son obligatorios</p><br>");
                out.println("<form action=\"FormularioSimpleValid\" method=\"post\">");
                out.println("<table>");

                while (nombresParametros.hasMoreElements()) {
                    String parametro = nombresParametros.nextElement();
                    String valor = mapaParametros.get(parametro)[0];
                    boolean vacio = nulos.contains(parametro);

                    //En cada caso comprobamos si está vacío o no e imprimimos en consecuencia
                    switch (parametro) {
                        case "Nombre":
                            out.println("<tr>");
                            out.println("<td><label for=\"nb\">Nombre</label></td>");
                            if (vacio) {
                                //Si está vacio imprime campo vacío y con bordes rojos
                                out.println("<td><input class=\"vacio\" type=\"text\" name=\"Nombre\" id=\"nb\" placeholder=\"Ej. Juan\"></td>");
                            } else {
                                //Si está lleno recuerda el valor con "value="valor""
                                out.println("<td><input type=\"text\" name=\"Nombre\" id=\"nb\" placeholder=\"Ej. Juan\" value=\""
                                        + valor + "\"></td>");
                            }
                            out.println("</tr>");
                            break;
                        case "Fecha_de_nacimiento":
                            out.println("<tr>");
                            out.println("<td><label for=\"dt\">Fecha de nacimiento</label></td>");
                            if (vacio) {
                                out.println("<td><input class=\"vacio\" type=\"date\" name=\"Fecha_de_nacimiento\" id=\"dt\"></td>");
                            } else {
                                out.println("<td><input type=\"date\" name=\"Fecha_de_nacimiento\" id=\"dt\" value=\""
                                        + valor + "\"></td>");
                            }
                            out.println("</tr>");
                            break;
                        case "Salario":
                            out.println("<tr>");
                            out.println("<td><label for=\"sal\">Salario</label></td>");
                            if (vacio) {
                                out.println("<td><input class=\"vacio\" type=\"number\" name=\"Salario\" step=\"0.01\" id=\"sal\"></td>");
                            } else {
                                out.println("<td><input type=\"number\" name=\"Salario\" step=\"0.01\" id=\"sal\" value=\""
                                        + valor + "\"></td>");
                            }
                            out.println("</tr>");
                            break;
                        case "Hijos":
                            out.println("<tr>");
                            out.println("<td><label for=\"hj\">Hijos</label></td>");
                            if (vacio) {
                                out.println("<td><input class=\"vacio\" type=\"number\" name=\"Hijos\" id=\"hj\"></td>");
                            } else {
                                out.println("<td><input type=\"number\" name=\"Hijos\" id=\"hj\" value=\""
                                        + valor + "\"></td>");
                            }
                            out.println("</tr>");
                            break;
                    }

                }

                //Las preferencias no se guardan, las imprimimos como siempre
                out.println(pintarPreferencias());
                out.println("</table>");
                out.println("<input class=\"botonEnviar\" type=\"submit\">");
                out.println("<input type=\"button\" class=\"botonVolver\" name=\"volver\" value=\"Volver al inicio\" onclick=\"window.location.href='index.html'\">");
                out.println("</form>");
                out.println("</div>");
                out.println("<br>");

            } else {

                //Si el ArrayList nulos está vacío quiere decir que todo está ok, así que mostramos resultados
                while (nombresParametros.hasMoreElements()) {
                    String parametro = nombresParametros.nextElement();
                    String[] valores = request.getParameterValues(parametro);

                    //Se hace distinción para las preferencias porque si no hay no se imprimen
                    if (parametro.equals("Preferencias")) {
                        if (valores != null && valores.length > 0) {
                            out.println("<p>Preferencias</p>");
                            out.println("<ul>");
                            for (String valor : valores) {
                                out.println("<li>" + valor + "</li>");
                            }
                            out.println("</ul><br>");
                        }
                    } else if (parametro.equals("Fecha_de_nacimiento")) {
                        // Si es fecha, la formateamos
                        String nombreParametro = parametro.replace('_', ' ');
                        out.println("<p>" + nombreParametro + "</p>");
                        LocalDate fecha = LocalDate.parse(valores[0]);
                        DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        out.println("<p>" + fecha.format(formato) + "</p><br>");
                    } else {
                        //Impresión de los demás campos
                        out.println("<p>" + parametro + "</p>");
                        out.println("<p>" + valores[0] + "</p><br>");
                    }
                    
                }
                out.println(pintarFinalHTML("index.html"));
            }
            

            
        }
    }

    private String pintarCabeceraHTML(String titulo, String rutaCSS) {
        return "<!DOCTYPE html>\n" + "<html>\n" + "<head>\n" + "<title>" + titulo + "</title>\n"
                + "<link rel=\"stylesheet\" type=\"text/css\" href=\"" + rutaCSS + "\">\n"
                + "<link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap\" rel=\"stylesheet\">\n"
                + "</head>\n" + "<body>\n" + "<h1>" + titulo + "</h1><br>\n";
    }

    private String pintarFinalHTML(String rutaVolver) {
        return "<a class=\"enlace\" href=\"" + rutaVolver + "\">Volver</a>\n" + "</body>\n" + "</html>";
    }

    private String pintarPreferencias() {
        return "<tr>\n<td><label for=\"preferencias\">Preferencias</label></td>\n"
                + "<td><select name=\"Preferencias\" id=\"preferencias\" multiple>\n"
                + "<option value=\"Leer\">Leer</option>\n"
                + "<option value=\"Nadar\">Nadar</option>\n"
                + "<option value=\"Dormir\">Dormir</option>\n"
                + "<option value=\"Bailar\">Bailar</option>\n"
                + "</select></td>\n</tr>\n";
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
