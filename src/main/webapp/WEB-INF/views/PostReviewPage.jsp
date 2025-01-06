<%--
  Created by IntelliJ IDEA.
  User: 이윤채
  Date: 2024-12-24
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700&display=swap" rel="stylesheet">
<%--    <script src="/js/home.js"></script>--%>
    <link rel="stylesheet" href="/css/style.css?after"/>
<%--    <link rel="stylesheet" href="/css/mypageStyle.css"/>--%>
    <!-- Google Fonts에서 Noto Sans KR 불러오기 -->


    <script>
        // 별점 상태를 저장하는 변수
        let starRating = 0;
        let review_Image = null; // 업로드할 이미지 파일

        function getQueryParameter(param) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(param);
        }

        // 페이지 로드 시 URL에서 값 읽어오기
        const user_idx = getQueryParameter('user_idx');        // URL에서 user_idx 읽기
        const reservation_idx = getQueryParameter('reservation_idx');  // URL에서 reservation_idx 읽기
        const room_idx = getQueryParameter('room_idx');        // URL에서 room_idx 읽기

        // 이 값들을 사용해서 리뷰 작성 페이지에서 처리
        console.log('User ID:', user_idx);
        console.log('Reservation ID:', reservation_idx);
        console.log('Room ID:', room_idx);

        // 별점 클릭 이벤트 핸들러
        function handleStarClick(rating) {
            starRating = rating;
            renderStars();
        }

        function renderStars() {
            const starContainer = document.getElementById('starContainer');
            starContainer.innerHTML = ''; // 기존 별 초기화

            for (let i = 1; i <= 5; i++) {
                const star = document.createElement('span');
                star.className = 'star';
                star.innerHTML = i <= starRating ? '&#9733;' : '&#9734;'; // 채워진 별(★)과 빈 별(☆)
                star.style.cursor = 'pointer';
                star.style.fontSize = '30px';
                star.style.color = i <= starRating ? '#FFDF86' : 'gray';

                star.onclick = () => handleStarClick(i);

                starContainer.appendChild(star);
            }
        }

        // 페이지 로드 시 별점 초기화
        document.addEventListener('DOMContentLoaded', () => {
            renderStars();
        });

        // 파일 업로드 처리
        // function handleFileSelect(event) {
        //     const file = event.target.files[0];
        //     if (file) {
        //         review_Image = file; // 선택된 파일을 reviewImage 변수에 저장
        //         console.log("Selected file:", file);
        //     }
        // }
        // 파일 업로드 처리 및 미리보기 기능
        function handleFileSelect(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('imagePreview'); // 미리보기 이미지 요소

            if (file) {
                // 선택된 파일 저장
                review_Image = file;
                console.log("Selected file:", file);

                // 미리보기 처리
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result; // 파일 내용을 이미지 소스로 설정
                    preview.style.display = 'block'; // 이미지 표시
                };
                reader.readAsDataURL(file); // 파일 읽기
            } else {
                // 파일이 없을 경우 미리보기 숨김
                preview.style.display = 'none';
            }
        }

        // 리뷰 제출
        function submitReview() {
            const user_comment = document.getElementById('user_comment').value;

            if (starRating === 0 || user_comment.trim() === '') {
                alert('별점과 리뷰 내용을 입력해주세요!');
                return;
            }

            const formData = new FormData();
            formData.append('user_idx', user_idx);
            formData.append('reservation_idx', reservation_idx);
            formData.append('room_idx', room_idx);
            formData.append('review_img_url', review_Image); // 이미지 파일 추가
            formData.append('user_comment', user_comment);
            formData.append('rating', starRating);

            $.ajax({
                url: '<%=request.getContextPath()%>/review',
                type: 'POST',
                processData: false,
                contentType: false,
                data: formData,
                success: function(response) {
                    if (response.status === "success") {
                        alert(response.message);
                        window.location.href = '<%=request.getContextPath()%>/reservation/list';
                    } else {
                        alert(response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert('서버 오류로 인해 리뷰 등록에 실패했습니다.');
                }
            });
        }
    </script>
    <style>
        /* Noto Sans KR 폰트 적용 */
        body {
            font-family: 'Noto Sans KR', sans-serif !important; /* Noto Sans KR 폰트 적용 */
            margin: 0;
            padding: 0;
            background-color: #ffffff;
        }
        .content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            margin: 50px auto;
            max-width: 600px;

        }
        .starContainer {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .star {
            margin: 5px;
        }

        .header-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            width: 100%;
            max-width: 1200px; /* 최대 너비 1200px */
            margin: 0 auto; /* 가운데 정렬 */
            border-top: 1px solid #00000070;
            border-bottom: 1px solid #00000070;
            padding: 20px 0;
            margin-top: 50px;
            margin-bottom: 30px;
        }

        .back-button {
            position: absolute;
            left: 10px;
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
        }

        .header-title {
            font-size: 20px;
            color: #352018;
            font-weight: bold;
        }
        .lodging-info-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;  /* 왼쪽 정렬 */
            justify-content: flex-start;
        }

        .lodging-name {
            font-size: 32px;  /* 폰트 크기 24px 설정 */
            color: #352018;
            font-weight: bold;
            margin: 5px 0;    /* 위아래 간격을 조금 추가 */
        }
        .room-name{
            font-size: 16px;  /* 폰트 크기 24px 설정 */
            color: #352018;
            font-weight: bold;
            margin: 10px 0;    /* 위아래 간격을 조금 추가 */

        }

        .star-rating-container {
            margin-top: 10px;
        }

        #starContainer {
            display: flex;
            justify-content: flex-start;
            margin-top: 5px;
        }

        #user_comment {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            width: 100%;  /* 전체 너비로 설정 */
            max-width: 900px;  /* 최대 너비를 설정 */
            height: 518px;
            resize: none;  /* 크기 조정 불가 */
        }



        /* 업로드 컨테이너 */
        .upload-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px; /* 버튼과 미리보기 사이 간격 */
            margin-right: 370px;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        /* 파일 첨부 버튼 스타일 */
        .custom-file-label {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 250px;
            height: 250px;
            border: 1px solid #ccc;
            border-radius: 20px;
            cursor: pointer;
            background-color: #f9f9f9;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            color: #6b432f;
            text-align: center;
        }

        .custom-file-label:hover {
            background-color: #eaeaea;
        }

        .camera-icon {
            width: 40px;
            height: 40px;
            margin-bottom: 5px;
        }

        /* 사진 미리보기 */
        #imagePreviewContainer {
            /*display: flex;*/
            justify-content: center;
            align-items: center;
            width: 250px;
            height: 250px;
        }

        #imagePreview {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }

        #user_comment {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            width: 900px;
            height: 518px;
        }

        #submitButton {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #352018;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            width: 900px;
            height: 70px;
        }

        #submitButton:hover {
            background-color: #6b432f;
        }
    </style>
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentURI" value="${pageContext.request.requestURI}"/>
<%-------------------------------------------------------------------------------------------------------------------------------%>
<div class="header">
    <div class="size">
        <div class="logo"><a href="/home.do"><img src="/img/logo.svg" width="1398px" height="216.33px"></a></div>
        <div class="login">
            <c:if test="${empty login }">
                <a href="/member/login.do">로그인</a>  |
                <a href="/member/regist.do">회원가입</a>
            </c:if>
            <c:if test="${!empty login }">
                <a href="/member/edit.do">마이페이지</a>
            </c:if>
        </div>
    </div>
