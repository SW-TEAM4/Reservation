<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2024-12-12
  Time: 오전 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>로그인</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR';
            background-color: #fff;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .header {
            width: 100%;
            background-color: #8A5642;
            padding: 20px;
            text-align: center;
            position: absolute;
            top: 0;
        }

        .header img {
            height: 44px;
            width: 150.91px;
            margin-right: 1500px;
            top: 24px;
        }

        /*.header h1 {*/
        /*    !*background-image: url("/img/main_logo.svg");*!*/
        /*    margin: 0;*/
        /*    color: #DDAC7E;*/
        /*    font-size: 20px;*/
        /*}*/

        .container h1 {
            text-align: center;
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin-bottom: 70px;
        }

        .login_box {
            width: 486px;
            /*margin: 0 auto;*/
            /*padding: 30px;*/
            /*border: 1px solid #fff;*/
            /*border-radius: 5px;*/
            /*background-color: #fff;*/
            /*text-align: center;*/
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

        .footer {
            padding: 10px;
            font-size: 13px;
            color: #666;
            text-align: center;
            position: absolute;
            bottom: 0;
            margin-left: 110px;
        }

        .footer p {
            margin: 5px 0;
        }


    </style>
</head>
<body>
    <div class="header">
        <img src="/img/main_logo.svg" alt="logo">
<%--        <h1>같이가개 🐾</h1>--%>
    </div>

    <div class="container">
        <h1>로그인</h1>
        <form id="login" method="post" onsubmit="return loginCheck();">
            <div class="login_wrap">
                <div class="login_box">
                    <input type="text" id="SELLER_ID" name="SELLER_ID" placeholder="아이디" required>
                    <input type="password" id="SELLER_PWD" name="SELLER_PWD" placeholder="비밀번호" required>
                </div>

                <c:if test="${result == 0 }">
                    <div class="login_warn">사장님 ID 또는 비밀번호를 잘못 입력하셨습니다.<br>입력하신 내용을 다시 확인해주세요.</div>
                </c:if>

                <div class="login_button_wrap">
                    <input type="button" class="login_button" value="로그인">
                </div>
            </div>
        </form>
        <div class="footer">
            <p>이용약관 | 개인정보처리방침</p>
            <p>대표번호 010-6566-4932 | ⓒ4Team Corp.</p>
        </div>
    </div>


    <script>
        /* 로그인 버튼 클릭 메서드 */
        $(".login_button").click(function() {

            // alert("로그인 버튼 작동");

            /* 로그인 메서드 서버 요청 */
            $("#login").attr("action", "/sellerlogin");
            $("#login").submit();

        });

        function loginCheck() {
            if ($("#SELLER_ID").val() == '') {
                alert("아이디를 입력해 주세요");
                $("#SELLER_ID").focus();
                return false;
            }
            if ($("#SELLER_PWD").val() == '') {
                alert("비밀번호를 입력해 주세요");
                $("#SELLER_PWD").focus();
                return false;
            }
        }

    </script>
</body>
</html>
