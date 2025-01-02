document.addEventListener("DOMContentLoaded", function () {
    // === 변수 선언 ===
    let guestCount = parseInt(document.getElementById("guest-count").textContent);
    let petCount = parseInt(document.getElementById("pet-count").textContent);
    let checkinDate = moment().format('YYYY-MM-DD'); // 오늘 날짜
    let checkoutDate = moment().add(1, 'days').format('YYYY-MM-DD'); // 내일 날짜

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
        checkinDate = start.format('YYYY-MM-DD');
        checkoutDate = end.format('YYYY-MM-DD');

        // UI 업데이트
        document.getElementById('checkin-date').textContent = start.format('YYYY-MM-DD');
        document.getElementById('checkout-date').textContent = end.format('YYYY-MM-DD');
        document.getElementById('cal-date').textContent = `, ${end.diff(start, 'days')}박`;

        // AJAX 요청 전송
        sendSearchAjax();
    });

    // 서버로 검색 요청 전송
    function sendSearchAjax() {
        $.ajax({
            url: '/lodgment/availableRooms.do',
            type: 'POST',
            dataType: 'json',
            data: {
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
    // UI 업데이트 함수
    function updateRoomList(roomList) {
        const roomListContainer = document.getElementById("room-list");
        roomListContainer.innerHTML = ''; // 기존 리스트 초기화

        if (roomList && roomList.length > 0) {
            roomList.forEach(room => {
                const roomCard = `
                    <div class="room-card">
                        <img src="${room.room_img_url}" alt="${room.room_name}" class="room-img">
                        <div class="room-info">
                            <h3>${room.room_name}</h3>
                            <p>가격: ${Number(room.room_price).toLocaleString()}원</p>
                            <p>최대 인원: ${room.max_people_cnt}명</p>
                            <p>최대 반려동물 수: ${room.max_pet_cnt}마리</p>
                        </div>
                    </div>`;
                roomListContainer.insertAdjacentHTML('beforeend', roomCard);
            });
        } else {
            roomListContainer.innerHTML = '<p>조건에 맞는 객실이 없습니다.</p>';
        }
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
