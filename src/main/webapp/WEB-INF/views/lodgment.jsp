<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>숙소 상세</title>
  <link rel="stylesheet" href="/css/style.css"/>
  <link rel="stylesheet" href="/css/counter.css"/>
  <link rel="stylesheet" href="/css/style.css?after"/>

  <style>
    .wrap {
      margin: 0 80px;
    }
    .selection-container {
      display: flex;
      justify-content: space-between;
      gap: 20px;
      margin-bottom: 30px;
    }
    .selection-item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 8px;
      cursor: pointer;
      width: 48%;
      transition: all 0.3s ease;
    }
    .selection-item:hover {
      background-color: #f5f5f5;
    }
    .selection-item img {
      width: 20px;
    }
    #calendar-container {
      display: none;
      margin-top: 20px;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .lodgment-address {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .address-icon {
      width: 20px;
      height: auto;
    }
  </style>
</head>
<body>
<div class="wrap">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <!-- 숙소 정보 -->
  <div class="lodgment-container">
    <c:if test="${not empty lodgment.lodgment}">
      <img src="${lodgment.lodgment.lod_img_url}" alt="${lodgment.lodgment.lod_name}" width="1280" height="800">
      <p>${lodgment.lodgment.lod_name}</p>
      <p>평균 평점: ${lodgment.lodgment.avg_rating}</p>
    </c:if>
    <c:if test="${empty lodgment.lodgment}">
      <p>숙소 정보를 찾을 수 없습니다.</p>
    </c:if>
  </div>

  <!-- 날짜 선택 -->
  <div class="selection-container">
    <div class="selection-item" onclick="toggleCalendar()">
      <span id="selected-dates">날짜를 선택하세요</span>
      <img src="<c:url value='/img/search_icon_calendar.svg'/>" alt="달력 아이콘">
    </div>
  </div>

  <!-- 캘린더 컨테이너 -->
  <div id="calendar-container">
    <%@ include file="/WEB-INF/views/calendar.jsp" %>
  </div>


  <!-- 객실 리스트 -->
  <div class="room-list">
    <h3>객실 선택</h3>
    <c:forEach var="room" items="${roomList}">
      <%@ include file="/WEB-INF/views/roomcard.jsp" %>
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
    <c:set var="markerImage" value="/img/lodgment_map_marker.png" />
    <c:set var="mapWidth" value="1305px" />
    <c:set var="mapHeight" value="661px" />
    <%@ include file="/WEB-INF/views/map.jsp" %>
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

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
