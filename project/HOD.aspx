<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HOD.aspx.cs" Inherits="project.HOD" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HOD Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f8f9fa;
        }
        h2 {
            color: #333;
        }
        .grid-container {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }
        .grid-container .grid-header, .grid-container .grid-row {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .grid-container .grid-header {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        .grid-container .grid-row:nth-child(even) {
            background-color: #f9f9f9;
        }
        .grid-container .grid-cell {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .grid-container .grid-actions {
            display: flex;
            gap: 10px;
        }
        .grid-container .grid-actions button {
            padding: 5px 10px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border-radius: 3px;
        }
        .grid-container .grid-actions button.decline {
            background-color: #dc3545;
        }
        .grid-container .grid-actions button:hover {
            opacity: 0.8;
        }
        .grid-container .grid-actions button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .btn-export {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 3px;
        }
        .btn-export:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <form id="form1" runat="server">
            <h2>HOD Dashboard</h2>
            <div class="grid-container">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="LeaveRequestID" HeaderText="Leave Request ID" />
                        <asp:BoundField DataField="Reason" HeaderText="Reason" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="grid-actions">
                                    <asp:Button ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Container.DataItemIndex %>' Text="Approve" CssClass="approve" />
                                    <asp:Button ID="btnDecline" runat="server" CommandName="Decline" CommandArgument='<%# Container.DataItemIndex %>' Text="Decline" CssClass="decline" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <asp:Button ID="btnExport" runat="server" Text="Export to Excel" OnClick="btnExport_Click" CssClass="btn-export" />
        </form>
    </div>
</body>
</html>
