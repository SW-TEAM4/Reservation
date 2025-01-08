<%--
  파일명 : sellerShowReservation.jsp
  생성자 : JDeok
  날짜 : 2025.01.03
  기능 : 예약현황 조회
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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



