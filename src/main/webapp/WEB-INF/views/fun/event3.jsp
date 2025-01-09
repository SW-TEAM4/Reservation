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
            margin-bottom: 2px;
        }

        .top-container{
            height: 70px;
            width: 1280px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: row;
            padding: 10px 20px; /* 컨테이너 내부 여백 */
        }

        .top-container .header-img {
            position: absolute;
            left: 41%;
            transform: translateX(-50%);
        }

        .top-container .header-text{
            font-size: 20px;
            font-weight: bold;
            position: absolute;
            left: 54%;
            transform: translateX(-50%);
        }

        .event3_container {
            display: flex;
            flex-direction: column;
            justify-content: center;  /* 수직 중앙 정렬 */
            align-items: center;      /* 수평 중앙 정렬 */
            height: 80vh;            /* 화면 전체 높이 */
            padding: 0;
            text-align: left;         /* 텍스트 왼쪽 정렬 */
            width: 100%;
            position: relative;
            margin-bottom: 200px;
        }

        .event3 img {
            width: 100%;
            max-width: 1500px;
            height: 469.74px;
            margin-bottom: 150px;
        }

        .content3 {
            margin-bottom: 50px;
            position: absolute;
            left: 23%;
            bottom: -170px;
            max-width: 980px;
            font-family: "Noto Sans KR";
            font-size: 15px;
            padding: 20px;
        }

        .back_container {
            display: flex;
            justify-content: right;
            margin-top: 30px;
        }

        .back_btn {
            padding: 10px 20px;
            background-color: #352018;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            margin-right: 410px;
        }

        .back_btn:hover {
            background-color: #8A5642;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="top-container">
            <img src="/img/home_btn_bazaar.svg" class="header-img">
            <div class="header-text">누가 더 잘 어울리개, 내가 싸게 줄개</div>
        </div>
        <div class="back_container">
            <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
        </div>
        <div class="event3_container">
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
