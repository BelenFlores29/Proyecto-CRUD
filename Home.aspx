<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebSiteExampleLI.Pages.Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Home</title>
    <link href="\Bootstrap\bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFFFFF; /* Beige claro */
            color: #333333;
            font-family: 'Helvetica', sans-serif;
        }

        h2 {
            font-family: 'Georgia', serif;
            font-size: 36px;
            color: #000000; /* Negro */
            font-weight: bold;
            text-align: center; /* Centrado */
            margin-bottom: 20px;
            padding-top: 20px;
        }

        /* Estilos para el menú de navegación */
        nav {
            width: 100%;
            background-color:  #5C3B1E;
            padding: 10px;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            display: flex;
            justify-content: center;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 20px;
        }

        nav ul li {
            display: inline;
        }

        nav ul li a {
            color: #FFFFFF;
            text-decoration: none;
            font-size: 18px;
            font-family: 'Georgia', serif;
            font-weight: bold;
            padding: 5px 15px;
        }

        nav ul li a:hover {
            color: #FAF3E0; /* Color al pasar el puntero */
        }

        .main-content {
            margin-top: 80px;
        }

        .custom-image { 
            width: 425px; /* Ancho de la imagen */ 
            height: auto; /* Altura automática para mantener la proporción */ 
            display: block; /* Hace que el margen auto funcione */ 
            margin-left: auto; 
            margin-right: auto; 

        }
    </style>
</head>
<body>
    <!-- Menú de navegación -->
    <nav>
        <ul>
            <li><a href="Home.aspx">Inicio</a></li>
            <li><a href="Alumno.aspx">Alumno</a></li>
            <li><a href="Admin.aspx">Administrador</a></li>
        </ul>
    </nav>

    <div class="container text-center main-content">
        <h2>Esc. Prep. Fed. Por Coop. Prof. Augusto Hdez. Olivé</h2>
        <img src="/Imagen/Imagen10.jpeg" class="custom-image" >
    </div>
</body>
</html>
