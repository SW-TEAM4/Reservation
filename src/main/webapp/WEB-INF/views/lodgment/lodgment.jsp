<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>숙소상세</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <link rel="stylesheet" href="/css/lodgment.css"/>
    <link rel="stylesheet" href="/css/roomcard.css"/>
    <link rel="stylesheet" href="/css/bookingbutton.css"/>
    <script src="/js/home.js"></script>
    <%-- Date Range Picker --%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>

    <script src="/js/lodsearch.js"></script>
    <%-- 판매자 팝업 --%>
    <script>
        // 팝업 열기
        function showSellerPopup() {
            const popup = document.getElementById("seller-popup");
            popup.classList.remove("hidden");
        }

        // 팝업 닫기
        function closeSellerPopup() {
            const popup = document.getElementById("seller-popup");
            popup.classList.add("hidden");
        }

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
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="container">
        <!-- 숙소 정보 -->
        <div class="lodgment-container">
            <div class="top-container">
                <img class="arrow-icon" id="left-arrow" src="/img/home_icon_left_arrow.svg"/>
                <div class="header-text">숙소 상세</div>
            </div>
            <div class="reserve-info">
                <c:if test="${not empty lodgmentDTO}">
                    <img src="${lodgmentDTO.lod_img_url}" alt="${lodgmentDTO.lod_name}"
                         style="margin-top: 30px; width: 1280px; height: 800px">
                    <p style="font-size: 24px; font-weight: bold">${lodgmentDTO.lod_name}</p>
                </c:if>
                <c:if test="${empty lodgmentDTO}">
                    <img src="<c:url value='/img/search_no_result.svg'/>" alt="결과 없음">
                </c:if>
            </div>
        </div>
        <!-- 리뷰 더보개 -->
        <div class="lod-review-container">
            <!-- 리뷰 통계 영역 -->
            <section class="review-summary">
                <div class="review-header">
                    <div class="review-statistics">
                        <div style="display: flex; align-items: center; gap: 5px;">
                            <img src="/img/search_icon_star.svg" class="star-icon" style="width: 16px; height: 16px;"/>
                            <p style="color: #352018; font-size: 14px; font-weight: bold;">${statistics['AVG_RATING']}</p>
                            <p style="color: #352018; font-size: 14px;">(${statistics['REVIEW_COUNT']})</p>
                        </div>
                    </div>
                    <a href="/lodreview.do?lod_idx=${lod_idx}" class="review-detail-link">
                        리뷰 더보기
                    </a>
                </div>
            </section>
            <div class="review-container">
                <c:if test="${not empty reviewList}">
                    <c:forEach var="review" items="${reviewList}" begin="0" end="2">
                        <div class="review-card">
                            <!-- 상단: 별점과 작성 날짜 -->
                            <div class="review-header">
                        <span class="review-rating">
                            <c:choose>
                                <c:when test="${review.reviewer_rating >= 0.0 && review.reviewer_rating < 1.0}">
                                    ☆
                                </c:when>
                                <c:when test="${review.reviewer_rating >= 1.0 && review.reviewer_rating < 2.0}">
                                    ⭐
                                </c:when>
                                <c:when test="${review.reviewer_rating >= 2.0 && review.reviewer_rating < 3.0}">
                                    ⭐ ⭐
                                </c:when>
                                <c:when test="${review.reviewer_rating >= 3.0 && review.reviewer_rating < 4.0}">
                                    ⭐ ⭐ ⭐
                                </c:when>
                                <c:when test="${review.reviewer_rating >= 4.0 && review.reviewer_rating < 5.0}">
                                    ⭐ ⭐ ⭐ ⭐
                                </c:when>
                                <c:otherwise>
                                    ⭐ ⭐ ⭐ ⭐ ⭐
                                </c:otherwise>
                            </c:choose>
                            (${review.reviewer_rating})
                        </span>
                                <span class="review-date">${review.reviewer_created}</span>
                            </div>

                            <!-- 하단: 리뷰 내용과 이미지 -->
                            <div class="review-body">
                                <div class="review-content">${review.reviewer_content}</div>
                                <div class="review-image-container">
                                    <c:if test="${not empty review.reviewer_image}">
                                        <img src="${review.reviewer_image}" alt="리뷰 이미지" class="review-image">
                                    </c:if>
                                    <c:if test="${empty review.reviewer_image}">
                                        <img src="/img/lodgment_img_no_review.svg" alt="기본 이미지" class="review-image">
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>

                <!-- 리뷰가 없을 경우 -->
                <c:if test="${empty reviewList}">
                    <p>등록된 리뷰가 없습니다.</p>
                </c:if>
            </div>
        </div>

        <h3 style="display: flex; justify-content: flex-start; width: 100%; max-width: 1280px; font-size: 22px;">객실 선택</h3>
        <div class="lod-search_filters">
            <!-- 날짜 선택 -->
            <div class="selection-item">
                <div class="search-button" id="date-picker">
                        <span>
                            <img src="/img/search_icon_calendar.svg" class="calendar_icon" alt="calendar"/>
                            <span id="checkin-date">${checkinDate}</span> ~
                            <span id="checkout-date">${checkoutDate}</span>
                            <span id="cal-date"></span>
                        </span>
                </div>
            </div>
            <!-- 인원 및 반려동물 수 선택-->
            <div class="count-container">
                <!-- 인원 및 반려동물 수 선택 버튼 -->
                <button id="guest-button" class="count-selector">
                        <span class="guest-label">
                           인원 <span id="guest-count">${guestCount}</span>,
                           반려동물 <span id="pet-count">${petCount}</span>
                        </span>
                </button>
                <!-- 팝업 !-->
                <div id="guest-popup" class="guest-popup hidden">
                    <!-- 인원 조절 !-->
                    <div class="counter">
                        <div class="popup-header">인원ㅤㅤ</div>
                        <button id="minus-guest-btn" class="counter-btn">-</button>
                        <span id="guest-counter">${guestCount}</span>
                        <button id="plus-guest-btn" class="counter-btn">+</button>
                    </div>

                    <!-- 반려동물 조절 !-->
                    <div class="counter">
                        <div class="popup-header">반려동물</div>
                        <button id="minus-pet-btn" class="counter-btn">-</button>
                        <span id="pet-counter">${petCount}</span>
                        <button id="plus-pet-btn" class="counter-btn">+</button>
                    </div>

                    <!-- 완료 버튼 !-->
                    <p class="popup-subtitle">유아 및 아동도 인원수에 포함해주세요.</p>
                    <button id="apply-btn" class="apply-btn">완료</button>
                </div>
            </div>
        </div>
        <!-- 객실 리스트 !-->
        <div class="room-list" id="room-list">
            <input type="hidden" id="lod_idx" value="${lod_idx}">
            <c:if test="${not empty roomList}">
                <c:forEach var="room" items="${roomList}">
                    <%@ include file="/WEB-INF/views/room/roomcard.jsp" %>
                </c:forEach>
            </c:if>
            <c:if test="${empty roomList}">
                <p>예약 가능한 방이 없습니다!</p>
            </c:if>
        </div>

        <!-- 지도 -->
        <div class="lodgment-map">
            <div style="margin-bottom: 15px;">위치/교통</div>
            <c:set var="centerX" value="${lodgmentDTO.x != null ? lodgmentDTO.x : 0}"/>
            <c:set var="centerY" value="${lodgmentDTO.y != null ? lodgmentDTO.y : 0}"/>
            <c:set var="zoomLevel" value="3"/>
            <c:set var="markerX" value="${lodgmentDTO.x}"/>
            <c:set var="markerY" value="${lodgmentDTO.y}"/>
            <c:set var="markerImage" value="/img/lod_map_marker.png"/>
            <c:set var="mapWidth" value="1305px"/>
            <c:set var="mapHeight" value="661px"/>

            <%@ include file="/WEB-INF/views/lodgment/map.jsp" %>
        </div>

        <!-- 숙소 주소 -->
        <div class="lodgment-address">
            <img src="/img/lod_map_location.svg" alt="숙소 주소 아이콘" class="address-icon">
            <span>${lodgmentDTO.lod_address}</span>
        </div>

        <!-- 사장님이 알려주개 -->
        <div class="lodgment-seller-notice">
            <h3>사장님이 알려주개</h3>
            <p>${lodgmentDTO.seller_notice}</p>
        </div>

        <!-- 예약 공지 -->
        <div class="lodgment-reservation-notice">
            <h3>예약 공지</h3>
            <p>${lodgmentDTO.reservation_notice}</p>
        </div>

        <div class="facility-item">
            <h3>시설/서비스</h3>
            <c:if test="${not empty facilityList}">
                <c:forEach var="facility" items="${facilityList}">
                    <p>* ${facility.lod_facility_name}</p>
                </c:forEach>
            </c:if>
            <c:if test="${empty facilityList}">
                <p>등록된 시설 정보가 없습니다.</p>
            </c:if>
        </div>
        <%-- 판매자 정보 --%>
        <div id="seller-popup">
            <div class="popup-content">
                <h3>판매자 정보</h3>
                <table>
                    <tr>
                        <th>이름</th>
                        <td>${sellerInfo.SELLER_NAME}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>${sellerInfo.SELLER_EMAIL}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>${sellerInfo.SELLER_PHONE_NUMBER}</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
