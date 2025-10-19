<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Saludar</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/style.css">
    </head>
    <body>
        <h1>Saludar</h1>
        <%
            String nombre = request.getParameter("nombre");
            String sexo = request.getParameter("sexo");
            String saludo = "";
            String nomenclatura = "";

            if (nombre == null || nombre.isEmpty() || sexo == null) {
        %>
        <p>Por favor, introduce todos los datos correctamente.</p><br>
        <a class="enlace" href="<%= request.getContextPath()%>/html/saludar.html">Reintentar</a>
        <%
        } else {

            LocalTime ahora = LocalTime.now();
            LocalTime inicioDia = LocalTime.of(8, 0);
            LocalTime finDia = LocalTime.of(13, 0);
            LocalTime inicioTarde = LocalTime.of(13, 1);
            LocalTime finTarde = LocalTime.of(21, 0);

            if (!ahora.isBefore(inicioDia) && !ahora.isAfter(finDia)) {
                saludo = "Buenos d&iacute;s";
            } else if (!ahora.isBefore(inicioTarde) && !ahora.isAfter(finTarde)) {
                saludo = "Buenas tardes";
            } else {
                saludo = "Buenas noches";
            }

            if (sexo.equals("hombre")) {
                nomenclatura = "se&ntilde;or";
            } else {
                nomenclatura = "se&ntilde;ora";
            }
        %>
        <p><%= saludo %> <%= nomenclatura%> <%= nombre%></p><br>
        <a class="enlace" href="<%= request.getContextPath()%>">Volver</a>
        <%
            }
        %>
    </body>
</html>
