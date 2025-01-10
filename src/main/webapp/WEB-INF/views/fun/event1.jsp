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
            padding: 5px 20px; /* 컨테이너 내부 여백 */
            position: relative;
            margin: 20px 0 20px 0;
        }

        .top-container .center {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
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

        .event1_container {
            padding: 20px;
            margin: 0 auto;
            max-width: 1280px;
        }

        .event1 img {
            width: 100%;
            max-width: 1280px;
            height: auto;
        }

        .content1 {
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
            right: 20px;
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
            <div class="event1_container">
                <div class="top-container">
                    <div class="center">
                        <img src="/img/event.svg" class="header-img">
                        <div class="header-text">너와 함께하개! 미션 스탬프 투어</div>
                    </div>
                    <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
                </div>
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
