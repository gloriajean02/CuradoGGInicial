<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
<c:set var="contexto" value="${pageContext.request.contextPath}" scope="application"/>
<c:url var="estilo" value="/css/estilosCartas.css" scope="application"/>
<!DOCTYPE html>
<head>
    <link rel="stylesheet" type="text/css" href="${applicationScope.estilo}">
    <title>Cartas</title>
</head>
<body>

    <main>
        <section class="container">                
            <form action="${contexto}/CartasController" method="post">
                <div class="cartas">

                    <c:forEach var="entrada" items="${applicationScope.cartas}">
                        <c:set var="carta" value="${entrada}"/>
                        <div class="carta">
                            <button type="submit" name="accion" value="${carta.id}">
                                <img src="${contexto}/imagenes/${carta.imagen}" >
                            </button>
                            <p>${carta.nombre}</p>
                            <p>Elixir: ${carta.elixir}</p>
                            <p>Rareza: ${carta.rareza}</p>
                        </div>
                    </c:forEach>

                </div>
            </form>
        </section>
    </main>

</body>
