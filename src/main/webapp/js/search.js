document.addEventListener("DOMContentLoaded", function () {
    // === 변수 선언 ===
    let guestCount = 2; // 기본 인원 수
    let petCount = 1;   // 기본 반려동물 수
    let selectedType = 0; // 기본 선택 값
    let selectedWeight = 0; // 기본 선택 값
    let calendar; // FullCalendar 인스턴스 저장 변수
    let checkinDate = formatDate(new Date()); // 수정
    let checkoutDate = formatDate(new Date(tomorrow)); // 수정
    let selectedRegion = 0;

    function sendSearchAjax() {
        console.log("guestCount:" + guestCount + "petCount: " + petCount + "selectedType: " + selectedType + "selectedWeight: " +
            selectedWeight + "checkinDate: " + checkinDate + "checkoutDate: " + checkoutDate + "selectedRegion: " + selectedRegion);

        $.ajax({
            url: "/search/updateUI.do",
            type: "GET",
            dataType:'json',
            data: {
                checkinDate: checkinDate instanceof Date ? checkinDate.toISOString().split('T')[0] : checkinDate,
                checkoutDate: checkoutDate instanceof Date ? checkoutDate.toISOString().split('T')[0] : checkoutDate,
                guestCount: guestCount,
                petCount: petCount,
                type: selectedType,
                weight: selectedWeight,
                region: selectedRegion
            },
            cache: false,
            success: function (response) {
                console.log(response);
                updateResultUI(response);
            },
            error: function (error) {
                console.error("검색 요청 오류:", error);
            }
        });
    }

    function updateResultUI(data){
        const resultContainer = document.getElementById("result-container");
        resultContainer.innerHTML = "";

        // 이미지가 null일 때 이미지 처리 추가하기
        if (data && data.length > 0) {
            data.forEach(lodgment => {
                const resultItem = document.createElement('div');
                resultItem.classList.add('result-item');
                resultItem.innerHTML = `
                <img src="${lodgment.lod_img_url}" alt="${lodgment.lod_name}" class="result-img" width="200px" height="200px">
                <h3>${lodgment.lod_name}</h3>
                <p>${lodgment.lod_address}</p>
                <p>평점: ${lodgment.avg_rating}</p>
            `;
                resultContainer.appendChild(resultItem);
            });
        } else {
            resultContainer.innerHTML = `
            <img src="/img/search_img_no_search.svg" style="width: 384px; height: 339px;" alt="default_img"/>
        `;
        }
    }

    // === 팝업 요소 가져오기 ===
    const guestPopup = document.getElementById('guest-popup');
    const typePopup = document.getElementById('type-popup');
    const weightPopup = document.getElementById('weight-popup');
    const calendarContainer = document.getElementById('calendar-container');
    const calendarEl = document.getElementById('calendar');

    // === 팝업 닫기 함수 ===
    function closeAllPopups(except = null) {
        if (except !== 'guest') guestPopup.classList.add('hidden');
        if (except !== 'type') typePopup.classList.add('hidden');
        if (except !== 'weight') weightPopup.classList.add('hidden');
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

    // === 타입 팝업 ===
    document.getElementById('type-button').addEventListener('click', function (e) {
        e.stopPropagation();
        togglePopup(typePopup, 'type');
    });

    document.querySelectorAll('.type-item').forEach(item => {
        item.addEventListener('click', function () {
            selectedType = this.getAttribute('value');
            document.querySelector('.type-label').innerText = this.getAttribute('data-value');
            typePopup.classList.add('hidden');
            sendSearchAjax();
        });
    });

    // === 몸무게 팝업 ===
    document.getElementById('weight-button').addEventListener('click', function (e) {
        e.stopPropagation();
        togglePopup(weightPopup, 'weight');
    });

    document.querySelectorAll('.weight-item').forEach(item => {
        item.addEventListener('click', function () {
            selectedWeight = this.getAttribute('value');
            document.querySelector('.weight-label').innerText = this.getAttribute('data-value');
            weightPopup.classList.add('hidden');
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
            typePopup.contains(e.target) ||
            weightPopup.contains(e.target) ||
            calendarContainer.contains(e.target);

        if (!isInsidePopup) closeAllPopups();
    });

    // === 초기 렌더링 ===
    initializeCalendar();
    updateCounts();
    sendSearchAjax();

// === 탭 클릭 이벤트 추가 ===
    document.addEventListener("DOMContentLoaded", function () {
        // === 탭 선택 기능 ===
        const tabs = document.querySelectorAll('.tab'); // 모든 탭 가져오기
        tabs.forEach(tab => {
            tab.addEventListener('click', function () {
                // 모든 탭에서 active 클래스 제거
                tabs.forEach(t => t.classList.remove('active'));
                tabs.forEach(t => t.classList.add('inactive'));
                // 현재 클릭한 탭에 active 추가
                tab.classList.remove('inactive'); // 비활성화 클래스 제거
                tab.classList.add('active');     // 활성화 클래스 추가
                // 나중에 쿼리 연동을 위한 선택된 지역 정보
                const selectedRegion = tab.getAttribute('id'); // ID로 지역 구분
                console.log("선택된 지역:", selectedRegion); // 선택 확인용 (테스트)

                sendSearchAjax();
            });
        });
    });

});
