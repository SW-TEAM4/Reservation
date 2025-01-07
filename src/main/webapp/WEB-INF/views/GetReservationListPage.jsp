<%--
  Created by IntelliJ IDEA.
  User: 이윤채
  Date: 2024-12-24
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>같이가개 - 예약리스트</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <!-- Google Fonts에서 Noto Sans KR 불러오기 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <script src="/js/home.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #ffffff;
        }

        .header-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            width: 100%;
            max-width: 1200px; /* 최대 너비 1200px */
            margin: 0 auto; /* 가운데 정렬 */
            border-top: 1px solid #00000070;
            border-bottom: 1px solid #00000070;
            padding: 20px 0;
            /*font-family: 'Noto Sans', sans-serif;*/
            margin-top: 50px;
            margin-bottom: 30px;
        }


        .back-button {
            position: absolute;
            left: 10px;
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
        }

        .back-button img {
            width: 24px;
            height: 24px;
        }

        .header-title {
            font-size: 20px;
            color: #352018;
            font-weight: bold;
        }

        .mypagecontainer {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .card {
            display: flex;
            background-color: #ffffff;
            border: 1px solid #ffffff;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 240px;
            height: 300px;
            object-fit: cover;
        }

        .card-content {
            flex: 1;
            padding: 10px;
            margin-left: 20px;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-title-wrapper {
            display: flex; /* 플렉스 박스를 사용하여 나란히 정렬 */
            align-items: center; /* 세로 가운데 정렬 */
            margin-bottom: 10px; /* 하단 간격 */
        }

        .card-title {
            font-size: 32px;
            font-weight: bold;
            color: #352018;
            margin-right: 10px; /* 텍스트와 화살표 이미지 간 간격 */
        }

        .right-back-button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            margin: 0;
        }

        .right-back-button img {
            width: 35px; /* 이미지 크기 */
            height: 35px; /* 이미지 크기 */
        }


        .card-date {
            color: #352018;
            margin-bottom: 23px;
            font-weight: bold;
        }

        .review-button {
            align-self: flex-start;
            padding: 20px 35px;
            background-color: #352018;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            font-size: 24px;
            display: inline-block;
            text-align: center;
            cursor: pointer;
            text-decoration: none;
            border-radius: 13px;
            margin-top: 100px;
        }

        .review-button:hover {
            background-color: #6b432f;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="header-bar">
    <button class="back-button" onclick="history.back();">
        <img src="/img/arrow-left.svg" alt="Back" />
    </button>
    <span class="header-title">예약내역</span>
</div>

<div class="mypagecontainer">
    <c:forEach var="dto" items="${map.list}">
        <div class="card">

            <img src="${dto.lod_img_url}" alt="숙소 이미지">
            <div class="card-content">
                <div class="card-date">${dto.res_str_date} ~ ${dto.res_end_date}</div>


                <div class="card-title-wrapper" onclick="window.location.href='/reservation/detailInfo?user_idx=${dto.user_idx}&reservation_idx=${dto.reservation_idx}';" style="cursor: pointer;">
                    <div class="card-title">${dto.lod_name}</div>
                    <button class="right-back-button">
                        <img src="/img/arrow-right.svg" alt="Go" />
                    </button>
                </div>

                <c:if test="${dto.status == 'A'}">
                    <c:choose>
                        <c:when test="${dto.res_end_date <= currentTime}">
                            <a href="/review?user_idx=${dto.user_idx}&reservation_idx=${dto.reservation_idx}&room_idx=${dto.room_idx}" class="review-button">
                                <img src="/img/dog_footprint.svg" alt="발자국" style="width: 40px; height: 40px; vertical-align: middle; margin-right: -5px;">
                                리뷰쓰기
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0);" class="review-button" onclick="alert('아직 예약기간이 끝나지 않았습니다. \n예약 기간이 끝난 후 리뷰를 써주세요.');">
                                <img src="/img/dog_footprint.svg" alt="발자국" style="width: 40px; height: 40px; vertical-align: middle; margin-right: -5px;">
                                리뷰쓰기
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:if>

            </div>
        </div>
    </c:forEach>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
