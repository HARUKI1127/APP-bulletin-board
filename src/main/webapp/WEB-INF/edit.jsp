<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ひとこと編集</title>
    <style>
        :root {
            --bg: #f5f5f5;
            --text: #222;
            --card-bg: #fff;
            --border: #ddd;
            --primary: #3b82f6;
            --primary-hover: #2563eb;
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

        h1 { text-align: center; margin-bottom: 20px; }

        .toggle { text-align: right; margin-bottom: 15px; }

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
        }

        input[type=text] {
            width: 100%;
            padding: 8px;
            margin: 6px 0 12px;
            border: 1px solid var(--border);
            border-radius: 6px;
            background: var(--bg);
            color: var(--text);
        }

        input[type=submit], a.button {
            padding: 10px 20px;
            background: var(--primary);
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        input[type=submit]:hover, a.button:hover {
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

    <h1>ひとこと編集</h1>

    <div class="card">
        <form action="${pageContext.request.contextPath}/Edit" method="post">
            <input type="hidden" name="id" value="${mutter.id}">

            <label>名前：</label>
            <input type="text" name="name" value="${mutter.name}">

            <label>内容：</label>
            <input type="text" name="text" value="${mutter.text}">

            <input type="submit" value="更新">
        </form>

        <p><a class="button" href="${pageContext.request.contextPath}/Main">メイン画面に戻る</a></p>
    </div>

</div>
</body>
</html>
