<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2024-12-31
  Time: 오후 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입 완료</title>
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

        .container img {
            text-align: center;
            margin-left: 50px;
        }

        .container h2 {
            text-align: center;
            font-family: "Noto Sans KR";
            margin-bottom: 50px;
        }

        .button {
            background-color: #8A5642;
            color: white;
            text-align: center;
            border: none;
            border-radius: 5px;
            margin: 2px;
            width: 486px;
            height: 62px;
            font-family: "Noto Sans KR";
            cursor: pointer;
        }

        .footer {
            padding: 10px;
            font-size: 13px;
            color: #666;
            text-align: center;
            position: absolute;
            bottom: 0;
            margin-left: 30px;
        }

        .footer p {
            margin: 5px 0;
        }

    </style>
</head>
<body>
    <div class="header">
        <img src="/img/main_logo.svg" alt="main_logo">
    </div>
    <div class="container">
        <img src="/img/dog.svg" alt="logo">
        <h2>같이가개 가입을 축하드립니다!!</h2>
        <div><button class="button" onclick="location.href='/sellerlogin'">같이가개 서비스 시작하기</button></div>
    </div>

    <div class="footer">
        <p>이용약관 | 개인정보처리방침</p>
        <p>대표번호 010-6566-4932 | ⓒ4Team Corp.</p>
    </div>


</body>
</html>
