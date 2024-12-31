<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>최근 본 숙소</title>
  <style>
    .room-card {
      display: flex;
      margin: 20px 0;
      border: 1px solid #ddd;
      padding: 10px;
      border-radius: 5px;
    }
    .room-img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      margin-right: 20px;
    }
    .room-info {
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .room-name {
      font-size: 1.2em;
      font-weight: bold;
    }
    .room-price {
      color: #e74c3c;
    }
  </style>
</head>
<body>

<h1>최근 본 숙소</h1>

<div id="recent-rooms-container">
</div>

<script>
  window.onload = function() {
    // 로컬 스토리지에서 최근 본 숙소 목록 가져오기
    const recentRooms = JSON.parse(localStorage.getItem('recentRooms') || '[]');

    // 최근 본 숙소 목록을 담을 컨테이너
    const recentContainer = document.getElementById('recent-rooms-container');

    // 최근 본 숙소 목록이 있을 경우
    if (recentRooms.length > 0) {
      // 각 숙소 정보를 반복하면서 화면에 표시
      recentRooms.forEach(room => {
        console.log(room);  // room 객체를 확인
        const roomElement = document.createElement('div');
        roomElement.classList.add('room-card');
console.log(room);
        roomElement.innerHTML = `
    <a href="/room/detail?room_idx=${room.roomIdx}" class="room-image-link">
      <img src="${room.roomImgUrl}" alt="${room.roomName}" class="room-img">
    </a>
    <div class="room-info">
      <h3 class="room-name">${room.roomName}</h3>
      <p class="room-price">${room.roomPrice}원</p>
    </div>
  `;

        recentContainer.appendChild(roomElement);
      });
    } else {
      // 최근 본 숙소가 없으면 안내 메시지 표시
      recentContainer.innerHTML = '<p>최근 본 숙소가 없습니다.</p>';
    }
  };
</script>

</body>
</html>