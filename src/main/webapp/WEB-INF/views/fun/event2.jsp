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

        .event2_container {
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

        .event2 img {
            width: 100%;
            max-width: 1280px;
            height: auto;
            margin-bottom: 150px;
        }

        .content2 {
            margin-bottom: 50px;
            position: absolute;
            left: 13%;
            bottom: -20px;
            max-width: 980px;
            font-family: "Noto Sans KR";
            font-size: 15px;
            padding: 20px;
            transform: translateY(150px);
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
            <img src="/img/fm.svg" class="header-img">
            <div class="header-text">누가 누가 제일 잘 달리나 시합하개</div>
        </div>
        <div class="back_container">
            <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
        </div>
        <div class="event2_container">
            <div class="event2">
                <img src="/img/home_thumbnail_visual_2.svg">
            </div>
            <div class="content2">
                <p>
                    1. 운동회 날짜 : 2025.02.08(토), 10시~18시<br><br>
                    2. 모집기간: 2025.01.15(수) ~ 2025.01.31<br><br>
                    3. 모집대상: 반려동물과 새로운 경험을 하고, 예쁜 사진들과 추얻들을 만들 싶은 가족들<br><br>
                    4. 장소 : 어린이 대공원(서울 광진구 능동로 216)<br><br>
                    5. 체험부스 ▶ 견생네컷, 청결미용, 펫타로, 예쁜 포토존 등등<br><br>
                    6. 준비물 : 돗자리, 간식, 귀여운 반려견과 반려견을 사랑하는 반려인♥<br><br>
                    7. 주의사항 : 입마개가 필요한 견종은 반려인들께서 직접 입마개 필참
                </p>
            </div>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
