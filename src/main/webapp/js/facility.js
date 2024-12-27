// '추가' 버튼 클릭 이벤트 리스너 추가
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('addFacilityBtn').addEventListener('click', function () {
        console.log('추가 버튼 클릭'); // 디버깅용 로그

        // 시설/서비스 입력 필드의 값 가져오기
        const facilityText = document.getElementById('facilityText').value.trim();

        if (facilityText === '') {
            alert('시설/서비스를 입력해주세요.');
            return;
        }

        // 이미 추가된 시설/서비스 목록 가져오기
        const existingFacilities = Array.from(document.querySelectorAll('.facility-tag')).map(tag =>
            tag.getAttribute('data-value') // data-value 속성 값 가져오기
        );

        if (existingFacilities.includes(facilityText)) {
            alert('이미 추가된 시설/서비스입니다.');
            return;
        }

        // 새 시설/서비스 태그 생성
        const newTag = document.createElement('span');
        newTag.className = 'facility-tag';
        newTag.setAttribute('data-value', facilityText);
        newTag.innerHTML = `${facilityText} <button class="remove-btn" onclick="removeFacility(this)">×</button>`;

        // 시설/서비스 태그를 선택된 시설 목록에 추가
        document.querySelector('.selected-facilities').appendChild(newTag);
        console.log('시설 추가 완료:', facilityText); // 디버깅용 로그

        // Hidden input 추가
        addHiddenInput(facilityText);

        // 입력 필드 초기화
        document.getElementById('facilityText').value = '';
    });

    // Hidden input 추가 함수
    function addHiddenInput(value) {
        console.log('Hidden input 추가:', value); // 디버깅용 로그

        const hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.name = 'lod_facility'; // 배열 형태로 전송
        hiddenInput.value = value;
        document.getElementById('hidden-fields').appendChild(hiddenInput);
    }

    // 삭제 버튼 클릭 시 호출되는 함수
    window.removeFacility = function (button) {
        const tag = button.parentElement;

        // 삭제된 시설/서비스의 data-value 값 가져오기
        const value = tag.getAttribute('data-value');

        // 해당 hidden input 제거
        removeHiddenInput(value);

        // 삭제 버튼의 부모 요소(<span>)를 DOM에서 제거
        tag.remove();
    };

    // Hidden input 제거 함수
    function removeHiddenInput(value) {
        console.log('Hidden input 제거:', value); // 디버깅용 로그

        const hiddenInputs = document.querySelectorAll('input[name="lod_facility' +
            '"]');
        hiddenInputs.forEach(input => {
            if (input.value === value) {
                input.remove();
            }
        });
    }
});
