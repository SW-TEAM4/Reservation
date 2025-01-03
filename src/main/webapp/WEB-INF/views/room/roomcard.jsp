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
      const recentRooms = JSON.parse(localStorage.getItem('recentRooms') || '[]');

      // 중복 제거
      const updatedRooms = recentRooms.filter(room => room.roomIdx !== roomIdx);

      // 새 데이터 추가
      updatedRooms.unshift({ roomIdx, roomName, roomImgUrl, roomPrice });

      // 최대 5개까지만 저장
      if (updatedRooms.length > 5) {
        updatedRooms.pop();
      }

      // 로컬 스토리지에 저장
      localStorage.setItem('recentRooms', JSON.stringify(updatedRooms));
    }


  </script>
</head>
<body>
  <!-- 객실 카드 -->
  <div class="room-card">
    <!-- 객실 이미지 -->
      <div class="room-img-container">
        <div class="swiper swiper-visual">
          <div class="swiper-wrapper">
            <!-- room.room_img_urls 리스트를 반복 -->
            <c:forEach var="img_url" items="${room.room_img_urls[0]}">
              <div class="swiper-slide">
                <img src="${img_url}" alt="Room Image"/>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>
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
        <a href="/room/detail?room_idx=${room.room_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}"
           class="details-link"
           onclick="saveToRecent('${room.room_idx}', '${room.room_name}', '${room.room_img_urls[0]}', '${room.room_price}')">
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
