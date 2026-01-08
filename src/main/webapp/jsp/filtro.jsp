
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Filtro</title>
    </head>
    <body>
        <% if(request.getParameter("nombre") == null && request.getParameter("apellido") == null) {
        %>
        <form action="<%=request.getContextPath()%>/FilterController" method="post">
            <table>
                <tr>
                    <td>Nombre</td>
                    <td><input type="text" name="nombre" required></td>
                </tr>
                <tr>
                    <td>Apellido</td>
                    <td><input type="text" name="apellido" required></td>
                </tr>
            </table>
            <input type="submit" class="botonEnviar" name="Enviar" value="Enviar">
            <input type="button" class="botonVolver" name="volver" value="Volver al inicio" onclick="window.location.href = '<%=request.getContextPath()%>'">
        </form>
        <%
            } else {
        %>
        <p> Nombre: <%=request.getParameter("nombre")%> </p>
        <p> Apellido: <%=request.getParameter("apellido")%> </p>
        <input type="button" class="botonVolver" name="volver" value="Volver al inicio" onclick="window.location.href = '<%=request.getContextPath()%>'">
        <%

            }
        %>
        
    </body>
</html>
