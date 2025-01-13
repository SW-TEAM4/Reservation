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
            margin-left: 20px;
        }

        .event1_container {
            padding: 20px;
            margin: 0 auto;
            max-width: 1280px;
            text-align: center;
        }

        .event1 img {
            width: 100%;
            max-width: 900px;
            height: auto;
            margin: 0 auto;
        }

        .content1 {
            font-family: "Noto Sans KR";
            font-size: 15px;
            text-align: left;
            width: 100%;
            max-width: 900px;
            margin: 25px auto;
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
            <div class="event1_container">
                <div class="top-container">
                    <div class="center">
                        <img src="/img/event.svg" class="header-img">
                        <div class="header-text">🐾 너와 함께하개! 미션 스탬프 투어 이벤트 🐾</div>
                    </div>
                    <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
                </div>
                <div style="width: 1240px; height: 1px; background-color: #DBD6D6; margin-bottom: 30px;"></div>
                <div class="event1">
                    <img src="/img/home_visual1.svg">
                </div>
                <div class="content1">
                    <p>
                        🐾 너와 함께하개! 미션 스탬프 투어 이벤트 🐾<br><br>
                        반려견과 함께 특별한 추억을 쌓을 절호의 기회! 같이가개!에서 준비한 미션 스탬프 투어 이벤트에 참여하고 푸짐한 혜택을 받아보세요!<br>
                        여행도 즐기고, 미션도 클리어하며 추억을 기록하세요.<br>
                        무작위 추첨을 통해 특별한 선물도 기다리고 있습니다! 🎁<br><br>

                        <b>이벤트 상세 안내</b><br>
                        📅 <b>참여 신청 기간</b><br>
                        2025년 1월 15일(수) ~ 2025년 2월 15일(토)<br><br>

                        🗺️ <b>여행 기간</b><br>
                        2025년 2월 21일(금) ~ 2025년 2월 23일(일)<br><br>

                        📝 <b>후기 작성</b><br>
                        여행을 다녀오신 후 7일 이내에 후기를 남겨주세요.<br><br>

                        <b>모집 대상</b><br>
                        ✨ 같이가개! 사이트를 통해 숙소를 예약한 모든 이용객<br>
                        <span style="color: red">⚡ 1박 2일 이상 숙박 여행객만 참여 가능</span><br><br>

                        <b>참여 방법</b><br>
                        같이가개! 사이트를 통해 숙소를 예약해주세요.<br>
                        여행 기간 동안 반려견과 함께한 사진을 매일매일 올리며 스탬프를 찍으세요!<br>
                        여행을 마치고 7일 이내에 후기까지 작성하면 참여 완료!<br><br>

                        <b>이벤트 당첨 안내</b><br>
                        📌 스탬프 15개 이상 찍고 여행 후 후기를 작성한 이용객 중<br>
                        무작위로 추첨하여 특별한 선물을 드립니다! 🎉<br>
                        ✔️ 발표일: 2025년 2월 28일(금)<br><br>

                        반려견과 함께 행복한 순간을 남기고, 이벤트 참여로 특별한 혜택도 받아보세요!<br>
                        지금 바로 참여 신청하고 멋진 추억을 만들어보세요! 🐶💕
                    </p>
                </div>
            </div>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
