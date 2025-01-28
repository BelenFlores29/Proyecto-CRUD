using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace WebSiteExampleLI.Pages
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;  // El username es igual al Est_ID
            string password = txtPassword.Text;  // Contraseña ingresada por el alumno
            string hashedPassword = HashPassword(password);

            if (RegisterUser(username, hashedPassword))
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Response.Write("<script>alert('El nombre de usuario ya existe o el Est_ID no se encuentra en la base de datos.');</script>");
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

        private bool RegisterUser(string username, string hashedPassword)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Verificar si el Est_ID (que es el username) existe en la tabla Estudiante
                using (SqlCommand checkEstudiante = new SqlCommand("SELECT COUNT(*) FROM Estudiante WHERE Est_ID = @Est_ID", connection))
                {
                    checkEstudiante.Parameters.AddWithValue("@Est_ID", username);  // El username es el Est_ID

                    int estudianteExists = (int)checkEstudiante.ExecuteScalar();
                    if (estudianteExists == 0)
                    {
                        // Si no existe el Est_ID en la tabla Estudiante
                        return false;
                    }
                }

                // Verificar si el usuario (username) ya existe en la tabla Usuarios
                using (SqlCommand checkUser = new SqlCommand("SELECT COUNT(*) FROM Usuarios WHERE Username = @Username", connection))
                {
                    checkUser.Parameters.AddWithValue("@Username", username);
                    int userExists = (int)checkUser.ExecuteScalar();
                    if (userExists > 0)
                    {
                        // Si el usuario ya existe en la tabla Usuarios
                        return false;
                    }
                }

                // Insertar el nuevo usuario en la tabla Usuarios
                using (SqlCommand insertUser = new SqlCommand("INSERT INTO Usuarios (Username, PasswordHash, IsAdmin, Est_ID) VALUES (@Username, @PasswordHash, 0, @Est_ID)", connection))
                {
                    insertUser.Parameters.AddWithValue("@Username", username);  // El Username es igual al Est_ID
                    insertUser.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                    insertUser.Parameters.AddWithValue("@Est_ID", username);  // Asociamos el Est_ID con el Username
                    insertUser.ExecuteNonQuery();
                }
            }

            return true;
        }
    }
}

