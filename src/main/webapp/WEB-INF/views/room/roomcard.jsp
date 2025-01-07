<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <link rel="stylesheet" href="/css/roomcard.css"/>
  <link rel="stylesheet" href="/css/bookingbutton.css"/>
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
  <script src="/js/home.js"></script>

  <script>

    function saveToRecent(roomIdx, roomName, roomImgUrl, roomPrice) {
      // 기존 데이터 가져오기
      const recentlyRooms = JSON.parse(localStorage.getItem('recentlyRooms') || '[]');

      // 중복 제거
      const updatedRooms = recentlyRooms.filter(room => room.roomIdx !== roomIdx);

      // 새 데이터 추가
      updatedRooms.unshift({ roomIdx, roomName, roomImgUrl, roomPrice });

      // 최대 5개까지만 저장
      if (updatedRooms.length > 5) {
        updatedRooms.pop();
      }

      // 로컬 스토리지에 저장
      localStorage.setItem('recentlyRooms', JSON.stringify(updatedRooms));
    }


  </script>
</head>
<body>
  <!-- 객실 카드 -->
  <div class="room-card">
    <!-- 객실 이미지 -->
    <div class="room-img-container">
      <img src="${room.room_img_urls[0]}" alt="Room Image"/>
    </div>
    <!-- 객실 정보 -->
    <div class="room-info">
      <!-- 상단 영역 -->
      <div class="room-header">
        <div>
          <div class="room-name" style="margin-bottom: 5px;">숙박</div>
          <div class="check-in-out">체크인 15:00 - 체크아웃 11:00</div>
        </div>
        <a href="/room/detail?room_idx=${room.room_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}"
           class="details-link"
           onclick="saveToRecent('${room.room_idx}', '${room.room_name}', '${room.room_img_urls[0]}', '${room.room_price}')">
          상세보기
        </a>
      </div>
      <!-- 하단 영역 -->
      <div class="room-footer">
        <p class="room-price">${room.room_price}원</p>
        <!-- 예약 버튼 -->
        <button class="booking-button" onclick="location.href='/reserve/reservation.do?room_idx=${room.room_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&res_people_cnt=${guestCount}&res_pets_cnt=${petCount}'">
          <img src="../img/button_foot.svg" alt="icon" class="button-icon">
          <span class="button-text">예약하기</span>
        </button>
      </div>
    </div>
  </div>
  <h3 class="room-name" style="margin-left: 5px;">${room.room_name}</h3>
  <p class="checkin-people" style="margin-left: 5px;">
    <img src="/img/ResDetail_user_img.svg" alt="아이콘" style="width: 16px !important; height: 16px !important; vertical-align: -1.0627px"> 성인 ${room.max_people_cnt}명 /
    반려동물: ${room.max_pet_cnt}마리
  </p>
  <div style="width: 1280px; height: 1px; background-color: #cccccc; margin: 30px auto;"></div>
</body>
</html>
