<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2024-12-31
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<html>
<head>
    <title>모여보개</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR";
        }

        a {
            text-decoration: none;
        }


        .header {
            width: 100%; /* 전체 너비 사용 */
            height: 260px; /* 높이 조정 */
            display: flex; /* Flex 사용 */
            flex-direction: column; /* 아이템을 세로로 배치 */
            justify-content: flex-end; /* 아이템을 하단으로 정렬 */
            align-items: center; /* 아이템을 가로 중앙으로 정렬 */
            padding: 10px 0;
            background-color: #8A5642; /* 배경색 설정 */
        }

        .login {
            position: absolute;
            right: 36px; /* 오른쪽 정렬 */
            top: 24px; /* 상단 고정 */
        }

        .login > a {
            color: #352018;
            font-size: 16px;
        }

        .size {
            width: auto; /* 자동 너비 설정 */
            display: flex; /* Flex 사용 */
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
            height: 100%; /* 헤더 높이에 맞춤 */
        }

        .size a img {
            transform: translateY(67px); /* Y축으로 -100px 이동 */
            margin-bottom: 45px;
        }

        .menu {
            width: 1200px;
            margin: 20px auto 0; /* 상단에 간격 추가 */
            height: 40px;
        }

        .menu > ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .menu > ul > li {
            float: left; /* 메뉴 항목을 가로로 배열 */
            width: 25%; /* 메뉴 너비 설정 */
        }

        .menu > ul > li > a {
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 14px 23px; /* 상하 14px, 좌우 23px 패딩 */
            border-radius: 20px;
            transition: background-color 0.3s;
            background-color: #fff; /* 기본 배경색 */
            color: #352018;
            font-weight: bold;
            font-size: 20px;
        }

        .menu > ul > li > a.active {
            background-color: #352018;
            color: white;
        }

        .boardname {
            position: relative;
            width: 100%;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .boardname h2 {
            margin: 0 0 0 60px;
            padding: 5px 20px;
            color: #352018;
            font-family: "Noto Sans KR";
            position: absolute;
            left: 10px;
            top: 0;
        }

        .boardname p {
            margin: 25px 0 0 60px;
            padding: 5px 20px; /* 텍스트 여백 */
            font-size: 15px;
            color: #352018;
            font-family: "Noto Sans KR";
            position: absolute; /* 위치 지정 */
            left: 10px; /* 부모의 왼쪽에 위치 */
            top: 10px; /* 상단에 위치 */
        }

        .boardname button.write-btn {
            position: absolute;
            top: 10px; /* 부모의 상단에 위치 */
            right: 10px; /* 부모의 오른쪽에 위치 */
            margin: 0 78px 0 0; /* 버튼 기본 마진 제거 */
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
            margin: 60px auto 0 auto;
            padding: 0 20px;
            max-width: 1600px;
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
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }

        .pagination {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: white;
            padding: 10px 20px;
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
    <div class="header">
        <div class="size">
            <div><a href="/home.do"><img src="/img/logo.svg" width="1398px" height="216.33px"></a></div>
            <div class="login">
                <c:if test="${empty usersession }">
                    <a href="/userlogin">로그인</a>  |
                    <a href="/userregister">회원가입</a>
                </c:if>
                <c:if test="${!empty usersession }">
                    <a href="/member/edit.do">마이페이지</a>
                </c:if>
            </div>
        </div>
    </div>
    <div class="menu">
        <ul class="depth1">
            <li><a href="/home.do">홈</a></li>
            <li><a href="/search/search.do">구경하개</a></li>
            <li><a href="/gather">모여보개</a></li>
            <li><a href="/fun.do">재미나개</a></li>
        </ul>
    </div>
    <div class="boardname">
        <h2>모여보개</h2><br>
        <p>자유롭게 반려동물 이야기를 나눠보개</p>
            <button type="button" class="write-btn" onclick="checkSession()">
                    <img src="/img/write.svg" alt="write">
            </button>
    </div>
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
                            <td><a href="/detail?BOARD_IDX=${row.BOARD_IDX}"> ${row.BOARD_TITLE}</a></td>
                            <td>${row.WRITER_NAME}</td>
                            <td><fmt:formatDate value="${row.CREATED}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pagination">
        <a href="#">&laquo;</a>
        <c:forEach begin="1" end="10" var="page">
            <a href="?page=${page}">${page}</a>
        </c:forEach>
        <a href="#">&raquo;</a>
    </div>
</body>
</html>
