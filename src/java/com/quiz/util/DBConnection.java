package com.quiz.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://turntable.proxy.rlwy.net:37573/railway?useSSL=false&allowPublicKeyRetrieval=true&connectTimeout=30000";
    private static final String USER = "root";
    private static final String PASSWORD = "JxYlbxIQwuOGAoYnjdWiAYaIiyZWBftU";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("❌ DATABASE CONNECTION FAILED:");
            return null;
        }
    }
}