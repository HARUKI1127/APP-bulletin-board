<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>つぶやき掲示板</title>
    <style>
        :root {
            --bg: #f5f5f5;
            --text: #222;
            --card-bg: #fff;
            --border: #ddd;
        }
        body.dark {
            --bg: #1a1a1a;
            --text: #eee;
            --card-bg: #2a2a2a;
            --border: #444;
        }
        body {
            font-family: "Arial", sans-serif;
            background: var(--bg);
            color: var(--text);
            margin: 0;
            padding: 20px;
            transition: background 0.3s, color 0.3s;
        }
        .container { max-width: 800px; margin: auto; }
        h1, h2 { text-align: center; }
        .toggle { text-align: right; margin-bottom: 10px; }
        button.mode-btn {
            padding: 6px 12px;
            background: var(--card-bg);
            border: 1px solid var(--border);
            cursor: pointer;
            color: var(--text);
            border-radius: 6px;
        }
        .card, .post {
            background: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid var(--border);
        }
        input[type=text], textarea {
            width: 100%;
            padding: 10px;
            margin: 6px 0 12px;
            border: 1px solid var(--border);
            border-radius: 6px;
            background: var(--bg);
            color: var(--text);
        }
        input[type=submit] {
            padding: 10px 20px;
            background: #3b82f6;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type=submit]:hover { background: #2563eb; }
        .name { font-weight: bold; color: #3b82f6; }
        .error { color: #ff5555; font-weight: bold; margin-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        table th, table td { border: 1px solid var(--border); padding: 8px; background: var(--card-bg); }
        table th { background: #3b82f6; color: white; }
    </style>

    <script>
        function toggleMode() {
            document.body.classList.toggle("dark");
            localStorage.setItem("darkMode", document.body.classList.contains("dark"));
        }
        window.onload = function() {
            if (localStorage.getItem("darkMode") === "true") {
                document.body.classList.add("dark");
            }
        }
    </script>
</head>

<body>
<div class="container">
    <div class="toggle">
        <button class="mode-btn" onclick="toggleMode()">🌙 / ☀️ モード切替</button>
    </div>

    <h1>つぶやき掲示板</h1>

    <c:if test="${not empty errorMsg}">
        <p class="error">${errorMsg}</p>
    </c:if>

    <div class="card">
        <form action="Main" method="post">
            <label>名前：</label>
            <input type="text" name="userName" />
            <label>つぶやき：</label>
            <textarea name="text" rows="3"></textarea>
            <input type="submit" value="投稿" />
        </form>
    </div>

    <h2>投稿一覧（テーブル表示）</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>投稿者</th>
            <th>内容</th>
            <th>投稿日時</th>
            <th colspan="2">操作</th> <%-- 2列に拡張 --%>
        </tr>

        <c:forEach var="mutter" items="${mutterList}">
            <tr>
                <td>${mutter.id}</td>
                <td>${mutter.name}</td>
                <td>${mutter.text}</td>
                <td>${mutter.timestamp}</td>
                <td><a href="/mutter-app/Edit?id=${mutter.id}">編集</a></td>
                <td><a href="/mutter-app/Delete?id=${mutter.id}">削除</a></td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
