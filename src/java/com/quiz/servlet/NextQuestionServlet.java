package com.quiz.servlet;

import com.quiz.util.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/nextQuestion")
public class NextQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String selected = request.getParameter("answer");
        String correct = request.getParameter("correct");

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        int score = (int) session.getAttribute("score");
        int index = (int) session.getAttribute("index");

        List<Map<String, String>> questions =
                (List<Map<String, String>>) session.getAttribute("questions");

        List<String> answers =
                (List<String>) session.getAttribute("answers");

        if (answers == null) {
            answers = new ArrayList<>();
        }

        if (selected == null) {
            selected = "Not Answered";
        }

        answers.add(selected);
        session.setAttribute("answers", answers);

        boolean isCorrect = selected.equals(correct);

        if (isCorrect) {
            score++;
        }

        // SAVE EACH ATTEMPT IN DATABASE
        try {
            if (userId != null && questions != null && index < questions.size()) {

                Connection con = DBConnection.getConnection();

                String query = "INSERT INTO attempts(user_id, question, selected_answer, correct_answer, is_correct) VALUES (?, ?, ?, ?, ?)";

                PreparedStatement ps = con.prepareStatement(query);

                ps.setInt(1, userId);
                ps.setString(2, questions.get(index).get("question"));
                ps.setString(3, selected);
                ps.setString(4, correct);
                ps.setBoolean(5, isCorrect);

                ps.executeUpdate();
            }

        } catch (SQLException e) {
           
        }

        session.setAttribute("score", score);
        session.setAttribute("index", index + 1);

        response.sendRedirect("quiz.jsp");
    }
}