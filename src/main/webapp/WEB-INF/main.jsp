<!-- Unified Main & Edit UI (Improved Design) -->
<!-- ======================= main.jsp ======================= -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>つぶやき掲示板 - Main</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
        :root {
            --bg: #f4f6fa;
            --text: #222;
            --card-bg: #fff;
            --border: #e3e3e3;
            --primary: #3b82f6;
            --primary-hover: #2563eb;
            --topbar-bg: #ffffff;
            --topbar-border: #dcdcdc;
        }
        body.dark {
            --bg: #1c1c1c;
            --text: #eaeaea;
            --card-bg: #262626;
            --border: #444;
            --topbar-bg: #222;
            --topbar-border: #444;
        }
        body {
            font-family: "Segoe UI", sans-serif;
            background: var(--bg);
            color: var(--text);
            margin: 0;
            transition: .25s;
        }

        /* Top Bar */
        header.topbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 70px;
            background: var(--topbar-bg);
            border-bottom: 1px solid var(--topbar-border);
            display: flex;
            align-items: center;
            padding: 0 25px;
            z-index: 10;
        }
        header .menu a {
            color: var(--text);
            margin-right: 22px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            font-size: 16px;
            gap: 6px;
            padding: 8px 10px;
            border-radius: 6px;
        }
        header .menu a:hover {
            background: var(--border);
        }

        /* Content */
        .content {
            margin: 100px auto;
            max-width: 900px;
            padding: 10px;
        }
        .card {
            background: var(--card-bg);
            padding: 20px;
            border-radius: 12px;
            border: 1px solid var(--border);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border: 1px solid var(--border);
            border-radius: 8px;
            background: var(--bg);
            color: var(--text);
        }
        input:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 5px rgba(59,130,246,.5);
        }

        .btn {
            padding: 10px 16px;
            background: var(--primary);
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            font-size: 15px;
            border: none;
            cursor: pointer;
        }
        .btn:hover { background: var(--primary-hover); }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
            border-radius: 12px;
            overflow: hidden;
            margin-top: 20px;
        }
        th, td {
            padding: 14px;
            border-bottom: 1px solid var(--border);
        }
        th { background: var(--primary); color: #fff; }

    </style>
</head>
<body>
<header class="topbar">
    <nav class="menu">
        <a href="${pageContext.request.contextPath}/Main"><i class="fa-solid fa-home"></i> メイン</a>
        <a href="#"><i class="fa-solid fa-user"></i> ユーザー管理</a>
        <a href="#"><i class="fa-solid fa-database"></i> 投稿データ</a>
        <a href="#"><i class="material-icons">settings</i> 設定</a>
    </nav>
</header>

<div class="content">
    <h1>つぶやき掲示板</h1>

    <div class="card">
        <form action="${pageContext.request.contextPath}/Main" method="post">
            <label>名前</label>
            <input type="text" name="userName" required>

            <label>つぶやき</label>
            <textarea name="text" rows="3" required></textarea>

            <br>
            <input type="submit" class="btn" value="投稿">
        </form>
    </div>

    <h2>投稿一覧</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>投稿者</th>
            <th>内容</th>
            <th>日時</th>
            <th>編集</th>
            <th>削除</th>
        </tr>

        <c:forEach var="m" items="${mutterList}">
            <tr>
                <td>${m.id}</td>
                <td>${m.name}</td>
                <td>${m.text}</td>
                <td>${m.timestamp}</td>

                <td>
                    <a class="btn" href="${pageContext.request.contextPath}/Edit?id=${m.id}">
                        <i class="fa-solid fa-pen"></i>
                    </a>
                </td>

                <td>
                    <a class="btn" href="${pageContext.request.contextPath}/Delete?id=${m.id}" onclick="return confirm('削除しますか？')">
                        <i class="fa-solid fa-trash"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
