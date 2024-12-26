<%--
  Created by IntelliJ IDEA.
  User: 이윤채
  Date: 2024-12-24
  Time: 오후 3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation List</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        td {
            word-wrap: break-word;
            max-width: 200px;
        }
        h1 {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<h1>Reservation List</h1>

<table>
    <thead>
    <tr>
        <th>name</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="dto" items="${map.list}">
        <tr>
            <td>${dto.res_str_date}</td>
            <td>${dto.res_end_date}</td>
            <td>${dto.lod_img_url}</td>
            <td>${dto.LOD_NAME}</td>
            <td>
                <c:if test="${dto.status == 'A'}">
                    <button onclick="location.href='/review?user_idx=${dto.user_idx}&reservation_idx=${dto.reservation_idx}&room_idx=${dto.room_idx}';">Write Review</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
