/*
    파일명 : timeStep.js
    생성자 : JDeok
    날 짜  : 2024.12.23
    시 간  : 오후 07:25
    기 능  : 숙소등록페이지 -> 체크인/체크아웃 시간 입력을 10분 단위로 제한
    변경사항
     - 2024.12.23 : JDeok(최초작성)
*/

document.addEventListener('DOMContentLoaded', function () {
    // 시간 데이터를 숨겨진 필드에 저장하는 함수
    function updateHiddenFields() {
        // 체크인 시간 조합
        const checkinAmPm = document.getElementById('checkinAmPm').value || "AM";
        var   checkinHour = document.getElementById('checkinHour').value || "08";
        var   checkinMinute = document.getElementById('checkinMinute').value || "00";

        if(checkinAmPm == "PM") {
            checkinHour = parseInt(checkinHour, 10) + 12;
        }

        const checkinTime = `${checkinHour}:${checkinMinute}:00`;

        // 체크아웃 시간 조합
        const checkoutAmPm = document.getElementById('checkoutAmPm').value || "PM";
        var   checkoutHour = document.getElementById('checkoutHour').value || "10";
        var   checkoutMinute = document.getElementById('checkoutMinute').value || "00";

        if(checkoutAmPm == "PM") {
            checkoutHour = parseInt(checkoutHour, 10) + 12;
        }
        const checkoutTime = `${checkoutHour}:${checkoutMinute}:00`;

        // 숨겨진 필드에 값 저장
        document.getElementById('checkinTime').value = checkinTime;
        document.getElementById('checkoutTime').value = checkoutTime;

        // 디버깅용 콘솔 출력
        console.log('Check-in Time:', checkinTime);
        console.log('Check-out Time:', checkoutTime);
    }

    // 체크인/체크아웃 시간이 10분 단위로 입력되도록 반올림
    function enforceStep(value) {
        // 분 값을 10분 단위로 반올림
        const roundedMinutes = Math.round(value / 10) * 10;
        return String(roundedMinutes).padStart(2, '0'); // 2자리 형식으로 반환
    }

    // 이벤트 리스너 추가 (변경 시 숨겨진 필드 업데이트)
    document.querySelectorAll('#checkinAmPm, #checkinHour, #checkinMinute, #checkoutAmPm, #checkoutHour, #checkoutMinute')
        .forEach(select => {
            select.addEventListener('change', function () {
                if (this.id.includes("Minute")) {
                    this.value = enforceStep(Number(this.value)); // 10분 단위로 반올림 적용
                }
                updateHiddenFields(); // 숨겨진 필드 업데이트
            });
        });

    // 페이지 로드 시 초기값 설정 (선택된 값이 없을 경우만 기본값 설정)
    if (!document.getElementById('checkinTime').value || !document.getElementById('checkoutTime').value) {
        document.getElementById('checkinAmPm').value = "AM";
        document.getElementById('checkinHour').value = "08";
        document.getElementById('checkinMinute').value = "00";
        document.getElementById('checkoutAmPm').value = "PM";
        document.getElementById('checkoutHour').value = "10";
        document.getElementById('checkoutMinute').value = "00";
        updateHiddenFields();
    }
});
