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
    <link rel="stylesheet" href="/css/sellerSiderbar.css">                                                                 <!-- 사이드바 CSS       -->
    <link rel="stylesheet" href="/css/sellerDetailMain.css">                                                               <!-- 상세페이지 CSS     -->
    <link rel="stylesheet" href="/css/sellerHeader.css">                                                                   <!-- 헤더 CSS          -->
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Noto+Sans&display=swap" rel="stylesheet">    <!-- 폰트              -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css">                    <!-- 풀캘린더 CSS       -->


</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %> <!-- 상단 헤더 포함 -->

<div class="main-container">
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %> <!-- 사이드바 포함 -->

    <!-- 오른쪽 메인 콘텐츠 -->
    <div class="content">
        <%--[check] 캘린더 기능 추가 할 거 넣어야 할지--%>
        <h1>객실 상세 관리</h1>
        <p>예약 일정을 확인하고 관리하세요.</p>
        <div id="calendar" class="calendar-container"></div>
    </div>
</div>
</body>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: [
                {
                    title: '예약 - 객실 A',
                    start: '2024-12-25',
                    end: '2024-12-27',
                    color: '#ff9f89'
                },
                {
                    title: '예약 - 객실 B',
                    start: '2024-12-31',
                    color: '#87CEEB'
                }
            ],
            editable: true,
            selectable: true,
            select: function (info) {
                const title = prompt('새 일정 제목:');
                if (title) {
                    calendar.addEvent({
                        title: title,
                        start: info.startStr,
                        end: info.endStr,
                        allDay: info.allDay
                    });
                    alert('새 일정이 추가되었습니다.');
                }
                calendar.unselect();
            },
            eventClick: function (info) {
                if (confirm(`"${info.event.title}" 일정을 삭제하시겠습니까?`)) {
                    info.event.remove();
                    alert('일정이 삭제되었습니다.');
                }
            }
        });

        calendar.render();
    });
</script>
</body>
</html>
