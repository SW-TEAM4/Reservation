<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2024-12-31
  Time: 오후 3:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>재미나개</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css?after"/>
    <style>
        /** {*/
        /*    box-sizing: border-box;*/
        /*    margin: 0;*/
        /*    padding: 0;*/
        /*    font-family: "Noto Sans KR";*/
        /*}*/

        /*a {*/
        /*    text-decoration: none;*/
        /*}*/


        /*.header {*/
        /*    width: 100%; !* 전체 너비 사용 *!*/
        /*    height: 260px; !* 높이 조정 *!*/
        /*    display: flex; !* Flex 사용 *!*/
        /*    flex-direction: column; !* 아이템을 세로로 배치 *!*/
        /*    justify-content: flex-end; !* 아이템을 하단으로 정렬 *!*/
        /*    align-items: center; !* 아이템을 가로 중앙으로 정렬 *!*/
        /*    padding: 10px 0;*/
        /*    background-color: #8A5642; !* 배경색 설정 *!*/
        /*}*/

        /*.login {*/
        /*    position: absolute;*/
        /*    right: 36px; !* 오른쪽 정렬 *!*/
        /*    top: 24px; !* 상단 고정 *!*/
        /*}*/

        /*.login > a {*/
        /*    color: #352018;*/
        /*    font-size: 16px;*/
        /*}*/

        /*.size {*/
        /*    width: auto; !* 자동 너비 설정 *!*/
        /*    display: flex; !* Flex 사용 *!*/
        /*    justify-content: center; !* 가로 중앙 정렬 *!*/
        /*    align-items: center; !* 세로 중앙 정렬 *!*/
        /*    height: 100%; !* 헤더 높이에 맞춤 *!*/
        /*}*/

        /*.size a img {*/
        /*    transform: translateY(67px); !* Y축으로 -100px 이동 *!*/
        /*    margin-bottom: 45px;*/
        /*}*/


        .main {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /*.menu {*/
        /*    width: 1200px;*/
        /*    margin: 20px auto 0; !* 상단에 간격 추가 *!*/
        /*    height: 40px;*/
        /*}*/

        /*.menu > ul {*/
        /*    margin: 0;*/
        /*    padding: 0;*/
        /*    list-style: none;*/
        /*}*/

        /*.menu > ul > li {*/
        /*    float: left; !* 메뉴 항목을 가로로 배열 *!*/
        /*    width: 25%; !* 메뉴 너비 설정 *!*/
        /*}*/

        /*.menu > ul > li > a {*/
        /*    display: flex;*/
        /*    justify-content: center;*/
        /*    align-items: center;*/
        /*    text-align: center;*/
        /*    padding: 14px 23px; !* 상하 14px, 좌우 23px 패딩 *!*/
        /*    border-radius: 20px;*/
        /*    transition: background-color 0.3s;*/
        /*    background-color: #fff; !* 기본 배경색 *!*/
        /*    color: #352018;*/
        /*    font-weight: bold;*/
        /*    font-size: 20px;*/
        /*}*/

        /*.menu > ul > li > a.active {*/
        /*    background-color: #352018;*/
        /*    color: white;*/
        /*}*/

        /*.menu > ul > li {*/
        /*    list-style: none;*/
        /*}*/

        .main h2 {
            font-weight: bold;
            font-family: "Noto Sans KR";
            margin-bottom: 10px;
            color: #333;
        }

        .main p {
            color: #666;
            margin-bottom: 30px;
            /*border-bottom: 1px solid #929292;*/
            font-family: "Noto Sans KR";
        }

        .card_container1 {
            display: flex;
            /*flex-wrap: wrap;*/
            /*gap: 20px;*/
            flex-direction: row;
            border-top: 2px solid #929292;
            padding-bottom: 10px;
        }

        .card1 {
            /*background-color: #fff;*/
            /*border: 1px solid #ddd;*/
            border-radius: 5px;
            flex: 1;
            /*box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);*/
            width: 461px;
            height: 300px;
            overflow: hidden;
            margin-top: 20px;
        }

        .card1 img {
            width: 461px;
            height: 300px;
        }

        .card_content1 {
            flex: 1;
            display: flex;
            flex-direction: column;
            /*padding: 15px;*/
            margin-top: 50px;
            /*width: 65%;*/
            /*flex-direction: row;*/
        }

        .notice1 {
            width: 126.06px;
            height: 45.79px;
            margin-bottom: 17.21px;
        }

        .title1 {
            font-size: 18px;
            margin-bottom: 10px;
            height: 40px;
        }

        .content1 {
            font-size: 14px;
            color: #352018;
        }

        .card_container2 {
            display: flex;
            /*flex-wrap: wrap;*/
            /*gap: 20px;*/
            flex-direction: row;
            border-top: 2px solid #929292;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }

        .card2 {
            /*background-color: #fff;*/
            /*border: 1px solid #ddd;*/
            border-radius: 5px;
            flex: 1;
            /*box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);*/
            width: 461px;
            height: 300px;
            overflow: hidden;
            margin-top: 20px;
        }

        .card2 img {
            width: 461px;
            height: 300px;
        }

        .card_content2 {
            flex: 1;
            display: flex;
            flex-direction: column;
            /*padding: 15px;*/
            margin-top: 50px;
            /*width: 65%;*/
            /*flex-direction: row;*/
        }

        .notice2 {
            width: 126.06px;
            height: 45.79px;
            margin-bottom: 17.21px;
        }

        .title2 {
            font-size: 18px;
            margin-bottom: 10px;
            height: 40px;
        }

        .content2 {
            font-size: 14px;
            color: #352018;
        }

        .card_container3 {
            display: flex;
            /*flex-wrap: wrap;*/
            /*gap: 20px;*/
            flex-direction: row;
            border-top: 2px solid #929292;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }

        .card3 {
            /*background-color: #fff;*/
            /*border: 1px solid #ddd;*/
            border-radius: 5px;
            flex: 1;
            /*box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);*/
            width: 461px;
            height: 300px;
            overflow: hidden;
            margin-top: 20px;
        }

        .card3 img {
            width: 461px;
            height: 300px;
        }

        .card_content3 {
            flex: 1;
            display: flex;
            flex-direction: column;
            /*padding: 15px;*/
            margin-top: 50px;
            /*width: 65%;*/
            /*flex-direction: row;*/
        }

        .notice3 {
            width: 126.06px;
            height: 45.79px;
            margin-bottom: 17.21px;
        }

        .title3 {
            font-size: 18px;
            margin-bottom: 10px;
            height: 40px;
        }

        .content3 {
            font-size: 14px;
            color: #352018;
        }


        /*.footer {*/
        /*    width: 100%; !* 푸터의 너비를 전체로 설정 *!*/
        /*    text-align: center;*/
        /*    padding: 10px 0; !* 푸터 내부 패딩 *!*/
        /*    border-top: 1px solid #929292; !* 상단 테두리 설정: 너비, 스타일, 색상 *!*/
        /*    justify-content: center;*/
        /*    align-items: center;*/
        /*}*/

        /*.footer > .size {*/
        /*    width: 1200px;*/
        /*    height: 156px;*/
        /*    margin: 0 auto;*/
        /*}*/

        /*.footer > .size > .info > p {*/
        /*    line-height: 20px;*/
        /*    color: gray;*/
        /*    font-weight: bold;*/
        /*}*/

    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="main">
        <h2>재미나개</h2>
        <p>운동회 / 바자회 / 스탬프 투어 등 다양한 이벤트에 참여해 보개</p>
        <div class="card_container1">
            <div class="card1">
                <img src="/img/home_thumbnail_visual_1.svg" alt="이벤트1" onclick="location.href='event1'">
            </div>
            <div class="card_content1">
                <div class="notice1">
                    <img src="/img/event.svg" alt="알림판">
                </div>
                <div class="title1">
                    <h3><a href="/event1">너와 함께하개! 미션 스탬프 투어</a></h3><br>
                </div>
                <div class="content1">
                    <p>1. 참여 신청기간: 2024.10.28(월)~12.13(금)<br>2. 여행기간: 2024.11.01(금)~12.15(일)<br>3. 후기 작성 및 지원금 신청: 여행 후 7일 이내<br>4. 모집대상: 타 지역에서 경기도로 여행하는...</p>
                </div>
            </div>
        </div>
        <div class="card_container2">
            <div class="card2">
                <img src="/img/home_thumbnail_visual_2.svg" alt="이벤트2" onclick="location.href='event2'">
            </div>
            <div class="card_content2">
                <div class="notice2">
                    <img src="/img/fm.svg" alt="운동회">
                </div>
                <div class="title2">
                    <h3><a href="/event2">누가 누가 제일 잘 달리나 시합하개</a></h3>
                </div>
                <div class="content2">
                    <p>1. 운동회 날짜: 2024.12.28<br>2. 모집기간: 2024.11.01(금)~12.15(일)<br>3. 모집대상: 반려동물과 새로운 경험을 하고 싶은 가족들<br>4. 1가구당 최대 2인 참여 가능</p>
                </div>
            </div>
        </div>
        <div class="card_container3">
            <div class="card3">
                <img src="/img/home_visual3.svg" alt="이벤트3" onclick="location.href='event3'">
            </div>
            <div class="card_content3">
                <div class="notice3">
                    <img src="/img/home_btn_bazaar.svg" alt="이벤트3">
                </div>
                <div class="title3">
                    <h3><a href="/event3">누가 더 잘 어울리개 내가 싸게 줄개</a></h3>
                </div>
                <div class="content3">
                    <p>1. 참여 신청기간: 2024.10.28(월)~12.13(금)<br>2. 여행기간: 2024.11.01(금)~12.15(일)<br>3. 모집대상: 반려동물과 옷 사는 경험이<br>4. 규칙: 전혀 못 쓰는 물건은 금지하며...</p>
                </div>
            </div>
        </div>
    </div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
