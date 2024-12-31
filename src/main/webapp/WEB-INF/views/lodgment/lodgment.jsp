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
  <script src="/js/lodsearch.js"></script>
  <%--판매자 팝업--%>
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
      <div class="selection-item" onclick="toggleCalendar()">
        <div class="search-button" id="date-picker">
            <span>
                <img src="/img/search_icon_calendar.svg" class="calendar_icon" alt="calendar"/>
                <span id="checkin-date"></span> ~
                <span id="checkout-date"></span>
                <span id="cal-date"></span>
            </span>
        </div>
      </div>

      <!-- 캘린더 컨테이너 -->
      <div id="calendar-container">
        <div id="calendar"></div>
        <button id="confirm-dates-btn" class="confirm_btn" onclick="confirmDates()">확인</button>
      </div>

      <!-- 인원 및 반려동물 수 선택-->
      <div class="count-container">
        <!-- 필터 버튼 -->
        <button id="guest-button" class="count-selector">
                    <span class="guest-label"> 인원 <span id="guest-count">2</span>, 반려동물 <span id="pet-count">1</span>
                     </span>
        </button>

        <!-- 팝업: 인원 및 반려동물 수 조절 -->
        <div id="guest-popup" class="guest-popup hidden">
          <!-- 인원 조절 -->
          <div class="counter">
            <div class="popup-header">인원ㅤㅤ</div>
            <button id="minus-guest-btn" class="counter-btn">-</button>
            <span id="guest-counter">2</span>
            <button id="plus-guest-btn" class="counter-btn">+</button>
          </div>

          <!-- 반려동물 조절 -->
          <div class="counter">
            <div class="popup-header">반려동물</div>
            <button id="minus-pet-btn" class="counter-btn">-</button>
            <span id="pet-counter">1</span>
            <button id="plus-pet-btn" class="counter-btn">+</button>
          </div>

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


<%--    <!-- 지도 -->--%>
<%--    <div class="lodgment-map">--%>
<%--      <h3>위치/교통</h3>--%>
<%--      <c:set var="centerX" value="${lodgment.lodgment.x}" />--%>
<%--      <c:set var="centerY" value="${lodgment.lodgment.y}" />--%>
<%--      <c:set var="zoomLevel" value="3" />--%>
<%--      <c:set var="markerX" value="${lodgment.lodgment.x}" />--%>
<%--      <c:set var="markerY" value="${lodgment.lodgment.y}" />--%>
<%--      <c:set var="markerImage" value="/img/lod_map_marker.png" />--%>
<%--      <c:set var="mapWidth" value="1305px" />--%>
<%--      <c:set var="mapHeight" value="661px" />--%>

