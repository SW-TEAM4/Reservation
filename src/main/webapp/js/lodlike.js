$(document).ready(function () {
    $(".heart-icon").on("click", function (event) {
        event.stopPropagation(); // 부모 클릭 이벤트 방지

        const lodIdx = $(this).data("lod-idx"); // 숙소 ID
        const userIdx = $("#user-id").val(); // 숨겨진 필드에서 user-id 값 가져오기
        const likeIcon = $(this); // 클릭된 하트 아이콘
        console.log("User IDX from hidden input:", userIdx); // 디버깅용 로그

        // 로그인 여부 확인
        if (!userIdx || userIdx.trim() === "") {
            alert("로그인이 필요합니다.");
            window.location.href = "/userlogin";
            return;
        }

        // AJAX 요청: 찜 상태 토글
        $.ajax({
            url: "/lodlike/toggle",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                lod_idx: lodIdx,
                user_idx: userIdx
            }),
            success: function (response) {
                if (response.status === "added") { // 찜 추가 성공
                    likeIcon.addClass("active");
                    likeIcon.text("❤️"); // 빨간 하트로 변경
                    alert("찜 목록에 추가되었습니다.");
                } else if (response.status === "removed") { // 찜 제거 성공
                    likeIcon.removeClass("active");
                    likeIcon.text("🤍"); // 빈 하트로 변경
                    alert("찜 목록에서 제거되었습니다.");
                }
            },
            error: function () {
                alert("요청 처리 중 오류가 발생했습니다.");
            }
        });
    });
});
