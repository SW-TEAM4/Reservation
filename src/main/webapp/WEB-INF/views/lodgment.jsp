<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>숙소 상세</title>
  <link rel="stylesheet" href="/css/style.css"/>
  <style>
    .visual img {
      width: 100%;
      max-height: 400px;
      object-fit: cover;
      margin-bottom: 20px;
    }
    #map {
      width: 100%;
      height: 400px;
      margin-top: 20px;
    }
  </style>
</head>
<body>
<div class="wrap">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <div class="visual">
    <c:if test="${not empty lodgment.lodgment}">
      <img src="${lodgment.lodgment.lod_img_url}" alt="${lodgment.lodgment.lod_name}">
      <p>숙소 이름: ${lodgment.lodgment.lod_name}</p>
      <p>숙소 주소: ${lodgment.lodgment.lod_address}</p>
      <p>평균 평점: ${lodgment.lodgment.avg_rating}</p>

      <div class="room-list">
        <c:forEach var="room" items="${roomList}">
          <%@ include file="/WEB-INF/views/roomcard.jsp" %>
        </c:forEach>
      </div>

      <!-- 지도 표시 -->
      <div id="map" style="width:500px;height:400px;"></div>
      <script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=71180ffc5bc9d9a75e44c3840f393ad2&autoload=false&libraries=clusterer,services"></script>
      <script type="text/javascript">
        // Kakao Maps API 초기화
        kakao.maps.load(function() {
          var container = document.getElementById('map'); // 지도를 표시할 div
          var options = {
            center: new kakao.maps.LatLng(${lodgment.lodgment.x}, ${lodgment.lodgment.y}), // 중심좌표
            level: 3 // 확대 레벨
          };
          var map = new kakao.maps.Map(container, options); // 지도 생성
          var markerPosition  = new kakao.maps.LatLng(${lodgment.lodgment.x}, ${lodgment.lodgment.y});  // 마커가 표시될 위치

          var imageSrc = "img/lodgment_map_marker.png"; // 마커 이미지
          var imageSize = new kakao.maps.Size(64, 69); // 마커 사이즈
          var imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커 위치
          var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)

          var marker = new kakao.maps.Marker({  // 마커 생성
            position: markerPosition,
            image: markerImage,
          });

          marker.setMap(map);
        });
      </script>
    </c:if>
    <c:if test="${empty lodgment.lodgment}">
      <p>숙소 정보를 찾을 수 없습니다.</p>
    </c:if>
  </div>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>
</body>
</html>