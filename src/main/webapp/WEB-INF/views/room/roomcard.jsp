<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/css/roomcard.css"/>
  <link rel="stylesheet" href="/css/button.css"/>
  <script>
    // 최근 본 숙소 목록에 추가하는 함수
    function saveToRecent(roomIdx, roomName, roomImgUrl, roomPrice) {
      const recentRooms = JSON.parse(localStorage.getItem('recentRooms') || '[]');
      const updatedRooms = recentRooms.filter(room => room.roomIdx !== roomIdx);
      updatedRooms.unshift({ roomIdx, roomName, roomImgUrl, roomPrice });
      if (updatedRooms.length > 5) {
        updatedRooms.pop();
      }
      localStorage.setItem('recentRooms', JSON.stringify(updatedRooms));
    }
  </script>
</head>
<body>
  <!-- 객실 카드 -->
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
          <div class="guest-pet-count">사람수: ${room.max_people_cnt} | 반려동물수: ${room.max_pet_cnt}</div>
        </div>
        <a href="/room/detail?room_idx=${room.room_idx}" class="details-link"
           onclick="saveToRecent('${room.room_idx}', '${room.room_name}', '${room.room_img_url}', '${room.room_price}')">
          상세보기 &gt;
        </a>
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
