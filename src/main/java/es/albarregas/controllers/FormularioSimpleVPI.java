/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
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
@WebServlet(name = "FormularioSimpleVPI", urlPatterns = {"/FormularioSimpleVPI"})
public class FormularioSimpleVPI extends HttpServlet {

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
            out.println("<title>Formulario Simple con Validaciones y pantalla intermedia</title>");
            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\">\n");
            out.println("<link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap\" rel=\"stylesheet\">");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Formulario con Validaciones y pantalla intermedia</h1><br>");

            //Obtenemos los nombres de los parámetros
            Enumeration<String> nombresParametros = request.getParameterNames();
            
            //Bandera de campos vacíos
            boolean campoVacio = false;
            
            //Bandera de formulario de corrección
            boolean formularioCorreccion = false;
            
            //Comprobamos si se ha pulsado el botón aceptar de la pantalla intermedia.
            //Si se ha pulsado, cambiamos formualarioCorreccion a true y por lo tanto de vista
            if (request.getParameter("botonAceptar") != null) {
                formularioCorreccion = true;
            }

            //En cuanto detecta un campo vacio la bandera campoVacio cambia a true y salimos del bucle
            while (nombresParametros.hasMoreElements() && campoVacio == false) {
                String parametro = nombresParametros.nextElement();
                String valor = request.getParameter(parametro);
                if (valor.trim().isEmpty()) {
                    campoVacio = true;
                }
            }

            //Si hay campos vacíos pero la bandera de corrección no está activa, se abre la pantalla intermedia
            if (campoVacio && !formularioCorreccion) {
                out.println("<p class=\"alerta\">Se han producido errores de entrada</p>");

                //Utilizamos un formulario oculto para recordar los datos de una vista a otra
                out.println("<form action=\"FormularioSimpleVPI\" method=\"post\">");

                //Abrimos otro Enumeration porque el anterior se ha vaciado
                Enumeration<String> parametrosHidden = request.getParameterNames();
                while (parametrosHidden.hasMoreElements()) {
                    String parametro = parametrosHidden.nextElement();
                    String[] valores = request.getParameterValues(parametro);
                    for (String valor : valores) {
                        out.println("<input type=\"hidden\" name=\"" + parametro + "\" value=\"" + valor + "\">");
                    }
                }
                out.println("<input class=\"botonEnviar\" type=\"submit\"  name=\"botonAceptar\" value=\"Aceptar\">");
                out.println("</form>");
                
            //Si hay campos vacíos y la bandera de corrección está activa, se abre el formulario de
            //corrección con campos recordados
            } else if (campoVacio && formularioCorreccion) {
                //Mensaje de alerta
                out.println("<p class=\"alerta\">Los campos son obligatorios</p>");
                
                //Imprimimos formulario
                out.println("<div class=\"formulario\">");
                out.println("<form action=\"FormularioSimpleVPI\" method=\"post\">");

                Enumeration<String> parametrosRecordados = request.getParameterNames();
                while (parametrosRecordados.hasMoreElements()) {
                    String parametro = parametrosRecordados.nextElement();
                    String[] valores = request.getParameterValues(parametro);
                    
                    String parametroEspaciado = parametro.replace('_', ' ');
                    String valorActual = "";

                    if (valores != null && valores.length == 1) {
                        valorActual = valores[0];
                    }
                    
                    //Pintamos el formulario con los valores recordados
                    switch (parametro) {

                        case "Nombre":
                            out.println("<label for=\"nb\">" + parametroEspaciado + "</label><br>");
                            out.println("<input type=\"text\" name=\"Nombre\" id=\"nb\" placeholder=\"Ej. Juan\" value=\""+valorActual+"\"><br>");
                            break;

                        case "Fecha_de_nacimiento":
                            out.println("<label for=\"dt\">" + parametroEspaciado + "</label><br>");
                            out.println("<input type=\"date\" name=\"Fecha_de_nacimiento\" id=\"dt\" value=\""+valorActual+"\"><br>");
                            break;

                        case "Salario":
                            out.println("<label for=\"sal\">" + parametroEspaciado + "</label><br>");
                            out.println("<input type=\"number\" name=\"Salario\" step=\"0.01\" id=\"sal\" value=\""+valorActual+"\"><br>");
                            break;

                        case "Hijos":
                            out.println("<label for=\"hj\">" + parametroEspaciado + "</label><br>");
                            out.println("<input type=\"number\" name=\"Hijos\" id=\"hj\" value=\""+valorActual+"\"><br>");
                            break;

                    }
                }
                
                //Tratamos las preferencias por separado porque cuando no se selecciona ninguna el enumeration no las detecta
                out.println("<label for=\"preferencias\">Preferencias</label><br>");
                out.println("<select name=\"Preferencias\" id=\"preferencias\" multiple>");

                String[] opciones = {"Leer", "Nadar", "Dormir", "Bailar"};

                //Obtenemos las preferencias seleccionadas previamente
                String[] preferenciasSeleccionadas = request.getParameterValues("Preferencias");
                
                //Detectamos cuáles son las seleccionadas de nuestro array de opciones y las marcamos con la bandera selected
                for (String opcion : opciones) {
                    boolean selected = false;

                    if (preferenciasSeleccionadas != null) {
                        for (String preferencia : preferenciasSeleccionadas) {
                            if (opcion.equals(preferencia)) {
                                selected = true;
                            }
                        }
                    }
                    
                    //Si ha sido selected, añadimos la etiqueta selected al html de esa opción
                    if (selected) {
                        out.println("<option value=\"" + opcion + "\" selected>" + opcion + "</option>");
                    } else {
                        out.println("<option value=\"" + opcion + "\">" + opcion + "</option>");
                    }
                }

                out.println("</select><br>");

                out.println("<input class=\"botonEnviar\" type=\"submit\">");
                out.println("</form>");
                out.println("</div>");
                out.println("<br>");

            } else {

                //Utilizamos Map para mostrar valores
                Map<String, String[]> mapaParametros = request.getParameterMap();

                DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("dd/MM/yyyy");

                for (Map.Entry<String, String[]> entry : mapaParametros.entrySet()) {
                    String nombreParametro = entry.getKey();
                    String[] valoresParametro = entry.getValue();

                    String nombreParametroEspaciado = nombreParametro.replace('_', ' ');

                    //Si hay un parámetro con varias opciones, solo lo mostramos si hay valores seleccionados
                    if (valoresParametro.length > 1) {
                        out.println("<h2>" + nombreParametroEspaciado + "</h2>");
                        out.println("<ul>");
                        for (String valor : valoresParametro) {
                            out.println("<li>" + valor + "</li>");
                        }
                        out.println("</ul><br>");
                    } else {
                        //Si solo tiene un valor, lo mostramos así
                        String valor = valoresParametro[0];
                        try {
                            // Comprobar si el valor es fecha, si lo es lo formateamos
                            LocalDate fecha = LocalDate.parse(valor);
                            String fechaFormateada = fecha.format(formatoFecha);

                            out.println("<h2>" + nombreParametroEspaciado + "</h2>");
                            out.println("<p>" + fechaFormateada + "</p>");
                        } catch (DateTimeParseException e) {
                            // Si no era fecha, lo mostramos tal cual
                            out.println("<h2>" + nombreParametroEspaciado + "</h2>");
                            out.println("<p>" + valor + "</p>");
                        }
                    }
                }
            }

            out.println("<a class=\"enlace\" href=\"index.html\">Volver</a>");
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
