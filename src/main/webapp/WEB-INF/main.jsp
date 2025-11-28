<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>つぶやき掲示板</title>
    <!-- Font Awesome & Material Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
        :root {
            --bg: #f5f5f5;
            --text: #222;
            --card-bg: #fff;
            --border: #ddd;
            --primary: #3b82f6;
            --primary-hover: #2563eb;
            --sidebar-bg: #ffffff;
            --sidebar-border: #ccc;
        }
        body.dark {
            --bg: #1a1a1a;
            --text: #eee;
            --card-bg: #2a2a2a;
            --border: #444;
            --sidebar-bg: #202020;
            --sidebar-border: #555;
        }
        body {
            font-family: "Arial", sans-serif;
            background: var(--bg);
            color: var(--text);
            margin: 0;
            display: flex;
            transition: 0.3s;
        }

        /* ===== サイドバー ===== */
        .sidebar {
            width: 220px;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--sidebar-border);
            height: 100vh;
            position: fixed;
            padding-top: 20px;
        }
        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .sidebar a {
            display: block;
            padding: 12px 20px;
            color: var(--text);
            text-decoration: none;
            font-size: 15px;
        }
        .sidebar a:hover {
            background: var(--border);
        }
        .sidebar i, .sidebar .material-icons {
            margin-right: 8px;
        }

        /* ===== コンテンツ領域 ===== */
        .content {
            margin-left: 220px;
            padding: 20px;
            width: calc(100% - 220px);
        }

        .card {
            background: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid var(--border);
            margin-bottom: 25px;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid var(--border);
            background: var(--bg);
            color: var(--text);
        }
        .btn {
            padding: 8px 16px;
            background: var(--primary);
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background: var(--primary-hover);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid var(--border);
            padding: 10px;
        }
        th { background: var(--primary); color: white; }
    </style>

    <script>
        function toggleMode() {
            document.body.classList.toggle("dark");
            localStorage.setItem("darkMode", document.body.classList.contains("dark"));
        }
        window.onload = () => {
            if (localStorage.getItem("darkMode") === "true") document.body.classList.add("dark");
        }
    </script>
</head>
<body>

<!-- ===== サイドバー ===== -->
<div class="sidebar">
    <h2><i class="fa-solid fa-comments"></i> 管理</h2>
    <a href="${pageContext.request.contextPath}/Main"><i class="fa-solid fa-home"></i> メイン</a>
    <a href="#"><i class="fa-solid fa-user"></i> ユーザー管理</a>
    <a href="#"><i class="fa-solid fa-database"></i> 投稿データ</a>
    <a href="#"><i class="material-icons">settings</i> 設定</a>
    <a href="#"><i class="fa-solid fa-right-from-bracket"></i> ログアウト</a>
</div>

<!-- ===== メインコンテンツ ===== -->
<div class="content">

    <div style="text-align:right; margin-bottom:10px;">
        <button class="btn" onclick="toggleMode()"><i class="fa-solid fa-moon"></i> / <i class="fa-solid fa-sun"></i></button>
    </div>

    <h1>つぶやき掲示板</h1>

    <!-- 投稿フォーム -->
    <div class="card">
        <form action="${pageContext.request.contextPath}/Main" method="post">
            <label>名前</label>
            <input type="text" name="userName" required>

            <label>つぶやき</label>
            <textarea name="text" rows="3" required></textarea>

            <input type="submit" value="投稿" class="btn">
        </form>
    </div>

    <h2>投稿一覧</h2>
    <table>
        <tr>
            <th>ID</th><th>投稿者</th><th>内容</th><th>日時</th><th>編集</th><th>削除</th>
        </tr>
        <c:forEach var="m" items="${mutterList}">
            <tr>
                <td>${m.id}</td>
                <td>${m.name}</td>
                <td>${m.text}</td>
                <td>${m.timestamp}</td>
                <td><a class="btn" href="${pageContext.request.contextPath}/Edit?id=${m.id}"><i class="fa-solid fa-pen"></i></a></td>
                <td><a class="btn" href="${pageContext.request.contextPath}/Delete?id=${m.id}" onclick="return confirm('削除しますか？')"><i class="fa-solid fa-trash"></i></a></td>
            </tr>
        </c:forEach>
    </table>

</div>
</body>
</html>
