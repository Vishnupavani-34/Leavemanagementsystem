using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace project
{
    public partial class Employee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLeaveStatusGrid();
            }
        }

        protected void btnSubmitLeave_Click(object sender, EventArgs e)
        {
            string employeeID = txtEmployeeID.Text;
            string leaveReason = txtLeaveReason.Text;
            DateTime startDate = Convert.ToDateTime(txtLeaveStartDate.Text);
            DateTime endDate = Convert.ToDateTime(txtLeaveEndDate.Text);

            string connectionString = ConfigurationManager.ConnectionStrings["LeaveManagementDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO LeaveRequests (EmployeeID, Reason, StartDate, EndDate, Status) VALUES (@EmployeeID, @Reason, @StartDate, @EndDate, 'Pending')";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                    cmd.Parameters.AddWithValue("@Reason", leaveReason);
                    cmd.Parameters.AddWithValue("@StartDate", startDate);
                    cmd.Parameters.AddWithValue("@EndDate", endDate);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            BindLeaveStatusGrid();
            ShowMessageAndRedirect("Leave application submitted successfully.", "Login.aspx");
        }

        private void BindLeaveStatusGrid()
        {
            string employeeID = txtEmployeeID.Text;
            string connectionString = ConfigurationManager.ConnectionStrings["LeaveManagementDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT LeaveRequestID, Reason, StartDate, EndDate, Status FROM LeaveRequests WHERE EmployeeID = @EmployeeID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        GridViewLeaveStatus.DataSource = dt;
                        GridViewLeaveStatus.DataBind();
                    }
                }
            }
        }

        private void ShowMessageAndRedirect(string message, string url)
        {
            string script = $@"
                <script type='text/javascript'>
                    alert('{message}');
                    setTimeout(function() {{
                        window.location.href = '{url}';
                    }}, 5000);
                </script>";
            ltScript.Text = script;
        }
    }
}
