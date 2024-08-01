using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.IO;
using System.Web;

namespace project
{
    public partial class HOD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Decline")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView1.Rows[index];
                int leaveRequestID = Convert.ToInt32(row.Cells[0].Text);
                string status = e.CommandName == "Approve" ? "Approved" : "Declined";

                string connectionString = ConfigurationManager.ConnectionStrings["LeaveManagementDB"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "UPDATE LeaveRequests SET Status = @Status WHERE LeaveRequestID = @LeaveRequestID AND Status = 'Pending'";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@LeaveRequestID", leaveRequestID);
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        con.Close();

                        if (rowsAffected == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Decision has already been taken for this leave request.');", true);
                        }
                    }
                }
                BindGrid();
            }
        }

        private void BindGrid()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LeaveManagementDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT LeaveRequestID, Reason, StartDate, EndDate, Status FROM LeaveRequests";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["LeaveManagementDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT LeaveRequestID, Reason, StartDate, EndDate, Status FROM LeaveRequests";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            if (dt.Rows.Count > 0)
            {
                string attachment = "attachment; filename=LeaveRequests.xls";
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.AddHeader("content-disposition", attachment);
                HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.Charset = "";
                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        GridView gv = new GridView();
                        gv.DataSource = dt;
                        gv.DataBind();
                        gv.RenderControl(hw);
                        HttpContext.Current.Response.Output.Write(sw.ToString());
                        HttpContext.Current.Response.Flush();
                        HttpContext.Current.Response.End();
                    }
                }
            }
        }
    }
}
