window.onload = function () {
    const recentlyRooms = JSON.parse(localStorage.getItem('recentlyRooms') || '[]');
    const recentlyContainer = document.getElementById('recently-rooms-container');

    if (recentlyRooms.length > 0) {
        recentlyRooms.forEach(room => {
            if (!room || !room.roomIdx || !room.roomName || !room.roomImgUrl || !room.roomPrice || !room.checkinDate || !room.checkoutDate || !room.guestCount || !room.petCount) return;

            const roomElement = document.createElement('div');
            roomElement.classList.add('room-card');

            // HTML 구조 생성
            roomElement.innerHTML = `
        <a href="/room/detail?room_idx=${room.roomIdx}" class="room-image-link">
          <img src="${room.roomImgUrl}" alt="${room.roomName}" class="room-img">
        </a>
        <div class="room-info">
          <h3 class="room-name">${room.roomName}</h3>
          <div class="room-footer">
            <div class="check-in-out">
              체크인: ${room.checkinDate} / 체크아웃: ${room.checkoutDate}
            </div>
            <button class="booking-button" onclick="location.href='/room/detail?room_idx=${room.roomIdx}&checkinDate=${room.checkinDate}&checkoutDate=${room.checkoutDate}&guestCount=${room.guestCount}&petCount=${room.petCount}'">
              객실 보기
            </button>
          </div>
        </div>
      `;

            recentlyContainer.appendChild(roomElement);
        });
    }else {
        // 최근 본 숙소가 없으면 안내 이미지로 표시
        recentlyContainer.innerHTML = `
        <div class="no-recently-rooms-container">
            <img src="/img/recently_no_result.svg" alt="최근 본 숙소 없음" class="no-recently-rooms-image">
        </div>
    `;
    }
};
