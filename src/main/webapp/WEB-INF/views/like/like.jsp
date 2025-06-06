<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String todayDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    String tomorrowDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000));
%>
<c:set var="today" value="<%= todayDate %>" />
<c:set var="tomorrow" value="<%= tomorrowDate %>" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>찜한 숙소 목록</title>
    <link rel="stylesheet" href="/css/style.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/lodlike.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="/js/lodlike.js"></script>
    <style>
        .arrow-button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>
<div class="wrap">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <input type="hidden" id="user-id" value="${userIdx}" />
<div class="container">
    <div class="top-container">
        <button class="arrow-button" id="left-arrow" onclick="history.back();">
            <img src="/img/home_icon_left_arrow.svg" alt="뒤로 가기">
        </button>
        <div class="header-text">찜 한 숙소</div>
    </div>
    <div class="lod-like-info">
    <c:if test="${empty wishlist}">
        <div class="no-like-room-container">
            <img src="/img/lodlike_no_result.svg" alt="찜한 숙소 없음" class="no-like-room-image">
        </div>
    </c:if>
    <div class="card-container">
        <c:forEach var="lodgment" items="${wishlist}">
            <div class="card">
                <a href="/lodgment.do?lod_idx=${lodgment.lod_idx}&checkinDate=${today}&checkoutDate=${tomorrow}&guestCount=2&petCount=1"  class="room-image-link">
                    <img src="${lodgment.lod_img_url}" alt="${lodgment.lod_name}" class="card-image">
                </a>
                <div class="card-header">
                    <h3 class="card-title">${lodgment.lod_name}</h3>
                    <img
                            class="heart-icon ${lodgment.like_idx != null ? 'active' : ''}"
                            id="heart-icon"
                            src="${lodgment.like_idx != null ? '/img/like_full_heart.png' : '/img/like_empty_heart.png'}"
                            alt="Heart Icon"
                            data-lod-idx="${lodgment.lod_idx}"
                    />
                </div>
            </div>
        </c:forEach>
    </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</div>
</body>
</html>
