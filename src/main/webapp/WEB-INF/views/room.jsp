<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>같이가개</title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" href="/css/style.css"/>
    <script src="/js/home.js"></script>
</head>
<body>
<div class="wrap">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:if test="${not empty room}">
    <div class="room-detail">
        <h2>${room.room_name}</h2>
        <img src="${room.room_img_url}" alt="${room.room_name}" class="detail-img">

        <div class="detail-info">
            <p><strong>숙소 이름:</strong> ${room.room_name}</p>
            <p><strong>가격:</strong> ${room.room_price}원</p>
            <p><strong>최대 인원:</strong> ${room.max_people_cnt}명</p>
            <p><strong>최대 반려동물 수:</strong> ${room.max_pet_cnt}마리</p>
            <p>${room.room_notice}</p>
        </div>

        <button onclick="location.href='/reservation?room_idx=${room.room_idx}'">예약하기</button>
    </div>

</c:if>
<c:if test="${empty room}">
    <p>예약 가능한 방이 없습니다.</p>
</c:if>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>