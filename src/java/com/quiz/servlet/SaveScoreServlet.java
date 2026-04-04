package com.quiz.servlet;

import com.quiz.dao.ScoreDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/saveScore")
public class SaveScoreServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("saveScore: userId is null, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }

        // Safe score reading
        Object scoreObj = session.getAttribute("score");
        Object questionsObj = session.getAttribute("questions");

        if (scoreObj == null || questionsObj == null) {
            System.out.println("saveScore: score or questions session attribute is null!");
            response.sendRedirect("feedback.jsp");
            return;
        }

        int score = (int) scoreObj;
        int total = ((List) questionsObj).size();

        System.out.println("saveScore: userId=" + userId + " score=" + score + " total=" + total);

        ScoreDAO dao = new ScoreDAO();
        dao.saveScore(userId, score, total);

        response.sendRedirect("result.jsp");
    }
}