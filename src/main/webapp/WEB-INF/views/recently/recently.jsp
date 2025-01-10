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
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      // back 화살표 클릭 동작 이벤트 추가
      const arrowIcon = document.getElementById("left-arrow");
      if (arrowIcon) {
        arrowIcon.addEventListener("click", function () {
          if (document.referrer) { // 이전 페이지가 있으면
            window.history.back(); // 이전 페이지로 이동
          } else { // 이전 페이지가 없으면
            window.location.href = '/home.do'; // 홈페이지로 이동
          }
        });
      }
    });
    document.addEventListener('click', function (event) {
      if (event.target.classList.contains('delete-room-button')) {
        const roomIdx = event.target.getAttribute('data-room-idx');
        deleteRoomFromLocalStorage(roomIdx); // 로컬 스토리지에서 삭제
        removeRoomFromDOM(event.target.closest('.room-card')); // 화면에서 제거
      }
    });
  </script>
</head>
<body>
<div class="wrap">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <div class="container">
    <div class="top-container">
      <img class="arrow-icon" id="left-arrow" src="/img/home_icon_left_arrow.svg"/>
      <div class="header-text">최근 본 객실</div>
    </div>
    <div class="recently-room-list" id="recently-rooms-container"></div>
  </div>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>