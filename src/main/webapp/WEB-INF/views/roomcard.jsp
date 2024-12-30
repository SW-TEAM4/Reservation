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
      <a href="/room/detail?room_idx=${room.room_idx}" class="details-link"
         onclick="saveToRecent('${room.room_idx}', '${room.room_name}', '${room.room_img_url}', '${room.room_price}')">
        상세보기 &gt;
      </a>

      <script>
        // 최근 본 숙소 목록에 추가하는 함수
        function saveToRecent(roomIdx, roomName, roomImgUrl, roomPrice) {
          // localStorage에서 기존 최근 본 숙소 목록 가져오기
          const recentRooms = JSON.parse(localStorage.getItem('recentRooms') || '[]');

          // 중복을 방지하기 위해 현재 선택한 객실이 이미 목록에 있으면 제거
          const updatedRooms = recentRooms.filter(room => room.roomIdx !== roomIdx);

          // 새로운 객실을 목록 맨 앞에 추가
          updatedRooms.unshift({ roomIdx, roomName, roomImgUrl, roomPrice });

          // 최근 본 숙소는 최대 5개까지만 저장
          if (updatedRooms.length > 5) {
            updatedRooms.pop(); // 가장 오래된 항목 제거
          }

          // 로컬 스토리지에 저장
          localStorage.setItem('recentRooms', JSON.stringify(updatedRooms));
        }
      </script>

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