<%--      <%@ include file="/WEB-INF/views/map.jsp" %>--%>
<%--    </div>--%>

    <!-- 숙소 주소 -->
    <div class="lodgment-address">
      <img src="/img/lod_map_location.svg" alt="숙소 주소 아이콘" class="address-icon">
      <span>${lodgment.lodgment.lod_address}</span>
    </div>


    <!-- 사장님이 알s려주개 -->
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
    <%--달력 fullcalendar--%>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
    <%--달력 팝업--%>
    <script>
      let calendar; // FullCalendar 인스턴스를 저장할 변수 추가

      // 오늘 날짜 및 내일 날짜 계산
      let today = new Date(); // 오늘 날짜
      let tomorrow = new Date(); // 내일 날짜 계산용
      tomorrow.setDate(today.getDate() + 1); // 내일 날짜 설정

      // 날짜를 '월 일 요일' 형식으로 변환하는 함수
      function formatDate(date) {
        const options = {month: 'long', day: 'numeric', weekday: 'long'}; // "월 일 요일" 형식
        return date.toLocaleDateString('ko-KR', options); // 한국어 형식
      }

      // 날짜 변환 및 표시
      let checkinDate = formatDate(today); // 오늘 날짜
      let checkoutDate = formatDate(tomorrow); // 내일 날짜

      // HTML 요소에 날짜 삽입
      document.getElementById('checkin-date').innerText = checkinDate; // 체크인 날짜
      document.getElementById('checkout-date').innerText += checkoutDate; // 체크아웃 날짜
      document.getElementById('cal-date').innerText = ", 1박"; // 기본 1박 설정


      let checkinDateEl = document.getElementById('checkin-date'); // 체크인 날짜 요소 참조
      let checkoutDateEl = document.getElementById('checkout-date'); // 체크아웃 날짜 요소 참조
      let calDateEl = document.getElementById('cal-date'); // 박 수 표시 엘리먼트

      function toggleCalendar() {
        const calendarContainer = document.getElementById('calendar-container');
        if (calendarContainer.style.display === 'none' || calendarContainer.style.display === '') {
          calendarContainer.style.display = 'block';
          renderCalendar(); // Render the calendar
        } else {
          calendarContainer.style.display = 'none';
        }
      }

      function renderCalendar() {
        const calendarEl = document.getElementById('calendar');
        if (calendar) return; // Do not recreate if already rendered

        const today = new Date();
        today.setHours(0, 0, 0, 0);

        calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          selectable: true,
          validRange: {start: today.toISOString().split('T')[0]},
          selectAllow: (selectInfo) => selectInfo.start >= today,
          select(info) {
            const selectedDate = new Date(info.startStr);

            if (!checkinDate || (checkinDate && checkoutDate)) {
              checkinDate = info.startStr;
              checkoutDate = null;
              checkinDateEl.textContent = formatDate(selectedDate);
              checkoutDateEl.textContent = '';
              calDateEl.textContent = ''; // 박 초기화
              resetStyles();
            } else if (checkinDate && !checkoutDate) {
              let startDate = new Date(checkinDate);

              if (selectedDate < startDate) {
                checkinDate = info.startStr;
                checkinDateEl.textContent = formatDate(selectedDate);
                resetStyles();
              } else if (selectedDate > startDate) {
                checkoutDate = info.startStr;
                checkoutDateEl.textContent = formatDate(selectedDate);

                function calculateNights(startDate, endDate) {
                  const diffTime = Math.abs(endDate - startDate); // 밀리초 차이 계산
                  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // 일수 계산
                  return diffDays; // 박 수 반환
                }

                calDateEl.textContent = ", " + calculateNights(startDate, selectedDate).toString() + "박";

                applyRangeStyles(startDate, selectedDate);
              }
            }
          },
          unselectAuto: false,
          height: 'auto',
          handleWindowResize: true,
        });

        calendar.render();
      }

      function confirmDates() {
        if (!checkinDate || !checkoutDate) {
          alert("입실일과 퇴실일을 모두 선택하세요.");
          return;
        }

        // 캘린더 숨기기
        document.getElementById("calendar-container").style.display = "none";
      }

      function applyRangeStyles(startDate, endDate) {
        resetStyles(); // 이전에 적용된 스타일 초기화

        let start = new Date(startDate);
        let end = new Date(endDate);
        end.setDate(end.getDate() + 1); // 범위의 마지막 날 포함

        while (start < end) {
          let dateStr = formatDateToString(start);
          let dayCell = document.querySelector(`[data-date="${dateStr}"]`);
          if (dayCell) {
            dayCell.style.backgroundColor = '#0096FF'; // 선택 범위 파란색으로 표시
            dayCell.style.color = '#FFFFFF'; // 글자 색상 흰색으로 변경
          }
          start.setDate(start.getDate() + 1);
        }
      }

      function formatDateToString(date) {
        return date.toISOString().split('T')[0]; // 날짜를 YYYY-MM-DD 형식으로 변환
      }

      function resetStyles() {
        document.querySelectorAll('[data-date]').forEach(day => {
          day.style.backgroundColor = ''; // 배경색 초기화
          day.style.color = ''; // 글자색 초기화
        });
      }
    </script>
  </div>
</body>
</html>
