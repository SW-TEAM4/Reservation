<%--
  파일명 : sellerShowReview.jsp
  생성자 : JDeok
  날짜 : 2025.01.03
  기능 : 리뷰 조회
--%>
<%-- 파일명 : sellerShowReview.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 조회</title>
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link rel="stylesheet" href="/css/sellerSiderbar.css">
    <link rel="stylesheet" href="/css/sellerShowReview.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<div class="layout">
    <%-- 왼쪽 사이드바 포함 --%>
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %>

    <!-- 오른쪽 콘텐츠 -->
    <main class="content">
        <h1>리뷰 조회</h1>

        <%-- 리뷰 요약 섹션 --%>
        <div class="review-summary">
            <div class="average-rating">
                <span class="rating-number">${review.avg_rating}</span>
                <span class="star-icon">⭐</span>
            </div>
            <div class="review-count">총 ${review.count_num}명이 리뷰를 달았습니다.</div>
        </div>

        <%-- 리뷰 리스트 --%>
        <div id="reviewContainer" class="container">
            <c:forEach var="dto" items="${reviews}">
                <div class="card">
                        <%-- 이미지 섹션 --%>
                    <img class="card-image" src="${empty dto.review_img_url ? '/img/review_defalt_img.svg' : dto.review_img_url}" alt="리뷰 이미지">

                        <%-- 본문 --%>
                    <div class="card-content">
                        <div class="card-header">
                            <div class="card-title">${dto.lod_name}</div>
                           <%-- <span>${dto.formattedDate}</span> [check] 날짜 필요한지--%>
                        </div>

                            <%-- 객실 이름 --%>
                        <div class="card-room-name">${dto.room_name}</div>
                            <%-- 유저 이름 --%>
                        <div class="card-user-name">${dto.user_name}</div>
                            <%-- 별점 --%>
                        <div class="star-container">
                            <c:forEach begin="1" end="5" varStatus="i">
                                <span class="star ${dto.rating >= i.index ? 'filled' : ''}">&#9733;</span>
                            </c:forEach>
                        </div>

                            <%-- 사용자 댓글 --%>
                        <div class="card-description">${dto.user_comment}</div>

                            <%-- 사장님 답글 또는 답글 입력 필드 --%>
                            <%-- 사장님 답글 또는 답글 입력 필드 --%>
                        <div class="lod-comment-wrapper">
                            <c:choose>
                                <%-- 답글이 아직 없을 경우 textarea 표시 --%>
                                <c:when test="${dto.comment_status == 'Y'}">
                                    <div class="reply-container">
                                        <textarea id="reply_${dto.review_idx}" class="reply-textarea" placeholder="답글을 입력하세요"></textarea>
                                        <div class="reply-button-container">
                                            <button class="reply-button"
                                                    data-review_idx="${dto.review_idx}">
                                                답글 달기
                                            </button>
                                        </div>
                                    </div>
                                </c:when>

                                <%-- 답글이 있을 경우 해당 내용 표시 --%>
                                <c:otherwise>
                                    <div class="lod-comment-title">사장님</div>
                                    <div class="lod-comment">${dto.comment_status}</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        // 답글 달기 버튼 클릭 이벤트
        $(".reply-button").click(function () {
            const review_idx = $(this).data("review_idx");
            const replyContent = $("#reply_" + review_idx).val();

            if (!replyContent) {
                alert("답글 내용을 입력하세요.");
                return;
            }

            $.ajax({
                url: "/lodgment/sellerReviewList", // 서버의 엔드포인트
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    review_idx: review_idx,
                    replycontent: replyContent
                }),
                success: function (response) {
                    // 컨테이너 부분만 새로고침
                    $("#reviewContainer").html(response);
                },
                error: function () {
                    alert("답글을 등록하는 데 실패했습니다.");
                }
            });
        });
    });
</script>




