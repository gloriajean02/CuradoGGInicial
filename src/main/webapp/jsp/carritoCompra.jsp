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
        <h1>Gestor de vuelta</h1>
<%
    //Obtenemos el precio
    String precioStr = request.getParameter("precio");
    double precio = 0;
    if(precioStr != null && !precioStr.isEmpty()) {
        precio = Double.parseDouble(precioStr);
        //Lo pasamos a céntimos
        precio = precio * 100;
    }
    
    //Obtenemos el dinero entregado
    String entregaStr = request.getParameter("entregado");
    double entregado = 0;
    if(entregaStr != null && !entregaStr.isEmpty()) {
        entregado = Double.parseDouble(entregaStr);
        //Lo pasamos a céntimos
        entregado = entregado * 100;
    }
    
    //Obtenemos la vuelta en céntimos
    double vuelta = entregado - precio;
     
    //La moneda mayor es 50000, así que empezamos por ahí
    double moneda = 50000;
    
    
    StringBuilder imprimirMonedas = new StringBuilder();
    
    while (vuelta != 0) {
        
        int contadorMonedas = 1;
        //Si la moneda es más grande que la vuelta (la resta dará números negativos), no nos interesa, pasamos a otra
        //En cambio si la resta da números positivos, restamos la moneda a la vuelta y la adjudicamos para el cambio
        if (vuelta - moneda >= 0){  
            vuelta = vuelta - moneda;
            //Pasamos de céntimos a euros
            Double monedaDecimal = moneda / 100;
            imprimirMonedas.append(monedaDecimal);
            
            //mientras que (vuelta - moneda actual) resulte positivo o 0, seguimos restando y aumentando el contadorMonedas para esta moneda
            while (vuelta - moneda >= 0) {
                vuelta = vuelta - moneda;
                contadorMonedas++;
            }
            imprimirMonedas.append("["+contadorMonedas+"] ,");
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

        <p><%= imprimirMonedas %></p>
        
    </body>
</html>
