<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2025-01-02
  Time: 오전 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <style>
        body {
            font-family: "Noto Sans KR";
            margin: 0 auto;
        }

        .detail_container {
            border: 2px solid #ccc;
            padding: 20px;
            border-radius: 8px;
            background-color: white;
            max-width: 1600px;
            margin: 70px auto;
        }

        .detail_idx {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .detail_header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .detail_writer {
            font-size: 16px;
            color: #555;
            margin-bottom: 50px;
        }

        .detail_content {
            font-size: 18px;
            line-height: 2.0;
        }

        .back_container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .back_btn {
            padding: 10px 20px;
            background-color: #352018;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
        }

        .back_btn:hover {
            background-color: #8A5642;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <div class="detail_container">
            <div class="detail_idx">번호 : ${detail.BOARD_IDX}</div>
            <div class="detail_header">제목 : ${detail.BOARD_TITLE}</div>
            <div class="detail_writer">작성자 : ${detail.WRITER_NAME}</div>
            <div class="detail_content">내용 : ${detail.BOARD_CONTENT}</div>
        </div>
        <div class="back_container">
            <a href="/gather" class="back_btn">목록으로 돌아가기</a>
        </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
