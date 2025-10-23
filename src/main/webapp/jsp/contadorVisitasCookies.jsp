<%-- 
    Document   : contadorVisitas
    Created on : 17 oct 2025, 16:06:21
    Author     : gloriajean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.net.URLEncoder" %>
<%@page import = "java.net.URLDecoder" %>
<%
    Cookie cookie = null;
    boolean existe = false;
    String contadorStr = "1";
    int contador = 1;
    
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(int i=0; i < cookies.length && !existe; i++){
            if (cookies[i].getName().equals("CONTADOR")){           
                cookie = cookies[i];
                existe = true;
            }
        }        
    }
    
    if (existe && cookie != null) {
        try {
            contador = Integer.parseInt(cookie.getValue());
        } catch (Exception e) {
            contador = 1;
        }
    }
    
    if (request.getParameter("Recargar") != null){
        if (cookie != null){            
            contador++;
            contadorStr = String.valueOf(contador);
            cookie.setValue(contadorStr);
            response.addCookie(cookie);    
        }
        
    }
    
    if (request.getParameter("Eliminar") != null){
        if (cookie != null){
            cookie.setMaxAge(0);
            response.addCookie(cookie);
            contador = 1;
        } 
        
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
    if (existe && contador > 1) {
        contadorStr = URLDecoder.decode(cookie.getValue(), "UTF-8");
        contador = Integer.parseInt(contadorStr);
        %>
        <h4><%= mensaje%></h4>
        <%
    } else {
        if (contadorStr != null && !contadorStr.isEmpty()) {
            String valorCodificado = URLEncoder.encode(contadorStr, "UTF-8");
            cookie = new Cookie("CONTADOR", valorCodificado);
            cookie.setMaxAge(60 * 60); // dura 1 hora
            cookie.setVersion(1);
            cookie.setSecure(false);
            response.addCookie(cookie);           
        }
         %>
            <h4><%=mensaje%></h4>
            <h2>Informaci&oacute;n de la cookie</h2>
            <p>Caducidad: <%=cookie.getMaxAge()%></p>
            <p>Nombre: <%=cookie.getName()%></p>
            <p>Segura: <%=cookie.getSecure()%></p>
            <p>Versi&oacute;n: <%=cookie.getVersion()%></p>
        <%
    }
        %>
        <form action="contadorVisitas.jsp" method="post">
            <input type="submit" class="botonEnviar" name="Recargar" value="Recargar">
            <input type="submit" class="botonEliminar" name="Eliminar" value="Eliminar">
            <input type="button" class="botonVolver" name="volver" value="Volver al inicio" onclick="window.location.href='<%=request.getContextPath()%>'">
        </form>
        </div>
</body>
</html>
