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

        .event2_container h2 {
            margin-bottom: 20px;
        }

        .event2_container {
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

        .event2 img {
            width: 100%;
            max-width: 980px;
            height: auto;
            margin-bottom: 150px;
        }

        .content2 {
            margin-bottom: 50px;
            position: absolute;
            left: 50%;
            transform: translateX(-111%);
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
        <div class="event2_container">
            <h2>너와 함께하개! 미션 스탬프 투어</h2>
            <div class="event2">
                <img src="/img/home_thumbnail_visual_2.svg" width="1300px" height="800px">
            </div>
            <div class="content2">
                <p>1. 운동회 날짜: 2024.12.28<br><br>
                    2. 모집기간: 2024.11.01(금)~12.15(일)<br><br>
                    3. 모집대상: 반려동물과 새로운 경험을 하고 싶은 가족들<br><br>
                    4. 1가구당 최대 2인 참여 가능
                </p>
            </div>
        </div>
        <div class="back_container">
            <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
