using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using WebSiteExampleLI.EmailWSReference;  // Referencia del web service

namespace WebSiteExampleLI.Pages
{
    public partial class Alumno : System.Web.UI.Page
    {
        string connectionString = "Data Source=DESKTOP-H7HHTRT\\SQLEXPRESS;Initial Catalog=EscuelaDB;User ID=sa;Password=2001";

        // Método para obtener los datos del alumno
        private void LoadStudentData(int Est_ID)
        {
            string query = @"
                SELECT Est.Est_ID, Est.Est_Nombre, Est.Est_Turno, Est.Est_Semestre, 
                       Est.Est_FechaNacimiento, Est.Est_Direccion, 
                       Est.Est_Telefono, Est.Est_correo
                FROM Estudiante Est
                INNER JOIN Usuarios U ON Est.Est_ID = U.Est_ID
                WHERE U.Est_ID = @Est_ID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Est_ID", Est_ID);

                try
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            reader.Read();
                            lblMatricula.Text = reader["Est_ID"].ToString();
                            lblNombre.Text = reader["Est_Nombre"].ToString();
                            lblTurno.Text = reader["Est_Turno"].ToString();
                            lblSemestre.Text = reader["Est_Semestre"].ToString();
                            lblFechaNacimiento.Text = Convert.ToDateTime(reader["Est_FechaNacimiento"]).ToString("yyyy-MM-dd");
                            lblDireccion.Text = reader["Est_Direccion"].ToString();
                            lblTelefono.Text = reader["Est_Telefono"].ToString();
                            lblCorreo.Text = reader["Est_correo"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblNombre.Text = "Error al cargar los datos: " + ex.Message;
                }
            }
        }

        // Método para cargar las actividades estáticas
        private void LoadActivities()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Actividad");
            dt.Columns.Add("Descripcion");
            dt.Columns.Add("Lugar");
            dt.Columns.Add("Día");
            dt.Columns.Add("Hora");

            // Actividades estáticas
            dt.Rows.Add("Futbol", "Actividad deportiva", "Campo deportivo municipal", "Jueves", "4pm - 7pm");
            dt.Rows.Add("Baloncesto", "Actividad deportiva", "Cancha deportiva municipal", "Viernes", "5pm - 7pm");
            dt.Rows.Add("Folklore", "Actividad cultural", "Cancha escolar", "Sábado", "8am - 1pm");
            dt.Rows.Add("Pintura", "Actividad cultural", "Campo deportivo municipal", "Lunes", "10am - 12pm");
            dt.Rows.Add("Atletismo", "Actividad deportiva", "Campo deportivo municipal", "Jueves", "4pm - 7pm");
            dt.Rows.Add("Ajedrez", "Actividad deportiva", "Sala audiovisual", "Martes", "9am - 11am");
            dt.Rows.Add("Danza Contemporanea", "Actividad cultural", "Salón principal", "Miércoles", "9am - 12pm");
            dt.Rows.Add("Voleyball", "Actividad deportiva", "Cancha escolar", "Martes", "9am - 11am");
            dt.Rows.Add("Beisbol", "Actividad deportiva", "Cancha municipal", "Sábado", "8am - 1pm");
            dt.Rows.Add("Natacion", "Actividad deportiva", "Alberca escolar", "Sábado", "2pm - 6pm");

            gvActividades.DataSource = dt;
            gvActividades.DataBind();
        }

        // Método para manejar los comandos de la tabla de actividades
        public void gvActividades_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Inscribir")
            {
                // Obtener el índice de la fila seleccionada
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvActividades.Rows[rowIndex];

                // Obtener el nombre de la actividad
                string actividad = row.Cells[0].Text;

                // Mapear la actividad al templateId de SendGrid
                string templateId = GetTemplateIdForActivity(actividad);

                if (templateId != null)
                {
                    // Enviar el correo con el templateId correspondiente
                    SendEmail(templateId);

                    // Cambiar el texto del botón a "Enviado"
                    Button btn = (Button)row.FindControl("btnInscribir");
                    if (btn != null)
                    {
                        btn.Text = "Enviado";
                        btn.Enabled = false;  // Desactivar el botón
                    }
                }
                else
                {
                    // Si no se encuentra el templateId, mostrar un error
                    lblNombre.Text = "Error: No se ha encontrado el template para la actividad.";
                }
            }
        }

        // Método para obtener el templateId correspondiente a la actividad
        private string GetTemplateIdForActivity(string actividad)
        {
            switch (actividad)
            {
                case "Futbol":
                    return "d-1593377fac6b49a68e266f464d119664";
                case "Baloncesto":
                    return "d-10fa7f36cce449f5836a4ff909d1ab51";
                case "Folklore":
                    return "d-4a1b5c2a89e84bb7b9b5b21bad1a1bca";
                case "Pintura":
                    return "d-81c29481cf6e434f9159f65edf267f81";
                case "Atletismo":
                    return "d-081a85e8128d458cbae3f175982689a2";
                case "Ajedrez":
                    return "d-9a3ecdccf9ed4b978af8daa286698a41";
                case "Danza Contemporanea":
                    return "d-6bc6be09076a4b979073c1e10c3f84a2";
                case "Voleyball":
                    return "d-757517f719974e49a91665978dddbd3e";
                case "Beisbol":
                    return "d-4ead0a0d72aa4acf8f6ddcfdafb1ab1a";
                case "Natacion":
                    return "d-2a7a39040d97473bbeeedf04f7e9464b";
                default:
                    return null;
            }
        }

        // Método para enviar el correo con el templateId usando el servicio web
        private void SendEmail(string templateId)
        {
            // Crear instancia del web service
            EmailWS emailService = new EmailWS();

            // Intentamos obtener el ID del estudiante de la sesión o alguna otra fuente de información
            int estId = 0; // Inicializamos el ID del estudiante en 0 (no válido)

            // Intentar obtener el ID desde la sesión si está disponible
            if (Session["Est_ID"] != null)
            {
                estId = Convert.ToInt32(Session["Est_ID"]);
            }

            if (estId == 0)
            {
                lblNombre.Text = "Error: La matrícula del estudiante no está disponible.";
                return; // Salir si no hay matrícula
            }

            try
            {
                // Llamar al método del web service para enviar el correo
                emailService.SendRequestEmail(estId, templateId);
            }
            catch (Exception ex)
            {
                lblNombre.Text = "Error al enviar el correo: " + ex.Message;
            }
        }

        // Método para manejar la personalización de las filas del GridView
        protected void gvActividades_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Verifica si la actividad es "Danza contemporánea"
                if (e.Row.Cells[0].Text == "Danza Contemporanea")  // Asumiendo que la actividad está en la primera columna
                {
                    e.Row.Cells[0].CssClass = "danza-contemporanea"; // Asigna la clase CSS
                }
            }
        }

        // Cargar datos del alumno y actividades al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Obtener el ID de la sesión, si es posible
                if (Session["Est_ID"] != null)
                {
                    int estId = Convert.ToInt32(Session["Est_ID"]);
                    LoadStudentData(estId);
                }
                LoadActivities();
            }
        }
    }
}





