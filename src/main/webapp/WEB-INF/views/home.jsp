<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>같이가개</title>
  <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
  <link rel="stylesheet" href="/css/style.css"/>
  <script src="/js/home.js"></script>
</head>
<body>
<div class="wrap">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <div class="visual">
    <div class="swiper swiper-visual">
      <div class="swiper-wrapper">
        <div class="swiper-slide" style="background-image:url('/img/home_visual1.svg');"></div>
        <div class="swiper-slide" style="background-image:url('/img/home_visual2.svg');"></div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>