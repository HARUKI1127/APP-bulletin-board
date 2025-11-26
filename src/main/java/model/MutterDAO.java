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
     *  ID / TIMESTAMP も取得できる完全版 findAll
     * ------------------------------ */
    public List<Mutter> findAll() {
        List<Mutter> mutterList = new ArrayList<>();
        Connection conn = null;

        try {
            // データベース接続
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);

            // SQL
            String sql = "SELECT ID, NAME, TEXT, TIMESTAMP FROM MUTTER ORDER BY ID DESC";
            PreparedStatement pStmt = conn.prepareStatement(sql);

            // 実行
            ResultSet rs = pStmt.executeQuery();

            // 結果をリストに追加
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
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return mutterList;
    }

    /** ------------------------------
     *  投稿の追加
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
}
