<%@ page import="java.util.*, com.quiz.dao.HistoryDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>


<%
    Integer userId = (Integer) session.getAttribute("userId");
    HistoryDAO dao = new HistoryDAO();
    List<Map<String, String>> list = dao.getHistory(userId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>History</title>
</head>
<body>

<h2>Your Previous Attempts</h2>
<div style="text-align:left;" >
<a href="logout" style="float:bottom; color:red;">Logout</a>
</div>

<br>
<br>

<table border="1">
<tr><th>Score</th><th>Total</th><th>Date</th></tr>

<%
for (Map<String, String> m : list) {
%>
<tr>
<td><%= m.get("score") %></td>
<td><%= m.get("total") %></td>
<td><%= m.get("date") %></td>
</tr>
<% } %>

</table>

</body>

</html>