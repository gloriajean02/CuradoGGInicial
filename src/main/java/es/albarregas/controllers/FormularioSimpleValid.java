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
                if (!nombreParametro.equals("preferencias")) {
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
                out.println("<p class=\"alerta\">Los campos son obligatorios</p>");
                out.println("<div class=\"formulario\">");
                out.println("<form action=\"FormularioSimpleValid\" method=\"post\">");

                while (nombresParametros.hasMoreElements()) {
                    String parametro = nombresParametros.nextElement();
                    String valor = mapaParametros.get(parametro)[0];
                    boolean vacio = nulos.contains(parametro);
                    
                    //En cada caso comprobamos si está vacío o no e imprimimos en consecuencia
                    switch (parametro) {
                        case "nombre":
                            out.println("<label for=\"nb\">Nombre</label><br>");
                            if (vacio) {
                                //Si está vacio imprime campo vacío y con bordes rojos
                                out.println("<input class=\"vacio\" type=\"text\" name=\"nombre\" id=\"nb\" placeholder=\"Ej. Juan\"><br>");
                            } else {
                                //Si está lleno recuerda el valor con "value="valor""
                                out.println("<input type=\"text\" name=\"nombre\" id=\"nb\" placeholder=\"Ej. Juan\" value=\""
                                        + valor + "\"><br>");
                            }
                            break;
                        case "fechaNacimiento":
                            out.println("<label for=\"dt\">Fecha de nacimiento</label><br>");
                            if (vacio) {
                                out.println("<input class=\"vacio\" type=\"date\" name=\"fechaNacimiento\" id=\"dt\"><br>");
                            } else {
                                out.println("<input type=\"date\" name=\"fechaNacimiento\" id=\"dt\" value=\""
                                        + valor + "\"><br>");
                            }
                            break;
                        case "salario":
                            out.println("<label for=\"sal\">Salario</label><br>");
                            if (vacio) {
                                out.println("<input class=\"vacio\" type=\"number\" name=\"salario\" step=\"0.01\" id=\"sal\"><br>");
                            } else {
                                out.println("<input type=\"number\" name=\"salario\" step=\"0.01\" id=\"sal\" value=\""
                                        + valor + "\"><br>");
                            }
                            break;
                        case "hijos":
                            out.println("<label for=\"hj\">N&uacute;mero de hijos</label><br>");
                            if (vacio) {
                                out.println("<input class=\"vacio\" type=\"number\" name=\"hijos\" id=\"hj\"><br>");
                            } else {
                                out.println("<input type=\"number\" name=\"hijos\" id=\"hj\" value=\""
                                        + valor + "\"><br>");
                            }
                            break;
                    }

                }
                
                //Las preferencias no se guardan, las imprimimos como siempre
                out.println(pintarPreferencias());

                out.println("<input class=\"botonEnviar\" type=\"submit\">");
                out.println("</form>");
                out.println("</div>");
                out.println("<br>");

            } else {
                
                //Si el ArrayList nulos está vacío quiere decir que todo está ok, así que mostramos resultados
                while (nombresParametros.hasMoreElements()) {
                    String parametro = nombresParametros.nextElement(); 
                    String[] valores = request.getParameterValues(parametro);
                    
                    //Se hace distinción para las preferencias porque si no hay no se imprimen
                    if (parametro.equals("preferencias")) {
                        if (valores != null && valores.length > 0) {
                            out.println("<h2>Preferencias</h2>");
                            out.println("<ul>");
                            for (String valor : valores) {
                                out.println("<li>" + valor + "</li>");
                            }
                            out.println("</ul><br>");
                        }
                    } else {
                        
                        //Impresión de los demás campos
                        out.println("<h2>" + parametro + "</h2>");

                        // Si es fecha, la formateamos
                        if (parametro.equals("fechaNacimiento")) {
                            LocalDate fecha = LocalDate.parse(valores[0]);
                            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                            out.println("<p>" + fecha.format(formato) + "</p><br>");
                        } else {
                            out.println("<p>" + valores[0] + "</p><br>");
                        }
                    }
                }
            }

            out.println(pintarFinalHTML("index.html"));
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
        return "<label for=\"preferencias\">Preferencias</label><br>\n"
                + "<select name=\"preferencias\" id=\"preferencias\" multiple>\n"
                + "<option value=\"Leer\">Leer</option>\n"
                + "<option value=\"Nadar\">Nadar</option>\n"
                + "<option value=\"Dormir\">Dormir</option>\n"
                + "<option value=\"Bailar\">Bailar</option>\n"
                + "</select><br>\n";
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
