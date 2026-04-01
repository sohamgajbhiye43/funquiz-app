package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AnswerDAO {

    public void saveAnswer(int userId, String question, String selected, String correct) {
        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO user_answers(user_id, question, selected_answer, correct_answer, is_correct) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, userId);
            ps.setString(2, question);
            ps.setString(3, selected);
            ps.setString(4, correct);
            ps.setBoolean(5, selected.equals(correct));

            ps.executeUpdate();

        } catch (SQLException e) {
        }
    }
}