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
    <link rel="stylesheet" href="/css/mypage.css"/>
<%--    <link rel="stylesheet" href="/css/mypageStyle.css"/>--%>
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
                <img src="/img/mypage_icon_3.svg" alt="최근 본 객실">
                <span>최근 본 객실</span>
                <img src="/img/Arrow_Icon.svg" alt="Arrow Icon" />
            </div>
            <div class="listItem" onclick="location.href='/lodlike/lodwish.do'">
                <img src="/img/mypage_heart.png" class="heart-icon" alt="찜한 숙소">
                <span>찜한 숙소</span>
                <img src="/img/Arrow_Icon.svg" alt="Arrow Icon">
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
