<%--
  파일명 : sellerRoomUpdate.jsp
  생성자 : JDeok
  날 짜  : 2025.01.07
  시 간  : 오후 04:22
  기 능  : 사장님 객실 수정
  변경사항
     - 2025.01.07 : JDeok(기능 추가 및 수정)
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실 정보 수정</title>
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link rel="stylesheet" href="/css/RoomRegister.css">
    <link rel="stylesheet" href="/css/sellerSiderbar.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<div class="layout">
    <%-- 왼쪽 사이드바 포함 --%>
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %>

    <!-- 오른쪽 콘텐츠 -->
    <main class="content">
        <h1>객실 정보 수정</h1>
        <p class="sub-title">수정하려는 객실 정보를 변경하세요.</p>

        <form action="/lodgment/updateRoom.do" method="post" enctype="multipart/form-data">
            <table class="room-table">
                <thead>
                <tr>
                    <th>객실명</th>
                    <th>가격</th>
                    <th>최대 인원</th>
                    <th>최대 반려동물 수</th>
                    <th>객실 기본정보</th>
                    <th>반려동물 사이즈</th>
                    <%--<th>삭제</th>--%>
                </tr>
                </thead>
                <tbody id="roomTableBody">
                <c:forEach var="room" items="${roomList}">
                    <tr>
                        <td>
                            <input type="hidden" name="rooms[${room.room_idx}].room_idx" value="${room.room_idx}">
                            <input type="text" name="rooms[${room.room_idx}].room_name"
                                   value="${room.room_name}" placeholder="객실명" class="small-input">
                        </td>
                        <td>
                            <input type="text" name="rooms[${room.room_idx}].room_price"
                                   value="${room.room_price}" placeholder="가격" class="small-input room-price-input" id="price">
                        </td>
                        <td>
                            <input type="number" name="rooms[${room.room_idx}].max_people_cnt"
                                   value="${room.max_people_cnt}" placeholder="최대 인원" class="extra-small-input">
                        </td>
                        <td>
                            <input type="number" name="rooms[${room.room_idx}].max_pet_cnt"
                                   value="${room.max_pet_cnt}" placeholder="최대 반려동물 수" class="extra-small-input">
                        </td>
                        <td>
                            <textarea name="rooms[${room.room_idx}].room_notice"
                                      placeholder="객실 기본정보" class="textarea-input">${room.room_notice}</textarea>
                        </td>
                        <td>
                            <label>
                                <input type="radio" name="rooms[${room.room_idx}].max_pets_weight" value="2"
                                    ${room.max_pets_weight == 2 ? 'checked' : ''}> 10kg 초과
                            </label>
                            <label>
                                <input type="radio" name="rooms[${room.room_idx}].max_pets_weight" value="1"
                                    ${room.max_pets_weight == 1 ? 'checked' : ''}> 5kg 이상 ~ 10kg 이하
                            </label>
                            <label>
                                <input type="radio" name="rooms[${room.room_idx}].max_pets_weight" value="0"
                                    ${room.max_pets_weight == 0 ? 'checked' : ''}> 5kg 미만
                            </label>
                        </td>
                       <%-- <td>
                            <button type="button" class="delete-room-btn" onclick="deleteRoomRow(this)">삭제</button>
                        </td>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="actions">
                <%--<button type="button" id="addRoomButton" class="btn">객실 추가</button>--%>
                <button type="submit" class="btn submit">수정 내용 저장</button>
            </div>
        </form>
    </main>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const inputs = document.querySelectorAll('.room-price-input');
        console.log('Inputs found:', inputs); // 입력 필드 확인

        inputs.forEach(input => {
            console.log('Adding listener to:', input); // 각 필드에 리스너 적용 확인
            let paidMoney = input.value;
            paidMoney = paidMoney.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            input.value = paidMoney;

            input.addEventListener('focus', () => {
                // 포커스 시 쉼표 제거
                input.value = input.value.replace(/,/g, '');
            });

            input.addEventListener('blur', () => {
                // 포커스를 잃으면 쉼표 다시 추가
                let value = input.value.replace(/[^0-9]/g, '');
                if (value !== '') {
                    input.value = parseInt(value, 10).toLocaleString('ko-KR');
                }
            });
        });


      /*  let newRoomiIndex = 0;
        // 객실 추가 버튼 기능
        document.getElementById('addRoomButton').addEventListener('click', () => {
            const roomTableBody = document.getElementById('roomTableBody');
            const newRow = document.createElement('tr');
            const rowIndex = roomTableBody.querySelectorAll('tr').length;

            newRow.innerHTML = `
                <input type="hidden" name="rooms[\${newRoomiIndex}].room_idx" value="\${newRoomiIndex}">
                <td><input type="text" name="rooms[\${newRoomiIndex}].room_name" placeholder="객실명" class="small-input"></td>
                <td><input type="text" name="rooms[\${newRoomiIndex}].room_price" placeholder="가격" class="small-input room-price-input"></td>
                <td><input type="number" name="rooms[\${newRoomiIndex}].max_people_cnt" placeholder="최대 인원" class="extra-small-input"></td>
                <td><input type="number" name="rooms[\${newRoomiIndex}].max_pet_cnt" placeholder="최대 반려동물 수" class="extra-small-input"></td>
                <td><textarea name="rooms[\${newRoomiIndex}].room_notice" placeholder="객실 기본정보" class="textarea-input"></textarea></td>
                <td>
                    <label><input type="radio" name="rooms[\${newRoomiIndex}].max_pets_weight" value="2"> 10kg 초과</label>
                    <label><input type="radio" name="rooms[\${newRoomiIndex}].max_pets_weight" value="1"> 5kg 이상 ~ 10kg 이하</label>
                    <label><input type="radio" name="rooms[\${newRoomiIndex}].max_pets_weight" value="0"> 5kg 미만</label>
                </td>
                <td><button type="button" class="delete-room-btn" onclick="deleteRoomRow(this)">삭제</button></td>
            `;
            roomTableBody.appendChild(newRow);
            newRoomiIndex--;
        });
*/
        // 객실 행 삭제 기능
        window.deleteRoomRow = function (button) {
            const row = button.closest('tr');
            row.remove();
        };

        // 활성화된 메뉴 스타일링
        const activeMenu = document.querySelector(".active");
        if (activeMenu) {
            activeMenu.style.fontWeight = "bold";
        }
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // JSP 데이터를 JavaScript 변수로 전달
        const success = ${success ? 'true' : 'false'}; // JSP에서 success 값을 Boolean으로 처리
        const errorMessage = "${fn:escapeXml(errorMessage)}"; // JSP의 errorMessage 값 처리 (Null-safe)

        if (success === true) {
            alert("정상적으로 처리됐습니다.");
            window.location.href = "/lodgment/sellerDetailMain.do";
        } else if (errorMessage) {
            alert(errorMessage);
            window.location.href = "/lodgment/sellerDetailMain.do";
        }
    });
</script>
</body>
</html>
