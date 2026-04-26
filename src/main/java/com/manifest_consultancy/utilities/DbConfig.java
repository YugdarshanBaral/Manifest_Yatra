package com.manifest_consultancy.utilities;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConfig {

    private static final String URL = "jdbc:mysql://localhost:3306/manifest_consultancy?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() {

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }
}