<%--
  파일명 : roomRegister.jsp
  생성자 : JDeok
  날 짜  : 2024.12.24
  시 간  : 오전 10:01
  기 능  : 사장님 상세 페이지
  변경사항
     - 2024.12.24 : JDeok(최초작성)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>성수기 일정관리</title>
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link rel="stylesheet" href="/css/sellerSiderbar.css">
    <link rel="stylesheet" href="/css/sellerPeakPrice.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">

    <!-- Date Range Picker -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<div class="layout">
    <%-- 왼쪽 사이드바 포함 --%>
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %>

    <!-- 오른쪽 콘텐츠 -->
    <main class="content">
        <h1>성수기 일정관리</h1>
        <div class="important-info">
            <h2>📢 성수기/극성수기 가격 책정에 대한 정보</h2>
            <ul>
                <li><b>성수기: </b> 비수기 가격기준 평일 20%, 금/토 35% 인상</li>
                <li><b>극성수기:</b> 비수기 가격기준 평일 40%, 금/토 55% 인상</li>
            </ul>
        </div>

        <form action="/lodgment/savePeakPrice.do" method="post">
            <table class="table">
                <thead>
                <tr>
                    <th>요금 타입</th>
                    <th>기간</th>
                </tr>
                </thead>
                <tbody>
                <!-- 성수기 -->
                <tr>
                    <td>성수기</td>
                    <td>
                        <input type="text" id="peakStartDate" name="peak_str_dt" class="input-field date-input"
                               placeholder="시작일" value="${dto.peak_str_dt != null ? dto.peak_str_dt : ''}" readonly>
                        ~
                        <input type="text" id="peakEndDate" name="peak_end_dt" class="input-field date-input"
                               placeholder="종료일" value="${dto.peak_end_dt != null ? dto.peak_end_dt : ''}" readonly>
                        <button type="button" class="calendar-btn" onclick="openDateRangePicker('#peakStartDate', '#peakEndDate')">📅</button>
                    </td>
                </tr>
                <tr>
                    <td>극성수기</td>
                    <td>
                        <input type="text" id="highPeakStartDate" name="hpeak_str_dt" class="input-field date-input"
                               placeholder="시작일" value="${dto.hpeak_str_dt != null ? dto.hpeak_str_dt : ''}" readonly>
                        ~
                        <input type="text" id="highPeakEndDate" name="hpeak_end_dt" class="input-field date-input"
                               placeholder="종료일" value="${dto.hpeak_end_dt != null ? dto.hpeak_end_dt : ''}" readonly>
                        <button type="button" class="calendar-btn" onclick="openDateRangePicker('#highPeakStartDate', '#highPeakEndDate')">📅</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="actions">
                <button type="submit" class="btn submit">요금 저장</button>
            </div>
        </form>

        <!-- FullCalendar Modal -->
        <div id="calendarModal" style="display:none;">
            <div id="calendar"></div>
            <div class="calendar-actions">
                <button type="button" class="btn" onclick="closeCalendar()">닫기</button>
            </div>
        </div>
    </main>
</div>
<script>
    // Date Range Picker를 열어 필드를 채우는 함수
    function openDateRangePicker(startField, endField) {
        $(startField).daterangepicker({
            locale: {
                format: 'YYYY-MM-DD', // 날짜 형식
                applyLabel: '적용',
                cancelLabel: '취소',
                daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                firstDay: 1 // 월요일 시작
            },
            autoUpdateInput: false, // 필드에 초기값 자동 입력 비활성화
            opens: 'right', // 달력 위치
            singleDatePicker: false // 범위 선택
        }, function(start, end) {
            // 이곳은 기본 콜백이며, 여기서 아무 동작도 수행하지 않음
        });

        // Apply 이벤트 커스터마이징
        $(startField).on('apply.daterangepicker', function(ev, picker) {
            // 시작일 필드에 시작일만 설정
            $(startField).val(picker.startDate.format('YYYY-MM-DD'));
            // 종료일 필드에 종료일만 설정
            $(endField).val(picker.endDate.format('YYYY-MM-DD'));
        });

        // Cancel 이벤트 처리: 입력 필드 초기화
        $(startField).on('cancel.daterangepicker', function(ev, picker) {
            $(startField).val('');
            $(endField).val('');
        });

        // 달력 열기
        $(startField).data('daterangepicker').show();
    }



    // 삭제 버튼 기능
    $(document).on('click', '.delete-btn', function () {
        $(this).closest('tr').remove();
    });
</script>

</body>
</html>




