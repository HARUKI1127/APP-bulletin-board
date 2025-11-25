package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MutterDAO {

    private final String JDBC_URL = "jdbc:mysql://localhost:3306/yourdb?useSSL=false&useUnicode=true&characterEncoding=UTF-8";
    private final String DB_USER = "root";
    private final String DB_PASS = ""; // 必要に応じてパスワードを設定

    // JDBCドライバを明示的にロード
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<Mutter> findAll() {
        List<Mutter> mutterList = new ArrayList<>();
        String sql = "SELECT NAME, TEXT FROM MUTTER ORDER BY ID DESC";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement pStmt = conn.prepareStatement(sql);
             ResultSet rs = pStmt.executeQuery()) {

            while (rs.next()) {
                String name = rs.getString("NAME");
                String text = rs.getString("TEXT");
                mutterList.add(new Mutter(name, text));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mutterList;
    }

    public boolean create(Mutter mutter) {
        String sql = "INSERT INTO MUTTER (NAME, TEXT) VALUES (?, ?)";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement pStmt = conn.prepareStatement(sql)) {

            pStmt.setString(1, mutter.getName());
            pStmt.setString(2, mutter.getText());
            return pStmt.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

