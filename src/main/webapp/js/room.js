document.addEventListener("DOMContentLoaded", function () {
    const slides = document.querySelectorAll(".slider-slide"); // 슬라이드 목록
    const currentSlideElement = document.getElementById("current-slide");
    const totalSlidesElement = document.getElementById("total-slides");

    let currentIndex = 0; // 현재 슬라이드 인덱스 (0부터 시작)
    const totalSlides = slides.length; // 총 슬라이드 개수

    // 총 슬라이드 개수 설정
    totalSlidesElement.textContent = totalSlides;

    /*2025.01.09 JDeok 변경 */
    const recentlyRooms = JSON.parse(localStorage.getItem('recentlyRooms'));
    const roomPrice = document.querySelector(".room-price");

    roomPrice.textContent = formatPrice(recentlyRooms[0].roomPrice) + " 원";

    /* 정규식 */
    function formatPrice(price) {
        if (typeof price === 'number') {
            // 숫자 -> 쉼표 포함된 문자열로 변환
            return price.toLocaleString('ko-KR');
        } else if (typeof price === 'string') {
            // 문자열 -> 숫자로 변환 후 쉼표 포함된 문자열로 변환
            const numericPrice = parseInt(price.replace(/,/g, ''), 10); // 쉼표 제거 후 숫자로 변환
            return numericPrice.toLocaleString('ko-KR');
        }
        return '0';
    }

    // 이전 버튼 클릭 이벤트
    document.querySelector(".prev-button").addEventListener("click", function () {
        currentIndex = (currentIndex - 1 + totalSlides) % totalSlides; // 이전 슬라이드로 이동
        updateSlider();
    });

    // 다음 버튼 클릭 이벤트
    document.querySelector(".next-button").addEventListener("click", function () {
        currentIndex = (currentIndex + 1) % totalSlides; // 다음 슬라이드로 이동
        updateSlider();
    });

    // 슬라이더 업데이트 함수
    function updateSlider() {
        const sliderWrapper = document.querySelector(".slider-wrapper");
        sliderWrapper.style.transform = `translateX(-${currentIndex * 100}%)`; // 슬라이드 이동
        currentSlideElement.textContent = currentIndex + 1; // 현재 슬라이드 번호 업데이트
    }
})