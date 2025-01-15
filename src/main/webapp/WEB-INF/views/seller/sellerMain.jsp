<%--
  파일명 : sellerMain.jsp
  생성자 : JDeok
  날 짜  : 2024.12.23
  시 간  : 오전 10:14
  기 능  : 사장님 메인페이지(jsp)
  변경사항
     - 2024.12.23 : JDeok(최초작성)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>반려동물과 함께하는 여행</title>                                   <!-- 브라우저 탭에 표시될 제목 -->
  <link rel="stylesheet" href="/css/sellerHeader.css">                  <!-- CSS 파일 연결(header)  -->
  <link rel="stylesheet" href="/css/sellerMain.css">                    <!-- CSS 파일 연결          -->
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">

</head>
<body>
<div class="container">
  <!-- 헤더 시작 -->
  <%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <main class="main-content">
    <img src="/img/seller_main.svg" alt="강아지" class="background-image"> <!-- 배경 이미지  -->
    <div class="text-container">
      <h2>반려동물과 같이 하는 여행</h2>                                        <!-- 큰 제목     -->
      <p>반려견과 함께하는 즐거운 여행,<br>
        반려견과 즐거운 추억을 쌓을 수 있는 장소를 제공하는 "같이가개"입니다.</p>      <!-- 본문 텍스트 -->
    </div>
    <div class="buttons">
      <button onclick="location.href='/sellerlogin'" class="btn">로그인</button>                   <!-- 로그인 버튼 -->
      <button onclick="location.href='/sellerregister'" class="btn btn-signup">회원가입</button>    <!-- 회원가입 버튼 -->
    </div>
  </main>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
