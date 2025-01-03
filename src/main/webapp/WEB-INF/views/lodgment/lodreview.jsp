<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>리뷰 페이지</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }

        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tbody tr:hover {
            background-color: #f1f1f1;
        }

        img {
            border-radius: 4px;
        }
    </style>
</head>
<body>
<h1>숙소 리뷰 페이지</h1>

<!-- 리뷰 통계 -->
<section>
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

<!-- 개별 리뷰 목록 -->
<section>
    <h2>리뷰 목록</h2>
    <table>
        <thead>
        <tr>
            <th>닉네임</th>
            <th>평점</th>
            <th>리뷰 내용</th>
            <th>이미지</th>
            <th>작성일</th>
            <th>사장님 답글</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty reviewList}">
                <c:forEach var="review" items="${reviewList}">
                    <tr>
                        <td>${review.reviewer_nickname}</td>
                        <td>
                <!-- 점수에 따라 별 개수 계산 -->
                <c:choose>
                    <c:when test="${review.reviewer_rating >= 0.0 && review.reviewer_rating < 1.0}">
                        ☆
                    </c:when>
                    <c:when test="${review.reviewer_rating >= 1.0 && review.reviewer_rating < 2.0}">
                        ⭐
                    </c:when>
                    <c:when test="${review.reviewer_rating >= 2.0 && review.reviewer_rating < 3.0}">
                        ⭐ ⭐
                    </c:when>
                    <c:when test="${review.reviewer_rating >= 3.0 && review.reviewer_rating < 4.0}">
                        ⭐ ⭐ ⭐
                    </c:when>
                    <c:when test="${review.reviewer_rating >= 4.0 && review.reviewer_rating < 5.0}">
                        ⭐ ⭐ ⭐ ⭐
                    </c:when>
                    <c:when test="${review.reviewer_rating >= 5.0}">
                        ⭐ ⭐ ⭐ ⭐ ⭐
                    </c:when>
                </c:choose>
            </td>
                        <td>${fn:escapeXml(review.reviewer_content)}</td>
                        <td>
                            <img src="${not empty review.reviewer_image ? review.reviewer_image : '/img/default-review.jpg'}"
                                 alt="리뷰 이미지" width="100">
                        </td>
                        <td>${review.reviewer_created}</td>
                        <td>${review.manager_reply}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="5">등록된 리뷰가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>
</body>
</html>