package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.*;
import java.util.*;

public class HistoryDAO {

    public List<Map<String, String>> getHistory(int userId) {
        List<Map<String, String>> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM scores WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("score", rs.getString("score"));
                m.put("total", rs.getString("total_questions"));
                m.put("date", rs.getString("date"));
                list.add(m);
            }

        } catch (SQLException e) {
        }

        return list;
    }
}