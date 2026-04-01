package com.quiz.servlet;

import com.quiz.dao.QuestionDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String difficulty = request.getParameter("difficulty");

        QuestionDAO dao = new QuestionDAO();
        List<Map<String, String>> questions = dao.getQuestions(category, difficulty);

        HttpSession session = request.getSession();
        session.setAttribute("questions", questions);
        session.setAttribute("index", 0);
        session.setAttribute("score", 0);
        session.setAttribute("answers", new ArrayList<String>());

        response.sendRedirect("quiz.jsp");
    }
}