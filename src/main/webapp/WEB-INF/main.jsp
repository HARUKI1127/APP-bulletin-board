<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>つぶやき掲示板</title>
</head>
<body>
<h1>掲示板</h1>

<c:if test="${not empty errorMsg}">
    <p style="color:red">${errorMsg}</p>
</c:if>

<form action="Main" method="post">
    名前: <input type="text" name="userName" /><br/>
    つぶやき: <textarea name="text"></textarea><br/>
    <input type="submit" value="投稿" />
</form>

<hr/>
<h2>投稿一覧</h2>
<c:forEach var="m" items="${mutterList}">
    <p><strong>${m.name}</strong>: ${m.text}</p>
</c:forEach>

</body>
</html>
