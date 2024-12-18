<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>같이가개</title>
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <script src="/js/home.js"></script>
</head>
<body>
<div class="wrap">
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <div class="visual">
        <div class="swiper swiper-visual">
            <div class="swiper-wrapper">
                <div class="swiper-slide" style="background-image:url('/img/home_thumbnail_visual_1.svg');"></div>
                <div class="swiper-slide" style="background-image:url('/img/home_thumbnail_visual_2.svg');"></div>
            </div>
        </div>
    </div>
    <div class="home_txt">
        <div class="txt_main">
            <img src="/img/home_txt_main.svg">
        </div>
        <div class="txt_sub">
            <img src="/img/home_txt_sub.svg">
        </div>
    </div>
    <div class="container">
        <div class="size">
            <div class="section">
                <a href=""><img src="/img/home_thumbnail_seoul.png"></a>
                <a href=""><img src="/img/home_btn_seoul.svg" style="width: 128px; height: 50px;"></a>
            </div>
            <div class="section">
                <a href=""><img src="/img/home_thumbnail_gyeonggi.svg"></a>
                <a href=""><img src="/img/home_btn_incheon.svg" style="width: 128px; height: 50px;"></a>
            </div>
            <div class="section">
                <a href=""><img src="/img/home_thumbnail_incheon.svg"></a>
                <a href=""><img src="/img/home_btn_gyeonggi.svg" style="width: 128px; height: 50px;"></a>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
