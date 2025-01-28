using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebSiteExampleLI.EmailWSReference;  // Referencia de servicio web

namespace WebSiteExampleLI.Pages
{
    public partial class Gestion : System.Web.UI.Page
    {
        private EmailWS _emailWS = new EmailWS();  // Instancia del servicio web

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadActivities();
            }
        }

        private void LoadActivities()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT ActTrans_ID, Est_ID, Act_Selec FROM ActTrans";
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                GridViewActivities.DataSource = dt;
                GridViewActivities.DataBind();
            }
        }

        protected void GridViewActivities_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewActivities.EditIndex = e.NewEditIndex;
            LoadActivities();
        }

        protected void GridViewActivities_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GridViewActivities.DataKeys[e.RowIndex].Value);
            GridViewRow row = GridViewActivities.Rows[e.RowIndex];
            int estId = Convert.ToInt32((row.Cells[1].Controls[0] as TextBox).Text);
            string actividad = (row.Cells[2].Controls[0] as TextBox).Text;

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                string query = "UPDATE ActTrans SET Est_ID = @Est_ID, Act_Selec = @Act_Selec WHERE ActTrans_ID = @ActTrans_ID";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@Est_ID", estId);
                cmd.Parameters.AddWithValue("@Act_Selec", actividad);
                cmd.Parameters.AddWithValue("@ActTrans_ID", id);

                connection.Open();
                cmd.ExecuteNonQuery();
            }

            GridViewActivities.EditIndex = -1;
            LoadActivities();
        }

        protected void GridViewActivities_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewActivities.EditIndex = -1;
            LoadActivities();
        }

        protected void GridViewActivities_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridViewActivities.DataKeys[e.RowIndex].Value);

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                string query = "DELETE FROM ActTrans WHERE ActTrans_ID = @ActTrans_ID";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@ActTrans_ID", id);

                connection.Open();
                cmd.ExecuteNonQuery();
            }

            LoadActivities();
        }

        // Evento para mostrar el panel de agregar alumno
        protected void btnAgregarAlumno_Click(object sender, EventArgs e)
        {
            pnlAgregarAlumno.Visible = true;
            btnAgregarAlumno.Visible = false;
        }

        // Evento para confirmar la agregación de un alumno
        protected void btnConfirmarAgregarAlumno_Click(object sender, EventArgs e)
        {
            int estId = Convert.ToInt32(txtNewMatricula.Text);
            string actividad = txtNewActividad.Text;

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                string query = "INSERT INTO ActTrans (Est_ID, Act_Selec) VALUES (@Est_ID, @Act_Selec)";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@Est_ID", estId);
                cmd.Parameters.AddWithValue("@Act_Selec", actividad);

                connection.Open();
                cmd.ExecuteNonQuery();
            }

            txtNewMatricula.Text = "";
            txtNewActividad.Text = "";
            LoadActivities();
            pnlAgregarAlumno.Visible = false;
            btnAgregarAlumno.Visible = true;
        }

        // Evento para cancelar la agregación de un alumno
        protected void btnCancelarAgregarAlumno_Click(object sender, EventArgs e)
        {
            txtNewMatricula.Text = "";
            txtNewActividad.Text = "";
            pnlAgregarAlumno.Visible = false;
            btnAgregarAlumno.Visible = true;
        }

        // Evento para mostrar el panel de notificación
        protected void btnNotificarAlumno_Click(object sender, EventArgs e)
        {
            pnlNotificarAlumno.Visible = true;
        }

        // Evento para enviar la notificación de éxito
        protected void btnExito_Click(object sender, EventArgs e)
        {
            string studentEmail = txtCorreoAlumno.Text.Trim();

            if (string.IsNullOrEmpty(studentEmail))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Por favor, ingresa un correo válido.')", true);
                return;
            }

            // Llamada al servicio web para enviar la notificación de éxito
            _emailWS.SendNotificationEmail("d-5997316c96434e798329a6512118eced", studentEmail);

            pnlNotificarAlumno.Visible = false;
            txtCorreoAlumno.Text = "";
        }

        // Evento para enviar la notificación de rechazo
        protected void btnRechazo_Click(object sender, EventArgs e)
        {
            string studentEmail = txtCorreoAlumno.Text.Trim();

            if (string.IsNullOrEmpty(studentEmail))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Por favor, ingresa un correo válido.')", true);
                return;
            }

            // Llamada al servicio web para enviar la notificación de rechazo
            _emailWS.SendNotificationEmail("d-3e01d5f6fb8c4ef590f6fdd4d595c8c5", studentEmail);

            pnlNotificarAlumno.Visible = false;
            txtCorreoAlumno.Text = "";
        }

        protected void btnCancelarNotificarAlumno_Click(object sender, EventArgs e)
        {
            pnlNotificarAlumno.Visible = false;
            txtCorreoAlumno.Text = string.Empty;
        }
    }
}


