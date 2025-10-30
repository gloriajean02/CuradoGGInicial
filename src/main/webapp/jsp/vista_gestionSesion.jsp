<%-- 
    Document   : vista_gestionSesion
    Created on : 29 oct 2025, 16:53:00
    Author     : gloriajean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Control de sesiones</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="../css/sesionesStyle.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <h1>Control de sesiones</h1>
        <form action="controlador_gestionSesion.jsp" method="post">
            
            <section id="atributoSesion">
                <%
                    String mensaje = (String) session.getAttribute("mensaje");
                    if (mensaje != null) {
                %>
                    <%= mensaje %>                    
                <%
                    session.removeAttribute("mensaje");
                    }
                %>
                <h3>Atributo de sesi&oacute;n</h3>
                <div class="contenedor">
                    <label>Nombre</label>
                    <input type="text" name="nombreAtributo"
                        <%= 
                            (session.getAttribute("vista") != null && !session.getAttribute("vista").equals("inicial")) 
                            ? "readonly" 
                            : "" 
                        %>
                        <% 
                            String nombreUsuario = (String) session.getAttribute("nombreUsuario");
                        %>
                        <%=
                            (nombreUsuario != null && !session.getAttribute("vista").equals("inicial")) 
                            ?  "value=\"" + nombreUsuario + "\"" 
                            : "" 
                        %> 
                    >

                    <input type="submit" class="boton" id="botonVerde" name="buscar" value="Buscar"
                        <%= 
                            (session.getAttribute("vista") != null && !session.getAttribute("vista").equals("inicial")) 
                            ? "disabled" 
                            : "" 
                        %>
                    >
                    <%
                        if (session.getAttribute("vista") != null && session.getAttribute("vista").equals("inicial") 
                            && session.getAttribute("existenUsuarios").equals("si")) {                  
                    %>
                    <input type="submit" class="boton" id="botonAzul" name="buscarTodos" value="Todos">
                    <%
                        }
                    %>
                </div>
            </section>
            
            <%
                if ((session.getAttribute("vista") != null && session.getAttribute("vista").equals("datos"))) {
            %>
            <section id="datosAtributo">
                <h3>Datos del atributo de sesi&oacute;n</h3>
                <div class="contenedor">
                    <table>
                        <tr>
                            <td>Nombre</td>
                            <td><input type="text" name="nombre"></td>
                        </tr>
                        <tr>
                            <td>Fecha de nacimiento</td>
                            <td><input type="date" name="fechaNacimiento"></td>
                        </tr>
                        <tr>
                            <td>N&uacute;mero de hijos</td>
                            <td><input type="text" name="numHijos"></td>
                        </tr>
                        <tr>
                            <td>Salario</td>
                            <td><input type="text" name="salario" step="0.01"></td>
                        </tr>
                    </table>
                </div>
            </section>
            <%
                }
            %>
            
            <%
                if ((session.getAttribute("vista") != null && session.getAttribute("vista").equals("lista"))) {
            %>
            <section id="listadoAtributos">
                <h3>Listado de atributos</h3>
                <div class="contenedor" id="atributos"></div>
            </section>
            <%
                }
            %>
            
            <section id="acciones">
                <h3>Acciones</h3>
                <div class="contenedor">
            <%
                if (session.getAttribute("vista") != null && session.getAttribute("vista").equals("datos")) {
                    if (session.getAttribute("nombreAtributo") == null) {
            %>      
                    <input type="submit" class="boton" id="botonVerde" name="crear" value="Crear">            
            <%
                    } else {
            %>            
                    <input type="submit" class="boton" id="botonAzul" name="actualizar" value="Actualizar">
                    <input type="submit" class="boton" id="botonRojo" name="eliminar" value="Eliminar">                   
            <%  
                    }
                }

                if (session.getAttribute("vista") != null && session.getAttribute("vista").equals("datos")) {
            %>                  
                    <input type="submit" class="boton" id="botonRojo" name="cancelar" value="Cancelar">
            <% 
                }
                
                if (session.getAttribute("vista") != null && session.getAttribute("vista").equals("lista")) {
            %>
                    <input type="submit" class="boton" id="botonRojo" name="eliminarTodos" value="Eliminar todos">
            <%
                }
            %>    
                    <input type="submit" class="boton" id="botonLila" name="inicio" value="Inicio">
                </div>
            </section>
            
            <%
                if (session.getAttribute("vista") != null && session.getAttribute("vista").equals("eliminar")) {
            %>
            <section id="accionesEliminar">
                <p>¿Est&aacute;s seguro de que quieres eliminar el atributo de sesi&oacute;n?</p>
                <div class="contenedor">
                    <input type="submit" class="boton" id="botonVerde" name="conforme" value="Conforme">
                    <input type="submit" class="boton" id="botonRojo" name="cancelar" value="Cancelar">
                    <input type="submit" class="boton" id="botonLila" name="inicio" value="Inicio">
                </div>
            </section>
            <%                   
                } 
            %>
        </form>
        
        <footer>Gloria Curado Garc&iacute;a ©</footer>
    </body>
</html>
