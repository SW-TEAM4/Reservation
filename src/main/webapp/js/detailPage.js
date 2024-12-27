/*
    파일명 : detailPage.js
    생성자 : JDeok
    날 짜  : 2024.12.24
    시 간  : 오전 10:08
    기 능  : 숙소등록 페이지 -> 시설/서비스 관련 JavaScript
    변경사항
     - 2024.12.23 : JDeok(최초작성)
*/
document.addEventListener('DOMContentLoaded', function () {
    const roomTableBody = document.getElementById('roomTableBody');
    const addRoomButton = document.getElementById('addRoomButton');

    // 객실 정보 추가
    addRoomButton.addEventListener('click', function () {
        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td><input type="text" name="roomName" placeholder="객실명"></td>
            <td><input type="number" name="roomPrice" placeholder="가격"></td>
            <td><input type="number" name="maxPeople" placeholder="최대 인원"></td>
            <td><input type="number" name="maxDogs" placeholder="최대 애견 수"></td>
            <td>
                <label><input type="checkbox" name="dogSize10kg"> 10kg 초과</label>
                <label><input type="checkbox" name="dogSize5to10kg"> 5kg 이상 ~ 10kg 이하</label>
                <label><input type="checkbox" name="dogSize5kg"> 5kg 미만</label>
            </td>
            <td>
                <input type="file" name="roomPhoto" accept="image/*">
                <button type="button" class="delete-photo">삭제</button>
            </td>
        `;
        roomTableBody.appendChild(newRow);

        // 사진 삭제 버튼 이벤트 추가
        newRow.querySelector('.delete-photo').addEventListener('click', function () {
            this.parentElement.parentElement.remove();
        });
    });

    // 초기 삭제 버튼 이벤트 추가
    roomTableBody.addEventListener('click', function (e) {
        if (e.target.classList.contains('delete-photo')) {
            e.target.parentElement.parentElement.remove();
        }
    });
});
