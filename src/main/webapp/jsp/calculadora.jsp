<%@page import="java.util.InputMismatchException"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Calculadora</title>
        <link rel="stylesheet" type="text/css" href="../css/style.css">
    </head>
    <body>
        <h1>Calculadora</h1><br>
        <div class="formulario" >           
        <%
        //Switch es un input oculto que enviamos en el form para detectar rápidamente si se han enviado parámetros
        //Si se han enviado (es distinto de null) procedemos a comprobarlos
        if (request.getParameter("switch") != null) {
            //Sacamos la fecha actual, la formateamos y ponemos la primera letra en mayúsculas
            LocalDate fechaActual = LocalDate.now();
            DateTimeFormatter formato = DateTimeFormatter.ofPattern("EEEE d 'de' MMMM 'de' yyyy");
            String fechaFormateada = fechaActual.format(formato);
            String fechaMayus = fechaFormateada.substring(0, 1).toUpperCase() + fechaFormateada.substring(1);
            
            //Pedimos los parámetros
            String param1 = request.getParameter("param1");
            String param2 = request.getParameter("param2");
            
            //Intentamos parsearlos y calcular con ellos
            try {
                int num1 = Integer.parseInt(param1);
                int num2 = Integer.parseInt(param2);
                
                int resultado = 0;
                
                boolean divisionCero = false;
                
                String operacion = request.getParameter("operacion");
                switch (operacion) {
                    case "+":
                        resultado = num1 + num2;
                        break;
                    case "-":
                        resultado = num1 - num2;
                        break;
                    case "*":
                        resultado = num1 * num2;
                        break;
                    case "/":
                        if (num2 == 0) {
                            divisionCero = true;
                        } else {
                            resultado = num1 / num2;
                        }
                        break;
                }
                
                if (divisionCero) {
        %>
        <p class="alerta">Se est&aacute; intentando dividir por cero</p><br>
        <%        
                } else {
        %>
        <p><%= fechaMayus%></p><br>
        <p>El resultado de <%= num1%> <%= operacion%> <%= num2%> = <%= resultado%></p><br>
        <%        
                }
            //Si hay fallo en el intento se manda excepción
            } catch(Exception e){
        %>
        <p class="alerta">Introduce n&uacute;meros v&aacute;lidos</p><br>
        <%            
            }
        }
        %>
        <h5>Calculadora b&aacute;sica</h5><br>
            <form method="post" action="../jsp/calculadora.jsp">
                <input type="hidden" name="switch" value="true">
                <table>             
                    <tr>
                        <td>Primer número:</td>
                        <td><input type="text" name="param1"></td>
                    </tr>
                    <tr>
                        <td>Segundo número:</td>
                        <td><input type="text" name="param2"></td>
                    </tr>
                    <tr>
                        <td><input type="radio" name= "operacion" value="+" checked="checked">Sumar</td>
                        <td><input type="radio" name= "operacion" value="-">Restar</td>                     
                    </tr>
                    <tr>
                        <td><input type="radio" name= "operacion" value="*">Multiplicar</td>
                        <td><input type="radio" name= "operacion" value="/">Dividir</td>
                    </tr>
                </table>
                <input type="submit" class="botonEnviar">
                <input type="reset" class="botonEliminar">
                <input type="button" class="botonVolver" name="volver" value="Volver al inicio" onclick="window.location.href='<%=request.getContextPath()%>'">                
            </form>
        </div>            
    </body>
</html>
