<%-- 
    Document   : menuSesion
    Created on : 24 oct 2025, 16:49:01
    Author     : gloriajean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html lang=es>
<html>
    <head>
        <title>Gesti&oacute;n de sesi&oacute;n</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="../css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <h1>Gesti&oacute;n de sesi&oacute;n</h1>
        <div class="formulario">
            <form action="controlSesion.jsp" method="post">
                <table>
                    <tr>
                        <td>Nombre del atributo de sesi&oacute;n:</td>
                        <td><input type="text" name="nombreAtributo"></td>
                    </tr>
                    <tr>
                        <td>Valor del atributo de sesi&oacute;n:</td>
                        <td><input type="text" name="valorAtributo"></td>
                    </tr>
                </table>
                <input type="submit" class="botonEnviar" name="crear" value="Crear">
                <input type="submit" class="botonActualizar" name="actualizar" value="Actualizar">
                <input type="submit" class="botonEliminar" name="eliminar" value="Eliminar">
                <input type="submit" class="botonVolver" name="indice" value="Volver al men&uacute;">
                <%
                    String mensaje = (String) session.getAttribute("mensaje");
                    if (mensaje != null) {
                %>
                    <%= mensaje %>
                    
                <%
                    session.removeAttribute("mensaje");
                    }
                %>
            </form>
        </div>
    </body>
</html>
