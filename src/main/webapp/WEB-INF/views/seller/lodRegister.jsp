<%--
  파일명 : lodRegister.jsp
  생성자 : JDeok
  날 짜  : 2024.12.23
  시 간  : 오후 02:10
  기 능  : 사장님 숙소등록 페이지
  변경사항
     - 2024.12.23 : JDeok(최초작성)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>숙소 등록</title>

    <%-- CSS 파일 연결 (공통 헤더와 페이지 전용 스타일) --%>
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link rel="stylesheet" href="/css/lodRegister.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">
</head>
<body>
<%-- 현재 페이지 정보 설정 (헤더에서 사용) --%>
<%
    /**
     * 숙소등록화면 일 때 상단헤더에 "숙소등록" 문구 필요
     */
    request.setAttribute("currentPage", "lodRegister");
%>

<%-- 헤더 파일 포함 --%>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<%-- 컨테이너 시작 (전체 폼을 포함하는 영역) --%>
<div class="container">

    <%-- 숙소 등록 폼 시작 --%>
    <form action="/lodgment/insertLod.do" method="post" enctype="multipart/form-data">

        <%-- 숙소명 입력 --%>
        <div class="form-group">
            <label for="accommodationName">숙소명</label>
            <input type="text" id="accommodationName" name="lod_name" required>
        </div>

        <%-- 사업주 이메일 --%>
        <div class="form-group">
            <label for="accommodationName">사업주 이메일</label>
            <input type="text" id="accommodationEmail" name="biz_email" required>
        </div>

        <%-- 사업자 번호 입력 --%>
        <%-- [check] 사업자번호 숫자만 시간남으면 사업자번호 대조 api 넣어서 확인--%>
        <%-- [check]사업자번호 정규화 패턴  길이 수 체크 --%>
        <div class="form-group">
            <label for="businessNumber">사업자 번호</label>
            <input type="text" id="businessNumber" name="biz_num" required>
        </div>

        <%-- 숙소 전화번호 입력 --%>
        <%-- [check] 전화번호 정규화 패턴--%>
        <div class="form-group">
            <label for="contactNumber">숙소 전화번호</label>
            <input type="tel" id="contactNumber" name="lod_phone_number" required>
        </div>


        <%-- 숙소 대표 사진 업로드 --%>
            <%--[check] 숙소사진 필수처리 --%>
        <div class="form-group">
            <label for="mainImage">숙소 대표 사진</label>
            <input type="file" id="mainImage" name="lod_img" accept="image/*">
        </div>

        <%-- 지역 유형 선택 (강원/경기/인천) --%>
        <div class="other-group">
            <div class="box"></div>
            <label class="other-label">지역 유형</label>
            <div class="other-type">
                <label><input type="radio" class="location" name="region_idx" value="1" required> 강원</label>
                <label><input type="radio" class="location" name="region_idx" value="2"> 경기</label>
                <label><input type="radio" class="location" name="region_idx" value="3"> 인천</label>
            </div>
        </div>

            <!-- 우편번호 버튼 -->
        <div class="lod-group">
            <div class="box"></div>
            <label for="postcode" class="lod-label">숙소 주소</label>
            <div class="address-inputs">
                <input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly>
                <button type="button" class="btn-postcode">우편주소</button>
            </div>
        </div>
        <div>
            <label></label>
            <input type="text" id="detailedAddress" name="lod_address" placeholder="주소" class="address-input" readonly>
        </div>
            <input type="hidden" id="mapX" name="x">
            <input type="hidden" id="mapY" name="y">

        <%-- 숙소 소개 입력 --%>
        <div class="form-group">
            <label for="description">예약 공지</label>
            <input type="text" id="description" name="reservation_notice">
        </div>

        <%-- 사장님이 알려주개 입력 --%>
        <div class="form-group">
            <label for="ownerTip">사장님이 알려주개</label>
            <input type="text" id="ownerTip" name="seller_notice">
        </div>

        <%-- 체크인/체크아웃 시간 선택 --%>
            <%-- [check] UI 조절 필요 --%>
        <div class="time-selection">
            <div class="box"></div>
            <label class="time-label">체크인/아웃 시간</label>
            <select id="checkinAmPm" name="checkinAmPm">
                <option value="AM">오전</option>
                <option value="PM">오후</option>
            </select>
            <select id="checkinHour" name="checkinHour">
                <% for (int i = 1; i <= 12; i++) { %>
                <option value="<%= String.format("%02d", i) %>"><%= String.format("%02d", i) %></option>
                <% } %>
            </select>
            <select id="checkinMinute" name="checkinMinute">
                <% for (int i = 0; i < 60; i += 10) { %>
                <option value="<%= String.format("%02d", i) %>"><%= String.format("%02d", i) %></option>
                <% } %>
            </select>

            <span>~</span>

            <select id="checkoutAmPm" name="checkoutAmPm">
                <option value="AM">오전</option>
                <option value="PM">오후</option>
            </select>
            <select id="checkoutHour" name="checkoutHour">
                <% for (int i = 1; i <= 12; i++) { %>
                <option value="<%= String.format("%02d", i) %>"><%= String.format("%02d", i) %></option>
                <% } %>
            </select>
            <select id="checkoutMinute" name="checkoutMinute">
                <% for (int i = 0; i < 60; i += 10) { %>
                <option value="<%= String.format("%02d", i) %>"><%= String.format("%02d", i) %></option>
                <% } %>
            </select>
        </div>
            <input type="hidden" id="checkinTime" name="lod_check_in">
            <input type="hidden" id="checkoutTime" name="lod_check_out">

        <%-- 시설/서비스 추가 --%>
        <div class="facility-container">
            <div class="box"></div>
            <label class="other-label">시설/서비스</label>
            <div>
                <div class="facility-input">
                    <input type="text" id="facilityText" placeholder="시설/서비스를 입력하세요">
                    <button id="addFacilityBtn" type="button">추가</button>
                </div>
                <div class="selected-facilities">
                    <span class="facility-tag" data-value="와이파이">와이파이 <button class="remove-btn" onclick="removeFacility(this)">×</button></span>
                    <span class="facility-tag" data-value="주차장">주차장 <button class="remove-btn" onclick="removeFacility(this)">×</button></span>
                    <span class="facility-tag" data-value="바비큐">바비큐 <button class="remove-btn" onclick="removeFacility(this)">×</button></span>
                    <span class="facility-tag" data-value="스파/풀장">스파/풀장 <button class="remove-btn" onclick="removeFacility(this)">×</button></span>
                </div>
                <div id="hidden-fields"></div>
            </div>

        </div>

        <%-- 숙소 유형 선택 --%>
        <div class="form-group">
            <label>숙소 유형</label>
            <div class="accommodation-type">
                <label><input type="radio" name="lod_category_idx" value="1" required> 펜션</label>
                <label><input type="radio" name="lod_category_idx" value="2"> 글램핑 </label>
            </div>
        </div>
            <%-- 등록 버튼 --%>
            <button type="submit" class="submit-button">숙소 정보 등록하기</button>
    </form>
