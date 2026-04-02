package com.quiz.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            // Paste your actual Railway values below
            String host = "turntable.proxy.rlwy.net";  // ← replace with your Railway host
            String port = "37573";                       // ← replace with your Railway port
            String dbName = "railway";                   // ← replace with your Railway DB name
            String user = "root";                        // ← replace with your Railway username
            String password = "JxYlbxIQwuOGAoYnjdWiAYaIiyZWBftU";            // ← replace with your Railway password

            String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName
                       + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Database connected successfully!");

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("DB Connection failed: " + e.getMessage());
        }
        return con;
    }
}
