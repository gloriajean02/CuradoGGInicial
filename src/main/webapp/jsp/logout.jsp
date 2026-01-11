<jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
<!DOCTYPE html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/estilosCartas.css">
    <title>Home</title>
</head>
<body>

    <main>
        <section class="form">
            <h1>Home</h1>

            <p>Sesión de usuario correcta</p>

            <form action="${pageContext.request.contextPath}/LoginController" method="post">
                <input type="submit" name="accion" value="Logout"/>
                <input type="submit" name="accion" value="Volver al inicio"/>
            </form>
        </section>
    </main>


</body>