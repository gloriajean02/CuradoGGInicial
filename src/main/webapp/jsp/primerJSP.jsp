<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Mi primer JSP</title>
        <link rel="stylesheet" type="text/css" href="../css/style.css">
    </head>
    <body>
        <%-- Método para sumar dos números enteros --%>
        <%!
            public int sumar(int param1, int param2) {
                return param1 + param2;
            }
        %>
        <%
        if (request.getParameter("switch") == null) {
        %>
        <h1>Mi primer JSP</h1>
        <div class="formulario">
            <form method="post" action="primerJSP.jsp" >
                <input type="hidden" name="switch" value="true">
                <table>
                    <tr>
                        <td>Primer número:</td>
                        <td><input name="param1"></td>
                    </tr>
                    <tr>
                        <td>Segundo número:</td>
                        <td><input name="param2"></td>
                    </tr>
                </table>
                <input type="submit" class="botonEnviar" value="Sumar">
                <input type="button" class="botonVolver" name="volver" value="Volver al inicio" onclick="window.location.href='<%=request.getContextPath()%>'">
            </form>
        </div>

        
        <%
        } else {
            try {
                int param1 = Integer.parseInt(request.getParameter("param1"));
                int param2 = Integer.parseInt(request.getParameter("param2"));
                int result = param1 + param2;
        %>
        <p>El resultado de la suma es: <%= sumar(param1, param2)%></p>
        <%
        } catch (NumberFormatException ex) {
        %>
        <p>Alguno de los números no contenía dígitos válidos...</p>
        <%
            }
        %>
        <p><%= Calendar.getInstance().getTime()%></p>
        <a class="enlace" href="../index.html">Volver</a>
        <%
            }
        %>
    </body>
</html>
