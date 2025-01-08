<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>객실상세</title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css">
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="stylesheet" href="/css/bookingbutton.css"/>
    <link rel="stylesheet" href="/css/room.css"/>
    <link rel="stylesheet" href="/css/roomcard.css"/>
    <script src="/js/home.js"></script>
    <script src="/js/room.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // back 화살표 클릭 동작 이벤트 추가
            const arrowIcon = document.getElementById("left-arrow");
            if (arrowIcon) {
                arrowIcon.addEventListener("click", function () {
                    if (document.referrer) { // 이전 페이지가 있으면
                        window.history.back(); // 이전 페이지로 이동
                    } else { // 이전 페이지가 없으면
                        window.location.href = '/home.do'; // 홈페이지로 이동
                    }
                });
            }
        });
    </script>
</head>
<body>
<div class="wrap">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="container">
        <div class="top-container">
            <img class="arrow-icon" id="left-arrow" src="/img/home_icon_left_arrow.svg"/>
            <div class="header-text">객실 상세</div>
        </div>
        <div class="reserve-info">
            <c:if test="${not empty room}">
            <div class="room-detail">

                <!-- 객실 이미지 -->
                <c:if test="${not empty room.room_img_urls}">
                    <div class="custom-slider">
                        <div class="slider-wrapper">
                            <!-- 이미지 리스트 -->
                            <c:forEach var="imgUrl" items="${room.room_img_urls}">
                                <div class="slider-slide">
                                    <img src="${imgUrl}" alt="${room.room_name}" class="detail-img"
                                         style="width: 100%; height: auto;">
                                </div>
                            </c:forEach>
                        </div>
                        <!-- 네비게이션 버튼 -->
                        <img src="/img/room_img_left_swipe.svg" alt="이전" class="slider-button prev-button">
                        <img src="/img/room_img_right_swipe.svg" alt="다음" class="slider-button next-button">

                        <div class="slider-counter">
                            <span id="current-slide">1</span> / <span
                                id="total-slides">${fn:length(room.room_img_urls)}</span>
                        </div>
                    </div>
                </c:if>
            </div>
            <!-- 객실 정보 -->
            <!-- 객실 카드 -->
            <div class="room-room-card">
                <!-- 객실 정보 -->
                <div class="room-info">
                    <!-- 상단 영역 -->
                    <div class="room-header">
                        <div>
                            <div style="font-weight: bold; font-size: 20px; margin-bottom: 20px;">
                                    ${room.room_name}
                            </div>
                            <div class="room-name" style="margin-bottom: 5px;">숙박 일정</div>
                            <div class="check-in-out">${checkinDate} ~ ${checkoutDate}</div>
                            <p class="checkin-people">
                                <img src="/img/ResDetail_user_img.svg" alt="아이콘"
                                     style="width: 16px !important; height: 16px !important; vertical-align: -1.0627px">
                                성인 ${guestCount}명 /
                                반려동물: ${petCount}마리
                            </p>
                        </div>
                    </div>
                    <!-- 하단 영역 -->
                    <div class="room-footer">
                        <p class="room-price">${room.total_room_price}원</p>
                        <!-- 예약 버튼 -->
                        <button class="booking-button"
                                onclick="location.href='/reservation/reservation.do?room_idx=${room.room_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&res_people_cnt=${guestCount}&res_pets_cnt=${petCount}'">
                            <img src="../img/button_foot.svg" alt="icon" class="button-icon">
                            <span class="button-text">예약하기</span>
                        </button>
                    </div>
                </div>
            </div>

            <div style="width: 1280px; height: 1px; background-color: #cccccc; margin: 30px auto;"></div>

            <!-- 예약 공지 -->
            <div class="room-notice" style="margin-bottom: 50px;">
                <div style="font-size: 20px; font-weight: bold;">예약 공지
                </div>
                <p>${room.room_notice}</p>
            </div>
        </div>

        </c:if>

        <c:if test="${empty room}">
            <img src="<c:url value='/img/search_no_result.svg'/>" alt="결과 없음">
        </c:if>

        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    </div>
</div>
</body>
</html>
