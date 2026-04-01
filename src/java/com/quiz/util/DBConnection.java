package com.quiz.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // ✅ Railway Public DB Connection
    private static final String URL = "jdbc:mysql://turntable.proxy.rlwy.net:37573/quiz_app";
    private static final String USER = "root";
    private static final String PASSWORD = "JxYlbxIQwuOGAoYnjdWiAYaIiyZWBftU";
    //private static final String URL = "jdbc:mysql://localhost:3306/quiz_app";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ JDBC Driver not found!");
        } catch (SQLException e) {
            System.out.println("❌ Database connection failed!");
        }
        return con;
    }
}