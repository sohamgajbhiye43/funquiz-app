package com.quiz.servlet;

import com.quiz.dao.FeedbackDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/submitFeedback")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int q1 = request.getParameter("q1") != null ? Integer.parseInt(request.getParameter("q1")) : 0;
        int q2 = request.getParameter("q2") != null ? Integer.parseInt(request.getParameter("q2")) : 0;
        int q3 = request.getParameter("q3") != null ? Integer.parseInt(request.getParameter("q3")) : 0;
        int q4 = request.getParameter("q4") != null ? Integer.parseInt(request.getParameter("q4")) : 0;
        int q5 = request.getParameter("q5") != null ? Integer.parseInt(request.getParameter("q5")) : 0;
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId != null) {
            FeedbackDAO dao = new FeedbackDAO();
            dao.saveFeedback(userId, q1, q2, q3, q4, q5);

            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}