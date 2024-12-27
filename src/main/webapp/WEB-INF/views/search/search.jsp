<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
            <div class="search-button" id="date-picker">
            <span>
              <img src="/img/search_icon_calendar.svg" class="calendar_icon" alt="calendar"/>
              12.12 ~ 12.13, 1박
            </span>
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
                        <button id="minus-guest-btn" class="counter-btn">−</button>
                        <span id="guest-counter">2</span>
                        <button id="plus-guest-btn" class="counter-btn">+</button>
                    </div>

                    <!-- 반려동물 조절 -->
                    <div class="counter">
                        <div class="popup-header">반려동물</div>
                        <button id="minus-pet-btn" class="counter-btn">−</button>
                        <span id="pet-counter">1</span>
                        <button id="plus-pet-btn" class="counter-btn">+</button>
                    </div>

                    <p class="popup-subtitle">유아 및 아동도 인원수에 포함해주세요.</p>
                    <button id="apply-btn" class="apply-btn">완료</button>
                </div>
            </div>

            <%--            <!-- 최대 인원수 -->--%>
            <%--            <form class="search-button" id="max-form" action="/maxcnt.do" method="get" onclick="submit()">--%>
            <%--                <span>성인 ${adultCount}, 반려동물 ${childCount}</span>--%>
            <%--                <input type="hidden" name="adultCount" value="${adultCount}"/>--%>
            <%--                <input type="hidden" name="childCount" value="${childCount}"/>--%>
            <%--                <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>--%>
            <%--            </form>--%>

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
                        <li class="type-item" data-value="전체">전체</li>
                        <li class="type-item" data-value="펜션">펜션</li>
                        <li class="type-item" data-value="글램핑">글램핑</li>
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
                        <li class="weight-item" data-value="5kg 미만">5kg 미만</li>
                        <li class="weight-item" data-value="5kg 이상 ~ 10kg 이하">5kg 이상 ~ 10kg 이하</li>
                        <li class="weight-item" data-value="10kg 초과">10kg 초과</li>
                    </ul>
                </div>
            </div>

        </div>
        <div class="tab-container">
            <a href="#" class="tab active" id="tab-all">전체</a>
            <a href="#" class="tab inactive" id="tab-seoul">서울</a>
            <a href="#" class="tab inactive" id="tab-gyeonggi">경기</a>
            <a href="#" class="tab inactive" id="tab-incheon">인천</a>
        </div>
        <div class="product-info">
            <div class="product-count">144</div>
            <div class="product-text">개의 상품</div>
        </div>
        <div style="width: 1200px; height: 1px; background-color: #DBD6D6;"></div>

        <div class="result-container">
            <img src="/img/search_img_no_search.svg" style="width: 384px; height: 339px;" alt="default_img"/>
        </div>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
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

</div>
</body>
</html>