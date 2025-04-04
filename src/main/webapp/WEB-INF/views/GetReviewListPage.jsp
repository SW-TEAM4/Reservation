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
    <title>같이가개 - 리뷰리스트</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700&display=swap" rel="stylesheet">
    <script src="/js/home.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
<%--    <link rel="stylesheet" href="/css/mypageStyle.css"/>--%>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif !important;
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
            max-width: 1200px;
            margin: 0 auto;
            border-top: 1px solid #00000070;
            border-bottom: 1px solid #00000070;
            padding: 20px 0;
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
            margin-top: 8px;
        }
        .header-title {
            font-size: 20px;
            color: #352018;
            font-weight: bold;
        }

        .review-count {
            font-size: 23px;
            color: #352018;
            font-weight: bold;
            text-align: left;
            margin: 0 20px;
            display: flex;
            align-items: center;
            position: relative;
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 0;
            margin-bottom: 30px;
        }

        .container2 {
            max-width: 1200px;
            margin: 0 auto;
            margin-bottom: 80px;
        }

        .card {
            display: flex;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card-content {
            flex: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
            /*justify-content: space-between;*/
        }

        .card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .card-title {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 24px;
            font-weight: bold;
            color: #352018;
        }


        .right-back-button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            margin: 0;
        }

        .right-back-button img {
            width: 30px; /* 이미지 크기 */
            height: 30px; /* 이미지 크기 */
        }


        .card-room-name {
            font-size: 18px;
            color: #352018;
            margin-top: 5px;
            font-weight: bold;
        }

        .star-container {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .star {
            font-size: 18px;
            color: gray;
            margin-right: 5px;
        }

        .star-filled{
            font-size: 18px;
            color: #FFDF86;
            margin-right: 5px;
        }
        .card-image {
            width: 240px;
            height: 300px;
            object-fit: cover;
            border-radius: 5px;
        }

        .card-description {
            margin-top: 15px;
            font-size: 16px;
            color: #352018;
            font-weight: 700;
        }

        .lod-comment-wrapper {
            margin-top: 30px;
            padding: 20px 0px 20px 20px;
            background-color: #d9d9d985;
            border-left: 4px solid #6b432f;
            border-radius: 5px;
        }

        .lod-comment-title {
            font-size: 16px;
            font-weight: bold;
            color: #352018;
            margin-bottom: 10px; /* 사장님 텍스트와 댓글 간격 */
        }

        .lod-comment {
            font-size: 14px;
            color: #352018;
            line-height: 1.6; /* 줄 간격 조정 */
        }
        #reviewEmpty {
            display: block;
            margin: 50px auto;
            width: 500px;
            height: auto; /* 비율 유지 */
            margin-bottom: 200px;
            margin-top:100px;

        }

    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<div class="header-bar">
    <button class="back-button" onclick="history.back();">
        <img src="/img/arrow-left.svg" alt="Back" />
    </button>
    <span class="header-title">리뷰내역</span>
</div>
<c:if test="${not empty map.getReviewList}">
<span class="review-count">내가 쓴 총 리뷰 수 ${count}</span>
</c:if>
<div class="container2">
<c:choose>

    <c:when test="${not empty map.getReviewList}">
    <c:forEach var="dto" items="${map.getReviewList}">
        <div class="card">
            <img class="card-image" src="${empty dto.review_img_url ? '/img/review_defalt_img.svg' : dto.review_img_url}" alt="숙소 이미지">

            <div class="card-content">
                <div class="card-header">
                    <div class="card-title">
                            ${dto.lod_name}
                            <span style="color: #777777; font-size: 16px; margin-left: 10px;">${dto.formattedDate}</span>
                    </div>
<%--                    <button class="right-back-button" onclick="window.location.href='/reservation/detailInfo?user_idx=${dto.user_idx}&reservation_idx=${dto.reservation_idx}';">&gt;</button>--%>
                    <button class="right-back-button"onclick="window.location.href='/reservation/detailInfo?user_idx=${dto.user_idx}&reservation_idx=${dto.reservation_idx}';">
                        <img src="/img/arrow-right.svg" alt="Go" />
                    </button>
                </div>
                <div class="card-room-name">${dto.room_name}</div>

                <div class="star-container">
                    <c:forEach var="i" begin="1" end="5">
                        <c:choose>
                            <c:when test="${i <= dto.rating}">
                                <span class="star-filled">&#9733;</span>
                            </c:when>
                            <c:otherwise>
                                <span class="star">&#9733;</span>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>


                <div class="card-description">${dto.user_comment}</div>

                <c:if test="${dto.lod_comment != null}">
                    <div class="lod-comment-wrapper">
                        <div class="lod-comment-title">사장님</div>
                        <div class="lod-comment">${dto.lod_comment}</div>
                    </div>
                </c:if>
            </div>
        </div>
    </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="no-reservation">
            <img id="reviewEmpty" src="/img/review_empty_img.svg" alt="리뷰 내역 없음">
        </div>
    </c:otherwise>
</c:choose>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
