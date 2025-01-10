<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <style>
        .main-container {
            /* padding: 30px; */
            width: 100%;
            max-width: 1200px;
            display: contents;
        }

        .boardname {
            text-align: left; /* 텍스트 중앙 정렬 */
            max-width: 1200px; /* 화면 중앙 정렬 */
            color: #352018; /* 텍스트 색상 */
            margin: 70px auto 1px auto;
        }

        .boardname h2 {
            font-size: 26px; /* 제목 크기 */
            font-weight: bold;
            margin-bottom: 10px; /* 제목과 설명 간격 */
            color: #352018; /* 제목 색상 */
        }

        .boardname p {
            font-size: 20px; /* 설명 글씨 크기 */
            color: #352018; /* 설명 색상 */
            opacity: 0.5;
            margin-top: 0; /* 제목과의 간격 */
        }


        .detail_container {
            border: 1px solid #9C6A5E;
            padding: 60px;
            border-radius: 8px;
            background-color: #fff;
            max-width: 1200px;
            margin: 50px auto 1px auto;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .detail_header {
            font-size: 20px;
            font-weight: bold;
            color: #352018;
            margin-bottom: 15px;
        }

        .detail_writer {
            font-size: 14px;
            color: #555;
            margin-bottom: 20px;
        }

        .detail_content {
            font-size: 16px;
            line-height: 1.8;
            color: #333;
            background-color: #f5f5f5;
            padding: 30px;
            border-radius: 4px;
            border: 1px solid #ddd;
            height: 300px;
        }

        .comment_list {
            margin: 30px auto;
            max-width: 1200px;
            padding-top: 20px;
        }

        .no_comment_image {
            text-align: center; /* 이미지가 중앙에 배치되도록 */
            margin-top: 50px; /* 이미지와 다른 요소들 간의 여백 */
            margin-bottom: 50px;
        }

        .no_comment_image img {
            /*max-width: 200px;    !* 이미지 크기 제한 *!*/
            height: auto; /* 비율에 맞게 자동 조정 */
            opacity: 0.7; /* 약간의 투명도를 적용하여 스타일 추가 */
        }

        .comment_item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 30px 0;
        }

        .comment_profile {
            margin-right: 15px;
        }

        .comment_profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 1px solid #ddd;
        }

        .comment_content {
            flex: 1;
        }

        .comment_author {
            font-size: 14px;
            font-weight: bold;
            color: #352018;
        }

        .comment_text {
            font-size: 14px;
            color: #333;
            margin-top: 5px;
        }

        .comment_date {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }

        /* 댓글 작성 폼 스타일 */
        .comment_container {
            margin: 30px auto;
            max-width: 1200px;
        }

        .comment_input {
            width: 100%;
            height: 100px;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #9C6A5E;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 15px;
            resize: vertical;
            margin-top: 50px;
        }

        .comment_buttons {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }


        .comment_button {
            padding: 10px 20px;
            background-color: #9C6A5E;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .comment_button:hover {
            background-color: #8a5e46;
        }

        .back_container {
            display: flex;
            justify-content: center; /* 버튼을 정중앙으로 정렬 */
            align-items: center;
            margin-top: 90px; /* 위 요소들과 간격 */
            margin-bottom: 100px;
        }

        .back_btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            text-decoration: none;
            background-color: #9C6A5E; /* 버튼 배경색 */
            border-radius: 4px;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .back_btn:hover {
            background-color: #8a5e46; /* 마우스 오버 시 버튼 색상 */
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="main-container">
    <div class="boardname">
        <h2 style="display: inline-block;">모여보개</h2>
        <img src="/img/board_detail_footprint_img.svg" alt="아이콘" style="width: 26px; height: 26px; transform: translateY(3px);">
        <p>자유롭게 반려동물 이야기를 나눠보개</p>
    </div>
    <div class="detail_container">
        <div class="detail_header">작성자 : ${detail.WRITER_NAME}</div>
        <div class="detail_writer">
            작성일 :
            <fmt:formatDate value="${detail.CREATED}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
        <div class="detail_content">${detail.BOARD_CONTENT}</div>
    </div>
    <!-- 댓글 목록 -->
    <div class="comment_list">
        <c:if test="${empty commentResDTOList}">
            <!-- 댓글이 없을 때 이미지 표시 -->
            <div class="no_comment_image">
                <img src="/img/board_comment_empty_img.svg" alt="댓글 없음">
            </div>
        </c:if>

        <c:forEach var="comment" items="${commentResDTOList}">
            <div class="comment_item">
                <div class="comment_profile">
                    <img src="/img/ResDetail_user_img.svg" alt="프로필">
                </div>
                <div class="comment_content">
                    <div class="comment_author">${comment.USER_NAME}</div>
                    <div class="comment_text">${comment.COMMENT}</div>
                    <div class="comment_date">
                        <fmt:formatDate value="${comment.CREATED}" pattern="yyyy-MM-dd HH:mm"/>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 댓글 작성 폼 -->
    <div class="comment_container">
        <form action="/comment/write" method="post" onsubmit="checkLoginAndSubmit(event)">
            <input type="hidden" name="BOARD_IDX" value="${detail.BOARD_IDX}">
            <textarea name="COMMENT" class="comment_input" placeholder="댓글을 작성해주세요."></textarea>
            <div class="comment_buttons">
                <button type="submit" class="comment_button">답변</button>
            </div>
        </form>
    </div>
</div>

<div class="back_container">
    <a href="/gather" class="back_btn">목록으로 돌아가기</a>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script>
    function checkLoginAndSubmit(event) {
        var usersession = '<c:out value="${sessionScope.usersession}" />';
        if (!usersession || usersession === 'null') {
            event.preventDefault();
            alert("로그인 하지 않으면 답글을 작성할 수 없습니다.");
            window.location.href = "/detail?BOARD_IDX=" + '${detail.BOARD_IDX}';
        }
    }
</script>
</body>
</html>