</div>

<%-- JavaScript 파일 연결 --%>
<script src="/js/facility.js"></script>
<script src="/js/timeStep.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=cd3f60c442b3dcdb9c54d4dc8c7282d7&libraries=services"></script>
<script>
    /*우편주소*/
    document.addEventListener('DOMContentLoaded', () => {
        const postcodeButton = document.querySelector('.btn-postcode');

        postcodeButton.addEventListener('click', function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    const addressInput         = document.getElementById('postcode');
                    const detailedAddressInput = document.getElementById('detailedAddress');
                    const mapX                 = document.getElementById('mapX');
                    const mapY                 = document.getElementById('mapY');

                    addressInput.value = data.zonecode; // 우편번호
                    detailedAddressInput.value = data.address; // 기본 주소

                    // Kakao Maps API가 로드되었는지 확인
                    if (window.kakao && kakao.maps && kakao.maps.services) {
                        const geocoder = new kakao.maps.services.Geocoder();
                        geocoder.addressSearch(data.address, function (result, status) {
                            if (status === kakao.maps.services.Status.OK) {
                                const lat = result[0].y;
                                const lng = result[0].x;

                                mapX.value = lat;
                                mapY.value = lng;

                            } else {
                                console.error('Kakao Geocoding 실패:', status);
                            }
                        });
                    } else {
                        console.error('Kakao Maps API가 로드되지 않았습니다.');
                    }
                }
            }).open();
        });
    });
</script>
<script>
    /* 시설/서비스 */
    document.addEventListener('DOMContentLoaded', function () {
        const updateHiddenFields = () => {
            const selectedFacilities = [];
            document.querySelectorAll('.facility-tag').forEach(tag => {
                const value = tag.getAttribute('data-value');
                if (value) selectedFacilities.push(value);
            });

            // 히든 필드 업데이트
            const hiddenFieldsContainer = document.getElementById('hidden-fields');
            hiddenFieldsContainer.innerHTML = ''; // 기존 필드 초기화
            selectedFacilities.forEach((facility, index) => {
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = `lod_facility`; // 배열 형태로 전송
                hiddenInput.value = facility;
                hiddenFieldsContainer.appendChild(hiddenInput);
            });
        };

        // 페이지 로드 시 초기 값 설정
        updateHiddenFields();

        // 삭제 버튼 클릭 이벤트
        document.querySelectorAll('.remove-btn').forEach(button => {
            button.addEventListener('click', function () {
                const tag = this.closest('.facility-tag');
                if (tag) tag.remove();
                updateHiddenFields();
            });
        });
    });

</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const contactNumberInput = document.getElementById('contactNumber');

        // 입력 중 하이픈 추가
        contactNumberInput.addEventListener('input', function () {
            let value = this.value.replace(/[^0-9]/g, ''); // 숫자만 허용
            if (value.length <= 3) {
                this.value = value;
            } else if (value.length <= 7) {
                this.value = value.slice(0, 3) + '-' + value.slice(3);
            } else {
                this.value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7, 11);
            }
        });

        // 전송 시 하이픈 제거
        const form = document.querySelector('form');
        form.addEventListener('submit', function () {
            const rawValue = contactNumberInput.value.replace(/-/g, ''); // 하이픈 제거
            contactNumberInput.value = rawValue;
        });
    });
</script>


</body>
</html>
