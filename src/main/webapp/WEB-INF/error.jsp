<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>エラー</title>
    <style>
        :root {
            --bg: #f5f5f5;
            --text: #222;
            --card-bg: #fff;
            --border: #ddd;
            --primary: #3b82f6;
            --primary-hover: #2563eb;
            --error: #ff5555;
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

        .container {
            max-width: 800px;
            margin: auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .toggle {
            text-align: right;
            margin-bottom: 15px;
        }

        button.mode-btn {
            padding: 6px 14px;
            background: var(--card-bg);
            border: 1px solid var(--border);
            cursor: pointer;
            color: var(--text);
            border-radius: 6px;
            font-size: 14px;
        }

        .card {
            background: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid var(--border);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            text-align: center;
        }

        .error-msg {
            color: var(--error);
            font-weight: bold;
            margin-bottom: 15px;
        }

        a {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 16px;
            background: var(--primary);
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }

        a:hover {
            background: var(--primary-hover);
        }
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

    <h1>エラー発生</h1>

    <div class="card">
        <p class="error-msg">${errorMsg}</p>
        <a href="${pageContext.request.contextPath}/Main">メイン画面に戻る</a>
    </div>

</div>
</body>
</html>
