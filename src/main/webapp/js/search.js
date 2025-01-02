document.addEventListener("DOMContentLoaded", function () {
    // === 변수 선언 ===
    let guestCount = 2; // 기본 인원 수
    let petCount = 1;   // 기본 반려동물 수
    let selectedType = 0; // 기본 선택 값
    let selectedWeight = 0; // 기본 선택 값
    let checkinDate = moment().format('YYYY-MM-DD'); // 오늘 날짜
    let checkoutDate = moment().add(1, 'days').format('YYYY-MM-DD'); // 내일 날짜
    let selectedRegion = 0;

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
        autoApply:true,
        startDate: checkinDate,
        endDate: checkoutDate,
        minDate: moment().format('YYYY-MM-DD') // 오늘 이후 날짜만 선택 가능
    }, function (start, end) {
        // 선택된 날짜 업데이트
        checkinDate = start.format('YYYY-MM-DD');
        checkoutDate = end.format('YYYY-MM-DD');

        // UI 업데이트
        updateDateUI(start, end);


        // UI 업데이트
        document.getElementById('checkin-date').textContent = start.format('YYYY-MM-DD');
        document.getElementById('checkout-date').textContent = end.format('YYYY-MM-DD');
        document.getElementById('cal-date').textContent = `, ${end.diff(start, 'days')}박`;

        // AJAX 요청 전송
        sendSearchAjax();
    });
    // === UI 업데이트 함수 ===
    function updateDateUI(start, end) {
        document.getElementById('checkin-date').textContent = start.format('YYYY-MM-DD');
        document.getElementById('checkout-date').textContent = end.format('YYYY-MM-DD');
        document.getElementById('cal-date').textContent = `, ${end.diff(start, 'days')}박`;
    }


    function sendSearchAjax() {
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

    function updateResultUI(data) {
        const resultContainer = document.getElementById("result-container");
        resultContainer.innerHTML = ""; // 기존 결과 초기화

        if (data && data.lodgments && data.lodgments.length > 0) {
            data.lodgments.forEach(lodgment => {
                const resultItem = document.createElement('div');
                resultItem.classList.add('result-item');
                const imgUrl = lodgment.lod_img_url ? lodgment.lod_img_url : '/img/search_img_no_lodgment_thumbnail.svg';
                resultItem.innerHTML = `
                <img src="${imgUrl}" alt="${lodgment.lod_name}" class="result-img" width="240px" height="300px">
                <h3>${lodgment.lod_name}</h3>
                <p>${lodgment.lod_address}</p>
                <p>평점: ${lodgment.avg_rating}</p>
            `;
                // 클릭 이벤트 추가
                resultItem.addEventListener('click', () => {
                    window.location.href=`/lodgment.do?lod_idx=${lodgment.lod_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}
                &guestCount=${guestCount}&petCount=${petCount}`;
                });
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

    // === 팝업 닫기 함수 ===
    function closeAllPopups(except = null) {
        if (except !== 'guest') guestPopup.classList.add('hidden');
        if (except !== 'type') typePopup.classList.add('hidden');
        if (except !== 'weight') weightPopup.classList.add('hidden');
    }

    // === 팝업 토글 함수 ===
    function togglePopup(popup, except) {
        closeAllPopups(except);
        popup.classList.toggle('hidden');
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


    // === 외부 클릭 처리 ===
    document.addEventListener('click', function (e) {
        const isInsidePopup =
            guestPopup.contains(e.target) ||
            typePopup.contains(e.target) ||
            weightPopup.contains(e.target)

        if (!isInsidePopup) closeAllPopups();
    });



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

    // === 초기 UI 렌더링 ===
    updateDateUI(moment(checkinDate), moment(checkoutDate)); // 기본값으로 오늘과 내일 표시
    sendSearchAjax();
});

