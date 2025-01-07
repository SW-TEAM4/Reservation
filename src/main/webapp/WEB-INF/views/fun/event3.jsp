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

        .event3_container h2 {
            margin-bottom: 20px;
        }

        .event3_container {
            display: flex;
            flex-direction: column;
            justify-content: center;  /* 수직 중앙 정렬 */
            align-items: center;      /* 수평 중앙 정렬 */
            height: 100vh;            /* 화면 전체 높이 */
            padding: 0;
            text-align: left;         /* 텍스트 왼쪽 정렬 */
            width: 100%;
            position: relative;
            bottom: 60px;
        }

        .event3 img {
            width: 980px;
            max-width: 980px;
            height: auto;
            margin-bottom: 60px;
        }

        .content3 {
            margin-bottom: 50px;
            position: absolute;
            left: 50%;
            transform: translateX(-133%);
            bottom: -120px;
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
        <div class="event3_container">
            <h2>누가 더 잘 어울리개 내가 싸게 줄개</h2>
            <div class="event3">
                <img src="/img/home_visual3.svg" width="1300px" height="800px">
            </div>
            <div class="content3">
                <p>1. 참여 신청기간: 2024.10.28(월)~12.13(금)<br><br>
                    2. 여행기간: 2024.11.01(금)~12.15(일)<br><br>
                    3. 모집대상: 반려동물과 옷 사는 경험이<br><br>
                    4. 규칙: 전혀 못 쓰는 물건은 금지하며...
                </p>
            </div>
        </div>
        <div class="back_container">
            <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
