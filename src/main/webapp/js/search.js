document.addEventListener("DOMContentLoaded", function () {
    // === 변수 선언 ===
    let guestCount = 2; // 기본 인원 수
    let petCount = 1;   // 기본 반려동물 수
    let selectedType = "전체"; // 기본 선택 값
    let selectedWeight = "5kg 미만"; // 기본 선택 값

    // === 팝업 요소 가져오기 ===
    const guestPopup = document.getElementById('guest-popup');
    const typePopup = document.getElementById('type-popup');
    const weightPopup = document.getElementById('weight-popup');

    // === 팝업 닫기 함수 ===
    function closeAllPopups() {
        guestPopup.classList.add('hidden');
        typePopup.classList.add('hidden');
        weightPopup.classList.add('hidden');
    }

    // === 팝업 토글 함수 ===
    function togglePopup(popup) {
        closeAllPopups(); // 먼저 모든 팝업 닫기
        popup.classList.toggle('hidden'); // 클릭한 팝업만 토글
    }

    // === 인원 및 반려동물 팝업 ===
    document.getElementById('guest-button').addEventListener('click', function (e) {
        e.stopPropagation(); // 상위 요소 클릭 이벤트 전파 방지
        togglePopup(guestPopup); // 팝업 토글
    });

    document.getElementById('plus-guest-btn').addEventListener('click', function () {
        if (guestCount < 10) {
            guestCount++;
            updateCounts();
        }
    });

    document.getElementById('minus-guest-btn').addEventListener('click', function () {
        if (guestCount > 1) {
            guestCount--;
            updateCounts();
        }
    });

    document.getElementById('plus-pet-btn').addEventListener('click', function () {
        if (petCount < 5) {
            petCount++;
            updateCounts();
        }
    });

    document.getElementById('minus-pet-btn').addEventListener('click', function () {
        if (petCount > 0) {
            petCount--;
            updateCounts();
        }
    });

    function updateCounts() {
        document.getElementById('guest-counter').innerText = guestCount;
        document.getElementById('pet-counter').innerText = petCount;
        document.getElementById('guest-count').innerText = guestCount;
        document.getElementById('pet-count').innerText = petCount;
    }

    document.getElementById('apply-btn').addEventListener('click', function () {
        guestPopup.classList.add('hidden'); // 팝업 닫기
    });

    // === 타입 팝업 ===
    document.getElementById('type-button').addEventListener('click', function (e) {
        e.stopPropagation(); // 상위 요소 클릭 이벤트 전파 방지
        togglePopup(typePopup); // 팝업 토글
    });

    document.querySelectorAll('.type-item').forEach(item => {
        item.addEventListener('click', function () {
            selectedType = this.getAttribute('data-value');
            document.querySelector('.type-label').innerText = selectedType;
            typePopup.classList.add('hidden'); // 팝업 닫기
        });
    });

    // === 몸무게 팝업 ===
    document.getElementById('weight-button').addEventListener('click', function (e) {
        e.stopPropagation(); // 상위 요소 클릭 이벤트 전파 방지
        togglePopup(weightPopup); // 팝업 토글
    });

    document.querySelectorAll('.weight-item').forEach(item => {
        item.addEventListener('click', function () {
            selectedWeight = this.getAttribute('data-value');
            document.querySelector('.weight-label').innerText = selectedWeight;
            weightPopup.classList.add('hidden'); // 팝업 닫기
        });
    });

    // === 클릭 외부 영역 처리 ===
    document.addEventListener('click', function (e) {
        const isClickInsidePopup = guestPopup.contains(e.target) || typePopup.contains(e.target) || weightPopup.contains(e.target);
        const isClickInsideButton = e.target.closest('.count-selector') || e.target.closest('.type-selector') || e.target.closest('.weight-selector');

        if (!isClickInsidePopup && !isClickInsideButton) {
            closeAllPopups(); // 클릭 외부일 때 모든 팝업 닫기
        }
    });
});

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

            // 나중에 여기에 DB 쿼리 호출 함수 넣으면 됨
            // fetchFilteredResults(selectedRegion);
        });
    });
});

