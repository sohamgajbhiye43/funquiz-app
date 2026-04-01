package com.quiz.servlet;

import com.quiz.dao.ScoreDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/saveScore")
public class SaveScoreServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int score = (int) session.getAttribute("score");
        int total = ((java.util.List) session.getAttribute("questions")).size();

        ScoreDAO dao = new ScoreDAO();
        dao.saveScore(userId, score, total);

        response.sendRedirect("feedback.jsp");
    }
}