<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <style>
        .total-container-wrapper{
            width: 1200px;
            display: flex;
            justify-content: center;
            flex-direction: column;
            box-sizing: border-box;
            margin: 40px auto;
        }
        .total-container{
            width: 100%;
            display: flex;
            justify-content: center;
            flex-direction: column;
            align-items: center;
            text-align: center;
            margin-top: 20px;
            margin-bottom: 100px;
        }
        .top-container{
            height: 70px;
            width: 100%;
            margin: 10px auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-top: 1px solid #ccc; /* 위쪽 선 */
            border-bottom: 1px solid #ccc; /* 아래쪽 선 */
            padding: 10px 20px; /* 컨테이너 내부 여백 */
            position: relative;
        }
        .top-container .header-text{
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }
        .button-container {
            display: flex;
            margin-top: 150px;
            gap: 25px; /* 버튼 간격 */
        }
        .btn-reservation-list, .btn-home{
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            width: 410px; /* 버튼 크기 설정 */
            height: 77px;
            box-sizing: border-box;
            border-radius: 10px; /* 둥근 모서리 */
            background-color: #352018; /* 배경 색상 */
            color: white; /* 텍스트 색상 */
            font-size: 24px; /* 글씨 크기 설정 */
            font-weight: bold; /* 글씨 굵게 설정 */
            cursor: pointer; /* 클릭 시 포인터 표시 */
            border: none; /* 테두리 제거 */
        }
        .btn-reservation-list img, .btn-home img{
            margin-right: 20px;
            width: 24px;
            height: auto;
        }
        .payment-status{

        }
    </style>
    <title>payment complete</title>
    <link rel="stylesheet" href="/css/style.css"/>
    <script>
        document.addEventListener("DOMContentLoaded", function(){

            // 예약 내역 이동 기능 추가
            document.getElementById("btn-reservation-list").addEventListener("click", function (){
                var loginInfo = '${sessionScope.usersession}';
                if(loginInfo){
                    window.location.href = '/reservation/list/redirect';
                }else{
                    window.location.href = '/userlogin';
                }
            });

            // 홈 이동 기능 추가
            document.getElementById("btn-home").addEventListener("click", function (){
                window.location.href='/home.do';
            });
        });

    </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="total-container-wrapper">
    <div class="top-container">
        <div class="header-text">예약하기</div>
    </div>
    <div class="total-container">
        <img class="payment-image" src="/img/logo_no_text.svg" alt="결제 완료 이미지">
        <div class="payment-status">
            <p style="font-size: 24px; font-weight: bold;">결제 완료</p>
            <p style="font-size: 16px;">결제가 정상적으로 처리되었습니다.</p>
            <p style="font-size: 16px;">예약 내역은 마이페이지 > 예약내역에서 확인하실 수 있습니다.</p>
        </div>
        <div class="button-container">
            <button class="btn-reservation-list" id="btn-reservation-list">
                <img src="/img/button_foot.svg" alt="payment_foot_icon">
                예약내역
            </button>
            <button class="btn-home" id="btn-home">
                <img src="/img/button_foot.svg" alt="payment_foot_icon">
                홈으로 가기
            </button>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
