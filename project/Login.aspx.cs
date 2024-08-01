using System;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Remoting.Messaging;
namespace project
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["LeaveManagementDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Role FROM Employees WHERE Username = @Username AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string role = reader["Role"].ToString();
                    if (role == "Employee")
                    {
                        Response.Redirect("Employee.aspx");
                    }
                    else if (role == "HOD")
                    {
                        Response.Redirect("HOD.aspx");
                    }
                }
                else
                {

                    Response.Write("<script>alert('Invalid Username or Password');</script>");
                }
            }

        }
    }
}
