<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>함께가개</title>
</head>
<style>

    body {
        background: antiquewhite;
        margin: 0;
        height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }

    .logo {
        position: relative;
        transform: translateY(26px);
    }

    .index-container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .button-container {
        display: flex;
    }

    .user-btn {
        width: 300px;
        height: 300px;
        background: #DDAC7E;
        border-radius: 20px 0px 0px 20px;
        border-top: 5px solid #352018;
        border-bottom: 5px solid #352018;
        border-left: 5px solid #352018;
        color: #352018;
        font-weight: bold;
        cursor: pointer;
        font-size: 28px;
    }

    .owner-btn {
        width: 300px;
        height: 300px;
        background: #8A5642;
        border-top: 5px solid #352018;
        border-bottom: 5px solid #352018;
        border-right: 5px solid #352018;
        border-left: 3px solid #352018;
        border-radius: 0px 20px 20px 0px;
        color: #352018;
        font-weight: bold;
        cursor: pointer;
        font-size: 28px;
    }

</style>
<body>
<div class="index-container">
    <div class="logo">
        <img src="/img/logo.svg" width="1398px" height="216.33px">
    </div>

    <div class="button-container">
        <form action="/home.do" method="get">
            <button class="user-btn" type="submit">사용자</button>
        </form>

        <form action="/lodgment/sellerMain.do" method="get">
            <button class="owner-btn" type="submit">사장님</button>
        </form>
    </div>
</div>
</body>
</html>
