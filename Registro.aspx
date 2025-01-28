<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="WebSiteExampleLI.Pages.Registro" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Registro</title>
    <!-- Ruta relativa de Bootstrap -->
    <link href="\Bootstrap\bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Estilos generales */
        body {
            background-image: url('/Imagen/Imagen5.jpeg'); /* Ruta a tu imagen de fondo */ 
            background-size: cover; /* Asegura que la imagen cubra todo el fondo */ 
            background-position: center; /* Centra la imagen de fondo */ 
            background-repeat: no-repeat;
            color: #333333;
            font-family: 'Helvetica', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .register-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 350px; /* Mantener el tamaño proporcional */
            text-align: center;
        }

        .register-text {
            font-family: 'Georgia', serif;
            font-size: 26px;
            color: #5C3B1E; /* Café oscuro */
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
            color: #333333; /* Color negro para el texto normal */
            font-family: 'Helvetica', serif; /* Tipo de letra "Georgia" */
        }

        .register-link a {
            color: #8C6B3F; /* Asegura que el enlace tenga el mismo color café */
            font-weight: normal; /* No en negrita */
            font-family: 'Helvetica', serif; /* Tipo de letra "Georgia" */
        }

        .register-link a:hover {
            text-decoration: underline; /* Añadir subrayado al pasar el puntero */
        }
    </style>
</head>
<body>
    <!-- Contenedor de registro centrado -->
    <div class="register-container">
        <h2>BIENVENIDO</h2>
        <form method="post" action="Registro.aspx" runat="server">
            <div class="form-group">
                <label for="txtUsername">MATRÍCULA</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required="required" />
            </div>
            <div class="form-group">
                <label for="txtPassword">CONTRASEÑA</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" required="required" />
            </div>
            <asp:Button ID="btnRegister" runat="server" Text="Registrarme" CssClass="btn btn-custom" OnClick="btnRegister_Click" />
            <p class="register-link" style="font-family: 'Helvetica', serif;">¿Ya tienes una cuenta? <a href="Login.aspx">Inicia sesión aquí</a></p>
        </form>
    </div>

    <!-- Bootstrap y jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



