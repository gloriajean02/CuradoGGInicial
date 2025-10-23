<%-- 
    Document   : recordarUsuario
    Created on : 23 oct 2025, 16:06:21
    Author     : gloriajean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.net.URLEncoder" %>
<%@page import = "java.net.URLDecoder" %>
<%
        Cookie cookie = null;
        String usuario = "";
        boolean existe = false;

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length && !existe; i++) {
                if (cookies[i].getName().equals("usuario")) {
                    cookie = cookies[i];
                    existe = true;
                }
            }
        }

        if (cookie != null) {
            usuario = cookie.getValue();
        }

        if (request.getParameter("recordar") != null) {        
            String valorCodificado = URLEncoder.encode(request.getParameter("usuario"), "UTF-8");
            cookie = new Cookie("usuario", valorCodificado);
            usuario = cookie.getValue();
            cookie.setMaxAge(60 * 60); // 1 hora
            response.addCookie(cookie);
            
        }
    


%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Recordar usuario</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/style.css">
    </head>
    <body>
        <h1>Recordar usuario</h1>

        <div class=formulario>
            <form action="recordarUsuario.jsp" method="post">
                <table>
                    <tr>
                        <td>Nombre de usuario:</td>
                        <td><input type="text" name="usuario" value="<%=usuario%>"></td>
                    </tr>
                    <tr>
                        <td>Contrase&ntilde;a</td>
                        <td><input type="password" name="clave"></td>
                    </tr>
                    <tr>
                        <td>Recordar usuario:</td>
                        <%
                            if (usuario.length() > 0) {
                        %>
                        <td><input type="checkbox" name="recordar" checked disabled></td>
                            <%
                            } else {
                            %>
                        <td><input type="checkbox" name="recordar"></td>
                            <%
                            }
                            %>

                    </tr>
                </table>
                <input type="submit" class="botonEnviar" name="Enviar" value="Enviar">
                <input type="button" class="botonVolver" name="volver" value="Volver al inicio" onclick="window.location.href = '<%=request.getContextPath()%>'">
            </form>
        </div>
    </body>
</html>
