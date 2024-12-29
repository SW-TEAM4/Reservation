<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/css/roomcard.css"/>
  <link rel="stylesheet" href="/css/button.css"/>
  <style>
    /* 전체 카드 스타일 */
    .room-card {
      display: flex;
      border: 1px solid #ddd;
      border-radius: 8px;
      overflow: hidden;
      margin-top: 20px;
      margin-bottom: 20px;
      font-family: Arial, sans-serif;
    }

    /* 왼쪽 이미지 섹션 */
    .room-image-link {
      width: 510px;
      height: 319px;
      display: block;
    }

    .room-img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    /* 오른쪽 정보 섹션 */
    .room-info {
      width: 754px;
      height: 319px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 20px;
      background-color: #fff;
    }

    /* 상단 정보 */
    .room-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
    }

    .room-name {
      font-size: 20px;
      font-weight: bold;
      margin: 0;
    }

    .check-in-out {
      font-size: 14px;
      color: #555;
      margin-top: 5px;
    }

    .details-link {
      font-size: 14px;
      color: #007BFF;
      text-decoration: none;
    }

    /* 하단 정보 */
    .room-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .room-price {
      font-size: 18px;
      font-weight: bold;
    }

  </style>
</head>
<body>
<div class="room-card">

  <!-- 객실 이미지 -->
  <a href="/room/detail?room_idx=${room.room_idx}" class="room-image-link">
    <img src="${room.room_img_url}" alt="${room.room_name}" class="room-img">
  </a>

  <!-- 객실 정보 -->
  <div class="room-info">

    <!-- 상단 영역 -->
    <div class="room-header">
      <div>
        <h3 class="room-name">${room.room_name}</h3>
        <div class="check-in-out">체크인 15:00 - 체크아웃 11:00</div>
      </div>
      <a href="/room/detail?room_idx=${room.room_idx}" class="details-link">상세보기 &gt;</a>
    </div>

    <!-- 하단 영역 -->
    <div class="room-footer">
      <p class="room-price">${room.room_price}원</p>
      <!-- 예약 버튼 -->
      <button class="booking-button" onclick="location.href='/reserve/reservation.do?room_idx=${room.room_idx}'">
        예약하기
      </button>
    </div>
  </div>

</div>
<img src="<c:url value='/img/lod_divide_line.svg'/>" alt="구분선" width="800px">
</body>
</html>


