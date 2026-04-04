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

        System.out.println("Quiz started: " + questions.size() + " questions loaded");
        response.sendRedirect("quiz.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Map<String, String>> questions =
            (List<Map<String, String>>) session.getAttribute("questions");
        Integer index = (Integer) session.getAttribute("index");
        Integer score = (Integer) session.getAttribute("score");

        if (questions == null || index == null || score == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String selected = request.getParameter("answer");

        if (index < questions.size()) {
            Map<String, String> currentQuestion = questions.get(index);
            String correctAnswer = currentQuestion.get("correct"); // ✅ fixed key

            System.out.println("Q" + (index+1) + " | Selected: " + selected + " | Correct: " + correctAnswer);

            if (selected != null && selected.trim().equalsIgnoreCase(correctAnswer.trim())) {
                score++;
                session.setAttribute("score", score);
                System.out.println("✅ Correct! Score: " + score);
            } else {
                System.out.println("❌ Wrong or skipped");
            }

            List<String> answers = (List<String>) session.getAttribute("answers");
            if (answers == null) answers = new ArrayList<>();
            answers.add(selected != null ? selected : "");
            session.setAttribute("answers", answers);
        }

        index++;
        session.setAttribute("index", index);

        if (index >= questions.size()) {
            System.out.println("Quiz done! Final score: " + score + "/" + questions.size());
            response.sendRedirect("saveScore");
        } else {
            response.sendRedirect("quiz.jsp");
        }
    }
}