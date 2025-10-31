<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="es.albarregas.beans.Usuario" %>
<%
    HttpSession sesion = request.getSession(true);
 
    //Guardamos el nombreBuscado como String y creamos un atributo de sesión para poder guardarlo como value en el form
    String nombreBuscado = request.getParameter("nombreBuscado");    
    sesion.setAttribute("valueNombreBuscado", nombreBuscado);
    
    //Guardamos los atributos de usuario para usarlos en las opciones crear y actualizar
    String nombre = request.getParameter("nombre");
    String fecha = request.getParameter("fechaNacimiento");
    String numHijos = request.getParameter("numHijos");
    String salario = request.getParameter("salario");
    
    //Comprobamos si el atributo nombreBuscado existe en la sesión como objeto, si existe será porque ese usuario ya está creado
    Object usuarioCreado = sesion.getAttribute(nombreBuscado);
    //Lo casteamos a tipo Usuario para poder usarlo en la opción de Actualizar
    Usuario usuario = null;
    if (usuarioCreado instanceof Usuario) {
        usuario = (Usuario) usuarioCreado;
    } 
    
    String mensaje = "";
    
    //Comprobamos qué botón se ha pulsado
    String accion = request.getParameter("accion");
    
    switch (accion) {
        
        case "Buscar":
            
            if (nombreBuscado.trim().isEmpty() || nombreBuscado == null) {
                    //EL ATRIBUTO ESTÁ VACÍO, mostramos alerta
                    mensaje = "<p class=\"alerta\"> El nombre del atributo es obligatorio.</p>"; 
                    sesion.setAttribute("mensaje", mensaje);
            } else {
                    //EL ATRIBUTO EXISTE, mostramos la vista "datos"                    
                    sesion.setAttribute("datos", true);
            }
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
            
        case "Todos":
            
            //Recorremos los nombres de los atributos de sesión de tipo Usuario y los añadimos a un arraylist que leeremos desde la vista
            Enumeration<String> nombresUsuario = sesion.getAttributeNames();
            List<String> lista = new ArrayList<>();
            while (nombresUsuario.hasMoreElements()) {
                String nombreUsuario = nombresUsuario.nextElement();
                if (sesion.getAttribute(nombreUsuario) instanceof Usuario) {
                    lista.add(nombreUsuario);
                }
            }
            
            //Mandamos la lista a la vista como atributo de sesión
            sesion.setAttribute("listaUsuarios", lista);
            //Mostramos la vista "lista"
            sesion.setAttribute("lista", true);
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
        
        case "Crear":

            if (nombre == null || nombre.trim().isEmpty()
                    || fecha == null || fecha.trim().isEmpty()
                    || numHijos == null || numHijos.trim().isEmpty()
                    || salario == null || salario.trim().isEmpty()) {

                mensaje = "<p class=\"alerta\">Todos los datos son obligatorios.</p>";
                sesion.setAttribute("datos", true);
                
            } else {
                SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
                Date fechaFormateada = formato.parse(fecha);

                Usuario usuarioNuevo = new Usuario();
            
                usuarioNuevo.setNombre(nombre);
                usuarioNuevo.setFechaNacimiento(fechaFormateada);
                usuarioNuevo.setNumHijos(Integer.parseInt(numHijos));
                usuarioNuevo.setSalario(Double.parseDouble(salario));
            
                sesion.setAttribute(nombreBuscado, usuarioNuevo);
            
                mensaje = "<p class=\"exito\">Atributo de sesi&oacute;n creado con nombre: \""+ nombreBuscado +"\"<br> del usuario: <strong>"+usuarioNuevo.getNombre()+"</strong>.</p>";             
            }
            
            sesion.setAttribute("mensaje", mensaje);
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
            
        case "Actualizar":
            
            if (nombre == null || nombre.trim().isEmpty()
                    || fecha == null || fecha.trim().isEmpty()
                    || numHijos == null || numHijos.trim().isEmpty()
                    || salario == null || salario.trim().isEmpty()) {
                    
                mensaje = "<p class=\"alerta\">Todos los campos son obligatorios.</p>";
                sesion.setAttribute("datos", true);
            } else {
                SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
                Date fechaFormateada = formato.parse(fecha);
            
                usuario.setNombre(nombre);
                usuario.setFechaNacimiento(fechaFormateada);
                usuario.setNumHijos(Integer.parseInt(numHijos));
                usuario.setSalario(Double.parseDouble(salario));
            
                sesion.setAttribute(nombreBuscado, usuario);
            
                mensaje = "<p class=\"exito\">Atributo de sesi&oacute;n con nombre: \""+ nombreBuscado +"\"<br>modificado con &eacute;xito.</p>";             
            }
            
            sesion.setAttribute("mensaje", mensaje);
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
        
        case "Eliminar":
            sesion.setAttribute("confirmarEliminar", true);
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
        
        case "Conforme":
            sesion.removeAttribute(nombreBuscado);
            mensaje = "<p class=\"exito\">Atributo de sesi&oacute;n con nombre: \""+ nombreBuscado +"\"<br> eliminado con &eacute;xito.</p>";
            sesion.setAttribute("mensaje", mensaje);
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
            
        case "No realizar":
            sesion.setAttribute("datos", true);
            mensaje = "<p class=\"exito\">Se ha cancelado la eliminaci&oacute;n del atributo<br>de sesi&oacute;n: \""+ nombreBuscado +"\".</p>";
            sesion.setAttribute("mensaje", mensaje);
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
            
        case "Cancelar":
            sesion.setAttribute("nombreBuscado", "");
            sesion.removeAttribute("datos");
            sesion.removeAttribute("confirmarEliminar");
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
        
        case "Eliminar todos":
            //Recorremos los nombres de los atributos de sesión de tipo Usuario y los añadimos a un arraylist
            Enumeration<String> usuarios = sesion.getAttributeNames();
            List<String> listaEliminar = new ArrayList<>();
            while (usuarios.hasMoreElements()) {
                String nombreUsuario = usuarios.nextElement();
                if (sesion.getAttribute(nombreUsuario) instanceof Usuario) {
                    listaEliminar.add(nombreUsuario);
                }
            }
            
            //For each nombreUsuario dentro de la listaEliminar, iremos eliminando cada uno
            for (String nombreUsuario : listaEliminar) {
                session.removeAttribute(nombreUsuario);
            }
            response.sendRedirect(request.getContextPath() + "/jsp/vista_gestionSesion.jsp");
            break;
        
        case "Inicio":
            response.sendRedirect(request.getContextPath());
            break;
        
    }
    
%>
