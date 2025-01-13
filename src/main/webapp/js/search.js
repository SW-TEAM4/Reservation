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
        startDate: checkinDate,
        endDate: checkoutDate,
        minDate: moment().format('YYYY-MM-DD'), // 오늘 이후 날짜만 선택 가능
        maxSpan: { days: 30 } // 최대 30일까지만 선택 가능

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

    // === UI 업데이트 함수 ===
    function updateDateUI(start, end) {
        document.getElementById('checkin-date').textContent = start.format('YYYY-MM-DD');
        document.getElementById('checkout-date').textContent = end.format('YYYY-MM-DD');
        document.getElementById('cal-date').textContent = `, ${end.diff(start, 'days')}박`;
    }


    function sendSearchAjax() {
        console.log("guestCount:" + guestCount + "petCount: " + petCount + "selectedType: " + selectedType + "selectedWeight: " +
            selectedWeight + "checkinDate: " + checkinDate + "checkoutDate: " + checkoutDate + "selectedRegion: " + selectedRegion);

        $.ajax({
            url: "/search/updateUI.do",
            type: "GET",
            dataType: 'json',
            data: {
                checkinDate: checkinDate instanceof Date ? checkinDate.toISOString().split('T')[0] : checkinDate,
                checkoutDate: checkoutDate instanceof Date ? checkoutDate.toISOString().split('T')[0] : checkoutDate,
                guestCount: guestCount,
                petCount: petCount,
                type: selectedType,
                weight: selectedWeight,
                region: selectedRegion,
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

        // 상품 개수 표시 업데이트
        const productCountContainer = document.querySelector(".product-info .product-count");
        if (productCountContainer) {
            productCountContainer.textContent = data.lodgments.length; // 필터된 상품 개수 표시
        }

        // 체크인 시간 'HH:MM' 형식으로 자르기
        function formatTime(time) {
            return time ? time.substring(0, 5) : "";
        }

        if (data && data.lodgments && data.lodgments.length > 0) {
            data.lodgments.forEach(lodgment => {
                const resultItem = document.createElement('div');
                resultItem.classList.add('result-item');
                const imgUrl = lodgment.lod_img_url ? lodgment.lod_img_url : '/img/search_img_no_lodgment_thumbnail.svg';
                const lodCategory = lodgment.lod_category_idx === 1 ? '펜션' : (lodgment.lod_category_idx === 2 ? '글램핑' : '기타');
                const checkIn = formatTime(lodgment.lod_check_in);
                const minPrice = lodgment.min_room_price ? lodgment.min_room_price.toLocaleString() + '원 ~' : '예약 마감'; // 최소 가격 추가
                console.log(lodgment);

                resultItem.innerHTML = `
                
                <div class="result-item-container">
                    <div class="result-item-right-container">
                        <img src="${imgUrl}" alt="${lodgment.lod_name}" class="result-img" width="240px" height="300px">
                    </div>
                    <div class="result-item-left-container">
                        <p style="color: #352018; font-size: 18px; font-weight: bold">${lodgment.lod_name}</p>
                        <div style="display: flex; align-items: center; gap: 5px;">
                            <img src="/img/search_icon_star.svg" class="star-icon" style="width: 16px; height: 16px;"/>
                            <p style="color: #352018; font-size: 14px; font-weight: bold; margin-top: 0.5px;">${lodgment.avgRating}</p>
                            <p style="color: #352018; font-size: 14px; margin-top: 0.7px;">(${lodgment.reviewCount})</p>
                        </div>                
                        <p style="color: gray; font-size: 14px; font-weight: bold">${lodCategory}</p>
                        <div style="position: absolute; right: 20px; bottom: 20px; text-align: right;">
                            <p style="color: gray; font-size: 14px; font-weight: bold">숙박 ${checkIn} ~ </p>
                            <p style="color: #352018; font-size: 20px; font-weight: bold">${minPrice}</p>
                        </div>                
                    </div>
                </div>
            `;
                // 클릭 이벤트 추가
                resultItem.addEventListener('click', () => {
                    window.location.href = `/lodgment.do?lod_idx=${lodgment.lod_idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}`;
                });
                resultContainer.appendChild(resultItem);
            });
        } else {
            resultContainer.innerHTML = `
            <img src="/img/search_img_no_search.svg" style="width: 384px; height: 339px; margin: 300px auto; width: 384px; height: 339px" alt="default_img"/>
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
        popup.style.zIndex = 2;
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
        updateUI();
        togglePopup(guestPopup, 'guest');
    });

    document.getElementById('plus-guest-btn').addEventListener('click', function () {
        if (guestCount < 10) guestCount++;
        updateCounts();
        updateUI();
        sendSearchAjax();
    });

    document.getElementById('minus-guest-btn').addEventListener('click', function () {
        if (guestCount > 1) guestCount--;
        updateCounts();
        updateUI();
        sendSearchAjax();
    });

    document.getElementById('plus-pet-btn').addEventListener('click', function () {
        if (petCount < 5) petCount++;
        updateCounts();
        updateUI();
        sendSearchAjax();
    });

    document.getElementById('minus-pet-btn').addEventListener('click', function () {
        if (petCount > 0) petCount--;
        updateCounts();
        updateUI();
        sendSearchAjax();
    });

    document.getElementById('apply-btn').addEventListener('click', function () {
        guestPopup.classList.add('hidden');
        updateUI();
        updateCounts();
    });

    // === 타입 팝업 ===
    document.getElementById('type-button').addEventListener('click', function (e) {
        e.stopPropagation();
        updateUI();
        togglePopup(typePopup, 'type');
    });

    document.querySelectorAll('.type-item').forEach(item => {
        item.addEventListener('click', function () {
            selectedType = this.getAttribute('value');
            document.querySelector('.type-label').innerText = this.getAttribute('data-value');
            typePopup.classList.add('hidden');
            updateUI();
            sendSearchAjax();
        });
    });

    // === 몸무게 팝업 ===
    document.getElementById('weight-button').addEventListener('click', function (e) {
        e.stopPropagation();
        updateUI();
        togglePopup(weightPopup, 'weight');
    });

    document.querySelectorAll('.weight-item').forEach(item => {
        item.addEventListener('click', function () {
            selectedWeight = this.getAttribute('value');
            document.querySelector('.weight-label').innerText = this.getAttribute('data-value');
            weightPopup.classList.add('hidden');
            updateUI();
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

    // === URL 파라미터에서 지역 값 가져오기 ===
    const urlParams = new URLSearchParams(window.location.search);
    const regionParam = urlParams.get('region'); // URL에서 지역 값 읽기
    if (regionParam) {
        selectedRegion = parseInt(regionParam, 10); // URL 파라미터 값 적용
        localStorage.setItem('selectedRegion', selectedRegion); // 로컬스토리지에 저장
    } else {
        // 지역 값이 없으면 기본값을 전체(0)로 설정
        selectedRegion = 0;
    }

    // === 탭 UI 활성화 처리 ===
    document.querySelectorAll('.tab').forEach(tab => {
        const tabRegion = parseInt(tab.getAttribute('data-region'), 10); // 각 탭의 지역 값

        // 선택된 지역과 일치하면 활성화
        if (tabRegion === selectedRegion) {
            tab.classList.add('active'); // 선택된 탭 활성화
            tab.classList.remove('inactive'); // 비활성화 제거
        } else {
            tab.classList.remove('active'); // 선택 해제
            tab.classList.add('inactive'); // 비활성화 적용
        }
    });

    // === 탭 클릭 이벤트 추가 ===
    const tabs = document.querySelectorAll('.tab'); // 모든 탭 가져오기
    tabs.forEach(tab => {
        tab.addEventListener('click', function () {
            // 모든 탭 비활성화
            tabs.forEach(t => t.classList.remove('active'));
            tabs.forEach(t => t.classList.add('inactive'));

            // 클릭한 탭 활성화
            tab.classList.remove('inactive');
            tab.classList.add('active');

            // 클릭한 지역에 따라 selectedRegion 변경
            const tabId = tab.getAttribute('id'); // 탭 ID로 구분
            switch (tabId) {
                case 'tab-all':
                    selectedRegion = 0; // 전체
                    tab.classList.add('active'); // 선택된 탭 활성화
                    break;
                case 'tab-gangwondo':
                    selectedRegion = 1; // 강원도
                    tab.classList.add('active'); // 선택된 탭 활성화
                    break;
                case 'tab-gyeonggi':
                    selectedRegion = 2; // 경기
                    tab.classList.add('active'); // 선택된 탭 활성화

                    break;
                case 'tab-incheon':
                    selectedRegion = 3; // 인천
                    tab.classList.add('active'); // 선택된 탭 활성화

                    break;
                default:
                    selectedRegion = 0; // 기본값
                    tab.classList.add('active'); // 선택된 탭 활성화
            }

            // AJAX 요청 다시 보내기
            sendSearchAjax();
        });

    });

    function updateUI() {
        document.getElementById('guest-count').innerText = guestCount.toString();
        document.getElementById('pet-count').innerText = petCount.toString();
        document.querySelector('.type-label').innerText = document.querySelector(`.type-item[value='${selectedType}']`).getAttribute('data-value');
        document.querySelector('.weight-label').innerText = document.querySelector(`.weight-item[value='${selectedWeight}']`).getAttribute('data-value');
        document.getElementById('checkin-date').textContent = moment(checkinDate).format('YYYY-MM-DD');
        document.getElementById('checkout-date').textContent = moment(checkoutDate).format('YYYY-MM-DD');
        document.getElementById('cal-date').textContent = `, ${moment(checkoutDate).diff(moment(checkinDate), 'days')}박`;
    }

    // === 초기 UI 렌더링 ===
    updateUI();
    updateDateUI(moment(checkinDate), moment(checkoutDate)); // 기본값으로 오늘과 내일 표시
    sendSearchAjax();
});

