<%--
  파일명 : roomRegister.jsp
  생성자 : JDeok
  날 짜  : 2024.12.24
  시 간  : 오전 10:01
  기 능  : 사장님 상세 페이지
  변경사항
     - 2024.12.24 : JDeok(최초작성)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실 정보 등록</title>
    <link rel="stylesheet" href="/css/sellerHeader.css">                                                 <!-- CSS 파일 연결(header) -->
    <link rel="stylesheet" href="/css/RoomRegister.css">                                                 <!-- 사장님 상세페이지 CSS  -->
    <link rel="stylesheet" href="/css/sellerSiderbar.css">                                               <!-- Siderbar CSS        -->
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">   <!-- 폰트                 -->
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<div class="layout">
    <%-- 왼쪽 사이드바 포함 --%>
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %>

    <!-- 오른쪽 콘텐츠 -->
    <main class="content">
        <h1>객실 정보 등록</h1>
        <p class="sub-title">숙소의 객실 정보를 등록해주세요.</p>

        <form action="/lodgment/insertRoom.do" method="post" enctype="multipart/form-data">
            <table class="room-table">
                <thead>
                <tr>
                    <th>객실명</th>
                    <th>가격</th>
                    <th>최대 인원</th>
                    <th>최대 반려동물 수</th>
                    <th>객실 기본정보</th>
                    <th>반려동물 사이즈</th>
                    <th>객실 사진</th>
                </tr>
                </thead>
                <tbody id="roomTableBody">
                <tr>
                    <td><input type="text" name="rooms[0].room_name" placeholder="객실명" class="small-input"></td>
                    <td>
                        <input
                                type="text"
                                name="rooms[0].room_price"
                                placeholder="가격"
                                required
                                class="small-input room-price-input"
                                id="roomPrice"
                        >
                    </td>


                    <td><input type="number" name="rooms[0].max_people_cnt" placeholder="최대 인원" class="extra-small-input"></td>
                    <td><input type="number" name="rooms[0].max_pet_cnt" placeholder="최대 반려동물 수" class="extra-small-input"></td>
                    <td>
                        <textarea name="rooms[0].room_notice" placeholder="객실 기본정보를 입력하세요" class="textarea-input"></textarea>
                    </td>
                    <td>
                        <label><input type="radio" name="rooms[0].max_pets_weight" value="2"> 10kg 초과</label>
                        <label><input type="radio" name="rooms[0].max_pets_weight" value="1"> 5kg 이상 ~ 10kg 이하</label>
                        <label><input type="radio" name="rooms[0].max_pets_weight" value="0"> 5kg 미만</label>
                    </td>
                    <td>
                        <input type="file" name="rooms[0].room_photos" class="input-file" accept="image/*" multiple>
                        <button type="button" class="delete-photo">삭제</button>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="actions">
                <button type="button" id="addRoomButton" class="btn">객실 정보 추가</button>
                <button type="submit" class="btn submit">객실 정보 등록하기</button>
            </div>
        </form>
    </main>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const priceInput = document.getElementById('roomPrice');

        priceInput.addEventListener('input', (event) => {
            // 숫자가 아닌 문자를 제거
            let value = priceInput.value.replace(/[^0-9]/g, '');

            // 쉼표를 추가하는 형식
            if (value !== '') {
                value = parseInt(value, 10).toLocaleString('ko-KR');
            }

            // 필드에 형식화된 값 반영
            priceInput.value = value;
        });

        const activeMenu = document.querySelector(".active");
        if (activeMenu) {
            activeMenu.style.fontWeight = "bold";
        }
    });
</script>
<script src="/js/roomRegister.js"></script>
</body>
</html>
