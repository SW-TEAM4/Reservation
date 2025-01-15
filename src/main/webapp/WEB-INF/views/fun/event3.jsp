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

        .event3_container {
            padding: 20px 60px;
            margin: 0 auto;
            max-width: 1280px;
            text-align: center;
        }

        .event3 img {
            width: 100%;
            max-width: 900px;
            height: auto;
            margin: 0 auto;
        }

        .content3 {
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
        <div class="event3_container">
            <div class="top-container">
                <div class="center">
                    <img src="/img/home_btn_bazaar.svg" class="header-img">
                    <div class="header-text">누가 더 잘 어울리개, 내가 싸게 줄개</div>
                </div>
                <a href="/fun.do" class="back_btn">목록으로 돌아가기</a>
            </div>
            <div style="width: 1155px; height: 1px; background-color: #DBD6D6; margin-bottom: 30px;"></div>
            <div class="event3">
                <img src="/img/home_visual3.svg">
            </div>
            <div class="content3">
                <p>
                    🐾 누가 더 잘 어울리개, 내가 싸게 줄개 🐾<br><br>
                    반려동물을 위한 특별한 바자회에 여러분을 초대합니다!<br>
                    함께 나누고, 돕고, 추억을 만들어가는 뜻깊은 하루를 만들어 보세요.<br><br>

                    <b>📅 일정 안내</b><br>
                    참여 신청 기간: 2025년 1월 1일(금) 오전 9시 ~ 2025년 2월 28일(금) 오후 6시<br>
                    바자회 날짜: 2025년 3월 15일(토) 오전 9시 ~ 오후 6시<br><br>

                    <b>👨‍👩‍👧‍👦 모집 대상</b><br>
                    반려동물과 함께 바자회 물품을 나눔하고 싶으신 모든 반려인♥<br><br>

                    <b>📦 바자회 지원 물품</b><br>
                    - 반려동물 관련 물품: 장난감, 옷, 사료, 하우스 등<br>
                    - 생활용품: 반려인들이 함께 나눌 수 있는 소형 가전, 주방용품 등<br><br>

                    <b>🚫 금지 물품 안내</b><br>
                    - 거래가 불가능한 물품<br>
                    - 반려동물 및 반려인에게 위협적이거나 안전하지 않은 물품<br><br>

                    <b>💝 바자회 수익금 이용 안내</b><br>
                    바자회를 통해 발생한 모든 수익금은 종합 유기견 보호 센터에 전액 기부됩니다.<br>
                    반려동물을 돕는 따뜻한 나눔의 손길을 함께해주세요!<br><br>

                    <b>⚠️ 주의사항</b><br>
                    - 입마개 필수: 입마개가 필요한 견종은 반드시 준비해 주세요.<br>
                    - 바자회 현장에서는 참여자와 반려동물 모두의 안전을 위해 행사 규칙을 꼭 준수해주세요.<br><br>

                    🐕 따뜻한 마음을 나누는 특별한 하루<br>
                    이번 바자회는 단순한 나눔을 넘어, 유기견 보호와 반려동물 문화를 돕는 소중한 기회입니다.<br>
                    반려동물과 함께 나눔의 가치를 실천하며 따뜻한 추억을 만들어 보세요!<br>
                </p>
            </div>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
