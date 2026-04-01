package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.*;
import java.util.*;

public class AdminDAO {

    public List<Map<String, String>> getUsers() {
        List<Map<String, String>> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM users");

            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("id", rs.getString("id"));
                m.put("name", rs.getString("name"));
                m.put("email", rs.getString("email"));
                m.put("role", rs.getString("role"));
                list.add(m);
            }
        } catch (SQLException e) {
            
        }
        return list;
    }

    public List<Map<String, String>> getScores() {
        List<Map<String, String>> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT s.user_id, u.name, s.score, s.total_questions, s.date " +
                           "FROM scores s JOIN users u ON s.user_id = u.id";

            ResultSet rs = con.createStatement().executeQuery(query);

            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("user_id", rs.getString("user_id"));
                m.put("name", rs.getString("name"));
                m.put("score", rs.getString("score"));
                m.put("total", rs.getString("total_questions"));
                m.put("date", rs.getString("date"));
                list.add(m);
            }
        } catch (SQLException e) {
          
        }
        return list;
    }

    public List<Map<String, String>> getFeedback() {
        List<Map<String, String>> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM feedback");

            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("user_id", rs.getString("user_id"));
                m.put("q1", rs.getString("q1_rating"));
                m.put("q2", rs.getString("q2_rating"));
                m.put("q3", rs.getString("q3_rating"));
                m.put("q4", rs.getString("q4_rating"));
                m.put("q5", rs.getString("q5_rating"));
                list.add(m);
            }
        } catch (SQLException e) {
           
        }
        return list;
    }

    public List<Map<String, String>> getAttempts() {
        List<Map<String, String>> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT a.user_id, u.name, a.question, a.selected_answer, a.correct_answer, a.is_correct " +
                           "FROM attempts a JOIN users u ON a.user_id = u.id";

            ResultSet rs = con.createStatement().executeQuery(query);

            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("user_id", rs.getString("user_id"));
                m.put("name", rs.getString("name"));
                m.put("question", rs.getString("question"));
                m.put("selected", rs.getString("selected_answer"));
                m.put("correct", rs.getString("correct_answer"));
                m.put("status", rs.getString("is_correct"));
                list.add(m);
            }
        } catch (SQLException e) {
           
        }
        return list;
    }
}