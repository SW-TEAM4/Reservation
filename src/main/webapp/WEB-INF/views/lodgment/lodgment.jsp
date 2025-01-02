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
  <link rel="stylesheet" href="/css/button.css"/>

    <%-- Date Range Picker --%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
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
  </script>


</head>
<body>
  <div class="wrap">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="container">
    <!-- 숙소 정보 -->
    <div class="lodgment-container">
      <img src="<c:url value='/img/lod_toolbar.svg'/>" alt="객실 상세">
      <c:if test="${not empty lodgment.lodgment}">
        <img src="${lodgment.lodgment.lod_img_url}" alt="${lodgment.lodgment.lod_name}"
             width="1280px" height="800px">
        <p>${lodgment.lodgment.lod_name}</p>
        <div class="lod-review-container">
          <section class="review-summary">
            <div class="review-statistics">
              <p>리뷰 수: ${statistics['REVIEW_COUNT']}</p>
              <p>
              <span>
                <!-- 평균 평점에 따라 별 개수 계산 -->
                <c:choose>
                  <c:when test="${statistics['AVG_RATING'] >= 0.0 && statistics['AVG_RATING'] < 1.0}">
                    ☆ (평점: ${statistics['AVG_RATING']})
                  </c:when>
                  <c:when test="${statistics['AVG_RATING'] >= 1.0 && statistics['AVG_RATING'] < 2.0}">
                    ⭐ (평점: ${statistics['AVG_RATING']})
                  </c:when>
                  <c:when test="${statistics['AVG_RATING'] >= 2.0 && statistics['AVG_RATING'] < 3.0}">
                    ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
                  </c:when>
                  <c:when test="${statistics['AVG_RATING'] >= 3.0 && statistics['AVG_RATING'] < 4.0}">
                    ⭐ ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
                  </c:when>
                  <c:when test="${statistics['AVG_RATING'] >= 4.0 && statistics['AVG_RATING'] < 5.0}">
                    ⭐ ⭐ ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
                  </c:when>
                  <c:when test="${statistics['AVG_RATING'] >= 5.0}">
                    ⭐ ⭐ ⭐ ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
                  </c:when>
                </c:choose>
              </span>
              </p>
            </div>
            <a href="/lodreview.do" class="review-detail-link">
              <h2>리뷰 더보개 &gt;</h2>
            </a>
            <div class="review-container">
              <c:choose>
                <c:when test="${empty reviewList}">
                  <p>등록된 리뷰가 없습니다.</p>
                </c:when>
                <c:otherwise>
                  <c:forEach var="review" items="${reviewList}" begin="0" end="1">
                    <div class="review-card">
                      <h3>${review.reviewer_nickname}</h3>
                      <p>${review.reviewer_content}</p>
                      <span>
                          <!-- 점수에 따라 별 개수 계산 -->
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
                      </span>
                    </div>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </section>
        </div>
      </c:if>
      <c:if test="${empty lodgment.lodgment}">
        <img src="<c:url value='/img/search_no_result.svg'/>" alt="결과 없음">
      </c:if>
    </div>

    <h3>객실 선택</h3>
    <div class="search_filters">

      <!-- 날짜 선택 -->
      <div class="selection-item">
        <div class="search-button" id="date-picker">
            <span>
                <img src="/img/search_icon_calendar.svg" class="calendar_icon" alt="calendar"/>
                <span id="checkin-date">${requestScope.checkinDate}</span> ~
                <span id="checkout-date">${requestScope.checkoutDate}</span>
                <span id="cal-date"></span>
            </span>
        </div>
      </div>

      <!-- 인원 및 반려동물 수 선택-->
      <div class="count-container">

        <!-- 인원 및 반려동물 수 선택 버튼 -->
        <button id="guest-button" class="count-selector">
       <span class="guest-label">
           인원 <span id="guest-count">${requestScope.guestCount}</span>,
           반려동물 <span id="pet-count">${requestScope.petCount}</span>
       </span>
        </button>

        <!-- 팝업 -->
        <div id="guest-popup" class="guest-popup hidden">
          <!-- 인원 조절 -->
          <div class="counter">
            <div class="popup-header">인원</div>
            <button id="minus-guest-btn" class="counter-btn">-</button>
            <span id="guest-counter">${requestScope.guestCount}</span>
            <button id="plus-guest-btn" class="counter-btn">+</button>
          </div>

          <!-- 반려동물 조절 -->
          <div class="counter">
            <div class="popup-header">반려동물</div>
            <button id="minus-pet-btn" class="counter-btn">-</button>
            <span id="pet-counter">${requestScope.petCount}</span>
            <button id="plus-pet-btn" class="counter-btn">+</button>
          </div>

          <!-- 완료 버튼 -->
          <p class="popup-subtitle">유아 및 아동도 인원수에 포함해주세요.</p>
          <button id="apply-btn" class="apply-btn">완료</button>
        </div>
      </div>

    </div>
    <!-- 객실 리스트 -->
    <div class="room-list" id="room-list">
      <c:forEach var="room" items="${roomList}">
        <%@ include file="/WEB-INF/views/room/roomcard.jsp" %>
      </c:forEach>
    </div>


    <!-- 지도 -->
    <div class="lodgment-map">
      <h3>위치/교통</h3>
      <c:set var="centerX" value="${lodgment.lodgment.x}" />
      <c:set var="centerY" value="${lodgment.lodgment.y}" />
      <c:set var="zoomLevel" value="3" />
      <c:set var="markerX" value="${lodgment.lodgment.x}" />
      <c:set var="markerY" value="${lodgment.lodgment.y}" />
      <c:set var="markerImage" value="/img/lod_map_marker.png" />
      <c:set var="mapWidth" value="1305px" />
      <c:set var="mapHeight" value="661px" />

      <%@ include file="/WEB-INF/views/lodgment/map.jsp" %>
    </div>

    <!-- 숙소 주소 -->
    <div class="lodgment-address">
      <img src="/img/lod_map_location.svg" alt="숙소 주소 아이콘" class="address-icon">
      <span>${lodgment.lodgment.lod_address}</span>
    </div>


    <!-- 사장님이 알려주개 -->
    <div class="lodgment-seller-notice">
      <h3>사장님이 알려주개</h3>
      <p>${lodgment.lodgment.seller_notice}</p>
    </div>

    <!-- 예약 공지 -->
    <div class="lodgment-reservation-notice">
      <h3>예약 공지</h3>
      <p>${lodgment.lodgment.reservation_notice}</p>
    </div>

    <h3>시설/서비스</h3>
    <c:if test="${not empty facilityList}">
      <c:forEach var="facility" items="${facilityList}">
        <div class="facility-item">
          <p>* ${facility.lod_facility_name}</p>
        </div>
      </c:forEach>
    </c:if>
    <c:if test="${empty facilityList}">
      <p>등록된 시설 정보가 없습니다.</p>
    </c:if>

    <%-- 판매자 정보 --%>
    <div class="seller-info-container">
      <button onclick="showSellerPopup()">판매자 정보 보기</button>
    </div>
    <div id="seller-popup" class="popup hidden">
      <div class="popup-content">
        <button class="close-popup" onclick="closeSellerPopup()">X</button>
        <h3>판매자 정보</h3>
        <table>
          <tr>
            <th>이름</th>
            <td>${sellerInfo.seller_name}</td>
          </tr>
          <tr>
            <th>이메일</th>
            <td>${sellerInfo.seller_email}</td>
          </tr>
          <tr>
            <th>전화번호</th>
            <td>${sellerInfo.seller_phone_number}</td>
          </tr>
        </table>
      </div>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </div>
  </div>
</body>
</html>
