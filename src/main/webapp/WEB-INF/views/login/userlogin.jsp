<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2024-12-12
  Time: 오전 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>로그인</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css?after"/>
    <style>
        * {
            margin-bottom: 3px;
        }

        .container {
            height: 700px;
            padding: 50px 0px;
        }

        .login_wrap {
            align-items: center;
            text-align: center;
        }

        .container h1 {
            text-align: center;
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin-bottom: 70px;
        }

        .login_box {
            width: 486px;
        }

        .login_box input {
            width: 100%;
            height: 55px;
            padding: 10px;
            margin: 18px 0;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .login_box input::placeholder {
            color: #8A5642;
            font-family: "Noto Sans KR";
        }

        .login_button_wrap {
            width: 486px;
        }

        .login_button {
            background-color: #8A5642;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 20px;
            width: 100%;
            cursor: pointer;
            margin-top: 60px;
            height: 55px;
        }

        .login_warn {
            color: red;
            margin-top: 20px;
            text-align: center;
        }




    </style>
</head>
<body>
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
            <div class="container">
                <h1>로그인</h1>
                <form id="login" method="post" onsubmit="return loginCheck();">
                    <div class="login_wrap">
                        <div class="login_box">
                            <input type="text" id="USER_ID" name="USER_ID" placeholder="아이디" required>
                            <input type="password" id="USER_PWD" name="USER_PWD" placeholder="비밀번호" required>
                        </div>

                        <c:if test="${result == 0 }">
                            <div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.<br>입력하신 내용을 다시 확인해주세요.</div>
                        </c:if>

                        <div class="login_button_wrap">
                            <input type="button" class="login_button" value="로그인">
                        </div>
                    </div>
                </form>
            </div>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>

    <script>
        // 로그인 필터에서 메시지 전달 받을시 경고창 출력
        <c:if test="${ msg != null}">
            alert('<c:out value="${msg}" escapeXml="true" />');
        </c:if>

        /* 로그인 버튼 클릭 메서드 */
        $(".login_button").click(function () {

            // alert("로그인 버튼 작동");

            /* 로그인 메서드 서버 요청 */
            $("#login").attr("action", "/userlogin");
            $("#login").submit();

        });

        function loginCheck() {
            if ($("#USER_ID").val() == '') {
                alert("아이디를 입력해 주세요");
                $("#USER_ID").focus();
                return false;
            }
            if ($("#USER_PWD").val() == '') {
                alert("비밀번호를 입력해 주세요");
                $("#USER_PWD").focus();
                return false;
            }
        }


    </script>
</body>
</html>
