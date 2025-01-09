<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>찜한 숙소 목록</title>
    <link rel="stylesheet" href="/css/lodlike.css">
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="/js/lodlike.js"></script>
</head>
<body>
<div class="wrap">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>

    <!-- 사용자 ID 숨겨진 필드 -->
    <input type="hidden" id="user-id" value="${userIdx}" />

    <div class="card-container">
        <div class="top-container">
            <img class="arrow-icon" id="left-arrow" src="/img/home_icon_left_arrow.svg"/>
            <div class="header-text">찜 한 숙소</div>
        </div>

        <!-- 찜한 숙소가 없을 경우 -->
        <c:if test="${empty wishlist}">
            <div class="no-recently-rooms-container">
                <img src="/img/lodlike_no_result.svg" alt="찜한 숙소 없음" class="no-recently-rooms-image">
            </div>
        </c:if>

        <c:forEach var="lodgment" items="${wishlist}">
            <div class="card">

                <img src="${lodgment.lod_img_url}" alt="${lodgment.lod_name}" class="card-image">

                <img
                        class="heart-icon ${lodgment.like_idx != null ? 'active' : ''}"
                        id="heart-icon"
                        src="${lodgment.like_idx != null ? '/img/like_full_heart.png' : '/img/like_empty_heart.png'}"
                        alt="Heart Icon"
                        width="30"
                        height="30"
                        data-lod-idx="${lodgment.lod_idx}"
                />

                <h3>${lodgment.lod_name}</h3>
            </div>
        </c:forEach>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
