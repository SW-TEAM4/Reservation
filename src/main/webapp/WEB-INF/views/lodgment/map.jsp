<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>카카오 지도 테스트</title>
</head>
<body>
<div id="map" style="width:${mapWidth};height:${mapHeight};"></div>

<!-- JSP에서 동적 데이터 전달 -->
<script type="text/javascript">
  var centerX = ${lodgmentDTO.x};
  var centerY = ${lodgmentDTO.y};
</script>

<script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=1d380a4ab6f52b94fa5c601a140044ca&autoload=false&libraries=clusterer,services"></script>
<script type="text/javascript">
  // Kakao Maps API 초기화
  kakao.maps.load(function() {
    var container = document.getElementById('map'); // 지도를 표시할 div

    // 동적으로 전달된 좌표 값 사용
    var options = {
      center: new kakao.maps.LatLng(centerX, centerY), // 중심 좌표 설정
      level: 3 // 확대 레벨
    };

    var map = new kakao.maps.Map(container, options); // 지도 생성

    // 마커 위치 설정 (동적 데이터 사용)
    var markerPosition = new kakao.maps.LatLng(centerX, centerY);

    var imageSrc = "img/lod_map_marker.png"; // 마커 이미지 경로
    var imageSize = new kakao.maps.Size(64, 69); // 마커 사이즈 설정
    var imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커 위치 조정 옵션
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

    var marker = new kakao.maps.Marker({  // 마커 생성 및 설정
      position: markerPosition,
      image: markerImage,
    });

    marker.setMap(map); // 마커를 지도에 표시
  });
</script>
</body>
</html>
