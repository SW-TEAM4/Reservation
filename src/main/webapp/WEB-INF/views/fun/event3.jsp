<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2025-01-07
  Time: 오전 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
    <title>너와 함께하개! 미션 스탬프 투어</title>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <style>
        * {
            margin-bottom: 3px;
        }

        .top-container{
            height: 70px;
            width: 100%;
            padding: 5px; /* 컨테이너 내부 여백 */
            position: relative;
            margin: 20px 0 20px 0;
        }

        .top-container .center {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .top-container .header-img {
            width: auto;
            height: 50px;
        }

        .top-container .header-text{
            font-size: 20px;
            font-weight: bold;
        }

        .event3_container {
            padding: 20px;
            margin: 0 auto;
            max-width: 1280px;
        }

        .event3 img {
            width: 100%;
            max-width: 1280px;
            height: auto;
        }

        .content3 {
            font-family: "Noto Sans KR";
            font-size: 15px;
            text-align: left;
            width: 100%;
            max-width: 1280px;
            margin: 25px 0 20px 25px;
        }

        .back_btn {
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            padding: 10px 20px;
            background-color: #352018;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            margin-left: auto;
        }

        .back_btn:hover {
            background-color: #8A5642;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="event3_container">
            <div class="top-container">
                <div class="center">
                    <img src="/img/home_btn_bazaar.svg" class="header-img">
                    <div class="header-text">누가 더 잘 어울리개, 내가 싸게 줄개</div>
                </div>
                <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
            </div>
            <div class="event3">
                <img src="/img/home_visual3.svg">
            </div>
            <div class="content3">
                <p>
                    1. 참여 신청기간 : 2025.01.01(금) 09:00 ~ 2025.02.28(금) 18:00<br><br>
                    2. 바자회 날짜 : 2025.03.15(토) 09:00 ~ 18:00<br><br>
                    3. 모집 대상 : 반려동물과 함께 바자회 물품을 나눔을 원하는 반려인♥<br><br>
                    4. 바자회 지원 물품 : 반려동물과 관련된 반려 동물 아이템 혹은 반려인들끼리 나눌 수 있는 생활용품<br><br>
                    5. 바자회 금지 물품 : 정상적으로 거래가 되지 않을 물품, 반려동물 또는 반련인들에게 위협이 되는 물품 소지 금지<br><br>
                    6. 바자회 수익금 이용 안내 ▶ 수익금 발생 시 종합 유기견 보호 센터 전액 기부<br><br>
                    7. 주의사항 : 입마개가 필요한 견종은 반련인들께서 입마개 직접 필참
                </p>
            </div>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
