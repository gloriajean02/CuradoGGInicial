<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:directive.page contentType="text/html" pageEncoding="UTF-8"/>
<!DOCTYPE html>
<head>
    <link rel="stylesheet" type="text/css" href="${applicationScope.estilo}">
    <title>Editar carta</title>
</head>
<body>

    <main>
        <section class="container">                
            <form action="${contexto}/EditarCartaController" method="post">
                <c:set var="carta" value="${requestScope.cartaSeleccionada}"/>

                <div class="editor-carta">

                    <input type="hidden" name="id" value="${carta.id}" />
                    <img src="${contexto}/imagenes/${carta.imagen}" alt="${carta.nombre}">

                    <label>Nombre:</label>
                    <input type="text" name="nombre" value="${carta.nombre}" />

                    <label>Elixir:</label>
                    <input type="number" name="elixir" value="${carta.elixir}" />

                    <label>Rareza:</label>
                    <select name="rareza">
                        <option value="comun"  ${carta.rareza == 'comun'  ? 'selected' : ''}>Común</option>
                        <option value="rara"   ${carta.rareza == 'rara'   ? 'selected' : ''}>Rara</option>
                        <option value="epica"  ${carta.rareza == 'epica'  ? 'selected' : ''}>Épica</option>
                    </select>

                    <button type="submit" name="accion" value="editar">Guardar cambios</button>

                </div>
            </form>
        </section>
    </main>


</body>