/*
    파일명 : roomRegister.js
    생성자 : JDeok
    날 짜  : 2024.12.24
    시 간  : 오전 10:01
    기 능  : 사장님 상세 페이지
    변경사항
    - 2024.12.24 : JDeok(최초작성)
*/
document.addEventListener('DOMContentLoaded', function () {
    const roomTableBody = document.getElementById('roomTableBody');
    const addRoomButton = document.getElementById('addRoomButton');
    const form = document.querySelector('form');
    const success = "${success}" === "true"; // JSP에서 모델 속성 읽기
    /*const errorMessage = "${fn:escapeXml(errorMessage)}"; // 오류 메시지 처리 (Null-safe)*/

    if (success) {
        alert("정상적으로 처리됐습니다.");
        window.location.href = "/lodgment/sellerDetailMain.do";
    }
    /*else if (errorMessage) {
        alert(errorMessage);
    }*/
    // 페이지 로드 시 초기 필드에 포맷터 연결
    document.querySelectorAll('.room-price-input').forEach(input => attachPriceFormatter(input));

    // 객실 정보 추가 버튼 클릭
    addRoomButton.addEventListener('click', function () {
        addRoomRow();
    });

    // 행 삭제 및 재정렬
    roomTableBody.addEventListener('click', function (e) {
        if (e.target.classList.contains('delete-photo')) {
            const row = e.target.parentElement.parentElement;
            roomTableBody.removeChild(row);
            updateRowIndexes();
        }
    });

    // 폼 제출 시 쉼표 제거
    form.addEventListener('submit', function () {
        document.querySelectorAll('.room-price-input').forEach(input => {
            input.value = input.value.replace(/,/g, ''); // 쉼표 제거
        });
    });

    // 객실 행 추가 함수
    function addRoomRow() {
        const newRow = document.createElement('tr');
        const rowIndex = roomTableBody.querySelectorAll('tr').length;

        newRow.innerHTML = `
            <td><input type="text" name="rooms[${rowIndex}].room_name" placeholder="객실명" class="small-input"></td>
            <td>
                <input
                    type="text"
                    name="rooms[${rowIndex}].room_price"
                    placeholder="가격"
                    required
                    class="small-input room-price-input"
                >
            </td>
            <td><input type="number" name="rooms[${rowIndex}].max_people_cnt" placeholder="최대 인원" class="extra-small-input"></td>
            <td><input type="number" name="rooms[${rowIndex}].max_pet_cnt" placeholder="최대 반려동물 수" class="extra-small-input"></td>
            <td>
                <textarea name="rooms[${rowIndex}].room_notice" placeholder="객실 기본정보를 입력하세요" class="textarea-input"></textarea>
            </td>
            <td>
                <label><input type="checkbox" name="rooms[${rowIndex}].max_pet_weight" value="2"> 10kg 초과</label>
                <label><input type="checkbox" name="rooms[${rowIndex}].max_pet_weight" value="1"> 5kg 이상 ~ 10kg 이하</label>
                <label><input type="checkbox" name="rooms[${rowIndex}].max_pet_weight" value="0"> 5kg 미만</label>
            </td>
            <td>
                <input type="file" name="rooms[${rowIndex}].room_photos" class="input-file" accept="image/*" multiple>
            </td>
            <td>
                <button type="button" class="delete-photo">삭제</button>
            </td>
        `;
        roomTableBody.appendChild(newRow);
        attachPriceFormatter(newRow.querySelector('.room-price-input'));
    }

    // 모든 행의 인덱스 업데이트
    function updateRowIndexes() {
        const rows = roomTableBody.querySelectorAll('tr');
        rows.forEach((row, index) => {
            const inputs = row.querySelectorAll('input, textarea');
            inputs.forEach(input => {
                const name = input.name.replace(/\[.*?\]/, `[${index}]`); // 인덱스 업데이트
                input.setAttribute('name', name);
            });
        });
    }

    // 숫자 입력 포맷터 연결
    function attachPriceFormatter(inputElement) {
        inputElement.addEventListener('input', function () {
            let value = inputElement.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자 제거
            if (value !== '') {
                value = Number(value).toLocaleString(); // 쉼표 추가
            }
            inputElement.value = value;
        });

        // 포커스 상태에서 쉼표 제거
        inputElement.addEventListener('focus', function () {
            inputElement.value = inputElement.value.replace(/,/g, ''); // 쉼표 제거
        });

        // 블러 상태에서 쉼표 추가
        inputElement.addEventListener('blur', function () {
            let value = inputElement.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자 제거
            if (value !== '') {
                value = Number(value).toLocaleString(); // 쉼표 추가
            }
            inputElement.value = value;
        });
    }

    // 기존 행들에 포맷터 연결
    document.querySelectorAll('.room-price-input').forEach(input => attachPriceFormatter(input));

});

