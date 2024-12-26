<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="/css/style.css?after"/>
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
            <%--            <div class="swiper-button-prev">--%>
            <%--                <img src="/img/home_left_foot.svg" class="paw-button">--%>
            <%--            </div>--%>
            <%--            <div class="swiper-button-next">--%>
            <%--                <img src="/img/home_right_foot.svg" class="paw-button">--%>
            <%--            </div>--%>
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
                <a href=""><img src="/img/home_thumbnail_gangwon.png"></a>
                <a href=""><img src="/img/home_btn_gangwon.svg" style="width: 128px; height: 50px;"></a>
            </div>
            <div class="section">
                <a href=""><img src="/img/home_thumbnail_gyeonggi.svg"></a>
                <a href=""><img src="/img/home_btn_gyeonggi.svg" style="width: 128px; height: 50px;"></a>
            </div>
            <div class="section">
                <a href=""><img src="/img/home_thumbnail_incheon.svg"></a>
                <a href=""><img src="/img/home_btn_incheon.svg" style="width: 128px; height: 50px;"></a>
            </div>
        </div>
        <div class="home_plus_btn">
            <a href="/search/search.do"><img src="/img/home_btn_plus.svg" width="200px" height="65px">
            </a>
        </div>
        <div style="width: 1200px; height: 1px; background-color: #DBD6D6; margin: 60px auto;"></div>
        <div class="news_section">
            <!-- 왼쪽 영역 -->
            <div class="news_left">
                <div class="news_left_title">
                    <img src="/img/home_txt_sub_fun.svg" style="width: 246px; height: 52px;">
                    <a href=""><img src="/img/home_btn_fun_plus.svg" style="width: 24px; height: 24px;"></a>
                </div>
                <div class="news_item">
                    <div class="news_item_icon"><a href=""><img src="/img/home_btn_event.svg"
                                                                style="width: 126px; height: 45px;"></a></div>
                    <div class="news_item_text"><a href="">너와 함께하개! 미션 스탬프 투어</a></div>
                </div>
                <div class="news_item">
                    <div class="news_item_icon"><a href=""><img src="/img/home_btn_sports.svg"
                                                                style="width: 126px; height: 45px;"></a></div>
                    <div class="news_item_text"><a href="">누가 누가 제일 잘 달리나 시험하개</a></div>
                </div>
                <div class="news_item">
                    <div class="news_item_icon"><a href=""><img src="/img/home_btn_bazaar.svg"
                                                                style="width: 126px; height: 45px;"></a></div>
                    <div class="news_item_text"><a href="">너가 더 잘 어울리개 내가 싸게 줄개</a></div>
                </div>
            </div>
            <!-- 오른쪽 영역 -->
            <div class="news_right">
                <a href=""><img src="/img/home_thumbnail_fun.svg" style="width: 530px; height: 250px;"></a>
            </div>
        </div>
        <div style="width: 1200px; height: 1px; background-color: #DBD6D6; margin: 60px auto;"></div>
        <div class="notice_section">
            <div class="notice_title">
                <img src="/img/home_txt_sub_notice.svg" style="width: 351px; height: 52px;">
            </div>
            <div class="notice_item">
                <div class="notice_text"><img src="/img/home_txt_sub_notice_1.svg"
                                              style="width: 1195px; height: 133px;"></div>
            </div>
            <div class="notice_item">
                <div class="notice_text"><img src="/img/home_txt_sub_notice_2.svg"
                                              style="width: 1195px; height: 133px;"></div>
            </div>
            <div class="notice_item">
                <div class="notice_text"><img src="/img/home_txt_sub_notice_3.svg"
                                              style="width: 1195px; height: 133px;"></div>
            </div>
        </div>
        <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    </div>
</body>
</html>
