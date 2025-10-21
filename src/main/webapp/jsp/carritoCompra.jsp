<%-- 
    Document   : carritoCompra
    Created on : 19 oct 2025, 16:42:07
    Author     : gloriajean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <title>Carrito compra</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/style.css">
    </head>
    <body>
<%
    //Bandera para volver a mostrar formulario si hay errores
    boolean mostrarFormulario = false;
    
    //Alertas de error
    StringBuilder alerta = new StringBuilder();
    
    double precio = 0;
    double entregado = 0;
    
    //Comprobación de parámetros
    try {
        precio = Double.parseDouble(request.getParameter("precio"));
        entregado = Double.parseDouble(request.getParameter("entregado"));

        if(precio <= 0) {
            mostrarFormulario = true;
            alerta.append("<p class='alerta'><strong>Error:</strong> precio debe ser mayor que 0.</p>");
        }
        
        if(entregado <= 0 || entregado < precio) {
            mostrarFormulario = true;
            alerta.append("<p class='alerta'><strong>Error:</strong> el pago debe ser mayor o igual al precio.</p>");
        }
    } catch (Exception e) {
        mostrarFormulario = true;
        alerta.append("<p class='alerta'><strong>Error:</strong> introduce valores válidos.</p>");
    }
    
    //Si hay errores, mostramos formulario
    if (mostrarFormulario) {
    %>
        <h1>Carrito de la compra</h1>
        <div class="formulario">
            <%= alerta %>
            <form action="../jsp/carritoCompra.jsp" method="post">
                <h4>Entrada de datos</h4>
                <table>
                    <tr>
                        <td>Precio del producto:</td>
                        <td>
                            <input type="number" step="0.01" name="precio">
                        </td>
                    </tr>
                    <tr>
                        <td>Entregado:</td>
                        <td>
                            <input type="number" step="0.01" name="entregado">
                        </td>
                    </tr>
                </table>
                <input type="submit" class="botonEnviar" name="gestionarVuelta" value="Gestionar vuelta">
                <input type="button" class="botonVolver" value="Volver al inicio"
                       onclick="window.location.href='<%= request.getContextPath() %>'">
            </form>
        </div>
    <%
        
    //Si no hay errores continuamos
    } else {
    
        //Pasamos a céntimos
        precio = precio * 100;
        entregado = entregado * 100;
        
        //Obtenemos la vuelta en céntimos
        double vuelta = entregado - precio;
        
        //Guardamos la vuelta aquí para poder imprimirla después en euros
        double vueltaImprimir = vuelta/100;

        //La moneda mayor es 50000CENT (500€), así que empezamos por ahí
        double moneda = 50000;
        
        //Hago diferentes StringBuilders para poder imprimir los billetes en una línea y las monedas en otra
        StringBuilder imprimirBilletes = new StringBuilder();
        StringBuilder imprimirMonedas = new StringBuilder();
        StringBuilder imprimirContadorM = new StringBuilder();
        StringBuilder imprimirContadorB = new StringBuilder();

        while (vuelta != 0) {

            int contador = 1;
            //Si la moneda es más grande que la vuelta (la resta dará números negativos), no nos interesa, pasamos a otra
            //En cambio si la resta da números positivos, restamos la moneda a la vuelta y la adjudicamos para el cambio
            if (vuelta - moneda >= 0){  
                vuelta = vuelta - moneda;
                //Pasamos a string para poder buscar la imagen (1EUR = 100CENT.svg)
                String monedaSTR = String.valueOf((int) moneda);

                //Si la moneda es mayor a 500CENT (5€), imprimimos el StrBuilder de billetes, si no el de monedas
                if (moneda >= 500){
                    imprimirBilletes.append("<th><img src=\"../imagenes/"+monedaSTR+"CENT.svg\" height=\"60\"></th>\n");
                } else {
                    imprimirMonedas.append("<th><img src=\"../imagenes/"+monedaSTR+"CENT.svg\" height=\"60\"></th>\n");
                }

                //mientras que (vuelta - moneda actual) resulte positivo o 0, seguimos restando y aumentando el contador para esta moneda
                while (vuelta - moneda >= 0) {
                    vuelta = vuelta - moneda;
                    contador++;
                }
                
                //Si la moneda es mayor a 500CENT (5€), imprimimos el contador de billetes, si no el de monedas
                if (moneda >= 500) {
                    imprimirContadorB.append("<td>"+contador+"</td>\n");
                } else {
                    imprimirContadorM.append("<td>"+contador+"</td>\n");
                }

            }

            //Si después de escoger la moneda anterior las veces necesarias, la vuelta sigue siendo mayor a 0, calculamos la siguiente moneda
            if (vuelta > 0){
                //Detectamos si la moneda contiene el número 5
                String monedaSTR = String.valueOf(moneda);
                boolean cinco = false;
                for (int i = 0; i < monedaSTR.length() && !cinco; i++) {
                    if (monedaSTR.charAt(i) == '5') {
                        cinco = true;
                    }
                }

                //Si tiene 5 la dividimos entre 2.5 para pasar a la siguiente más pequeña, si no, entre 2
                if (cinco) {
                    moneda = moneda / 2.5; 
                } else {
                    moneda = moneda / 2; 
                }          
            }  
        } 
    %>
        <h1>Gestor de vuelta</h1>
        <div class="formulario">
            <%
                if (imprimirBilletes != null){
            %>
            <table id="tablaGestorVuelta">
                <tr>
                    <%= imprimirBilletes %>
                </tr>
                <tr>
                    <%= imprimirContadorB %>
                </tr>
            </table>
            <%
                }

                if (imprimirMonedas != null){
            %>
            
            <table id="tablaGestorVuelta">
                <tr>
                    <%= imprimirMonedas %>
                </tr>
                <tr>
                    <%= imprimirContadorM %>
                </tr>
            </table>
            <%
                }
            %>
            <p>Total a devolver: <%= vueltaImprimir %>€</p>
            <div id="divBotones">
                <button class="botonVolver" onclick="window.location.href='<%= request.getContextPath() %>'">
                    Volver al inicio
                </button>
                <button class="botonEnviar" onclick="window.location.href='<%= request.getContextPath() %>/html/carritoCompra.html'">
                    Otra operación
                </button>
            </div>    
                    
<%
    }
%>
    </body>
</html>
