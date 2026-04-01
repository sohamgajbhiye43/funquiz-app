package com.quiz.servlet;

import com.quiz.util.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/deleteQuestion")
public class DeleteQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM questions WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (NumberFormatException | SQLException e) {
        }

        response.sendRedirect("admin.jsp");
    }
}