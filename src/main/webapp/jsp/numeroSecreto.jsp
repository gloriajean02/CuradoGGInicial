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
            %>
            
            <form method="post" action="../jsp/numeroSecreto.jsp">
<!--                Tanto numeroSecreto como intentos se irán guardando en estos inputs ocultos del form-->
                <input type="hidden" name="intentos" value="<%= intentos %>">
                <input type="hidden" name="numeroSecreto" value="<%= numeroSecreto%>">
                <p><em>El ordenador "piensa" un n&uacute;mero y tenemos que averiguarlo en la menor cantidad de intentos posible.</em></p><br>
                <label>Introduce un n&uacute;mero del 1 al 100: <input type="number" name="numero" min="1" max="100"></label><br>
                    <%
                        if (!acierto) {
                    %>
                <input type="submit" class="botonEnviar" name="comprobar" value="Comprobar">
                <%
                } else {
                %>
                <a class="enlace" href="<%= request.getContextPath()%>">Volver</a>
                <%
                    }
                %>
            </form>
            
            <%
              //Si el String intentos no está vacio, imprimimos tabla
              if (!intentos.isEmpty()) {
                %>
                <table id="tablaNumSecreto">
                <%
                //Sacamos un Array de intentos dividiendolos por las ,
                String[] listaIntentos = intentos.split(", ");
                
                //Recorremos el array para imprimir la tabla
                for (String intento : listaIntentos) {
                    int intentoINT = Integer.parseInt(intento);
                %>
                <tr>
                    <td><%= intento%></td>
                <%
                    if (intentoINT > numeroSecreto){
                    %>
                    <td>El n&uacute;mero secreto es menor</td>
                    <%    
                    } else if (intentoINT < numeroSecreto) {
                    %>
                    <td>El n&uacute;mero secreto es mayor</td>
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
