<%@ page import="java.util.*, com.quiz.dao.AdminDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<%
AdminDAO dao = new AdminDAO();

List<Map<String,String>> users = dao.getUsers();
List<Map<String,String>> scores = dao.getScores();
List<Map<String,String>> feedback = dao.getFeedback();
List<Map<String,String>> attempts = dao.getAttempts();
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="css/st.css">

    <style>
        body { font-family: Arial; padding:20px; }
        table { border-collapse: collapse; width:100%; margin-bottom:30px; }
        th, td { border:1px solid #ccc; padding:8px; }
        th { background:#333; color:white; }
        .correct { background:#d4edda; }
        .wrong { background:#f8d7da; }
    </style>
</head>

<body>

<h2>Admin Dashboard</h2>

<h3 style="text-align:center;">Users</h3>
<table>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Password</th> <!-- ✅ added -->
    <th>Role</th>
    <th>Action</th> <!-- ✅ added -->
</tr>

<% for(Map<String,String> u: users){ %>
<tr>
    <td><%=u.get("id")%></td>
    <td><%=u.get("name")%></td>
    <td><%=u.get("email")%></td>
    <td><%=u.get("password")%></td> <!-- ✅ added -->
    <td><%=u.get("role")%></td>

    <td>
        <a href="adminData?deleteUserId=<%=u.get("id")%>" 
           style="color:red; font-weight:bold;">
           Delete
        </a>
    </td>

</tr>
<% } %>
</table>

<h3 style="text-align:center;" >Scores</h3>
<table>
<tr><th>User</th><th>Score</th><th>Total</th><th>Date</th></tr>
<% for(Map<String,String> s: scores){ %>
<tr>
<td><%=s.get("name")%></td>
<td><%=s.get("score")%></td>
<td><%=s.get("total")%></td>
<td><%=s.get("date")%></td>
</tr>
<% } %>
</table>

<h3 style="text-align:center;" >Feedback</h3>
<table>
<tr><th>User ID</th><th>Q1</th><th>Q2</th><th>Q3</th><th>Q4</th><th>Q5</th></tr>
<% for(Map<String,String> f: feedback){ %>
<tr>
<td><%=f.get("user_id")%></td>
<td><%=f.get("q1")%></td>
<td><%=f.get("q2")%></td>
<td><%=f.get("q3")%></td>
<td><%=f.get("q4")%></td>
<td><%=f.get("q5")%></td>
</tr>
<% } %>
</table>

    


    <div style="text-align:center;" onmouseover="this.style.transform='translateY(-10px) scale(1.05)'"
    onmouseout="this.style.transform='none'"
    >
        <a href="logout" style="color:red; font-size:25px; text-decoration:none; font-weight:bold;">
             Logout
        </a>
    </div>

</body>
</html>