</div>


<div class="menu">
    <ul class="depth">
        <li><a href="/home.do" class="${currentURI.endsWith('/WEB-INF/views/home.jsp') ? 'active' : ''}">홈</a></li>
        <li><a href="/search/search.do" class="${currentURI.endsWith('/WEB-INF/views/search/search.jsp') ? 'active' : ''}">구경하개</a></li>
        <li><a href="/gather.do" class="${currentURI.endsWith('/gather.do') ? 'active' : ''}">모여보개</a></li>
        <li><a href="/fun.do" class="${currentURI.endsWith('/fun.do') ? 'active' : ''}">재미나개</a></li>
    </ul>
</div>
<%-------------------------------------------------------------------------------------------------------------------------------%>
<div class="header-bar">
    <button class="back-button" onclick="history.back();">&lt;</button>
    <span class="header-title">리뷰쓰기</span>
</div>

<div class="content">
    <!-- 숙소 이름과 방 이름 표시 -->
<%--    <p>숙소 이름: ${lod_name}</p>--%>
<%--    <p>방 이름: ${room_name}</p>--%>
<%--    <!-- 별점 표시 -->--%>
<%--    <div>--%>
<%--        <label>별점:</label>--%>
<%--        <div id="starContainer" class="star-container"></div>--%>
<%--    </div>--%>
<%--    <div class="lodging-info-container">--%>
<%--        <!-- 숙소 이름과 방 이름 표시 -->--%>
<%--        <p>숙소 이름: ${lod_name}</p>--%>
<%--        <p>방 이름: ${room_name}</p>--%>

<%--        <!-- 별점 표시 -->--%>
<%--        <div class="star-rating-container">--%>
<%--            <div id="starContainer" class="star-container"></div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    &lt;%&ndash;    리뷰텍스트&ndash;%&gt;--%>
<%--    <textarea id="user_comment" placeholder="숙소에 대한 리뷰를 남겨주세요!"></textarea>--%>
    <div class="lodging-info-container">
        <!-- 숙소 이름과 방 이름 표시 -->
        <p class="lodging-name">${lod_name}</p>
        <p class="room-name">${room_name}</p>

        <!-- 별점 표시 -->
        <div class="star-rating-container">
            <div id="starContainer" class="star-container"></div>
        </div>

        <!-- 리뷰 텍스트 영역 -->
        <textarea id="user_comment" placeholder="숙소에 대한 리뷰를 남겨주세요!"></textarea>
    </div>

    <div class="upload-container">
        <!-- 파일 첨부 버튼 -->
        <label for="reviewImageInput" class="custom-file-label">
            <img src="/img/camera-icon.svg" alt="사진 첨부" class="camera-icon">
            <p>사진 첨부하기</p>
        </label>
        <input type="file" id="reviewImageInput" accept="image/*" onchange="handleFileSelect(event)" style="display: none;">

        <!-- 사진 미리보기 -->
        <div id="imagePreviewContainer">
            <img id="imagePreview" style="display: none;" alt="사진 미리보기">
        </div>
    </div>


    <button id="submitButton" onclick="submitReview()">완료</button>
</div>
<%-------------------------------------------------------------------------------------------------------------------------------%>
<div class="footer">
    <div class="size">
        <div class="info">
            <p>이용약관 | 개인정보처리방침 | 고객센터</p><br>
            <p>ⓒ4Team Corp.</p>
        </div>
    </div>
</div>
<%-------------------------------------------------------------------------------------------------------------------------------%>
</body>
</html>