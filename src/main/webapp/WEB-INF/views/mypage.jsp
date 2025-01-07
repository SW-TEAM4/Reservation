<%--
  Created by IntelliJ IDEA.
  User: 이윤채
  Date: 2024-12-24
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>같이가개 - 마이페이지</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <!-- Google Fonts에서 Noto Sans KR 불러오기 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700&display=swap" rel="stylesheet">
    <script src="/js/home.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
<%--    <link rel="stylesheet" href="/css/mypageStyle.css"/>--%>
    <style>

        .background {
            /*display: flex;*/
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .container {
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            background-color: #FFFFFF;
            /*width: 1200px;*/
        }

        .profile {
            width: 200px;
            height: 110px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 100px auto 100px;
        }

        .profile img {
            width: 120px;
            height: 120px;
        }

        .profileId {
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            cursor: pointer;
            margin-top: -80px;
            margin-left: 10px;
        }

        .userId {
            font-size: 20px;
            color: black;
            margin: 0 8px 0 0;
            font-weight: bold;
        }

        .listWrapper {
            background-color: #8A5642;
            width: 590px;
            height: 450px;
            border-radius: 30px 30px 30px 30px;
            padding-top: 30px;
            margin: 50px auto;
            position: relative;
            margin-bottom: 300px;
        }

        .list {
            width: 90%;
            margin: 0 auto;
        }

        .listItem {
            display: flex;
            align-items: center;
            padding: 50px 20px;
        }

        .listItem img:first-child {
            margin-right: 20px;
        }

        .listItem:last-child {
            border-bottom: none;
        }

        .listItem span {
            font-size: 20px;
            font-family: 'Noto Sans KR', sans-serif;
            color: #FFFFFF;
            margin-left: 10px;
            flex-grow: 1;
        }

    </style>
</head>
<body>
<div class="background">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>

    <div class="container">
        <div class="profile">
            <img src="/img/mypage_user_profil.svg" alt="프로필 이미지">
        </div>
        <div class="profileId" onclick="location.href='/modifyMyInfo'">
            <span class="userId">${userReservedDTO.user_name}님</span>
        </div>
    </div>

    <div class="listWrapper">
        <div class="list">
            <div class="listItem" onclick="location.href='/reservation/list'">
                <img src="/img/bone.svg" alt="예약내역 아이콘">
                <span>예약내역</span>
                <img src="/img/Arrow_Icon.svg" alt="Arrow Icon" />
            </div>
            <div class="listItem" onclick="location.href='/review/list'">
                <img src="/img/mypage_icon_1.svg" alt="리뷰내역 아이콘">
                <span>리뷰내역</span>
                <img src="/img/Arrow_Icon.svg" alt="Arrow Icon" />
            </div>
            <div class="listItem" onclick="location.href='recently/recently.do'">
                <img src="/img/mypage_icon_3.svg" alt="최근 본 숙소">
                <span>최근 본 숙소</span>
                <img src="/img/Arrow_Icon.svg" alt="Arrow Icon" />
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
