package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.*;
import java.util.*;

public class QuestionDAO {

    public List<Map<String, String>> getQuestions(String category, String difficulty) {
        List<Map<String, String>> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM questions WHERE category=? AND difficulty=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, category);
            ps.setString(2, difficulty);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> q = new HashMap<>();
                q.put("id", rs.getString("id"));
                q.put("question", rs.getString("question"));
                q.put("option1", rs.getString("option1"));
                q.put("option2", rs.getString("option2"));
                q.put("option3", rs.getString("option3"));
                q.put("option4", rs.getString("option4"));
                q.put("correct", rs.getString("correct_answer"));
                list.add(q);
            }

        } catch (SQLException e) {
            
        }

        return list;
    }
}