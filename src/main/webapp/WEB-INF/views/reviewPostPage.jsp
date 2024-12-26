<%--
  Created by IntelliJ IDEA.
  User: 이윤채
  Date: 2024-12-24
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 별점 상태를 저장하는 변수
        let starRating = 0;
        let reviewImage = null; // 업로드할 이미지 파일

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
            starRating = rating; // 별점 상태 업데이트
            renderStars(); // 별점 UI 업데이트
        }

        // 별점 UI를 렌더링
        function renderStars() {
            const starContainer = document.getElementById('starContainer');
            starContainer.innerHTML = ''; // 기존 별 초기화

            for (let i = 1; i <= 5; i++) {
                const star = document.createElement('span');
                star.className = 'star';
                star.innerHTML = i <= starRating ? '&#9733;' : '&#9734;'; // 채워진 별(★)과 빈 별(☆)
                star.style.cursor = 'pointer';
                star.style.fontSize = '30px';
                star.style.color = i <= starRating ? 'yellow' : 'gray';

                // 별 클릭 이벤트 연결
                star.onclick = () => handleStarClick(i);

                starContainer.appendChild(star);
            }
        }

        // 페이지 로드 시 별점 초기화
        document.addEventListener('DOMContentLoaded', () => {
            renderStars();
        });

        // 파일 업로드 처리
        function handleFileSelect(event) {
            const file = event.target.files[0];
            if (file) {
                reviewImage = file; // 선택된 파일을 reviewImage 변수에 저장
                console.log("Selected file:", file);
            }
        }

        // 리뷰 제출
        function submitReview() {
            const reviewText = document.getElementById('reviewText').value;

            if (starRating === 0 || reviewText.trim() === '') {
                alert('별점과 리뷰 내용을 입력해주세요!');
                return;
            }

            const formData = new FormData();
            formData.append('user_idx', user_idx);
            formData.append('reservation_idx', reservation_idx);
            formData.append('room_idx', room_idx);
            formData.append('review_img_url', reviewImage); // 이미지 파일 추가
            formData.append('user_comment', reviewText);
            formData.append('rating', starRating);

            $.ajax({
                url: '<%=request.getContextPath()%>/review',
                type: 'POST',
                data: formData,
                processData: false, // 파일을 전송할 때는 false로 설정해야 함
                contentType: false, // 파일 전송시 Content-Type을 자동으로 설정하지 않도록 함
                success: function(response) {
                    if (response === 1) {
                        alert('리뷰가 등록되었습니다.');
                        location.reload();
                    } else {
                        alert('리뷰 등록에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('서버 오류로 인해 리뷰 등록에 실패했습니다.');
                }
            });
        }
    </script>
    <style>
        .star {
            margin: 5px;
        }

        #reviewText {
            width: 100%;
            height: 100px;
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        #submitButton {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #5c67f2;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        #submitButton:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<h1>리뷰 작성</h1>
<div>
    <label>별점:</label>
    <div id="starContainer"></div>
</div>
<div>
    <textarea id="reviewText" placeholder="리뷰를 입력하세요"></textarea>
</div>
<div>
    <label for="fileInput">사진 첨부:</label>
    <input type="file" id="fileInput" accept="image/*" onchange="handleFileSelect(event)">
</div>
<button id="submitButton" onclick="submitReview()">리뷰 등록</button>
</body>
</html>