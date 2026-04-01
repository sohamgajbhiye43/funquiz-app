package com.quiz.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            String host = System.getenv("DB_HOST");
            String port = System.getenv("DB_PORT");
            String dbName = System.getenv("DB_NAME");
            String user = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");

            if (host == null || port == null || dbName == null || user == null || password == null) {
                System.out.println("ERROR: One or more environment variables are missing!");
                System.out.println("DB_HOST: " + host);
                System.out.println("DB_PORT: " + port);
                System.out.println("DB_NAME: " + dbName);
                System.out.println("DB_USER: " + user);
                System.out.println("DB_PASSWORD: " + (password != null ? "SET" : "NULL"));
                return null;
            }

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