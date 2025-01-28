using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSiteExampleLI.Pages
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (IsUserAdmin())
                {
                    LoadUsers();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private bool IsUserAdmin()
        {
            return Session["IsAdmin"] != null && (bool)Session["IsAdmin"];
        }

        private void LoadUsers()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT Usuario_Id, Username, PasswordHash FROM Usuarios", connection);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                GridViewUsers.DataSource = dt;
                GridViewUsers.DataBind();
            }
        }

        protected void GridViewUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewUsers.EditIndex = e.NewEditIndex;
            LoadUsers();
        }

        protected void GridViewUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridViewUsers.Rows[e.RowIndex];
            int userId = Convert.ToInt32(GridViewUsers.DataKeys[e.RowIndex].Values[0]);
            string username = (row.Cells[1].Controls[0] as TextBox).Text;
            string newPassword = (row.Cells[2].Controls[0] as TextBox).Text;
            string hashedPassword = HashPassword(newPassword);

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Usuarios SET Username = @Username, PasswordHash = @PasswordHash WHERE Usuario_Id = @Usuario_Id", connection);
                cmd.Parameters.AddWithValue("@Usuario_Id", userId);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                connection.Open();
                cmd.ExecuteNonQuery();
                connection.Close();
            }
            GridViewUsers.EditIndex = -1;
            LoadUsers();
        }

        protected void GridViewUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewUsers.EditIndex = -1;
            LoadUsers();
        }

        protected void GridViewUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(GridViewUsers.DataKeys[e.RowIndex].Values[0]);

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Usuarios WHERE Usuario_Id = @Usuario_Id", connection);
                cmd.Parameters.AddWithValue("@Usuario_Id", userId);
                connection.Open();
                cmd.ExecuteNonQuery();
                connection.Close();
            }
            LoadUsers();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                string username = txtNewUsername.Text.Trim();
                string password = txtNewPassword.Text.Trim();
                string hashedPassword = HashPassword(password);

                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO Usuarios (Username, PasswordHash, IsAdmin) VALUES (@Username, @PasswordHash, 0)", connection);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                    connection.Open();
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }
                LoadUsers();
                txtNewUsername.Text = "";
                txtNewPassword.Text = "";
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void btnRedirectToGestion_Click(object sender, EventArgs e)
        {
            Response.Redirect("Gestion.aspx");
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
