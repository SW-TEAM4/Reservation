<%--
  파일명 : sellerReviewList.jsp
  생성자 : JDeok
  날짜 : 2025.01.05
  기능 : 리뷰 조회
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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




