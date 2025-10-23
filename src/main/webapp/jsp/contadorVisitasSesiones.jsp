<%-- 
    Document   : contadorVisitas
    Created on : 23 oct 2025, 19:23:21
    Author     : gloriajean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(true);

    Integer contador = (Integer) sesion.getAttribute("visitas");
    if (contador == null) {
        contador = 1;
    }
    
    if (request.getParameter("recargar") != null && request.getParameter("eliminar") == null){
        contador++;
        sesion.setAttribute("visitas", contador);
    } else if (request.getParameter("recargar") != null && request.getParameter("eliminar") != null){
        sesion.removeAttribute("visitas");
        contador = 1;
    }
    
    String mensaje;
    
    if (contador == 1) {
        mensaje = "Has visitado la p&aacute;gina " + contador + " vez.";
    } else {
        mensaje = "Has visitado la p&aacute;gina " + contador + " veces.";
    }
%>
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Contador de visitas</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/style.css">
    </head>
    <body>
        <h1>Contador de visitas</h1>
        
        <div class=formulario>
<%   
    if (contador >= 1) {

        %>
        <h4><%= mensaje%></h4>
        <%
    }
        %>
        <form action="contadorVisitasSesiones.jsp" method="post">
            <label>Eliminar sesi&oacute;n<input type="checkbox" name="eliminar"></label><br>
            <input type="submit" class="botonEnviar" name="recargar" value="Recargar">
            <input type="button" class="botonVolver" name="volver" value="Volver al inicio" onclick="window.location.href='<%=request.getContextPath()%>'">
        </form>
        </div>
</body>
</html>
