<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Saludar</title>
        <link rel="stylesheet" type="text/css" href="../css/style.css">
    </head>
    <body>
        <h1>Saludar</h1><br>
        <%-- Método para saludar --%>
        <%!
            public String saludar(String nombre, String sexo) {
                if (sexo.equals("hombre")) {
                    return saludo() + " señor " + nombre;
                } else {
                    return saludo() + " señora " + nombre;
                }
            }
        %>
        <%!
            public String saludo() {
                LocalTime ahora = LocalTime.now();

                LocalTime inicioDia = LocalTime.of(8, 0);
                LocalTime finDia = LocalTime.of(13, 0);
                LocalTime inicioTarde = LocalTime.of(13, 1);
                LocalTime finTarde = LocalTime.of(21, 0);

                if (!ahora.isBefore(inicioDia) && !ahora.isAfter(finDia)) {
                    return "Buenos d&iacute;as";
                } else if (!ahora.isBefore(inicioTarde) && !ahora.isAfter(finTarde)) {
                    return "Buenas tardes";
                } else {
                    return "Buenas noches";
                }
            }
        %>
        <%
            //Si el form no se ha enviado aún, imprimimos el form:
            if (request.getParameter("switch") == null) {
        %>
        <div class="formulario">
            <form method="post" action="saludar.jsp" >
                <input type="hidden" name="switch" value="true">
                <!--                //input oculto para identificar si el form ya se ha enviado o no-->
                <table>
                    <tr>
                        <td>Nombre:</td>

                    </tr>
                    <tr>
                        <td><input name="nombre"></td>
                    </tr>
                    <tr>
                        <td>G&eacute;nero:</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name= "sexo" value="hombre">Hombre</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name= "sexo" value="mujer">Mujer</td>
                    </tr>
                    <tr>
                        <td><input type="submit" class="botonEnviar" value="Saludar"></td>
                    </tr>
                </table>
            </form>
        </div><br>
        <a class="enlace" href="../index.html">Volver</a>
        <%
        } else {
            //Si ya se ha enviado (switch != null), saludamos
            String nombre = request.getParameter("nombre");
            String sexo = request.getParameter("sexo");

            if (nombre == null || nombre.isEmpty() || sexo == null) {
        %>
        <p>Por favor, introduce todos los datos correctamente.</p><br>
                <a class="enlace" href="saludar.jsp">Volver</a>
        <%
            } else {
        %>
        <p><%= saludar(nombre, sexo)%></p><br>
                <a class="enlace" href="../index.html">Volver</a>
        <%
                }
            }
        %>
    </body>
</html>
