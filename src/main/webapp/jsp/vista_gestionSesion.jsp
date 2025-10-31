<%@page import="java.util.List"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="es.albarregas.beans.Usuario" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Control de sesiones</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/sesionesStyle.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <%  
        //Obtener el mensaje almacenado en sesión
        String mensaje = (String) session.getAttribute("mensaje");
        
        //Obtener el nombre buscado si está previamente almacenado en sesión
        String nombreBuscado = (String) session.getAttribute("valueNombreBuscado");
        
        //Banderas para controlar las vistas
        boolean datos = Boolean.TRUE.equals(session.getAttribute("datos"));
        boolean lista = Boolean.TRUE.equals(session.getAttribute("lista"));
        boolean confirmarEliminar = Boolean.TRUE.equals(session.getAttribute("confirmarEliminar"));
        
        //Saber si existen usuarios ya registrados para sacar el botón "todos" o no
//        boolean existenUsuarios = Boolean.TRUE.equals(session.getAttribute("existenUsuarios"));
        
        //Si estamos en cualquiera de estas vistas, la búsqueda se bloquea
        boolean deshabilitarBusqueda = false;
        if (datos || lista || confirmarEliminar) {
            deshabilitarBusqueda = true;
        }
        
        //Revisar si el nombreBuscado es ya un usuarioCreado o no
        Usuario usuarioCreado = null;
        if (nombreBuscado != null && !nombreBuscado.trim().isEmpty()) {
            usuarioCreado = (Usuario) session.getAttribute(nombreBuscado);
        }
        
        //Boolean existenUsuarios para saber si mostrar botón "Todos"
        boolean existenUsuarios = false;

        //Recorremos los atributos para saber si son de tipo usuario
        Enumeration<String> atributos = session.getAttributeNames();
        while (atributos.hasMoreElements() && !existenUsuarios) {
            Object atributo = session.getAttribute(atributos.nextElement());
            if (atributo instanceof Usuario) {
                existenUsuarios = true;
            }
        }
        
        //Lista para mostrar todos los usuarios guardados
        List<String> listaUsuarios = (List<String>) session.getAttribute("listaUsuarios");
    %>
    <body>
        <h1>Control de sesiones</h1>
        <form action="controlador_gestionSesion.jsp" method="post">
            
            <section id="atributoSesion">
                <%                   
                    if (mensaje != null) {
                %>
                    <%= mensaje %>                    
                <%                  
                    }
                %>
                <h3>Atributo de sesi&oacute;n</h3>
                <div class="contenedor">
                    <label>Nombre</label>
                    
                    <input type="text" name="nombreBuscado" <%= (deshabilitarBusqueda) ? "readonly" : "" %>
                        <%= (nombreBuscado != null && deshabilitarBusqueda) ?  "value=\"" + nombreBuscado + "\"" : "" %> >
                    
                    <input type="submit" class="boton" id="botonVerde" name="accion" value="Buscar"
                        <%= (deshabilitarBusqueda) ? "disabled" : "" %> >
                    <%
                        if (!deshabilitarBusqueda && existenUsuarios) {                  
                    %>
                    <input type="submit" class="boton" id="botonAzul" name="accion" value="Todos">
                    <%
                        }
                    %>
                </div>
            </section>
            
            <%
                if (datos) {
            %>
            <section id="datosAtributo">
                <h3>Datos del atributo de sesi&oacute;n</h3>
                <div class="contenedor">
                    <table>
                        <tr>
                            <td>Nombre</td>
                            <td><input type="text" name="nombre" value="<%= usuarioCreado != null && usuarioCreado.getNombre() != null ? 
                                    usuarioCreado.getNombre() : ""%>"></td>
                        </tr>
                        <tr>
                            <td>Fecha de nacimiento</td>
                            <td><input type="date" name="fechaNacimiento" value="<%= usuarioCreado != null && usuarioCreado.getFechaNacimiento() != null ?
                                    new java.text.SimpleDateFormat("yyyy-MM-dd").format(usuarioCreado.getFechaNacimiento()) : ""%>"></td>
                        </tr>
                        <tr>
                            <td>N&uacute;mero de hijos</td>
                            <td><input type="text" name="numHijos" step="1" value="<%= usuarioCreado != null && usuarioCreado.getNumHijos() != null ? 
                                    usuarioCreado.getNumHijos() : ""%>"></td>
                        </tr>
                        <tr>
                            <td>Salario</td>
                            <td><input type="text" name="salario" step="0.01" value="<%= usuarioCreado != null && usuarioCreado.getSalario() != null ? 
                                    usuarioCreado.getSalario() : ""%>"></td>
                        </tr>
                    </table>
                </div>
            </section>
            <%
                }
            %>
            
            <%
                if (lista) {
            %>
            <section id="listadoAtributos">
                <h3>Listado de atributos</h3>
                <div class="contenedor" id="atributos">
                    <% if (listaUsuarios != null && !listaUsuarios.isEmpty()) { %>
                    <ul>
                        <% for (String usuario : listaUsuarios) {%>
                            <li><%= usuario%></li>
                        <% } %>
                    </ul>
                    <% } %>
                </div>
            </section>
            <%
                }

                
                if (!confirmarEliminar) {
            %>
            
            <section id="acciones">
                <h3>Acciones</h3>
                <div class="contenedor">
            <%
                if (datos) {
                
                    if (usuarioCreado == null) {
            %>      
                    <input type="submit" class="boton" id="botonVerde" name="accion" value="Crear">            
            <%
                    } else {
            %>            
                    <input type="submit" class="boton" id="botonAzul" name="accion" value="Actualizar">
                    <input type="submit" class="boton" id="botonRojo" name="accion" value="Eliminar">                   
            <%  
                    }
            %>        
                    <input type="submit" class="boton" id="botonGris" name="accion" value="Cancelar">
            <%
                }                
              
                if (lista) {
            %>
                    <input type="submit" class="boton" id="botonRojo" name="accion" value="Eliminar todos">
                    <input type="submit" class="boton" id="botonGris" name="accion" value="Cancelar">
            <%
                }
            %>                   
                   <input type="submit" class="boton" id="botonLila" name="accion" value="Inicio">
                </div>
            </section>
            
            <%
                } else {
            %>
            <section id="accionesEliminar">
                <p>¿Est&aacute;s seguro de que quieres eliminar el atributo de sesi&oacute;n?</p>
                <div class="contenedor">
                    <input type="submit" class="boton" id="botonVerde" name="accion" value="Conforme">
                    <input type="submit" class="boton" id="botonGris" name="accion" value="No realizar">
                    <input type="submit" class="boton" id="botonLila" name="accion" value="Inicio">
                </div>
            </section>
            <%                   
                }
            %>
        </form>
        
            <% 
                session.removeAttribute("mensaje");
                session.removeAttribute("datos");
                session.removeAttribute("lista");
                session.removeAttribute("confirmarEliminar");
            %>
        
        <footer>Gloria Curado Garc&iacute;a ©</footer>
    </body>
</html>
