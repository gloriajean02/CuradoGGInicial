<%-- 
    Document   : controlSesion
    Created on : 24 oct 2025, 16:49:26
    Author     : gloriajean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(true);
    
    String nombre = request.getParameter("nombreAtributo");
    String valor = request.getParameter("valorAtributo");
    if (valor == null){
        valor = "";
    }
    
    String mensaje = "";
    
    if (request.getParameter("crear") != null){
        if (sesion.getAttribute(nombre) != null) {
            mensaje = "<p style=\"color:orange\"> El atributo <strong>"+nombre+ "</strong> ya existe y no se puede crear de nuevo.</p>";
            
        } else {
            if (nombre.isEmpty()) {
                mensaje = "<p class=\"alerta\"> Indica el nombre del atributo.</p>";
            } else {
                sesion.setAttribute(nombre, valor);
                mensaje = "<p> Has creado un atributo con nombre: <strong>"+nombre+ "</strong><br> y valor: <strong>"+valor+"</strong>.</p>";  
            }        
        }
        
        sesion.setAttribute("mensaje", mensaje);
        response.sendRedirect(request.getContextPath()+"/jsp/menuSesion.jsp");
    }
    
    if (request.getParameter("actualizar") != null){
        if (sesion.getAttribute(nombre) != null) {
            sesion.setAttribute(nombre, valor);
            mensaje = "<p> Has actualizado el atributo con nombre: <strong>"+nombre+ "</strong>,<br>nuevo valor: <strong>"+valor+"</strong>.</p>";
            
        } else {
            mensaje = "<p style=\"color:orange\"> El atributo <strong>"+nombre+ "</strong> no existe y no se puede actualizar.</p>";
            
        }
        
        sesion.setAttribute("mensaje", mensaje);
        response.sendRedirect(request.getContextPath()+"/jsp/menuSesion.jsp");
    }
    
    if (request.getParameter("eliminar") != null){
        if (sesion.getAttribute(nombre) != null) {
            sesion.removeAttribute(nombre);
            mensaje = "<p> Has eliminado el atributo con nombre: <strong>"+nombre+ "</strong>.</p>";

        } else {
            mensaje = "<p style=\"color:orange\"> El atributo <strong>"+nombre+ "</strong> no existe y no se puede eliminar.</p>";

        }
        
        sesion.setAttribute("mensaje", mensaje);
        response.sendRedirect(request.getContextPath()+"/jsp/menuSesion.jsp");
    }
    
    if (request.getParameter("indice") != null){
        response.sendRedirect(request.getContextPath());
    }
%>
