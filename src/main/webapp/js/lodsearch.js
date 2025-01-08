document.addEventListener("DOMContentLoaded", function () {
    // === 변수 선언 ===
    let guestCount = parseInt(document.getElementById("guest-count").textContent);
    let petCount = parseInt(document.getElementById("pet-count").textContent);
    let checkinDate = document.getElementById("checkin-date").textContent;

    let checkoutDate = document.getElementById("checkout-date").textContent;
    let lod_idx = document.getElementById("lod_idx").value;

    // === saveToRecent 함수 ===
    function saveToRecent(roomIdx, roomName, roomImgUrl, roomPrice) {
        const recentlyRooms = JSON.parse(localStorage.getItem('recentlyRooms') || '[]');
        const updatedRooms = recentlyRooms.filter(room => room.roomIdx !== roomIdx);
        updatedRooms.unshift({ roomIdx, roomName, roomImgUrl, roomPrice });
        if (updatedRooms.length > 5) updatedRooms.pop();
        localStorage.setItem('recentlyRooms', JSON.stringify(updatedRooms));
    }


    // Date Range Picker 초기화
    $('#date-picker').daterangepicker({
        locale: {
            format: 'YYYY-MM-DD',
            separator: ' ~ ',
            applyLabel: '확인',
            cancelLabel: '취소',
            daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
            monthNames: [
                '1월', '2월', '3월', '4월', '5월', '6월',
                '7월', '8월', '9월', '10월', '11월', '12월'
            ],
            firstDay: 0
        },
        startDate: checkinDate,
        endDate: checkoutDate,
        minDate: moment().format('YYYY-MM-DD') // 오늘 이후 날짜만 선택 가능
    }, function (start, end) {
        // 선택된 날짜 업데이트
        console.log("start:" + start + "end" + end);
        checkinDate = start.format('YYYY-MM-DD');
        checkoutDate = end.format('YYYY-MM-DD');
        checkinDate = checkinDate.trim();
        checkoutDate = checkoutDate.trim();
        // UI 업데이트
        document.getElementById('checkin-date').textContent = start.format('YYYY-MM-DD');
        document.getElementById('checkout-date').textContent = end.format('YYYY-MM-DD');
        document.getElementById('cal-date').textContent = `, ${end.diff(start, 'days')}박`;

        // AJAX 요청 전송
        sendSearchAjax();
    });

    // === 객실 카드 템플릿 함수 ===
    function createRoomCard(room, checkinTime, checkoutTime) {
        const roomPrice = room.room_price.toLocaleString() + '원';
        return `
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
                            <div class="room-name" style="margin-bottom: 5px;">${room.room_name}</div>
                            <div class="check-in-out">체크인 ${checkinTime}  ~ 체크아웃 ${checkoutTime}</div>
                        </div>
                        <a href="/room/detail?room_idx=${room.room_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}"
                           class="details-link"
                           onclick="saveToRecent('${room.room_idx}', '${room.room_name}', '${room.room_img_urls[0]}', '${room.room_price}')">
                            상세보기
                        </a>
                    </div>
                    <!-- 하단 영역 -->
                    <div class="room-footer">
                        <p class="room-price">${roomPrice}</p>
                        <!-- 예약 버튼 -->
                        <button class="booking-button" onclick="location.href='/reservation/reservation.do?room_idx=${room.room_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&res_people_cnt=${guestCount}&res_pets_cnt=${petCount}'">
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
        `;
    }

    // === UI 업데이트 함수 ===
    function updateRoomList(response) {
        const roomListContainer = document.getElementById("room-list");
        roomListContainer.innerHTML = ''; // 기존 리스트 초기화

        const roomList =  response.roomList;
        const checkinTime = response.checkinTime;
        const checkoutTime = response.checkoutTime;
        if (roomList && roomList.length > 0) {
            roomList.forEach(room => {
                const roomCard = createRoomCard(room, checkinTime, checkoutTime);
                roomListContainer.insertAdjacentHTML('beforeend', roomCard);
            });
        } else {
            roomListContainer.innerHTML = `
                <p>예약 가능한 방이 없습니다!</p>
                <div style="width: 1280px; height: 1px; background-color: #cccccc; margin: 20px auto;"></div>
            `;
        }
    }

    // 서버로 검색 요청 전송
    function sendSearchAjax() {
        var url = "/lodgment.do?lod_idx=" + lod_idx + "&checkinDate=" + checkinDate + "&checkoutDate=" + checkoutDate + "&guestCount=" + guestCount + "&petCount=" + petCount;
        console.log(url);
        $.ajax({
            url: '/lodgment/availableRooms.do',
            type: 'GET',
            dataType: 'json',
            data: {
                lod_idx: lod_idx,
                checkinDate: checkinDate,
                checkoutDate: checkoutDate,
                guestCount: guestCount,
                petCount: petCount
            },
            success: function (response) {
                updateRoomList(response); // 결과 업데이트 함수 호출
            },
            error: function (xhr, status, error) {
                alert('객실 정보를 가져오는 데 실패했습니다.');
            }
        });
    }

    // === 팝업 요소 가져오기 ===
    const guestPopup = document.getElementById("guest-popup");


    // === 팝업 닫기 함수 ===
    function closeAllPopups(except = null) {
        if (except !== 'guest') guestPopup.classList.add('hidden');
    }


    // === 팝업 토글 함수 ===
    function toggleGuestPopup() {
        guestPopup.classList.toggle("hidden");
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
        toggleGuestPopup();
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


    // === 외부 클릭 처리 ===
    document.addEventListener('click', function (e) {
        const isInsidePopup =
            guestPopup.contains(e.target)

        if (!isInsidePopup) closeAllPopups();
    });

    // === 초기 렌더링 ===
    updateCounts();
    sendSearchAjax();
});
