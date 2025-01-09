<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>최근 본 숙소</title>
  <link rel="stylesheet" href="/css/style.css"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/css/lodrecently.css"/>
  <script src="/js/recently.js"></script>
</head>
<body>
<div class="wrap">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <div class="container">
    <div class="top-container">
      <img class="arrow-icon" id="left-arrow" src="/img/home_icon_left_arrow.svg"/>
      <div class="header-text">최근 본 숙소</div>
    </div>
    <div class="recently-room-list" id="recently-rooms-container"></div>
  </div>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>