document.addEventListener("DOMContentLoaded", function () {
    const slides = document.querySelectorAll(".slider-slide"); // 슬라이드 목록
    const currentSlideElement = document.getElementById("current-slide");
    const totalSlidesElement = document.getElementById("total-slides");

    let currentIndex = 0; // 현재 슬라이드 인덱스 (0부터 시작)
    const totalSlides = slides.length; // 총 슬라이드 개수

    // 총 슬라이드 개수 설정
    totalSlidesElement.textContent = totalSlides;

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