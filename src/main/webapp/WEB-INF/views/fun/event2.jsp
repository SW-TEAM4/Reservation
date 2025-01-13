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

        .event2_container {
            padding: 20px 60px;
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
            <div style="width: 1155px; height: 1px; background-color: #DBD6D6; margin-bottom: 30px;"></div>
            <div class="event2">
                <img src="/img/home_thumbnail_visual_2.svg">
            </div>
            <div class="content2">
                <p>
                    🐾 누가 누가 제일 잘 달리나 시합하개 🐾<br><br>
                    반려견과 함께 특별한 하루를 보내고, 소중한 추억을 만들어 보세요!<br><br>

                    <b>📅 일정 안내</b><br>
                    운동회 날짜: 2025년 2월 8일(토) 오전 10시 ~ 오후 6시<br>
                    모집 기간: 2025년 1월 15일(수) ~ 2025년 1월 31일(금)<br><br>

                    <b>👨‍👩‍👧‍👦 모집 대상</b><br>
                    반려동물과 특별한 경험을 하고 싶으신 분들<br>
                    귀여운 반려견과 함께 예쁜 사진과 추억을 만들고 싶은 모든 가족<br><br>

                    <b>📍 행사 장소</b><br>
                    어린이대공원 (서울 광진구 능동로 216)<br>
                    자연 속에서 반려견과 함께 뛰어놀며 잊지 못할 추억을 만들어 보세요!<br><br>

                    <b>🎡 체험 부스 소개</b><br>
                    - 견생네컷: 반려견과 함께 특별한 사진을 남겨보세요~<br>
                    - 청결미용: 반려견을 위한 미니 청결 관리 체험!<br>
                    - 펫타로: 재미로 보는 반려견의 미래 운세!<br>
                    - 예쁜 포토존: 소중한 순간을 사진으로 기록하세요!!<br><br>

                    <b>🎒 준비물</b><br>
                    - 돗자리<br>
                    - 간식<br>
                    - 귀여운 반려견<br>
                    - 반려견을 사랑하는 마음 ♥<br><br>

                    <b>⚠️ 주의사항</b><br>
                    - 입마개 착용: 입마개가 필요한 견종은 반드시 준비해 주세요.<br>
                    - 행사장 내 질서를 위해 반려인의 적극적인 협조 부탁드립니다.<br>
                </p>
            </div>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
