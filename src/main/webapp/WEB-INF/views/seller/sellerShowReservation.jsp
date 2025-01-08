<%--
  파일명 : sellerShowReservation.jsp
  생성자 : JDeok
  날짜 : 2025.01.03
  기능 : 예약현황 조회
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 현황 조회</title>
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link rel="stylesheet" href="/css/sellerSiderbar.css">
    <link rel="stylesheet" href="/css/sellerShowReservation.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">
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
        <h1>예약 현황 조회</h1>

        <%-- 필터링 폼 --%>
        <form id="filterForm" class="filter-form">
            <label for="dateRange">기간 선택:</label>
            <input type="text" id="dateRange" name="dateRange" placeholder="날짜 선택">
        </form>

        <%-- 예약 리스트 영역 --%>
        <div id="reservationList" class="reservation-list">
            <%-- 서버에서 렌더링된 데이터가 없을 때 기본 틀 유지 --%>
            <c:choose>
                <c:when test="${reservations == null || reservations.isEmpty()}">
                    <div class="no-reservation">
                        <p>예약이 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="res" items="${reservations}">
                        <div class="reservation-item">
                            <div class="reservation-header">
                                <span>예약 일자: ${res.created}</span>
                            </div>
                            <div class="reservation-content">
                                <h3>${res.res_name}</h3>
                                <p><span>객실:</span> ${res.room_name}</p>
                                <p><span>기간:</span> ${res.res_str_date} ~ ${res.res_end_date}</p>
                                <p><span>결제 금액:</span>
                                    <fmt:formatNumber value="${res.paid_money}" type="number" pattern="#,###"/>원
                                </p>
                                <p><span>예약 인원:</span> ${res.res_people_cnt}명</p>
                                <p><span>동반 마릿수:</span> ${res.res_pets_cnt}마리</p>
                                <p><span>요청 사항:</span> ${res.request}</p>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<script>
    $(document).ready(function () {
        // Date Range Picker 설정
        $('#dateRange').daterangepicker({
            locale: {
                format: 'YYYY-MM-DD',
                daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                firstDay: 0
            },
            autoApply: true,
            autoUpdateInput: false
        }, function (start, end) {
            const dateRange = start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD');
            $('#dateRange').val(dateRange); // 선택된 기간을 필드에 표시
            $.ajax({
                url: '/lodgment/sellerGetReservation',
                method: 'GET',
                data: {
                        dateRange: dateRange
                      , ajax: true
                       },
                success: function (data) {
                    $('#reservationList').html(data);
                },
                error: function () {
                    alert('데이터를 가져오는 데 실패했습니다.');
                }
            });
        });
    });
</script>
</body>
</html>


