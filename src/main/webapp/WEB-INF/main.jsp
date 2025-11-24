<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>つぶやきアプリ</title>
<style>
  body { font-family: Arial, sans-serif; }
  .error { color: red; }
  input[type="text"] { padding: 4px; }
  input[type="submit"] { padding: 6px 12px; margin-top: 6px; }
</style>
</head>
<body>
<h1>つぶやきアプリ</h1>

<!-- エラーメッセージ -->
<c:if test="${not empty errorMsg}">
  <p class="error">${errorMsg}</p>
</c:if>

<h2>ひとことどうぞ</h2>
<form action="${pageContext.request.contextPath}/Main" method="post">
  名前：<input type="text" name="userName" required><br><br>
  つぶやき：<input type="text" name="text" size="60" required><br><br>
  <input type="submit" value="投稿">
</form>

<hr>

<h2>投稿一覧</h2>
<c:if test="${not empty mutterList}">
  <c:forEach var="m" items="${mutterList}">
    <p><strong>${m.name}</strong>：${m.text}</p>
  </c:forEach>
</c:if>
<c:if test="${empty mutterList}">
  <p>まだ投稿はありません。</p>
</c:if>

</body>
</html>