# ひとこと掲示板アプリ（GitHubレジュメ用サンプル）

MVCモデルに基づいたシンプルな掲示板アプリケーションの設計および実装コードです。
Tomcat + JSP + Servlet + MySQL を想定しています。

---

## 📁 ディレクトリ構成例

```
MutterApp/
├── src/
│   ├── controller/
│   │   └── MainServlet.java
│   ├── model/
│   │   ├── Mutter.java
│   │   └── MutterDAO.java
├── WebContent/
│   ├── main.jsp
│   └── META-INF/
│   └── WEB-INF/
└── sql/
    └── create_table.sql
```

---

## ① データベース設計（SQL）

### create_table.sql

```sql
CREATE DATABASE mutter_db;
USE mutter_db;

CREATE TABLE MUTTER (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(100) NOT NULL,
  TEXT VARCHAR(255) NOT NULL,
  TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## ② JavaBean（Mutter.java）

```java
package model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Mutter implements Serializable {
    private int id;
    private String name;
    private String text;
    private Timestamp timestamp;

    public Mutter() {}

    public Mutter(String name, String text) {
        this.name = name;
        this.text = text;
    }

    public Mutter(int id, String name, String text, Timestamp timestamp) {
        this.id = id;
        this.name = name;
        this.text = text;
        this.timestamp = timestamp;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getText() { return text; }
    public Timestamp getTimestamp() { return timestamp; }
}
```

---

## ③ DAOクラス（MutterDAO.java）

```java
package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MutterDAO {
    private final String JDBC_URL = "jdbc:mysql://localhost:3306/mutter_db?characterEncoding=UTF-8";
    private final String DB_USER = "root";
    private final String DB_PASS = "password";

    // 全件取得
    public List<Mutter> findAll() {
        List<Mutter> mutterList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
            String sql = "SELECT * FROM MUTTER ORDER BY ID DESC";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            ResultSet rs = pStmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("ID");
                String name = rs.getString("NAME");
                String text = rs.getString("TEXT");
                Timestamp time = rs.getTimestamp("TIMESTAMP");

                Mutter mutter = new Mutter(id, name, text, time);
                mutterList.add(mutter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mutterList;
    }

    // 投稿登録
    public void create(Mutter mutter) {
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO MUTTER(NAME, TEXT) VALUES(?, ?)";
            PreparedStatement pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, mutter.getName());
            pStmt.setString(2, mutter.getText());
            pStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

---

## ④ コントローラ（MainServlet.java）

```java
package controller;

import model.Mutter;
import model.MutterDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Main")
public class MainServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MutterDAO dao = new MutterDAO();
        List<Mutter> mutterList = dao.findAll();

        request.setAttribute("mutterList", mutterList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String text = request.getParameter("text");

        if(name != null && !name.isEmpty() && text != null && !text.isEmpty()){
            Mutter mutter = new Mutter(name, text);
            MutterDAO dao = new MutterDAO();
            dao.create(mutter);
        }

        response.sendRedirect("Main");
    }
}
```

---

## ⑤ View（main.jsp）

```jsp
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Mutter" %>

<html>
<head>
<title>ひとこと掲示板</title>
</head>
<body>
<h1>ひとこと掲示板</h1>

<form action="Main" method="post">
    名前：<input type="text" name="name"><br>
    ひとこと：<input type="text" name="text"><br>
    <input type="submit" value="投稿">
</form>

<hr>
<h2>投稿一覧</h2>

<%
List<Mutter> list = (List<Mutter>)request.getAttribute("mutterList");
for(Mutter m : list){
%>
<p>
<strong><%= m.getName() %></strong>：<%= m.getText() %>
（<%= m.getTimestamp() %>）
</p>
<% } %>

</body>
</html>
```

---

## ✅ 技術ポイント（レジュメ用）

* Java Servlet + JSP を使用したMVC構成
* DAOパターンによるデータベース分離設計
* MySQLによるデータ永続化
* POST/GETの役割分離
* 入力バリデーション実装
* GitHubポートフォリオに最適なシンプル構成

---

必要であれば：
✅ README.md 用の文章
✅ GitHubに載せる説明文
✅ デザイン付きCSS版
✅ 改良版（ログイン機能付き）

も作成できます。希望があれば教えてください！
