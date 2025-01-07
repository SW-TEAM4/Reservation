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

        .event1_container h2 {
            margin-bottom: 30px;
        }

        .event1_container {
            display: flex;
            flex-direction: column;
            justify-content: center;  /* 수직 중앙 정렬 */
            align-items: center;      /* 수평 중앙 정렬 */
            height: 100vh;            /* 화면 전체 높이 */
            padding: 0;
            text-align: left;         /* 텍스트 왼쪽 정렬 */
            width: 100%;
            position: relative;
            bottom: 130px;
        }

        .event1 img {
            width: 100%;
            max-width: 980px;
            height: auto;
            margin-bottom: 150px;
        }

        .content1 {
            margin-bottom: 50px;
            position: absolute;
            left: 50%;
            transform: translateX(-133%);
            bottom: -20px;
            max-width: 980px;
            font-family: "Noto Sans KR";
            font-size: 18px;
            padding: 20px;
        }

        .back_container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .back_btn {
            padding: 10px 20px;
            background-color: #352018;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
        }

        .back_btn:hover {
            background-color: #8A5642;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="event1_container">
            <h2>너와 함께하개! 미션 스탬프 투어</h2>
            <div class="event1">
                <img src="/img/home_thumbnail_visual_1.svg" width="1300px" height="800px">
            </div>
            <div class="content1">
                <p>1. 참여 신청기간: 2024.10.28(월)~12.13(금)<br><br>
                    2. 여행기간: 2024.11.01(금)~12.15(일)<br><br>
                    3. 후기 작성 및 지원금 신청: 여행 후 7일 이내<br><br>
                    4. 모집대상: 타 지역에서 경기도로 여행하는...
                </p>
            </div>
        </div>
        <div class="back_container">
            <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
