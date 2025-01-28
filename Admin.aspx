<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebSiteExampleLI.Pages.Admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Administrador</title>
    <link href="\Bootstrap\bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa; /* Fondo gris claro */
        }
        .container {
            margin-top: 50px;
            text-align: center;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-family: 'Times New Roman', serif; /* Letra más elegante */
            font-size: 2em;
        }
        h3 {
            text-align: center;
            margin-bottom: 15px;
            font-family: 'Georgia', serif; /* Letra más elegante */
        }
        .btn {
            margin: 5px;
        }
        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #fff;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            color: #fff;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            color: #fff;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
            color: #fff;
        }
        .btn-dark-brown {
            background-color: #5C3B1E; /* Café oscuro */
            border-color: #5C3B1E;
            color: #fff;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .short-textbox {
            width: 30%; /* Hace los TextBox más cortos */
            margin: 0 auto; /* Centrados */
        }
        .navbar-custom {
            background-color: #5C3B1E; /* Café oscuro */
        }
        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link {
            color: #ffffff; /* Letra blanca */
            font-family: 'Georgia', serif; /* Letra elegante */
        }
        /* Estilos para la franja superior y la referencia "Regresar" */
        .top-bar {
            background-color: #5C3B1E; /* Café oscuro */
            height: 50px;
            text-align: center;
            position: relative;
        }
        .top-bar a {
            font-family: 'Georgia', serif; /* Letra elegante */
            color: white; /* Color blanco */
            text-decoration: none; /* Sin subrayado */
            font-size: 1.5em; /* Tamaño de letra más grande */
            line-height: 50px; /* Centrado verticalmente */
        }
    </style>
</head>
<body>
    <!-- Menú de navegación superior -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Administrador</a>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="Gestion.aspx">Gestión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <form id="form1" runat="server">
        <div class="container">
            <h2>Administrar Usuarios</h2>
            <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False" DataKeyNames="Usuario_Id" CssClass="table table-striped table-bordered"
                          OnRowEditing="GridViewUsers_RowEditing" 
                          OnRowUpdating="GridViewUsers_RowUpdating" 
                          OnRowCancelingEdit="GridViewUsers_RowCancelingEdit" 
                          OnRowDeleting="GridViewUsers_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="Usuario_Id" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Username" HeaderText="Matrícula" />
                    <asp:BoundField DataField="PasswordHash" HeaderText="Contraseña" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-warning btn-sm">Editar</asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-danger btn-sm">Eliminar</asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm">Actualizar</asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm">Cancelar</asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Button ID="btnAddUser" runat="server" Text="Agregar Usuario" CssClass="btn btn-dark-brown" OnClientClick="showAddUserForm(); return false;" />

            <asp:Panel ID="addUserForm" runat="server" Style="display:none;">
                <h3>Agregar Nuevo Usuario</h3>
                <div class="form-group">
                    <label for="txtNewUsername">Matrícula:</label>
                    <asp:TextBox ID="txtNewUsername" runat="server" CssClass="form-control short-textbox" />
                </div>
                <div class="form-group">
                    <label for="txtNewPassword">Contraseña:</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control short-textbox" TextMode="Password" />
                </div>
                <div>
                    <asp:Button ID="btnSubmitNewUser" runat="server" Text="Agregar Usuario" CssClass="btn btn-dark-brown" OnClick="btnAddUser_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClientClick="document.getElementById('addUserForm').style.display='none'; return false;" />
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>

