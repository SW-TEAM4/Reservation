<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>숙소 상세</title>
  <link rel="stylesheet" href="/css/style.css"/>
  <link rel="stylesheet" href="/css/counter.css"/>
  <link rel="stylesheet" href="/css/style.css?after"/>

  <style>
    .lodgment-container {
      margin: 0 80px; /* 위아래는 0, 좌우는 20px */
    }
    .lod-review-container {
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      border-color: #8A5642;
      background-color: #FFFFFF;
      height: 329px;
    }
    .review-container {
      display: flex;
      flex-direction: row; /* 세로로 배치 */
      gap: 20px; /* 각 리뷰 간격 */
    }

    .review-card {
      display: flex;
      align-items: center;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fff;
    }

    .review-card h3 {
      margin: 0;
      font-size: 16px;
      font-weight: bold;
    }

    .review-card p {
      margin: 0;
      margin-left: 15px;
      font-size: 14px;
    }

    .review-card span {
      font-size: 14px;
      color: #f39c12;
      margin-left: 10px;
    }
    .review-summary {
      display: flex;
      align-items: center; /* 세로 정렬 */
      justify-content: space-between; /* 좌우로 정렬 */
      margin-top: 20px;
    }

    .review-statistics {
      display: flex;
      flex-direction: column; /* 텍스트를 세로로 나열 */
    }

    .review-detail-link {
      text-decoration: none;
      color: #8A5642; /* 원하는 텍스트 색상 */
      font-size: 18px;
      font-weight: bold;
    }
    .selection-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }
    .selection-container .selection-item {
      display: flex;
      align-items: center;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      cursor: pointer;
      width: 48%; /* 두 항목을 나란히 배치 */
    }
    .selection-container .selection-item img {
      margin-left: auto; /* 아이콘을 오른쪽 끝으로 배치 */
    }
    .selection-container {
      display: flex;
      justify-content: space-between;
      gap: 20px;
    }

    .selection-item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 8px;
      cursor: pointer;
    }

    .selection-item img {
      width: 20px;
    }

    .hidden {
      display: none; /* 숨김 */
    }

    /* 캘린더 컨테이너 */
    #calendar-container {
      display: none; /* 기본적으로 숨김 */
      margin-top: 20px;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fff;
    }

    .lodgment-address {
      display: flex;
      align-items: center; /* 세로 정렬을 가운데로 */
      gap: 10px; /* 아이콘과 텍스트 사이 간격 */
    }
    .address-icon {
      width: 20px; /* 아이콘 크기 조정 (필요시) */
      height: auto;
    }


    #selected-dates {
      color: blueviolet; /* 텍스트 색상 */
      font-size: 16px; /* 텍스트 크기 */
    }
    .fc-daygrid-day.in-range {
      background-color: #ffddc1; /* Light orange background */
      color: #000; /* Black text */
    }

    .fc-daygrid-day.in-range:hover {
      background-color: #ffc299; /* Darker orange on hover */
    }
    /* 팝업 배경 */
    .popup {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }

    .popup.hidden {
      display: none; /* 숨김 */
    }

    /* 팝업 내용 */
    .popup-content {
      position: relative; /* 닫기 버튼 위치 조정을 위해 추가 */
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      width: 400px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      text-align: center;
    }

    /* 닫기 버튼 */
    .close-popup {
      position: absolute; /* 부모 요소를 기준으로 위치 지정 */
      top: 10px; /* 상단 여백 */
      left: 10px; /* 왼쪽 여백 */
      background: none;
      border: none;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #f4f4f4;
    }
  </style>
</head>
<body>
<div class="wrap">

  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <!-- 숙소 정보 -->
  <div class="lodgment-container">
    <img src="<c:url value='/img/lod_toolbar.svg'/>" alt="객실 상세">
    <c:if test="${not empty lodgment.lodgment}">
      <img src="${lodgment.lodgment.lod_img_url}" alt="${lodgment.lodgment.lod_name}"
           width="1280px" height="800px">
      <p>${lodgment.lodgment.lod_name}</p>
      <div class="lod-review-container">
        <!-- 리뷰 통계 -->
        <section class="review-summary">
          <div class="review-statistics">
            <p>리뷰 수: ${statistics['REVIEW_COUNT']}</p>
            <p><span>
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
        </section>
        <div class="review-container">
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
                  <c:when test="${review.reviewer_rating >= 5.0}">
                    ⭐ ⭐ ⭐ ⭐ ⭐
                  </c:when>
                </c:choose>
            </span>
            </div>
          </c:forEach>
        </div>


        <!-- 리뷰 목록이 비어 있는 경우 -->
            <c:if test="${empty reviewList}">
              <p>등록된 리뷰가 없습니다.</p>
            </c:if>
          </div>
        </section>
      </div>
    </c:if>
    <c:if test="${empty lodgment.lodgment}">
      <img src="<c:url value='/img/search_no_result.svg'/>" alt="결과 없음">
    </c:if>

    <h3>객실 선택</h3>
    <!-- 날짜 및 인원수 선택 -->
    <div class="selection-container">
      <!-- 날짜 선택 -->
      <div class="selection-item" onclick="toggleCalendar()">
        <span id="checkin-date"></span>
        <span id="checkout-date"> ~ </span>
        <img src="<c:url value='/img/search_icon_calendar.svg'/>" alt="달력 아이콘">
      </div>

