<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/css/roomcard.css"/>
</head>
<body>
<div class="room-card">
  <!-- 객실 이미지 -->
  <a href="/room/detail?room_idx=${room.room_idx}" class="room-image-link">
    <img src="${room.room_img_url}" alt="${room.room_name}" class="room-img">
  </a>

  <!-- 객실 정보 -->
  <div class="room-info">
    <h3 class="room-name">${room.room_name}</h3>
    <div class="room-capacity">성인 ${room.max_people_cnt}명 / 반려동물 ${room.max_pet_cnt}마리</div>
    <div class="check-in-out">체크인: 15:00 / 체크아웃: 11:00</div>
    <div class="room-price">${room.room_price}원</div>

    <!-- 예약 버튼 -->
    <button class="booking-button" onclick="location.href='/reserve/reservation.do?room_idx=${room.room_idx}'">
      예약하기
    </button>
  </div>
</div>
</body>
</html>
