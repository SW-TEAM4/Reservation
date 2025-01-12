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
                  <!-- 상단 영역: 숙소 이름과 삭제 버튼 -->
                  <div class="room-header" style="display: flex; justify-content: space-between; align-items: center;">
                    <h3 class="room-name">${room.roomName}</h3>
                    <button class="delete-room-button" data-room-idx="${room.roomIdx}" style="background: none; border: none; font-size: 30px; cursor: pointer;">×</button>
                  </div>
                  <!-- 하단 영역 -->
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
    } else {
        // 최근 본 숙소가 없으면 안내 이미지로 표시
        recentlyContainer.innerHTML = `
            <div class="no-recently-rooms-container">
                <img src="/img/room_recently_no_result.svg" alt="최근 본 숙소 없음" class="no-recently-rooms-image">
            </div>
        `;
    }

    // === 삭제 버튼 클릭 이벤트 처리 ===
    document.addEventListener('click', function (event) {
        if (event.target.classList.contains('delete-room-button')) {
            const roomIdx = event.target.getAttribute('data-room-idx');
            deleteRoomFromLocalStorage(roomIdx); // 로컬 스토리지에서 데이터 삭제
            removeRoomFromDOM(event.target.closest('.room-card')); // DOM에서 카드 제거
        }
    });

    // === 로컬 스토리지에서 데이터 삭제 ===
    function deleteRoomFromLocalStorage(roomIdx) {
        const recentlyRooms = JSON.parse(localStorage.getItem('recentlyRooms') || '[]');
        const updatedRooms = recentlyRooms.filter(room => room.roomIdx !== roomIdx);
        localStorage.setItem('recentlyRooms', JSON.stringify(updatedRooms));
    }

    // === DOM에서 카드 제거 ===
    function removeRoomFromDOM(roomElement) {
        roomElement.remove();
        const recentlyContainer = document.getElementById('recently-rooms-container');
        if (!recentlyContainer.querySelector('.room-card')) { // 남은 카드가 없으면 안내 메시지 표시
            recentlyContainer.innerHTML = `
                <div class="no-recently-rooms-container">
                    <img src="/img/room_recently_no_result.svg" alt="최근 본 숙소 없음" class="no-recently-rooms-image">
                </div>
            `;
        }
    }
};
