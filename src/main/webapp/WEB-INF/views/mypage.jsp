<%--
  Created by IntelliJ IDEA.
  User: 이윤채
  Date: 2024-12-24
  Time: 오전 10:02
  To change this template use File | Settings | File Templates.
--%>
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
            <link rel="stylesheet" href="/css/mypageStyle.css"/>
        </head>
        <body>
        <div class="wrap">
            <%@ include file="/WEB-INF/views/include/header.jsp" %>
            <div class="profilImg" style="background-image: url('/img/mypage_user_profil.svg');"></div>
            <div class="mypageBox">
                <%@ include file="/WEB-INF/views/include/mypageMenu.jsp" %>
            </div>
            <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>
