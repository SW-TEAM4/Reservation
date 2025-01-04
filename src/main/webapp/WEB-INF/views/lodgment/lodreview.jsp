<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 페이지</title>
    <link rel="stylesheet" href="/css/lodreview.css"/>
</head>
<body>
<div class="lod-review-container">
    <!-- 리뷰 통계 -->
    <section>
        <h1>숙소 리뷰 페이지</h1>
        <h2>리뷰 통계</h2>
        <p>리뷰 수: ${statistics['REVIEW_COUNT']}</p>
        <p>평균 평점:   <c:choose>
            <c:when test="${statistics['AVG_RATING'] >= 0.0 && statistics['AVG_RATING'] < 1.0}">
                ☆ (평점: ${statistics['AVG_RATING']})
            </c:when>
            <c:when test="${statistics['AVG_RATING'] >= 1.0 && statistics['AVG_RATING'] < 2.0}">
                ⭐ (평점: ${statistics['AVG_RATING']})
            </c:when>
            <c:when test="${statistics['AVG_RATING'] >= 2.0 && statistics['AVG_RATING'] < 3.0}">
                ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
            </c:when>
            <c:when test="${statistics['AVG_RATING'] >= 3.0 && statistics['AVG_RATING'] < 4.0}">
                ⭐ ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
            </c:when>
            <c:when test="${statistics['AVG_RATING'] >= 4.0 && statistics['AVG_RATING'] < 5.0}">
                ⭐ ⭐ ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
            </c:when>
            <c:when test="${statistics['AVG_RATING'] >= 5.0}">
                ⭐ ⭐ ⭐ ⭐ ⭐ (평점: ${statistics['AVG_RATING']})
            </c:when>
        </c:choose></p>
    </section>
    <c:forEach var="lodreview" items="${reviewList}">
        <div class="lod-review-card">
            <img class="lod-review-card-image" src="${empty lodreview.reviewer_image ? '/img/review_defalt_img.svg' : lodreview.reviewer_image}" alt="리뷰 이미지">

            <div class="lod-review-card-content">

            <div class="lod-review-header">
                <div class="lod-review-star-container">
                    <c:choose>
                        <c:when test="${lodreview.reviewer_rating >= 0.0 && lodreview.reviewer_rating < 1.0}">
                            ☆
                        </c:when>
                        <c:when test="${lodreview.reviewer_rating >= 1.0 && lodreview.reviewer_rating < 2.0}">
                            ⭐
                        </c:when>
                        <c:when test="${lodreview.reviewer_rating >= 2.0 && lodreview.reviewer_rating < 3.0}">
                            ⭐ ⭐
                        </c:when>
                        <c:when test="${lodreview.reviewer_rating >= 3.0 && lodreview.reviewer_rating < 4.0}">
                            ⭐ ⭐ ⭐
                        </c:when>
                        <c:when test="${lodreview.reviewer_rating >= 4.0 && lodreview.reviewer_rating < 5.0}">
                            ⭐ ⭐ ⭐ ⭐
                        </c:when>
                        <c:when test="${lodreview.reviewer_rating >= 5.0}">
                            ⭐ ⭐ ⭐ ⭐ ⭐
                        </c:when>
                    </c:choose>
                </div>
                <div class="lod-review-created">${lodreview.reviewer_created}</div>
                </div>
                <!-- 사용자 댓글 -->
                <div class="lod-review-card-description">${lodreview.reviewer_content}</div>

                <c:if test="${lodreview.manager_reply != null}">
                    <div class="lod-manager-wrapper">
                        <div class="lod-manager-title">사장님</div>
                        <div class="lod-manager-reply">${lodreview.manager_reply}</div>
                    </div>
                </c:if>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>