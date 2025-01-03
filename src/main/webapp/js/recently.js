window.onload = function () {
    const recentlyRooms = JSON.parse(localStorage.getItem('recentlyRooms') || '[]');
    const recentlyContainer = document.getElementById('recently-rooms-container');

    if (recentlyRooms.length > 0) {
        recentlyRooms.forEach(room => {
            if (!room || !room.roomIdx || !room.roomName || !room.roomImgUrl || !room.roomPrice) return;

            const roomElement = document.createElement('div');
            roomElement.classList.add('room-card'); // roomcard.jsp의 스타일을 재사용

            // HTML 구조 생성
            roomElement.innerHTML = `
        <a href="/room/detail?room_idx=${escapeHtml(room.roomIdx)}" class="room-image-link">
          <img src="${escapeHtml(room.roomImgUrl)}" alt="${escapeHtml(room.roomName)}" class="room-img">
        </a>
        <div class="room-info">
          <div class="room-header">
            <h3 class="room-name">${escapeHtml(room.roomName)}</h3>
            <p class="room-price">${escapeHtml(room.roomPrice)}원</p>
          </div>
          <button class="booking-button" onclick="location.href='/reserve/reservation.do?room_idx=${escapeHtml(room.roomIdx)}'">
            예약하기
          </button>
        </div>
      `;

            recentlyContainer.appendChild(roomElement);
        });
    } else {
        // 최근 본 숙소가 없으면 안내 메시지 표시
        recentlyContainer.innerHTML = '<p class="no-recently-rooms">최근 본 숙소가 없습니다.</p>';
    }
};

// XSS 방지를 위한 HTML 이스케이프 함수
function escapeHtml(unsafe) {
    return unsafe
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}