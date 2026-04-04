package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ScoreDAO {
    public void saveScore(int userId, int score, int total) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("saveScore: DB connection is null!");
                return;
            }
            String query = "INSERT INTO scores(user_id, score, total_questions) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, score);
            ps.setInt(3, total);
            int rows = ps.executeUpdate();
            System.out.println("saveScore: rows inserted = " + rows);
        } catch (SQLException e) {
            System.out.println("saveScore error: " + e.getMessage());
        }
    }
}