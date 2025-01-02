<%--
  파일명 : sellerDetailMain.jsp
  생성자 : JDeok
  날 짜  : 2024.12.24
  시 간  : 오후 04:00
  기 능  : 사장님 상세 메인 페이지
  변경사항
     - 2024.12.24 : JDeok(최초작성)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실 상세 관리</title>
    <link rel="stylesheet" href="/css/sellerSiderbar.css">
    <link rel="stylesheet" href="/css/sellerDetailMain.css">
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Noto+Sans&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css">
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<div class="main-container">
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %>

    <!-- 오른쪽 메인 콘텐츠 -->
    <div class="content">
        <h1>객실 상세 관리</h1>
        <p>예약 일정을 확인하고 관리하세요.</p>
        <div id="calendar" class="calendar-container"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');

        // AJAX를 통해 서버에서 이벤트 데이터 가져오기
        fetch('/lodgment/getPeakPriceEvents.do')
            .then(response => response.json())
            .then(data => {
                const calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    locale: 'ko',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay'
                    },
                    events: data, // 서버에서 받아온 이벤트 데이터
                    editable: false, // 드래그 등 편집 불가
                    selectable: false // 달력 클릭 비활성화
                });

                calendar.render();
            })
            .catch(error => console.error('Error fetching events:', error));
    });
</script>
</body>
</html>

