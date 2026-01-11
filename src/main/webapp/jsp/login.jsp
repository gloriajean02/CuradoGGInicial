<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
<!DOCTYPE html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/estilosCartas.css">
    <title>Login</title>
</head>
<body>

    <main>
        <section class="form">
            <h1>Login</h1>
            <c:if test="${!empty requestScope.mensaje}">
                <p class="error">${requestScope.mensaje}</p>
            </c:if>
            <form action="${pageContext.request.contextPath}/LoginController" method="post">
                <label>Usuario:</label>
                <input type="text" name="usuario" value=""/>
                <label>Contraseña:</label>
                <input type="password" name="clave" value=""/>
                <label>Teléfono:</label>
                <input type="number" name="telefono" value=""/>
                <input type="submit" name="accion" value="Login"/>
                <br><br>
                <input type="submit" name="accion" value="Volver al inicio"/>
            </form>
        </section>
    </main>


</body>
