<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>구경하개</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <script src="/js/search.js"></script>
</head>
<body>
<div class="wrap">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="container">
        <div class="search_txt">
            <div class="txt_main">
                <img src="/img/search_txt_main.svg">
            </div>
            <div class="txt_sub">
                <img src="/img/search_txt_sub.svg">
            </div>
        </div>
        <div class="search_filters">

            <!-- 날짜 선택 -->
            <div class="button" id="date-picker">
            <span>
              <img src="/img/search_icon_calendar.svg" class="calendar_icon" alt="calendar"/>
              12.12 ~ 12.13, 1박
            </span>
            </div>

            <!-- 최대 인원수 -->
            <div class="button max-button" id="max-selector">
                <span>성인 0, 반려동물 0</span>
                <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>
            </div>

            <!-- 전체 / 펜션 / 글램핑 -->
            <div class="button max-button">
            <select class="select" name="type">
                <option value="type_all">전체</option>
                <option value="type_pension">펜션</option>
                <option value="type_glamping">글램핑</option>
            </select>
                <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>
            </div>

            <!-- 반려동물 몸무게 -->
            <div class="button max-button">
                <select class="select" name="kg">
                    <option value="kg_5kg">5kg 미만</option>
                    <option value="kg_5-10kg">5kg 이상 ~ 10kg 이하ㅤ</option>
                    <option value="kg_10kg">10kg 초과</option>
                </select>
                <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>
            </div>

        </div>
        <div class="tab-container">
            <a href="#" class="tab active" id="tab-all">전체</a>
            <a href="#" class="tab inactive" id="tab-seoul">서울</a>
            <a href="#" class="tab inactive" id="tab-gyeonggi">경기</a>
            <a href="#" class="tab inactive" id="tab-incheon">인천</a>
        </div>
        <div class="product-info">
            <div class="product-count">144</div>
            <div class="product-text">개의 상품</div>
        </div>
        <div class="size">
            <%@ include file="/WEB-INF/views/include/footer.jsp" %>
        </div>
</body>
</html>
