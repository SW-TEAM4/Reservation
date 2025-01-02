document.addEventListener("DOMContentLoaded", function () {
    const sliderWrapper = document.querySelector(".slider-wrapper");
    const slides = document.querySelectorAll(".slider-slide");
    const prevButton = document.querySelector(".prev-button");
    const nextButton = document.querySelector(".next-button");
    const currentSlideEl = document.getElementById("current-slide");
    const totalSlidesEl = document.getElementById("total-slides");

    let currentIndex = 0; // 현재 슬라이드 인덱스
    const totalSlides = slides.length;

    // 총 슬라이드 개수 표시
    totalSlidesEl.textContent = totalSlides;

    // 슬라이더 이동 함수
    function updateSlider() {
        sliderWrapper.style.transform = `translateX(-${currentIndex * 100}%)`;
        currentSlideEl.textContent = currentIndex + 1; // 현재 슬라이드 번호 업데이트
    }

    // 이전 버튼 클릭 이벤트
    prevButton.addEventListener("click", function () {
        if (currentIndex > 0) {
            currentIndex--;
            updateSlider();
        }
    });

    // 다음 버튼 클릭 이벤트
    nextButton.addEventListener("click", function () {
        if (currentIndex < totalSlides - 1) {
            currentIndex++;
            updateSlider();
        }
    });

    // 초기 슬라이더 상태 설정
    updateSlider();
});