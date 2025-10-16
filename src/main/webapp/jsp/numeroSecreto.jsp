<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Juego del n&uacute;mero secreto</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/style.css">
    </head>
    <body>
        <h1>Juego del n&uacute;mero secreto</h1><br>
        <div class="formulario">
            <%
                //Inicializamos el random y declaramos el número secreto
                Random random = new Random();
                int numeroSecreto = 0;
                
                //Si el numeroSecreto es nulo, le damos un random, si no llamamos al value del parámetro
                if (request.getParameter("numeroSecreto") == null) {
                    numeroSecreto = random.nextInt(101);
                } else {
                    numeroSecreto = Integer.parseInt(request.getParameter("numeroSecreto"));
                }
                
                //Creamos un String de intentos para ir concatenando intentos más adelante
                String intentos = request.getParameter("intentos");
                if (intentos == null) {
                    intentos = "";
                }
                
                //Declaramos la bandera acierto para que cuando esté true muestre el botón volver y no el comprobar
                boolean acierto = false;
                
                //Nos guardamos el value del parámetro número
                String numeroInput = request.getParameter("numero");
                
                //Si comprobar no es nulo (es decir, el form se ha enviado) comienza la ejecución del programa
                if (request.getParameter("comprobar") != null) {
                    //Comprobamos si el número es nulo o vacío para que no haya error 500
                    if (numeroInput == null || numeroInput.isEmpty()){
                    %>
                    <p class="alerta">¡Elige un n&uacute;mero antes de comprobar!</p>
                    <%
                    //Si no es nulo, lo parseamos a int para poder compararlo con el númeroSecreto
                    } else {
                        int numeroINT = Integer.parseInt(numeroInput);
                        
                        //Si son iguales, acierto cambia a true y en el form eligirá el botón volver
                        if (numeroSecreto == numeroINT) {
                            acierto = true;
                        }
                        
                        //Pase lo que pase, siempre va a guardar el número en intentos. Los separamos por comas para luego hacer un split
                        if (!intentos.isEmpty()) {
                            intentos += ", ";
                        }
                        intentos += numeroINT;
                    }                    
                }
                
                //Establecemos los valores iniciales de mínimo y máximo
                int min = 1;
                int max = 100;
                
                //Si hay intentos, recorremos los intentos separando por las comas
                if (!intentos.isEmpty()) {
                    String[] listaIntentos = intentos.split(", ");
                    for (String intento : listaIntentos) {
                        int intentoINT = Integer.parseInt(intento);
                        //Si el intento es mayor al num secreto y menor al máximo, acotamos el max a este intento - 1
                        if (intentoINT > numeroSecreto && intentoINT - 1 < max) {
                            max = intentoINT - 1;
                        }
                        //Si el intento es menor al num secreto y mayor al mínimo, acotamos el min a este intento + 1
                        if (intentoINT < numeroSecreto && intentoINT + 1 > min) {
                            min = intentoINT + 1;
                        }
                    }
                }

                
            %>
            
            <form method="post" action="../jsp/numeroSecreto.jsp">
<!--                Tanto numeroSecreto como intentos se irán guardando en estos inputs ocultos del form-->
                <input type="hidden" name="intentos" value="<%= intentos %>">
                <input type="hidden" name="numeroSecreto" value="<%= numeroSecreto%>">
<!--                También nos enviaremos el valor actual de min y max por parámetro oculto-->
                <input type="hidden" name="min" value="<%= min%>">
                <input type="hidden" name="max" value="<%= max%>">
                <p><em>El ordenador "piensa" un n&uacute;mero y tenemos que averiguarlo en la menor cantidad de intentos posible.</em></p><br>
<!--                Establecemos los min y max con las variables anteriores-->
                <label>Introduce un n&uacute;mero del <%= min%> al <%= max%>: <input type="number" name="numero" min="<%= min%>" max="<%= max%>"></label><br>
                    <%
                        if (!acierto) {
                    %>
                <input type="submit" class="botonEnviar" name="comprobar" value="Comprobar">
                <%
                } else {
                %>
                <input type="button" class="botonEnviar" name="enviar" value="Inicio" onclick="window.location.href='<%= request.getContextPath() %>'">
                <%
                    }
                %>
            </form>
            
            <%
              //Si el String intentos no está vacio, imprimimos tabla
              if (!intentos.isEmpty()) {
                %>
                <table id="tablaNumSecreto">
                    <tr>
                        <th>N&uacute;mero</th>
                        <th>Mensaje</th>
                    </tr>
                <%
                //Sacamos un Array de intentos dividiendolos por las ,
                String[] listaIntentos = intentos.split(", ");                                
                
                //Recorremos el array para imprimir la tabla
                for (String intento : listaIntentos) {
                    int intentoINT = Integer.parseInt(intento);
                     
                %>
                <tr>
                    <td><%= intentoINT%></td>
                <%
                    if (intentoINT > numeroSecreto){                                              
                    %>
                    <td>El n&uacute;mero secreto es menor. Est&aacute; entre <%= min%> y <%= max%>.</td>
                    <%    
                    } else if (intentoINT < numeroSecreto) {
                    %>
                    <td>El n&uacute;mero secreto es mayor. Est&aacute; entre <%= min%> y <%= max%>.</td>
                    <%    
                    } else {
                    %>
                    <td>¡Has acertado!</td>
                    <%
                    }
                    %>
                </tr>
                <%
                }
                %>
                </table>
                <%
                
              }
            %>    
        </div>
    </body>
</html>
