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

        .event2_container {
            padding: 20px;
            margin: 0 auto;
            max-width: 1280px;
        }

        .event2 img {
            width: 100%;
            max-width: 1280px;
            height: auto;
        }

        .content2 {
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
        <div class="event2_container">
            <div class="top-container">
                <div class="center">
                    <img src="/img/fm.svg" class="header-img">
                    <div class="header-text">누가 누가 제일 잘 달리나 시합하개</div>
                </div>
                <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
            </div>
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
