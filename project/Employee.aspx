<%@ Page Title="Employee" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="project.Employee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            background-color: #f8f9fa;
            color: #333;
            margin: 20px;
        }
        h2 {
            color: #007bff;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group textarea {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            margin-top: 5px;
        }
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        .btn-submit {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
        .grid-container {
            margin-top: 20px;
            overflow-x: auto;
        }
        .grid-container table {
            width: 100%;
            border-collapse: collapse;
            border-spacing: 0;
        }
        .grid-container th,
        .grid-container td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .grid-container th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        .grid-container tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        .grid-container tr:hover {
            background-color: #e9ecef;
        }
    </style>

    <h2>Leave Application</h2>
    <div class="form-group">
        <label for="txtEmployeeID">Employee ID:</label>
        <asp:TextBox ID="txtEmployeeID" runat="server" placeholder="Enter Employee ID" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label for="txtLeaveReason">Reason for Leave:</label>
        <asp:TextBox ID="txtLeaveReason" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label for="txtLeaveStartDate">Start Date:</label>
        <asp:TextBox ID="txtLeaveStartDate" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <div class="form-group">
        <label for="txtLeaveEndDate">End Date:</label>
        <asp:TextBox ID="txtLeaveEndDate" runat="server" CssClass="form-control"></asp:TextBox>
    </div>
    <asp:Button ID="btnSubmitLeave" runat="server" Text="Submit Leave" CssClass="btn btn-submit" OnClick="btnSubmitLeave_Click" />

    <h2>Leave Status</h2>
    <div class="grid-container">
        <asp:GridView ID="GridViewLeaveStatus" runat="server" AutoGenerateColumns="False" CssClass="table">
            <Columns>
                <asp:BoundField DataField="LeaveRequestID" HeaderText="Leave Request ID" ItemStyle-CssClass="th-sm" />
                <asp:BoundField DataField="Reason" HeaderText="Reason" ItemStyle-CssClass="th-sm" />
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-CssClass="th-sm" />
                <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-CssClass="th-sm" />
                <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-CssClass="th-sm" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Literal ID="ltScript" runat="server"></asp:Literal>
</asp:Content>
