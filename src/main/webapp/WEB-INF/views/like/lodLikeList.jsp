<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>찜한 숙소 목록</title>
    <style>
        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .card {
            position: relative;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s ease-in-out;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .heart-icon {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 24px;
            height: 24px;
            cursor: pointer;
            fill: gray;
            transition: transform 0.3s ease, fill 0.3s ease;
        }
        .heart-icon.active {
            fill: red;
        }
        .heart-icon:hover {
            transform: scale(1.2);
        }
        .card h3 {
            margin: 10px 0;
        }
        .card p {
            color: #555;
        }
    </style>
</head>
<body>
<h1 style="text-align:center;">찜한 숙소 목록</h1>
<input type="hidden" id="user-id" value="${userIdx}" />
<div class="card-container">
    <c:if test="${empty wishlist}">
        <p>찜한 숙소가 없습니다.</p>
    </c:if>

    <c:forEach var="lodgment" items="${wishlist}">
        <div class="card" onclick="location.href='/lodlike/lodgment/${lodgment.lod_idx}'">
            <!-- 숙소 이미지 -->
            <img src="${lodgment.lod_img_url}" alt="${lodgment.lod_name}">

            <!-- SVG 하트 아이콘 -->
            <svg class="heart-icon" data-lod-id="${lodgment.lod_idx}" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 6.5 3.5 5 5.5 5c1.54 0 3.04.99 3.57 2.36h1.87C15.46 5.99 16.96 5 18.5 5 20.5 5 22 6.5 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
            </svg>

            <!-- 숙소 이름 -->
            <h3>${lodgment.lod_name}</h3>

        </div>
    </c:forEach>
</div>

<input type="hidden" id="user-idx" value="${user_idx}" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/js/lodlike.js"></script>
</body>
</html>