<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>구경하개</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="/css/style.css?after"/>
    <%-- Date Range Picker --%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>
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
            <div class="selection-item">
                <div class="search-button" id="date-picker">
        <span>
            <img src="/img/search_icon_calendar.svg" class="calendar_icon" alt="calendar"/>
            <span id="checkin-date"></span> ~ <span id="checkout-date"></span>
            <span id="cal-date"></span>
        </span>
                </div>
            </div>


            <!-- 인원 및 반려동물 수 선택-->
            <div class="count-container">
                <!-- 필터 버튼 -->
                <button id="guest-button" class="count-selector">
                    <span class="guest-label"> 인원 <span id="guest-count">2</span>, 반려동물 <span id="pet-count">1</span>
                     </span>
                </button>

                <!-- 팝업: 인원 및 반려동물 수 조절 -->
                <div id="guest-popup" class="guest-popup hidden">
                    <!-- 인원 조절 -->
                    <div class="counter">
                        <div class="popup-header">인원ㅤㅤ</div>
                        <button id="minus-guest-btn" class="counter-btn">-</button>
                        <span id="guest-counter">2</span>
                        <button id="plus-guest-btn" class="counter-btn">+</button>
                    </div>

                    <!-- 반려동물 조절 -->
                    <div class="counter">
                        <div class="popup-header">반려동물</div>
                        <button id="minus-pet-btn" class="counter-btn">-</button>
                        <span id="pet-counter">1</span>
                        <button id="plus-pet-btn" class="counter-btn">+</button>
                    </div>

                    <p class="popup-subtitle">유아 및 아동도 인원수에 포함해주세요.</p>
                    <button id="apply-btn" class="apply-btn">완료</button>
                </div>
            </div>

            <!-- 타입 선택 -->
            <div class="type-container">
                <!-- 필터 버튼 -->
                <button id="type-button" class="type-selector">
                    <span class="type-label">전체</span>
                    <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>
                </button>

                <!-- 팝업: 타입 선택 -->
                <div id="type-popup" class="type-popup hidden">
                    <ul class="type-list">
                        <li class="type-item" data-value="전체" value="0">전체</li>
                        <li class="type-item" data-value="펜션" value="1">펜션</li>
                        <li class="type-item" data-value="글램핑" value="2">글램핑</li>
                    </ul>
                </div>
            </div>

            <!-- 반려동물 몸무게  선택 -->
            <div class="weight-container">
                <!-- 필터 버튼 -->
                <button id="weight-button" class="weight-selector">
                    <span class="weight-label">5kg 미만</span>
                    <img src="/img/search_icon_down.svg" class="icon" alt="arrow"/>
                </button>

                <!-- 팝업: 몸무게 선택 -->
                <div id="weight-popup" class="weight-popup hidden">
                    <ul class="weight-list">
                        <li class="weight-item" data-value="5kg 미만" value=0>5kg 미만</li>
                        <li class="weight-item" data-value="5kg 이상 ~ 10kg 이하" value=1>5kg 이상 ~ 10kg 이하</li>
                        <li class="weight-item" data-value="10kg 초과" value=2>10kg 초과</li>
                    </ul>
                </div>
            </div>

        </div>

        <div class="tab-container">
            <div class="tab active" id="tab-all" data-region="0">전체</div>
            <div class="tab inactive" id="tab-gangwondo" data-region="1">강원도</div>
            <div class="tab inactive" id="tab-gyeonggi" data-region="2">경기</div>
            <div class="tab inactive" id="tab-incheon" data-region="3">인천</div>
        </div>

        <div class="product-info">
            <div class="product-count"></div>
            <div class="product-text">개의 상품</div>
        </div>

        <div style="width: 1200px; height: 1px; background-color: #DBD6D6;"></div>

        <div class="result-container" id="result-container"></div>

        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    </div>
</div>
</body>
</html>