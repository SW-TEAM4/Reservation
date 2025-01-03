$(function() {
    // Swiper 초기화
    var swiper = new Swiper('.swiper-visual', {
        autoplay: {
            delay: 2000
        },
        loop: true
    });
});

// === 페이지 로드 시 지역 값 확인 ===
document.addEventListener("DOMContentLoaded", function () {
    const storedRegion = localStorage.getItem('selectedRegion'); // 로컬스토리지에서 값 불러오기
    if (!storedRegion) {
        localStorage.setItem('selectedRegion', 0); // 값이 없으면 기본값 0(전체) 저장
    }
});

// === 지역 선택 및 전송 기능 추가 ===
function setRegion(region) {
    // 로컬스토리지에 지역 값 저장
    localStorage.setItem('selectedRegion', region);

    // URL 파라미터 추가하여 검색 페이지로 이동
    window.location.href = `/search/search.do?region=${region}`;
}

// 강원도 버튼 클릭
$('#tab-gangwondo').on('click', function () {
    setRegion(1); // 강원도 값 1 전송
});

// 경기도 버튼 클릭
$('#tab-gyeonggi').on('click', function () {
    setRegion(2); // 경기도 값 2 전송
});

// 인천 버튼 클릭
$('#tab-incheon').on('click', function () {
    setRegion(3); // 인천 값 3 전송
});

// 전체 버튼 클릭
$('#tab-all').on('click', function () {
    setRegion(0); // 전체 값 0 전송
});
