package com.quiz.servlet;

import com.quiz.util.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/addQuestion")
public class AddQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            Connection con = DBConnection.getConnection();

            String q = "INSERT INTO questions(category,difficulty,question,option1,option2,option3,option4,correct_answer) VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, req.getParameter("category"));
            ps.setString(2, req.getParameter("difficulty"));
            ps.setString(3, req.getParameter("question"));
            ps.setString(4, req.getParameter("o1"));
            ps.setString(5, req.getParameter("o2"));
            ps.setString(6, req.getParameter("o3"));
            ps.setString(7, req.getParameter("o4"));
            ps.setString(8, req.getParameter("correct"));

            ps.executeUpdate();

        } catch (SQLException e) {
            
        }

        res.sendRedirect("adminData");
    }
}