<%--      인원수 선택--%>
      <div class="selection-item" onclick="toggleCounter()">
        <span id="selected-max">성인 2명, 아동 1명</span>
        <img src="<c:url value='/img/search_icon_down.svg'/>" alt="화살표 아이콘">
      </div>
    </div>
  <!-- 캘린더 컨테이너 -->
  <div id="calendar-container">
    <div id="calendar"></div>
    <button id="confirm-dates-btn" onclick="confirmDates()">확인</button>
  </div>
</div>

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script>
  let calendar; // FullCalendar 인스턴스를 저장할 변수
  let checkinDate = null;
  let checkoutDate = null;
  const checkinDateEl = document.getElementById('checkin-date');
  const checkoutDateEl = document.getElementById('checkout-date');
  // 캘린더 토글
  function toggleCalendar() {
    const calendarContainer = document.getElementById('calendar-container');
    if (calendarContainer.style.display === 'none' || calendarContainer.style.display === '') {
      calendarContainer.style.display = 'block';
      renderCalendar(); // 캘린더 렌더링
    } else {
      calendarContainer.style.display = 'none';
    }
  }

  function renderCalendar() {
    const calendarEl = document.getElementById('calendar');

    if (calendar) return; // 이미 렌더링된 경우 다시 생성하지 않음

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // FullCalendar 초기화
    calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      selectable: true,
      validRange: { start: today.toISOString().split('T')[0] }, // 오늘 이후만 선택 가능
      selectAllow: (selectInfo) => selectInfo.start >= today, // 과거 날짜 선택 방지
      select(info) {
        const selectedDate = new Date(info.startStr);

        if (!checkinDate || (checkinDate && checkoutDate)) {
          // 체크인 날짜 설정 및 체크아웃 초기화
          checkinDate = info.startStr;
          checkoutDate = null;
          checkinDateEl.textContent = formatDate(selectedDate);
          checkoutDateEl.textContent = '';
          resetStyles();
        } else if (checkinDate && !checkoutDate) {
          let startDate = new Date(checkinDate);

          if (selectedDate < startDate) {
            // 이전 날짜를 선택한 경우 체크인 날짜 변경
            checkinDate = info.startStr;
            checkinDateEl.textContent = formatDate(selectedDate);
            resetStyles();
          } else if (selectedDate > startDate) {
            // 이후 날짜를 선택한 경우 체크아웃 날짜 설정 및 범위 스타일 적용
            checkoutDate = info.startStr;
            checkoutDateEl.textContent = " ~ " + formatDate(selectedDate);
            applyRangeStyles(startDate, selectedDate);
          }
        }
      },
      unselectAuto: false,
      height: 'auto',
      handleWindowResize: true,
    });

    calendar.render(); // 캘린더 렌더링
  }

  //서버에 선택된 날짜 전달


  // 날짜 포맷팅 (몇월 몇일 무슨요일 형식)
  function formatDate(dateStr) {
    const date = new Date(dateStr);
    const options = { month: 'long', day: 'numeric', weekday: 'long' };
    return date.toLocaleDateString('ko-KR', options);
  }

  function applyRangeStyles(startDate, endDate) {
    resetStyles(); // 기존 스타일 초기화

    let currentDate = new Date(startDate);

    while (currentDate <= endDate) {
      const dateStr = currentDate.toISOString().split('T')[0]; // YYYY-MM-DD 형식으로 변환
      const dayCell = document.querySelector(`[data-date="${dateStr}"]`); // 해당 날짜 셀 선택

      if (dayCell) {
        dayCell.style.backgroundColor = '#ffddc1'; // 원하는 배경색 적용
        dayCell.style.color = '#000'; // 글자 색상 설정 (선택 사항)
      }

      currentDate.setDate(currentDate.getDate() + 1); // 다음 날짜로 이동
    }
  }

  // 스타일 초기화
  function resetStyles() {
    // 모든 날짜 셀의 스타일 초기화
    document.querySelectorAll('[data-date]').forEach(day => {
      day.style.backgroundColor = ''; // 배경색 초기화
      day.style.color = ''; // 글자 색상 초기화 (선택 사항)
    });
  }


  // 날짜 범위 스타일 적용
  function applyRangeStyles(startDate, endDate) {
    resetStyles();

    let currentDate = new Date(startDate);

    while (currentDate <= endDate) {
      const dateStr = currentDate.toISOString().split('T')[0];
      const dayCell = document.querySelector(`[data-date="${dateStr}"]`); // 셀 요소 가져오기

      if (dayCell) {
        dayCell.classList.add('fc-day-in-range'); // 범위 스타일 추가
      }

      currentDate.setDate(currentDate.getDate() + 1);
    }

  }
  function confirmDates() {
    if (!checkinDate || !checkoutDate) {
      alert("입실일과 퇴실일을 모두 선택하세요.");
      return;
    }

    // 선택된 날짜를 서버로 전송


    // 캘린더 숨기기
    document.getElementById("calendar-container").style.display = "none";
  }
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
    <!-- 객실 리스트 -->

    <div class="room-list">
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
      <c:set var="markerImage" value="/img/lod_map_marker.png" />
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

    <h3>시설/서비스</h3>
    <c:if test="${not empty facilityList}">
      <c:forEach var="facility" items="${facilityList}">
        <div class="facility-item">
          <p>* ${facility.lod_facility_name}</p> <!-- 시설명 -->
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
  </div>



  <!-- 인원수 선택 드롭다운 -->
  <div id="counter-dropdown" class="counter-dropdown hidden">
    <%@ include file="/WEB-INF/views/counter.jsp" %>
  </div>


  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
