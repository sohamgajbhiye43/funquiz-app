package com.quiz.servlet;

import com.quiz.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
int userId = dao.loginUser(email, password);

if (userId != -1) {

    HttpSession session = request.getSession();
    session.setAttribute("userId", userId);
    session.setAttribute("user", email);

    // CHECK ROLE
    if (    email.equals("admin199@gmail.com")) {
        response.sendRedirect("admin.jsp");
    } else {
        response.sendRedirect("dashboard.jsp");
    }

} 
    else {
    response.getWriter().println("Invalid Credentials!");
}
    }
}