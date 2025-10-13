<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Edad</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/style.css">
    </head>
    <body>
        <h1>Edad</h1><br>
        <%
            String nombre = request.getParameter("nombre");
            String fechaInput = request.getParameter("fecha");
            
            //Si hay algún parámetro nulo o vacío, pedimos reintentarlo
            if (nombre == null || nombre.isEmpty() || fechaInput == null) {
        %>
        <p>Por favor, introduce todos los datos correctamente.</p><br>
        <a class="enlace" href="<%= request.getContextPath()%>/html/edad.html">Reintentar</a>
        <%
            //Si están todos completos pasamos a contar
            } else {

                LocalDate ahora = LocalDate.now();
                
                //Formateamos la fecha del parámetro porque viene en String, la pasamos a Date
                LocalDate fechaFormateada = LocalDate.parse(fechaInput);
                
                //Sacamos el periodo que hay entre las dos fechas
                Period periodo = Period.between(fechaFormateada, ahora);

                if (periodo.isNegative()) {
        %>
        <p>Hola <%= nombre%>, a&uacute;n no has nacido.</p><br>
        <%
                } else if (periodo.isZero()) {
        %>
        <p>Hola <%= nombre%>, has nacido hoy.</p><br>
        <%
                //Si el periodo no es negativo ni es cero
                } else {
                    int anios = periodo.getYears();
                    int meses = periodo.getMonths();
                    int dias = periodo.getDays();

                    if (dias == 0 && meses == 0){
        %>
<!--    Si tiene 1 año imprimimos año, si tiene más de uno, años-->
        <p>Hola <%= nombre%>, tienes <%= anios%> <%= anios == 1 ? " a&ntilde;o" : " a&ntilde;os"%> y hoy es tu cumple, ¡felicidades!</p><br>
        <%
                    } else {
                        
                        //Abrimos un StringBuilder para imprimir la cuenta de años, meses y días
                        StringBuilder textoEdad = new StringBuilder();
                        
                        //Con los if anios, meses, dias > 0 controlamos que si es 0 no se imprima
                        if (anios > 0) {
                            textoEdad.append(anios)
                                     .append(anios == 1 ? " a&ntilde;o" : " a&ntilde;os");
                        }

                        if (meses > 0) {
                            //Con .length vemos si ya hay años en el builder, con dias == 0 vemos si imprimimos "y" o "," 
                            if (textoEdad.length() > 0 && dias == 0){
                                   textoEdad.append(" y ");
                            } else if (textoEdad.length() > 0 && dias != 0) {
                                    textoEdad.append(", ");
                            }
                            textoEdad.append(meses)
                                     .append(meses == 1 ? " mes" : " meses");
                        }
                        if (dias > 0) {
                            if (textoEdad.length() > 0) {
                                textoEdad.append(" y ");
                            }
                            textoEdad.append(dias)
                                     .append(dias == 1 ? " d&iacute;a" : " d&iacute;as");
                        }
        %>
        <p>Hola <%= nombre %>, tienes <%= textoEdad.toString() %>.</p><br>
        <%
                    }
                }                     
        %>
        <a class="enlace" href="<%= request.getContextPath()%>">Volver</a>
        <%
            }            
        %>
    </body>
</html>
