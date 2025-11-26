<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ひとこと編集</title>
</head>
<body>
    <h1>ひとこと編集</h1>

    <form action="/mutter-app/Edit" method="post">
        <%-- 更新対象のIDを隠しフィールドで送信 --%>
        <input type="hidden" name="id" value="${mutter.id}">

        名前：
        <input type="text" name="name" value="${mutter.name}"><br>

        内容：
        <input type="text" name="text" value="${mutter.text}" size="60"><br>

        <input type="submit" value="更新">
    </form>

    <p><a href="/mutter-app/Main">メイン画面に戻る</a></p>
</body>
</html>
