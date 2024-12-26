$(function() {
    // Swiper 초기화
    var swiper = new Swiper('.swiper-visual', {
        autoplay: {
            delay: 2000
        },
        loop: true
    });

    // // Swiper 초기화 확인
    // console.log(swiper);
    //
    // // 버튼 클릭 이벤트
    // $('.swiper-button-prev').on('click', function() {
    //     swiper.slidePrev(); // 이전 슬라이드로 이동
    // });
    //
    // $('.swiper-button-next').on('click', function() {
    //     swiper.slideNext(); // 다음 슬라이드로 이동
    // });
});
