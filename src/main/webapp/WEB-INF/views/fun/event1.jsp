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
            left: 53%;
            transform: translateX(-50%);
        }

        .event1_container {
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

        .event1 img {
            width: 100%;
            max-width: 1280px;
            height: auto;
            margin-bottom: 150px;
        }

        .content1 {
            margin-bottom: 50px;
            position: absolute;
            left: 14%;
            bottom: -70px;
            font-family: "Noto Sans KR";
            font-size: 15px;
            transform: translateY(100px);
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
            margin-right: 240px;
        }

        .back_btn:hover {
            background-color: #8A5642;
        }
    </style>
</head>
<body>
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
            <div class="top-container">
                <img src="/img/event.svg" class="header-img">
                <div class="header-text">너와 함께하개! 미션 스탬프 투어</div>
            </div>
            <div class="back_container">
                <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
            </div>
            <div class="event1_container">
                <div class="event1">
                    <img src="/img/home_thumbnail_visual_1.svg">
                </div>
                <div class="content1">
                    <p>
                        1. 참여 신청기간 : 2025.01.15(수) ~ 2025.02.15(토)<br><br>
                        2. 여행기간 : 2025.02.24 ~ 2025.02.26<br><br>
                        3. 후기 작성 : 여행 다녀온 후 7일 이내<br><br>
                        4. 모집대상 : 같이가개! 사이트를 통해 예약한 모든 숙박 이용객<span style="color: red">✨1박2일 이상 숙박 여행객만 참여가능</span><br><br>
                        5. 참여방법 : 같이가개! 사이트를 통해 숙소를 예약하고 예약 날짜까지 매일 매일 반려견과 함께 찍은 사진을 올리며 스탬프 찍기!<<br><br>
                        6. 이벤트 당첨 안내 : 스탬프를 15개 이상 찍고 여행을 다녀온 후 후기 작성한 이용객들 중에서 무작위 추첨 ▶ 2025.02.28(금) 당첨자 발표
                    </p>
                </div>
            </div>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
