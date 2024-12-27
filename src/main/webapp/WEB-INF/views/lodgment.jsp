<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>숙소 상세</title>
  <link rel="stylesheet" href="/css/style.css"/>
  <link rel="stylesheet" href="/css/style.css?after"/>

  <style>
    .wrap {
      margin: 0 auto;
      width: 80%; /* 가운데 정렬 */
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

    #selected-dates {
      color: blueviolet; /* 텍스트 색상 */
      font-size: 16px; /* 텍스트 크기 */
    }

  </style>
</head>
<body>
<div class="wrap">

  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <!-- 숙소 정보 -->
  <div class="lodgment-container">
    <c:if test="${not empty lodgment.lodgment}">
      <img src="${lodgment.lodgment.lod_img_url}" alt="${lodgment.lodgment.lod_name}">
      <p>숙소 이름: ${lodgment.lodgment.lod_name}</p>
      <p>평균 평점: ${lodgment.lodgment.avg_rating}</p>
    </c:if>
    <c:if test="${empty lodgment.lodgment}">
      <p>숙소 정보를 찾을 수 없습니다.</p>
    </c:if>
  </div>

  <!-- 날짜 및 인원수 선택 -->
  <div class="selection-container">
    <!-- 날짜 선택 -->
    <div class="selection-item" onclick="toggleCalendar()">
      <span id="checkin-date"></span>
      <span id="checkout-date"> ~ </span>
      <img src="<c:url value='/img/search_icon_calendar.svg'/>" alt="달력 아이콘">
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
          console.log("selectedDate:", selectedDate);
          if (!checkinDate || (checkinDate && checkoutDate)) {
            checkinDate = info.startStr;
            checkinDateEl.textContent = formatDate(selectedDate);
            checkoutDate = null;
            checkoutDateEl.textContent = '';
            console.log("if1: checkin:", checkinDate);
            console.log("if1: checkout:", checkoutDate);

            resetStyles();
          } else if (checkinDate && !checkoutDate) {
            const startDate = new Date(checkinDate);
            console.log("if2: startdate:", startDate);

            if (selectedDate <= startDate) {
              alert('퇴실일은 입실일 이후 날짜여야 합니다.');
            } else {
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
    function updateDatesOnServer(checkin, checkout) {
      const xhr = new XMLHttpRequest();
      xhr.open('POST', '/updateDates', true); // 서버의 API 엔드포인트 설정
      xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

      xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
          if (xhr.status === 200) {
            // 서버로부터 받은 결과를 화면에 반영
            const response = JSON.parse(xhr.responseText);
            document.getElementById('checkin-date').textContent = response.checkin;
            document.getElementById('checkout-date').textContent = response.checkout;

          } else {
            console.error('서버 통신 오류:', xhr.responseText);
          }
        }
      };


      const data = {
        checkin: checkin,
        checkout: checkout,
      };

      xhr.send(JSON.stringify(data));
    }

    // 날짜 포맷팅 (몇월 몇일 무슨요일 형식)
    function formatDate(dateStr) {
      const date = new Date(dateStr);
      const options = { month: 'long', day: 'numeric', weekday: 'long' };
      return date.toLocaleDateString('ko-KR', options);
    }

    function applyDates(startDate, endDate) {
      if (startDate && endDate) {
        const formattedStart = formatDate(startDate);
        const formattedEnd = formatDate(endDate);

        // DOM 업데이트
        const selectedDatesEl = document.getElementById('selected-dates');
        if (selectedDatesEl) {
          selectedDatesEl.innerText = `${formattedStart} ~ ${formattedEnd}`; // 텍스트 템플릿 리터럴로 수정
        } else {
          console.error("Element with ID 'selected-dates' not found.");
        }
      } else {
        console.log("날짜 선택 실패: 시작일 또는 종료일 없음");
      }
    }

    // 스타일 초기화
    function resetStyles() {
      document.querySelectorAll('.fc-day-in-range').forEach(day => day.classList.remove('fc-day-in-range'));
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
      updateDatesOnServer(checkinDate, checkoutDate);

      // 캘린더 숨기기
      document.getElementById("calendar-container").style.display = "none";
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
