package com.quiz.servlet;

import com.quiz.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic validation
        if (name == null || email == null || password == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red;'>All fields are required!</h3>");
            return;
        }

        UserDAO dao = new UserDAO();
        boolean success = dao.registerUser(name, email, password);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red;'>Registration Failed! Email may already exist.</h3>");
        }
    }
}