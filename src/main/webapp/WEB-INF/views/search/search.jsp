<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>구경하개</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <script src="/js/search.js"></script>
</head>
<body>
<div class="wrap">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="container">
        <div class="search_txt">
            <div class="txt_main">
                <img src="/img/search_txt_main.svg">
            </div>
            <div class="txt_sub">
                <img src="/img/search_txt_sub.svg">
            </div>
        </div>
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

            <!-- 타입 선택 -->
            <div class="type-container">
                <!-- 필터 버튼 -->
                <button id="type-button" class="type-selector">
                    <span class="type-label">전체</span>
                    <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>
                </button>

                <!-- 팝업: 타입 선택 -->
                <div id="type-popup" class="type-popup hidden">
                    <ul class="type-list">
                        <li class="type-item" data-value="전체" value="0">전체</li>
                        <li class="type-item" data-value="펜션" value="1">펜션</li>
                        <li class="type-item" data-value="글램핑" value="2">글램핑</li>
                    </ul>
                </div>
            </div>

            <!-- 반려동물 몸무게  선택 -->
            <div class="weight-container">
                <!-- 필터 버튼 -->
                <button id="weight-button" class="weight-selector">
                    <span class="weight-label">5kg 미만</span>
                    <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>
                </button>

                <!-- 팝업: 몸무게 선택 -->
                <div id="weight-popup" class="weight-popup hidden">
                    <ul class="weight-list">
                        <li class="weight-item" data-value="5kg 미만" value=0>5kg 미만</li>
                        <li class="weight-item" data-value="5kg 이상 ~ 10kg 이하" value=1>5kg 이상 ~ 10kg 이하</li>
                        <li class="weight-item" data-value="10kg 초과" value=2>10kg 초과</li>
                    </ul>
                </div>
            </div>

        </div>

        <div class="tab-container">
            <div class="tab active" id="tab-all">전체</div>
            <div class="tab inactive" id="tab-gangwondo">강원도</div>
            <div class="tab inactive" id="tab-gyeonggi">경기</div>
            <div class="tab inactive" id="tab-incheon">인천</div>
        </div>

        <div class="product-info">
            <div class="product-count">144</div>
            <div class="product-text">개의 상품</div>
        </div>
        <div style="width: 1200px; height: 1px; background-color: #DBD6D6;"></div>

        <div class="result-container" id="result-container">
            <img src="/img/search_img_no_search.svg" style="width: 384px; height: 339px;" alt="default_img"/>
<%--            <c:choose>--%>
<%--                <c:when test="${empty lodgments}">--%>
<%--                    <img src="/img/search_img_no_search.svg" style="width: 384px; height: 339px;" alt="default_img"/>--%>
<%--                </c:when>--%>
<%--                <c:otherwise>--%>
<%--                    <c:forEach var="lodgment" items="${lodgments}">--%>
<%--                        <div class="result-item">--%>
<%--                            <img src="${lodgment.lod_img_url}" alt="${lodgment.lod_name}" class="result-img" width="200px" height="200px">--%>
<%--                            <h3>${lodgment.lod_name}</h3>--%>
<%--                            <p>${lodgment.lod_address}</p>--%>
<%--                            <p>평점: ${lodgment.avg_rating}</p>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </c:otherwise>--%>
<%--            </c:choose>--%>
        </div>

        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    </div>

    <%--달력 fullcalendar--%>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
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