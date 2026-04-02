package com.quiz.dao;

import com.quiz.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // ✅ REGISTER USER
    public boolean registerUser(String name, String email, String password) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (SQLException e) {
        }

        return status;
    }

    // ✅ LOGIN USER
    public int loginUser(String email, String password) {
    int userId = -1;

    try {
        Connection con = DBConnection.getConnection();

        String query = "SELECT id FROM users WHERE email = ? AND password = ?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, email.trim());
        ps.setString(2, password.trim());

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            userId = rs.getInt("id"); // get user id
        }

    } catch (SQLException e) {
    }

    return userId;
    }
}