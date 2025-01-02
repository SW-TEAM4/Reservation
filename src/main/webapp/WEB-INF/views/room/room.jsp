<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>객실상세</title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="stylesheet" href="/css/roomcard.css"/>
    <link rel="stylesheet" href="/css/room.css"/>
    <script src="/js/home.js"></script>
    <script src="/js/room.js"></script>
    <style>


    </style>
</head>
<body>
<div class="wrap">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <img src="<c:url value='/img/lod_toolbar.svg'/>" alt="객실 상세" class="lod-tool-bar">
    <c:if test="${not empty room}">
        <div class="room-detail">

            <!-- 객실 이미지 -->
            <c:if test="${not empty room.room_img_urls}">
                <div class="custom-slider">
                    <div class="slider-wrapper">
                        <!-- 이미지 리스트 -->
                        <c:forEach var="imgUrl" items="${room.room_img_urls}">
                            <div class="slider-slide">
                                <img src="${imgUrl}" alt="${room.room_name}" class="detail-img" style="width: 100%; height: auto;">
                            </div>
                        </c:forEach>
                    </div>
                    <!-- 네비게이션 버튼 -->
                    <img src="/img/room_img_left_swipe.svg" alt="이전" class="slider-button prev-button">
                    <img src="/img/room_img_right_swipe.svg" alt="다음" class="slider-button next-button">

                    <!-- 현재 이미지 번호 -->
                    <div class="slider-counter">
                        <span id="current-slide">1</span> / <span id="total-slides">${(room.room_img_urls)}</span>
                    </div>
                </div>
            </c:if>


            <!-- 객실 정보 -->
            <div class="detail-info">
                <p><strong>숙소 이름:</strong> ${room.room_name}</p>
                <p><strong>가격:</strong> ${room.room_price}원</p>
                <p><strong>숙박 일정:</strong> ${checkinDate} ~ ${checkoutDate}</p>
                <p><strong>인원:</strong> ${guestCount}명</p>
                <p><strong>반려동물 수:</strong> ${petCount}마리</p>
            </div>

            <!-- 예약 공지 -->
            <div class="room-notice">
                <h3>예약 공지</h3>
                <p>${room.room_notice}</p>
            </div>

            <!-- 예약 버튼 -->
            <button class="booking-button" onclick="location.href='/reserve/reservation.do?room_idx=${room.room_idx}'">
                예약하기
            </button>
        </div>

    </c:if>

    <c:if test="${empty room}">
        <img src="<c:url value='/img/search_no_result.svg'/>" alt="결과 없음">
    </c:if>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
