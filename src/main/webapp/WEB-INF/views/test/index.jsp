<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
총 ${map.count }명
<table border=1 width=800 align=center>
    <tr align=center bgcolor="#FFFF66">
        <td>Id</td>
        <td>이름</td>
    </tr>
<c:forEach var="dto" items="${map.list }">
    <tr>
        <td>${dto.idx }</td>
        <td>${dto.name }</td>
    </tr>
</c:forEach>
</table>
</body>
</html>
