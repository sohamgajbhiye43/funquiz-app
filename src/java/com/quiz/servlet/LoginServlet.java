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
            session.setAttribute("role", dao.getLastRole()); // ✅ save role

            // Redirect based on role from DB, not hardcoded email
            if ("admin".equals(dao.getLastRole())) {
                response.sendRedirect("adminData");  // go through servlet not JSP directly
            } else {
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red;'>Invalid Credentials!</h3>");
        }
    }
}