<%@ page import="kr.co.team4.model.dto.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2025-01-02
  Time: 오전 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("usersession");

    if(user == null) {
        response.sendRedirect("/userlogin");
        return;
    }

    String USER_ID = user.getUSER_ID();
%>
<html>
<head>
    <title>게시글 작성</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: "Noto Sans KR";
            margin-bottom: 3px;
        }

        .head {
            height: 70px;
            width: 100%;
            padding: 5px 0px;
            position: relative;
            margin: 20px 0 20px 0;
        }

        .head .header-text {
            left: 0;
            font-family: "Noto Sans KR";
            color: #8A5642;
        }

        .write_container {
            margin: 0 auto;
            padding: 20px;
            max-width: 1300px;
        }

        .board_title {
            border: 2px solid #8A5642;
            border-radius: 5px;
            width: 1061px;
        }

        td {
            font-family: "Noto Sans KR";

        }

        .write-table {
            width: 100%;
            padding: 50px 80px;
            height: 600px;
        }

        .writer {
            margin-bottom: 5px;
            color: #8A5642;
            font-size: 14px;
        }

        .title {
            margin-bottom: 5px;
            color: #8A5642;
            font-size: 14px;
        }

        .content {
            font-size: 14px;
            margin-bottom: 5px;
            color: #8A5642;
        }

        textarea {
            border-radius: 8px;
            border: 2px solid #8A5642;
            background-color: white;
            width: 100%;
            height: 300px;
        }

        .submit {
            background-color: #352018;
            color: white;
            font-family: "Noto Sans KR";
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 80px;
            height: 44px;
            position: absolute;
            top: 50%;
            right: 170px;
        }

        .submit:hover {
            background-color: #8A5642;
        }

        .back {
            padding: 10px 20px;
            background-color: #352018;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            position: absolute;
            top: 50%;
            right: 0;
        }

        .back:hover {
            background-color: #8A5642;
        }

    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <form method="post" action="write" onsubmit="return writeCheck();">
        <div class="write_container">
            <div class="write-table">
                <div class="head">
                    <div class="header-text">
                        <h2>게시글 작성</h2>
                    </div>
                        <input type="submit" class="submit" value="등록">
                    <a href="/gather" class="back">목록으로 돌아가기</a>
                </div>
                <div class="body">
                    <div class="writer">
                        글쓴이 : <%= USER_ID != null ? USER_ID : "알 수 없음" %>
                    </div>
                    <div class="title">
                        제목 : <input type="text" class="board_title" id="BOARD_TITLE" name="BOARD_TITLE">
                    </div>
                    <div class="content">
                        <textarea rows="10" cols="150" id="BOARD_CONTENT" name="BOARD_CONTENT"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    <script>
        function writeCheck() {
            if ($("#BOARD_TITLE").val() == '') {
                alert("제목을 입력해 주세요");
                $("#BOARD_TITLE").focus();
                return false;
            }
            if ($("#BOARD_CONTENT").val() == '') {
                alert("내용을 입력해 주세요");
                $("#BOARD_CONTENT").focus();
                return false;
            }
        }
    </script>
</body>
</html>
