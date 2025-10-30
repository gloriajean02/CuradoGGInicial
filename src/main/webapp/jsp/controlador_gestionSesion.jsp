<%-- 
    Document   : controlador_gestionSesion
    Created on : 29 oct 2025, 16:53:31
    Author     : gloriajean
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="es.albarregas.beans.Usuario" %>
<%
    HttpSession sesion = request.getSession(true);

    //Atributo vista con el que iré gestionando las escenas
    sesion.setAttribute("vista", "inicial");

    //Atributo existenUsuarios para saber si mostrar botón "Todos"
    sesion.setAttribute("existenUsuarios", "no");

    Enumeration<String> atributos = sesion.getAttributeNames();
    while (atributos.hasMoreElements() && sesion.getAttribute("existenUsuarios").equals("no")) {
        if (sesion.getAttribute(atributos.nextElement()) instanceof Usuario) {
            sesion.setAttribute("existenUsuarios", "si");
        }
    }

    String nombreAtributo = request.getParameter("nombreAtributo");
    sesion.setAttribute("nombreUsuario", nombreAtributo);
    String mensaje = "";

    if (request.getParameter("buscar") != null) {

        if (sesion.getAttribute(nombreAtributo) != null) {
            //EL ATRIBUTO EXISTE
            sesion.setAttribute("vista", "datos");
            mensaje = "<p class=\"alerta\"> El atributo existe.</p>";

        } else {

            if (nombreAtributo.trim().isEmpty()) {
                //EL ATRIBUTO ESTÁ VACÍO
                mensaje = "<p class=\"alerta\"> El nombre del atributo es obligatorio.</p>";

            } else {
                //EL ATRIBUTO NO EXISTE
                mensaje = "<p class=\"alerta\"> El atributo no existe.</p>";
                sesion.setAttribute("vista", "datos");
            }
        }

        sesion.setAttribute("mensaje", mensaje);
        response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
    }

    if (request.getParameter("crear") != null) {
        
        String nombre = request.getParameter("nombre");
        String fecha = request.getParameter("fechaNacimiento");
        String numHijos = request.getParameter("numHijos");
        String salario = request.getParameter("salario");

        if (nombre == null || nombre.trim().isEmpty()
                || fecha == null || fecha.trim().isEmpty()
                || numHijos == null || numHijos.trim().isEmpty()
                || salario == null || salario.trim().isEmpty()) {

            mensaje = "<p class=\"alerta\">Todos los datos son obligatorios.</p>";
        } else {
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaFormateada = formato.parse(fecha);

            Usuario usuario = new Usuario();
            usuario.setNombre(nombre);
            usuario.setFechaNacimiento(fechaFormateada);
            usuario.setNumHijos(Integer.parseInt(numHijos));
            
            sesion.setAttribute((String) sesion.getAttribute("nombreUsuario"), usuario);
        }
        
        sesion.setAttribute("vista", "inicial");
        mensaje = "<p class=\"exito\">Usuario "+nombreAtributo+" creado con &eacute;xito.</p>";
        response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
    }
    
    if (request.getParameter("inicio") != null) {
        response.sendRedirect(request.getContextPath());
    }
%>
