<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2024-12-31
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css?after"/>
<html>
<head>
    <title>모여보개</title>
    <style>

        * {
            margin-bottom: 3px;
            font-family: "Noto Sans KR";
        }

        a {
            color: black;
            text-decoration: none;
        }

        a:visited {
            color: black;
        }

        .boardname {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-top: 20px;
            max-width: 1300px;
            padding: 5px 20px;
            height: 100px;
        }

        .text {
            display: flex;
            flex-direction: column; /* 수직 정렬 */
            align-items: flex-start; /* 왼쪽 정렬 */
            height: 100px;
        }

        .board-text1 {
            margin: 0 0 5px 0;
            color: #352018;
            height: 50px;
        }

        .board-text2 {
            font-size: 14px;
            color: #352018;
        }

        .boardname button.write-btn {
            background-color: #352018;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 14px;
            width: 150px;
            height: 55px;
            margin-top: 20px;
        }

        .boardname button.write-btn a {
            color: #fff;
            text-decoration: none;
        }

        .boardname button.write-btn img {
            width: 80px;
            height: auto;
            vertical-align: middle;
        }

        .board {
            margin: 60px auto 60px auto;
            padding: 0 20px;
            max-width: 1300px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        tbody {
            height: 50px;
            border-collapse: collapse;
        }
        th, td {
            border-right: none;
            border-left: none;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #8A5642;
            color: white;
        }
    </style>
    <script>
        function checkSession() {
            var usersession = '<c:out value="${usersession}"/>';
            if(!usersession) {
                alert("로그인 후 이용 가능합니다.");
                window.location.href="/gather";
            } else {
                window.location.href="/write";
            }
        }
    </script>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="board">
            <div class="boardname">
                <div class="text">
                    <div class="board-text1">
                        <h1>모여보개</h1><br>
                    </div>
                    <div class="board-text2">
                        <p>자유롭게 반려동물 이야기를 나눠보개</p>
                    </div>
                </div>
                <button type="button" class="write-btn" onclick="checkSession()">
                    <img src="/img/write.svg" alt="write">
                </button>
            </div>
            <table border="1" width="1000px">
                <colgroup>
                    <col style="width: 5%">
                    <col style="width: auto">
                    <col style="width: 15%">
                    <col style="width: 10%">
                </colgroup>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>작성일자</th>
                    </tr>
                </thead>
                <tbody>
                        <c:if test="${empty list }">
                            <tr>
                                <td colspan="5" align="center">게시글이 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="row" items="${list }">
                            <tr>
                                <td>${row.BOARD_IDX}</td>
                                <td style="text-align: left"><a href="/detail?BOARD_IDX=${row.BOARD_IDX}"> ${row.BOARD_TITLE}</a></td>
                                <td>${row.WRITER_NAME}</td>
                                <td><fmt:formatDate value="${row.CREATED}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                </tbody>
            </table>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
