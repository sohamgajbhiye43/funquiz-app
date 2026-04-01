package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FeedbackDAO {

    public void saveFeedback(int userId, int q1, int q2, int q3, int q4, int q5) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO feedback(user_id, q1_rating, q2_rating, q3_rating, q4_rating, q5_rating) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, q1);
            ps.setInt(3, q2);
            ps.setInt(4, q3);
            ps.setInt(5, q4);
            ps.setInt(6, q5);

            ps.executeUpdate();

        } catch (SQLException e) {
           
        }
    }
}