package com.quiz.servlet;

import com.quiz.util.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/adminData")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> users = new ArrayList<>();
        List<Map<String, String>> scores = new ArrayList<>();
        List<Map<String, String>> feedbacks = new ArrayList<>();
        List<Map<String, String>> questions = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                response.getWriter().println("Database connection failed!");
                return;
            }

            // DELETE USER
            String deleteId = request.getParameter("deleteUserId");
            if (deleteId != null) {
                PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE id=?");
                ps.setString(1, deleteId);
                ps.executeUpdate();
            }

            // USERS
            ResultSet rs1 = con.createStatement().executeQuery("SELECT * FROM users");
            while (rs1.next()) {
                Map<String, String> u = new HashMap<>();
                u.put("id", rs1.getString("id"));
                u.put("name", rs1.getString("name"));
                u.put("email", rs1.getString("email"));
                u.put("password", rs1.getString("password"));
                u.put("role", rs1.getString("role"));
                users.add(u);
            }

            // SCORES — fixed query with JOIN to get name, total, date
            String scoreQuery =
                "SELECT s.id, s.user_id, u.name, s.score, s.total_questions, s.date " +
                "FROM scores s JOIN users u ON s.user_id = u.id " +
                "ORDER BY s.date DESC";
            ResultSet rs2 = con.createStatement().executeQuery(scoreQuery);
            while (rs2.next()) {
                Map<String, String> s = new HashMap<>();
                s.put("id", rs2.getString("id"));
                s.put("user_id", rs2.getString("user_id"));
                s.put("name", rs2.getString("name"));
                s.put("score", rs2.getString("score"));
                s.put("total", rs2.getString("total_questions"));
                s.put("date", rs2.getString("date"));
                scores.add(s);
            }

            // FEEDBACK
            ResultSet rs3 = con.createStatement().executeQuery("SELECT * FROM feedback");
            while (rs3.next()) {
                Map<String, String> f = new HashMap<>();
                f.put("user_id", rs3.getString("user_id"));
                f.put("q1", rs3.getString("q1_rating"));
                f.put("q2", rs3.getString("q2_rating"));
                feedbacks.add(f);
            }

            // QUESTIONS
            ResultSet rs4 = con.createStatement().executeQuery("SELECT * FROM questions");
            while (rs4.next()) {
                Map<String, String> q = new HashMap<>();
                q.put("id", rs4.getString("id"));
                q.put("question", rs4.getString("question"));
                questions.add(q);
            }

        } catch (SQLException e) {
            System.out.println("AdminServlet error: " + e.getMessage());
        }

        HttpSession session = request.getSession();
        session.setAttribute("users", users);
        session.setAttribute("scores", scores);
        session.setAttribute("feedbacks", feedbacks);
        session.setAttribute("questions", questions);

        response.sendRedirect("admin.jsp");
    }
}