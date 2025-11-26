package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class MutterDAO {

    private final String JDBC_URL = "jdbc:mysql://localhost:3306/yourdb?useSSL=false&useUnicode=true&characterEncoding=UTF-8";
    private final String DB_USER = "root";
    private final String DB_PASS = ""; // 必要に応じてパスワード

    // JDBCドライバを明示的にロード
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    /** ------------------------------
     * 全件取得
     * ------------------------------ */
    public List<Mutter> findAll() {
        List<Mutter> mutterList = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
            String sql = "SELECT ID, NAME, TEXT, TIMESTAMP FROM MUTTER ORDER BY ID DESC";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            ResultSet rs = pStmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("ID");
                String userName = rs.getString("NAME");
                String text = rs.getString("TEXT");
                Timestamp timestamp = rs.getTimestamp("TIMESTAMP");

                Mutter mutter = new Mutter(id, userName, text, timestamp);
                mutterList.add(mutter);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;

        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }

        return mutterList;
    }

    /** ------------------------------
     * 投稿の追加
     * ------------------------------ */
    public boolean create(Mutter mutter) {
        String sql = "INSERT INTO MUTTER (NAME, TEXT, TIMESTAMP) VALUES (?, ?, NOW())";

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

    /** ------------------------------
     * ID指定で1件取得
     * ------------------------------ */
    public Mutter findOne(int id) {
        Mutter mutter = null;
        Connection conn = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
            String sql = "SELECT ID, NAME, TEXT, TIMESTAMP FROM MUTTER WHERE ID = ?";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setInt(1, id);
            ResultSet rs = pStmt.executeQuery();

            if (rs.next()) {
                String userName = rs.getString("NAME");
                String text = rs.getString("TEXT");
                Timestamp timestamp = rs.getTimestamp("TIMESTAMP");
                mutter = new Mutter(id, userName, text, timestamp);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }

        return mutter;
    }

    /** ------------------------------
     * 投稿の更新
     * ------------------------------ */
    public boolean update(Mutter mutter) {
        String sql = "UPDATE MUTTER SET NAME = ?, TEXT = ? WHERE ID = ?";
        Connection conn = null;

        try {
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, mutter.getName());
            pStmt.setString(2, mutter.getText());
            pStmt.setInt(3, mutter.getId());

            int result = pStmt.executeUpdate();
            return (result == 1);

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    /** ------------------------------
     * 投稿の削除
     * ------------------------------ */
    public boolean delete(int id) {
        Connection conn = null;
        try {
            // データベースへ接続
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
            // DELETE文の準備
            String sql = "DELETE FROM MUTTER WHERE ID = ?";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            // DELETE文中の「?」に値を設定
            pStmt.setInt(1, id);
            // DELETE文を実行
            int result = pStmt.executeUpdate();
            return (result == 1); // 成功すればtrue
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            // データベース切断
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}

