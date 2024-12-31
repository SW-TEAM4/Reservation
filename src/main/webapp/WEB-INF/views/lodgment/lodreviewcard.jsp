<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 페이지</title>
    <link rel="stylesheet" href="/css/roomcard.css"/>
    <link rel="stylesheet" href="/css/button.css"/>
    <style>
        /* 카드 레이아웃 컨테이너 */
        .review-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin-top: 20px;
        }

        /* 리뷰 카드 스타일 */
        .review-card {
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            font-family: Arial, sans-serif;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .review-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .review-card-body {
            padding: 15px;
            background-color: #fff;
        }

        .review-card h3 {
            font-size: 18px;
            font-weight: bold;
            margin: 0 0 10px;
        }

        .review-card p {
            margin: 5px 0;
        }

        .review-card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }

        .review-date {
            font-size: 12px;
            color: #888;
        }

        .review-rating {
            font-size: 16px;
            font-weight: bold;
            color: #f39c12;
        }
    </style>
</head>
<body>
<h1>숙소 리뷰 페이지</h1>

<!-- 리뷰 통계 -->
<section>
    <h2>리뷰 통계</h2>
    <p>리뷰 수: ${statistics['REVIEW_COUNT']}</p>
    <p>평균 평점: ${statistics['AVG_RATING']}</p>
</section>

<!-- 리뷰 목록 카드 -->
<section>
    <h2>리뷰 목록</h2>
    <div class="review-container">
        <c:forEach var="review" items="${reviewList}">
            <div class="review-card">
                <!-- 리뷰 이미지 -->
                <c:if test="${not empty review.reviewer_image}">
                    <img src="${review.reviewer_image}" alt="리뷰 이미지">
                </c:if>
                <c:if test="${empty review.reviewer_image}">
                    <img src="/img/default-review.jpg" alt="기본 이미지">
                </c:if>
                <!-- 리뷰 내용 -->
                <div class="review-card-body">
                    <h3>${review.reviewer_nickname}</h3>
                    <p>${review.reviewer_content}</p>
                    <div class="review-card-footer">
                        <span class="review-date">${review.reviewer_created}</span>
                        <span class="review-rating">${review.reviewer_rating}</span>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- 리뷰 목록이 비어 있을 경우 -->
        <c:if test="${empty reviewList}">
            <p>등록된 리뷰가 없습니다.</p>
        </c:if>
    </div>
</section>
</body>
</html>