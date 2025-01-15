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
        }

        a {
            color: black;
            text-decoration: none;
        }

        a:visited {
            color: black;
            text-decoration: none;
        }

        .main {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            margin-top: 50px;
        }

        .main h2 {
            font-weight: bold;
            font-family: "Noto Sans KR";
            margin-bottom: 10px;
            color: #333;
        }

        .main p {
            color: #666;
            margin-bottom: 30px;
            /* border-bottom: 1px solid #929292; */
            font-family: "Noto Sans KR";
        }

        .main button.write-btn {
            position: absolute;
            top: 10px; /* 부모의 상단에 위치 */
            right: 10px; /* 부모의 오른쪽에 위치 */
            background-color: #352018;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 14px;
            width: 150px;
            height: 55px;
        }

        .main button.write-btn a {
            color: #fff;
            text-decoration: none;
        }

        .main button.write-btn img {
            width: 80px;
            height: auto;
            vertical-align: middle;
        }

        .board {
            margin: 50px auto 100px auto;
            max-width: 1200px;
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
    <div class="gather-container">
        <div class="main">
            <h2>모여보개</h2>
            <p>자유롭게 반려동물 이야기를 나눠보개</p>
                <button type="button" class="write-btn" onclick="checkSession()">
                    <img src="/img/write.svg" alt="write">
                </button>
        </div>
        <div style="width: 1200px; height: 1px; background-color: #cccccc; margin: 30px auto;"></div>
        <div class="board">
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
    </div>
</body>
</html>
