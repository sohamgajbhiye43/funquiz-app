package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // REGISTER USER - returns true if successful
    public boolean registerUser(String name, String email, String password) {
        boolean success = false;
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("registerUser: DB connection is null!");
                return false;
            }
            String query = "INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, 'user')";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            int row = ps.executeUpdate();
            success = (row > 0);
            System.out.println("registerUser result: " + success);
        } catch (SQLException e) {
            System.out.println("registerUser error: " + e.getMessage());
        }
        return success;
    }

    // LOGIN USER - returns user id if found, -1 if not
    public int loginUser(String email, String password) {
        int userId = -1;
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("loginUser: DB connection is null!");
                return -1;
            }
            String query = "SELECT id FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("id");
            }
            System.out.println("loginUser result userId: " + userId);
        } catch (SQLException e) {
            System.out.println("loginUser error: " + e.getMessage());
        }
        return userId;
    }
}