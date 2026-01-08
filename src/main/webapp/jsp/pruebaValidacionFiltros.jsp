<jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario</title>
    </head>
    <body>
        <h1>Formulario</h1>    
        <form action="${pageContext.request.contextPath}/PruebaValidFiltrosController" method="post">
            <table>
                <tr>
                    <td>ID</td>
                    <td><input type="number" name="id" value="${param.id}"></td> 
                </tr>
                <tr>
                    <td>Nombre</td>
                    <td><input type="text" name="nombre" value="${param.nombre}"></td>
                </tr>
                <tr>
                    <td>Fecha</td>
                    <td><input type="date" name="fecha" value="${param.fecha}"></td>
                </tr>
                <tr>
                    <td>Tipo de identificaci&oacute;n</td>
                    <td>
                        <select name="tipoIdentificacion">
                            <option value="NIF" ${(param.tipoIdentificacion eq 'NIF')? "selected" : ""}>NIF</option>
                            <option value="NIE" ${(param.tipoIdentificacion eq 'NIE')? "selected" : ""}>NIE</option>
                            <option value="PASAPORTE" ${(param.tipoIdentificacion eq 'PASAPORTE')? "selected" : ""}>PASAPORTE</option>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>Identificaci&oacute;n</td>
                               <td><input type="text" name="identificacion" value="${param.identificacion}"></td>
                </tr>
                <tr>
                    <td>Preferencias</td>
                    <td>
                        <select name="preferencias" multiple>
                            <option value="Bailar" ${(param.preferencias eq 'Bailar')? "selected" : ""}>Bailar</option>
                            <option value="Nadar" ${(param.tipoIdentificacion eq 'Nadar')? "selected" : ""}>Nadar</option>
                            <option value="Leer" ${(param.tipoIdentificacion eq 'Leer')? "selected" : ""}>Leer</option>
                            <option value="Dibujar" ${(param.tipoIdentificacion eq 'Dibujar')? "selected" : ""}>Dibujar</option>
                        </select>

                    </td>
                </tr>
            </table>
            
            <input type="submit" class="boton" id="botonGris" name="accion" value="Cancelar">
            <input type="submit" class="boton" id="botonVerde" name="accion" value="Crear">
            
        </form>
    </body>
</html>