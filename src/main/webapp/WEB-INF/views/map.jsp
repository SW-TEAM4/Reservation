<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>카카오 지도 테스트</title>
</head>
<body>
<div id="map" style="width:500px;height:400px;"></div>

<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=71180ffc5bc9d9a75e44c3840f393ad2&autoload=false&libraries=clusterer,services"></script>
<script type="text/javascript">
  // Kakao Maps API 초기화
  kakao.maps.load(function() {
    var container = document.getElementById('map'); // 지도를 표시할 div
    var options = {
      center: new kakao.maps.LatLng(37.790863, 126.298854), // 중심좌표
      level: 3 // 확대 레벨
    };
    var map = new kakao.maps.Map(container, options); // 지도 생성
    var markerPosition  = new kakao.maps.LatLng(37.790863, 126.298854);  // 마커가 표시될 위치

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
</body>
</html>