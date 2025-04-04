<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 페이지</title>
    <link rel="stylesheet" href="/css/lodreview.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // back 화살표 클릭 동작 이벤트 추가
            const arrowIcon = document.getElementById("left-arrow");
            if (arrowIcon) {
                arrowIcon.addEventListener("click", function () {
                    if (document.referrer) { // 이전 페이지가 있으면
                        window.history.back(); // 이전 페이지로 이동
                    } else { // 이전 페이지가 없으면
                        window.location.href = '/home.do'; // 홈페이지로 이동
                    }
                });
            }
        });
    </script>
</head>
<body>
<div class="wrap">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="container">
        <div class="top-container">
            <img class="arrow-icon" id="left-arrow" src="/img/home_icon_left_arrow.svg"/>
            <div class="header-text">리뷰 모아보기</div>
        </div>
        <div class="reserve-info">
            <div class="lod-review-container">
                <c:if test="${statistics['AVG_RATING'] > 0 && statistics['REVIEW_COUNT'] > 0}">
                    <div class="review-statistics">
                        <div style="display: flex; align-items: center; gap: 5px;">
                            <img src="/img/search_icon_star.svg" class="star-icon" style="width: 26px; height: 26px;"/>
                            <p style="color: #352018; font-size: 24px; font-weight: bold;">${statistics['AVG_RATING']}</p>
                            <p style="color: #352018; font-size: 24px;">(${statistics['REVIEW_COUNT']})</p>
                        </div>
                    </div>
                </c:if>

                <c:choose>

                    <c:when test="${not empty reviewList}">
                        <c:forEach var="lodreview" items="${reviewList}">
                            <div class="lod-review-card">
                                <!-- 리뷰 이미지 -->
                                <img class="lod-review-card-image"
                                     src="${empty lodreview.reviewer_image ? '/img/review_defalt_img.svg' : lodreview.reviewer_image}"
                                     alt="리뷰 이미지">
                                <div class="lod-review-card-content">

                                    <!-- 리뷰 헤더 -->
                                    <div class="lod-review-card-header">

                                        <!-- 별점 -->
                                        <div class="lod-review-star-container">
                                            <c:forEach var="i" begin="1" end="5">
                                                <span class="${i <= lodreview.reviewer_rating ? 'star-filled' : 'star'}">&#9733;</span>
                                            </c:forEach>
                                        </div>
                                        <!-- 작성일 -->
                                        <div class="lod-review-created">${lodreview.reviewer_created}</div>
                                    </div>

                                    <!-- 리뷰 작성한 닉네임-->
                                    <div class="reviewer-info">
                                        <span class="userId">${lodreview.reviewer_nickname}</span>
                                    </div>

                                    <!-- 리뷰 내용 -->
                                    <div class="lod-review-card-description">${lodreview.reviewer_content}</div>

                                    <!-- 사장님 답변 -->
                                    <c:if test="${lodreview.manager_reply != null}">
                                        <div class="lod-manager-wrapper">
                                            <div class="lod-manager-title">사장님</div>
                                            <div class="lod-manager-reply">${lodreview.manager_reply}</div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="no-review-container">
                            <img src="/img/lod_no_review.svg" alt="리뷰 없음" />
                        </div>
                    </c:otherwise>
                </c:choose>



            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>