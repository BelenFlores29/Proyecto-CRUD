<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="Gestion.aspx.cs" Inherits="WebSiteExampleLI.Pages.Gestion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestión</title>
    <link href="\Bootstrap\bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
            text-align: center;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-family: 'Times New Roman', serif;
            font-size: 2em;
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
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
            color: #fff;
        }
        .btn-dark-brown {
            background-color: #5C3B1E;
            border-color: #5C3B1E;
            color: #fff;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .short-textbox {
            width: 30%;
            margin: 0 auto;
        }
        .navbar-custom {
            background-color: #5C3B1E;
        }
        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link {
            color: #ffffff;
            font-family: 'Georgia', serif;
        }
        .btn-container {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Gestión</a>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="Admin.aspx">Administrador</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <form id="form1" runat="server">
        <div class="container">
            <h2>Gestionar Actividades</h2>

            <!-- Botones de Acción -->
            <div class="btn-container">
                <asp:Button ID="btnAgregarAlumno" runat="server" Text="Agregar Alumno" CssClass="btn btn-dark-brown" OnClick="btnAgregarAlumno_Click" />
                <!-- Botón de Notificar Alumno -->
                <asp:Button ID="btnNotificarAlumno" runat="server" Text="Notificar Alumno" CssClass="btn btn-warning" OnClick="btnNotificarAlumno_Click" />
            </div>

            <!-- Panel para Agregar Alumno -->
            <asp:Panel ID="pnlAgregarAlumno" runat="server" Visible="false">                
                <div class="form-group">
                    <label for="txtNewMatricula">Matrícula:</label>
                    <asp:TextBox ID="txtNewMatricula" runat="server" CssClass="form-control short-textbox" />
                </div>
                <div class="form-group">
                    <label for="txtNewActividad">Actividad:</label>
                    <asp:TextBox ID="txtNewActividad" runat="server" CssClass="form-control short-textbox" />
                </div>
                <div>
                    <asp:Button ID="btnConfirmarAgregarAlumno" runat="server" Text="Agregar Alumno" CssClass="btn btn-dark-brown" OnClick="btnConfirmarAgregarAlumno_Click" />
                    <asp:Button ID="btnCancelarAgregarAlumno" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelarAgregarAlumno_Click" />
                </div>
            </asp:Panel>

            <!-- Panel para Notificar Alumno -->
            <asp:Panel ID="pnlNotificarAlumno" runat="server" Visible="false">
                <div class="form-group">
                    <label for="txtCorreoAlumno">Correo del Alumno:</label>
                    <asp:TextBox ID="txtCorreoAlumno" runat="server" CssClass="form-control short-textbox" />
                </div>
                <div class="form-group">
                    <asp:Button ID="btnExito" runat="server" Text="Éxito" CssClass="btn btn-success" OnClick="btnExito_Click" />
                    <asp:Button ID="btnRechazo" runat="server" Text="Rechazo" CssClass="btn btn-danger" OnClick="btnRechazo_Click" />
                    <asp:Button ID="btnCancelarNotificarAlumno" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelarNotificarAlumno_Click" />
                </div>
            </asp:Panel>

            <!-- GridView de Actividades -->
            <asp:GridView ID="GridViewActivities" runat="server" AutoGenerateColumns="False" DataKeyNames="ActTrans_ID"
                          CssClass="table table-striped table-bordered"
                          OnRowEditing="GridViewActivities_RowEditing"
                          OnRowUpdating="GridViewActivities_RowUpdating"
                          OnRowCancelingEdit="GridViewActivities_RowCancelingEdit"
                          OnRowDeleting="GridViewActivities_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ActTrans_ID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Est_ID" HeaderText="Matrícula" />
                    <asp:BoundField DataField="Act_Selec" HeaderText="Actividad" />
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

        </div>
    </form>
</body>
</html>

