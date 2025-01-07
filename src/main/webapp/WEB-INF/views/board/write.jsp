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
        }

        .write_container {
            margin-left: 300px;
            padding: 0 50px;
        }

        .board_title {
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        td {
            font-family: "Noto Sans KR";

        }

        textarea {
            border-radius: 8px;
            border: 2px solid #8A5642;
        }

        .submit {
            background-color: #8A5642;
            color: white;
            font-family: "Noto Sans KR";
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 80px;
            height: 30px;
            margin-top: 15px;

        }

        .back_container {
            display: flex;
            justify-content: center;
            margin: 0 auto;
        }

        .back {
            padding: 10px 20px;
            background-color: #352018;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
        }

        .back:hover {
            background-color: #8A5642;
        }

    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="write_container">
            <h2>게시글 작성</h2>
            <div class="writetable">
                <form method="post" action="write" onsubmit="return writeCheck();">
                    <table>
                        <tr>
                            <td>글쓴이 : </td>
                            <td>
                                <%= USER_ID != null ? USER_ID : "알 수 없음" %>
                            </td>
                        </tr>
                        <tr>
                            <td>제목 : </td>
                            <td>
                                <input type="text" class="board_title" id="BOARD_TITLE" name="BOARD_TITLE">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">내용 : </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea rows="10" cols="150" id="BOARD_CONTENT" name="BOARD_CONTENT"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" class="submit" value="등록">
                            </td>
                        </tr>
                    </table>
                </form>
                <div class="back_container">
                    <a href="/gather" class="back">목록으로 돌아가기</a>
                </div>
            </div>
        </div>
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
