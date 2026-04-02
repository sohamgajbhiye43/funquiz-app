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

        UserDAO dao = new UserDAO();
        int status = dao.registerUser(name, email, password);

        if (status == 1) {
            response.sendRedirect("login.jsp");
        } else {
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red;'>Registration Failed!</h3>");
        }
    }
}