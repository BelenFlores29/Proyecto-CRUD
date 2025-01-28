<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebSiteExampleLI.Pages.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Login</title>
    <!-- Ruta relativa de Bootstrap -->
    <link href="\Bootstrap\bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Estilos generales */
        body {
            background-color: #FAF3E0; /* Beige claro */
            color: #333333;
            font-family: 'Helvetica', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .left-container {
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background-color: #FFFFFF;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 350px; /* Mantener el tamaño proporcional */
            text-align: center;
        }

        .department-text {
            font-family: 'Georgia', serif;
            font-size: 26px;
            color: #5C3B1E; /* Café más oscuro */
            font-weight: bold;
            margin-bottom: 20px;
        }

        h2 {
            font-family: 'Georgia', serif;
            font-size: 30px; /* Ajustado un poco */
            color: #3E3A3A;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
            align-items: center; /* Centrar los labels y las cajas de texto */
            text-align: center;
        }

        label {
            font-family: 'Georgia', serif;
            font-size: 18px;
            color: #3E3A3A;
            text-align: center;
        }

        .form-control {
            font-size: 16px;
            color: #333333;
            background-color: #ffffff;
            border: 1px solid #D1C6B1;
            padding: 10px;
            width: 80%; /* Reduce el ancho de las cajas de texto */
            margin: 0 auto; /* Centrado horizontal */
        }

        .btn-custom {
            background-color: #5C3B1E; /* Café oscuro */
            color: white;
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            padding: 12px;
            text-transform: none; /* No usar mayúsculas */
            border: none;
            width: 80%; /* Mismo tamaño que las cajas de texto */
            margin-top: 15px;
        }

        .btn-custom:hover {
            background-color: #8C6B3F; /* Color más claro al pasar el puntero */
        }

        .register-link {
            margin-top: 15px;
            font-size: 16px;
            color: #000000; /* Color negro para "¿No tienes una cuenta?" */
        }

        .register-link a {
            color: #8C6B3F; /* Color café para el enlace */
        }

        .register-link a:hover {
            text-decoration: underline; /* Añadir subrayado al pasar el puntero */
        }

        .right-container {
            width: 50%;
            padding: 20px;
            margin-right: 100px; /* Mover un poco a la izquierda */
        }

        .carousel-inner img {
            width: 100%;
            height: 500px;
            object-fit: cover;
        }

        .carousel-fade .carousel-item {
            transition: opacity 1s ease;
        }
    </style>
</head>
<body>
    <!-- Contenedor de login a la izquierda -->
    <div class="left-container">
        <div class="login-container">
            <p class="department-text">Departamento de Deportes y Cultura</p>
            <form method="post" action="Login.aspx" runat="server">
                <div class="form-group">
                    <label for="txtUsername">MATRÍCULA</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required="required" />
                </div>
                <div class="form-group">
                    <label for="txtPassword">CONTRASEÑA</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" required="required" />
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-custom" OnClick="btnLogin_Click" />
                <p class="register-link">¿No tienes una cuenta? <a href="Registro.aspx">Regístrate aquí</a></p>
            </form>
        </div>
    </div>

    <!-- Carrusel de fotos a la derecha -->
    <div class="right-container">
        <div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="/Imagen/Imagen1.jpeg" class="d-block w-100" alt="Imagen 1">
                </div>
                <div class="carousel-item">
                    <img src="/Imagen/Imagen2.jpeg" class="d-block w-100" alt="Imagen 2">
                </div>
                <div class="carousel-item">
                    <img src="/Imagen/Imagen3.jpeg" class="d-block w-100" alt="Imagen 3">
                </div>
                <div class="carousel-item">
                    <img src="/Imagen/Imagen4.jpeg" class="d-block w-100" alt="Imagen 4">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>

    <!-- Bootstrap y jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
