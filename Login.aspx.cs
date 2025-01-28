using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace WebSiteExampleLI.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Convertimos el username a entero ya que es de tipo INT en la base de datos
            if (!int.TryParse(txtUsername.Text, out int username))
            {
                Response.Write("<script>alert('El usuario debe ser un número entero');</script>");
                return;
            }

            string password = txtPassword.Text;
            string hashedPassword = HashPassword(password);

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT Usuario_Id, IsAdmin, Est_ID FROM Usuarios WHERE Username = @Username AND PasswordHash = @PasswordHash", connection);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                connection.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Guardar los datos del usuario en sesión
                    Session["Usuario_Id"] = reader["Usuario_Id"];
                    Session["IsAdmin"] = reader["IsAdmin"];
                    Session["Est_ID"] = reader["Est_ID"];  // Guardamos el Est_ID en la sesión

                    // Llamamos al método para asociar el Est_ID si aún no está asignado
                    AsociarEstID(username);

                    // Redirigir a la página de inicio o perfil
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Usuario o contraseña incorrectos');</script>");
                }
            }
        }

        private void AsociarEstID(int username)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Consulta para actualizar el Est_ID en Usuarios basándose en Estudiante si está en NULL
                string query = @"
                    UPDATE Usuarios
                    SET Est_ID = (SELECT Est_ID FROM Estudiante WHERE Est_ID = @Username)
                    WHERE Username = @Username AND Est_ID IS NULL";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}

