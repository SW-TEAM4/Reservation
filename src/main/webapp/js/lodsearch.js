document.addEventListener("DOMContentLoaded", function () {
    // === 변수 선언 ===
    let guestCount = document.getElementById("guest-count").textContent; // 기본 인원 수
    let petCount = document.getElementById("pet-count").textContent;   // 기본 반려동물 수
    let calendar; // FullCalendar 인스턴스 저장 변수
    let checkinDate = document.getElementById("checkin-date").textContent.trim();
    let checkoutDate = document.getElementById("checkout-date").textContent.trim();

    console.log("lodsearchjs check:" +checkinDate + " out: " + checkoutDate + " lod_idx" + lod_idx);
    function sendSearchAjax() {
        console.log("sendSearchAjax");
        console.log("checkinDate: " + checkinDate + " checkoutDate: " + checkoutDate + " guestCount:" + guestCount + " petCount: " + petCount);
        console.log("lod_idx: " + lod_idx);
        $.ajax({
            url: '/lodgment/availableRooms.do', // 서버 API 엔드포인트
            type: 'POST',
            dataType: 'json', // 응답 데이터 타입
            data: {
                lod_idx: lod_idx,
                checkinDate: checkinDate,
                checkoutDate: checkoutDate,
                guestCount: guestCount,
                petCount: petCount
            },
            success: function (response) {
                console.log('필터링된 객실 데이터:', response);
                updateRoomList(response); // UI 업데이트 함수 호출
            },
            error: function (xhr, status, error) {
                console.error('객실 필터링 요청 실패:', error);
                alert('객실 정보를 가져오는 데 실패했습니다.');
            }
        });
    }

    // UI 업데이트 함수
    function updateRoomList(roomList) {
        const roomListContainer = document.getElementById("room-list");
        roomListContainer.innerHTML = '';

        if (roomList && roomList.length > 0) {
            roomList.forEach(room => {
                const roomCard = `
          <div class="room-card">
            <!-- 객실 이미지 -->
            <a href="/room/detail?room_idx=${room.room_idx}" class="room-image-link">
              <img src="${room.room_img_url}" alt="${room.room_name}" class="room-img">
            </a>

            <!-- 객실 정보 -->
            <div class="room-info">
              <!-- 상단 영역 -->
              <div class="room-header">
                <h3>${room.room_name}</h3>
                성인 ${room.max_people_cnt}, 반려동물 ${room.max_people_cnt}
                <p>체크인 15:00 - 체크아웃 11:00</p>
              </div>

              <!-- 하단 영역 -->
              <div class="room-footer">
                <p>${Number(room.room_price).toLocaleString()}원</p>
                <button onclick="location.href='/reserve/reservation.do?room_idx=${room.room_idx}'">
                  예약하기
                </button>
              </div>
            </div>
          </div>`;

                roomListContainer.insertAdjacentHTML('beforeend', roomCard);
            });
        } else {
            const noRoomsMessage = `<p>현재 이용 가능한 객실이 없습니다.</p>`;
            roomListContainer.insertAdjacentHTML('beforeend', noRoomsMessage);
        }
    }

    // === 팝업 요소 가져오기 ===
    const guestPopup = document.getElementById('guest-popup');
    const calendarContainer = document.getElementById('calendar-container');
    const calendarEl = document.getElementById('calendar');

    // === 팝업 닫기 함수 ===
    function closeAllPopups(except = null) {
        if (except !== 'guest') guestPopup.classList.add('hidden');
        // if (except !== 'type') typePopup.classList.add('hidden');
        // if (except !== 'weight') weightPopup.classList.add('hidden');
        if (except !== 'calendar') calendarContainer.style.display = 'none';
    }

    // === 팝업 토글 함수 ===
    function togglePopup(popup, except) {
        closeAllPopups(except);
        popup.classList.toggle('hidden');
    }

    // === 캘린더 초기화 및 렌더링 ===
    function initializeCalendar() {
        if (calendar) return; // 이미 초기화된 경우 중복 생성 방지

        // 캘린더 보이기 (크기 계산용)
        calendarContainer.style.display = 'block'; // 팝업 보이기
        calendarContainer.style.visibility = 'hidden'; // 보이지만 사용자에겐 안 보이게 설정

        const today = new Date();
        today.setHours(0, 0, 0, 0);

        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            selectable: true,
            validRange: {start: today.toISOString().split('T')[0]},
            select(info) {
                const selectedDate = new Date(info.startStr);

                if (!checkinDate || (checkinDate && checkoutDate)) {
                    checkinDate = info.startStr;
                    checkoutDate = null;
                    updateDatesUI(checkinDate, null);
                } else if (checkinDate && !checkoutDate) {
                    const startDate = new Date(checkinDate);

                    if (selectedDate > startDate) {
                        checkoutDate = info.startStr;
                        updateDatesUI(checkinDate, checkoutDate);
                    } else {
                        checkinDate = info.startStr;
                        checkoutDate = null;
                        updateDatesUI(checkinDate, null);
                    }
                }
            },
            unselectAuto: false,
            height: 'auto',
            handleWindowResize: true,
        });

        calendar.render();
        setTimeout(() => {
            calendar.updateSize(); // 크기 강제 업데이트
            calendarContainer.style.visibility = 'visible'; // 팝업 보이기
            calendarContainer.style.display = 'none'; // 다시 숨기기
        }, 10);
    }

    // === 날짜 업데이트 UI ===
    function updateDatesUI(checkin, checkout) {
        const checkinEl = document.getElementById('checkin-date');
        const checkoutEl = document.getElementById('checkout-date');
        const calDateEl = document.getElementById('cal-date');

        const checkinFormatted = formatDate(new Date(checkin));
        const checkoutFormatted = checkout ? formatDate(new Date(checkout)) : "";

        checkinEl.textContent = checkinFormatted;
        checkoutEl.textContent = checkoutFormatted;

        if (checkout) {
            const nights = calculateNights(new Date(checkin), new Date(checkout));
            calDateEl.textContent = `, ${nights}박`;

            sendSearchAjax();
        } else {
            calDateEl.textContent = "";
        }
    }

    // === 날짜 포맷 ===
    function formatDate(date) {
        const options = {month: 'long', day: 'numeric', weekday: 'long'};
        return date.toLocaleDateString('ko-KR', options);
    }

    // === 박 수 계산 ===
    function calculateNights(startDate, endDate) {
        const diffTime = Math.abs(endDate - startDate);
        return Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    }

    // === 인원 및 반려동물 수 변경 ===
    function updateCounts() {
        document.getElementById('guest-count').innerText = guestCount.toString();
        document.getElementById('pet-count').innerText = petCount.toString();
        document.getElementById('guest-counter').innerText = guestCount.toString();
        document.getElementById('pet-counter').innerText = petCount.toString();
    }

    // === 인원 팝업 ===
    document.getElementById('guest-button').addEventListener('click', function (e) {
        e.stopPropagation();
        togglePopup(guestPopup, 'guest');
    });

    document.getElementById('plus-guest-btn').addEventListener('click', function () {
        if (guestCount < 10) guestCount++;
        updateCounts();
        sendSearchAjax();
    });

    document.getElementById('minus-guest-btn').addEventListener('click', function () {
        if (guestCount > 1) guestCount--;
        updateCounts();
        sendSearchAjax();
    });

    document.getElementById('plus-pet-btn').addEventListener('click', function () {
        if (petCount < 5) petCount++;
        updateCounts();
        sendSearchAjax();
    });

    document.getElementById('minus-pet-btn').addEventListener('click', function () {
        if (petCount > 0) petCount--;
        updateCounts();
        sendSearchAjax();
    });

    document.getElementById('apply-btn').addEventListener('click', function () {
        guestPopup.classList.add('hidden');
        updateCounts();
    });

    document.querySelectorAll('.type-item').forEach(item => {
        item.addEventListener('click', function () {
            selectedType = this.getAttribute('value');
            document.querySelector('.type-label').innerText = this.getAttribute('data-value');
            typePopup.classList.add('hidden');
            sendSearchAjax();
        });
    });


    // === 캘린더 팝업 ===
    document.getElementById('date-picker').addEventListener('click', function (e) {
        e.stopPropagation();
        closeAllPopups('calendar');
        calendarContainer.style.display = 'block';
        initializeCalendar();
    });

    // === 외부 클릭 처리 ===
    document.addEventListener('click', function (e) {
        const isInsidePopup =
            guestPopup.contains(e.target) ||
            calendarContainer.contains(e.target);

        if (!isInsidePopup) closeAllPopups();
    });

    // === 초기 렌더링 ===
    initializeCalendar();
    updateCounts();
    sendSearchAjax();


});
