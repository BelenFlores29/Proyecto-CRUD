<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="Alumno.aspx.cs" Inherits="WebSiteExampleLI.Pages.Alumno" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Perfil del Alumno</title>
    <link href="\Bootstrap\bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa; /* Fondo gris claro */
        }
        .top-bar {
            background-color: #5C3B1E; 
            height: 50px; /* Aumentamos la altura de la franja superior */
            position: relative; /* Para permitir el uso de 'position: absolute' en el enlace */
        }
        .top-bar a {
            font-family: 'Georgia', serif; /* Letra más elegante */
            color: white; /* Color blanco para el texto */
            text-decoration: none; /* Eliminar subrayado */
            font-size: 1.2em; /* Tamaño de la letra */
            position: absolute;
            right: 20px; /* Alineado a la derecha */
            top: 50%; /* Centrado verticalmente */
            transform: translateY(-50%); /* Ajuste de centrado */
        }
        .container {
            margin-top: 70px;
            margin-bottom: 70px;
            text-align: center;
            width: 70%; /* Ajustar el ancho del contenedor */
            margin-left: auto;
            margin-right: auto;
        }
        h2, h3 {
            text-align: center;
            font-family: 'Georgia', serif; /* Letra más elegante */
            font-size: 2em;
            color: black; /* Color negro para ambos títulos */
        }
        .student-info {
            margin-top: 20px;
            text-align: left;
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif; /* Cambiado a Times New Roman */
        }
        .student-info label {
            font-family: 'Times New Roman', Times, serif; /* Cambiado a Times New Roman */
            font-weight: bold;
            font-size: 20px;
            margin-top: 10px;
            display: block;
        }
        .row {
            display: flex;

        }
        .column {
            flex: 0 0 45%;
            padding: 10px;
        }
        .column + .column {
            margin-left: 20px;
        }

        /* Tabla de actividades */
        .activities-table {
            margin-top: 0; /* Elimina el margen superior */
            width: 100%;
            border-collapse: collapse;
            table-layout: auto; /* Ajusta automáticamente las celdas */
            border: 1px solid #ddd; /* Borde uniforme */
        }
        .activities-table th, .activities-table td {
            padding: 10px;
            text-align: center; /* Centrado horizontal */
            vertical-align: middle; /* Centrado vertical */
            border: 1px solid #ddd;
            font-family: 'Georgia', serif; /* Letra más elegante */
            white-space: nowrap; /* Evitar saltos de línea */
        }
        .activities-table th {
            background-color: #5C3B1E;
            color: white;
        }
        .activities-table td {
            white-space: nowrap; /* Evitar que el texto se divida en varias líneas */
        }
        .activities-table .danza-contemporanea {
            white-space: normal; /* Permite que el texto se divida en varias líneas */
        }
        .btn-inscribir {
            background-color: #f8f9fa; 
            color: #5C3B1E;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 5px;
            white-space: nowrap;
        }
        .btn-inscribir:hover {
            background-color: #f8f9fa; 
        }
        .activities-table td:last-child {
            width: 150px; /* Ancho más amplio para la columna Inscribirse */
        }

        /* Ajuste del contenedor de la tabla */
        .table-wrapper {
            overflow-x: auto;
            border: 1px solid #ddd; /* Marco uniforme */
            margin-top: 20px;
        }

        /* Eliminar bordes adicionales innecesarios */
        .activities-table tr:first-child th {
            border-top: none;
        }
        .activities-table tr:last-child td {
            border-bottom: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top-bar">
            <a href="Login.aspx">Regresar</a> <!-- Enlace "Regresar" alineado a la derecha -->
        </div> <!-- Franja superior -->
        <div class="container">
            <h2>Perfil del Alumno</h2>
            <div class="row">
               <div class="column">
                   <div class="student-info">
                       <label>Matrícula:</label>
                       <asp:Label ID="lblMatricula" runat="server" Text=""></asp:Label><br />
                       <label>Nombre:</label>
                       <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label><br />
                       <label>Turno:</label>
                       <asp:Label ID="lblTurno" runat="server" Text=""></asp:Label><br />
                       <label>Semestre:</label>
                       <asp:Label ID="lblSemestre" runat="server" Text=""></asp:Label><br />
                   </div>
               </div>
               <div class="column">
                   <div class="student-info">
                       <label>Fecha de Nacimiento:</label>
                       <asp:Label ID="lblFechaNacimiento" runat="server" Text=""></asp:Label><br />
                       <label>Dirección:</label>
                       <asp:Label ID="lblDireccion" runat="server" Text=""></asp:Label><br />
                       <label>Teléfono:</label>
                       <asp:Label ID="lblTelefono" runat="server" Text=""></asp:Label><br />
                       <label>Correo:</label>
                       <asp:Label ID="lblCorreo" runat="server" Text=""></asp:Label><br />
                   </div>
               </div>
            </div>
            <!-- Sección de la tabla de actividades -->
            <h3>Actividades</h3>
            <div class="table-wrapper">
                <asp:GridView ID="gvActividades" runat="server" AutoGenerateColumns="False" CssClass="activities-table" OnRowDataBound="gvActividades_RowDataBound" OnRowCommand="gvActividades_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Actividad" HeaderText="Actividad" SortExpression="Actividad" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion" />
                        <asp:BoundField DataField="Lugar" HeaderText="Lugar" SortExpression="Lugar" />
                        <asp:BoundField DataField="Día" HeaderText="Día" SortExpression="Día" />
                        <asp:BoundField DataField="Hora" HeaderText="Hora" SortExpression="Hora" />
                        <asp:TemplateField HeaderText="Inscribirse">
                            <ItemTemplate>
                                <asp:Button ID="btnInscribir" runat="server" Text="Enviar solicitud" CommandName="Inscribir" CssClass="btn-inscribir" CommandArgument='<%# Container.DataItemIndex %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div class="bottom-bar"></div> <!-- Franja inferior -->
    </form>
</body>
</html>











