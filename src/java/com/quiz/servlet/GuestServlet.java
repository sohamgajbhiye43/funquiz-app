//package com.quiz.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/guestLogin")
public class GuestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Set guest user
        session.setAttribute("user", "Guest");
        session.setAttribute("userId", 0); // 0 = guest

        response.sendRedirect("dashboard.jsp");
    }
}