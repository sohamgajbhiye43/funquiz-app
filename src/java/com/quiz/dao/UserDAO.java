package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // ✅ REGISTER USER (returns 1 = success, 0 = fail)
    public int registerUser(String name, String email, String password) {
        int status = 0;

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("❌ DB connection is NULL in registerUser");
                return 0;
            }

            String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name.trim());
            ps.setString(2, email.trim());
            ps.setString(3, password.trim());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = 1; // success
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ✅ LOGIN USER (returns userId if success, -1 if fail)
    public int loginUser(String email, String password) {
        int userId = -1;

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("❌ DB connection is NULL in loginUser");
                return -1;
            }

            String query = "SELECT id FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email.trim());
            ps.setString(2, password.trim());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id");
            }

        } catch (SQLException e) {
        }

        return userId;
    }
}