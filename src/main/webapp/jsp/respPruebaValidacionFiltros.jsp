
<jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario</title>
    </head>
    <body>
        <h1>Formulario</h1>    
        <p> ID: ${param.id} </p>
        <p> Nombre: ${param.nombre} </p>
        <p> Fecha: ${param.fecha} </p>
        <p> Tipo de identificación: ${param.tipoIdentificacion}</p>
        <p> Identificación: ${param.identificacion}</p>
    </body>
</html>