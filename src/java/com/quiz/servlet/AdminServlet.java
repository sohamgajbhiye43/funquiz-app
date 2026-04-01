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

            // USERS
            ResultSet rs1 = con.createStatement().executeQuery("SELECT * FROM users");
            while (rs1.next()) {
                Map<String, String> u = new HashMap<>();
                u.put("id", rs1.getString("id"));
                u.put("email", rs1.getString("email"));
                u.put("role", rs1.getString("role"));
                users.add(u);
            }

            // SCORES
            ResultSet rs2 = con.createStatement().executeQuery("SELECT * FROM scores");
            while (rs2.next()) {
                Map<String, String> s = new HashMap<>();
                s.put("user_id", rs2.getString("user_id"));
                s.put("score", rs2.getString("score"));
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
           
        }

        HttpSession session = request.getSession();
        session.setAttribute("users", users);
        session.setAttribute("scores", scores);
        session.setAttribute("feedbacks", feedbacks);
        session.setAttribute("questions", questions);

        response.sendRedirect("admin.jsp");
    }
}