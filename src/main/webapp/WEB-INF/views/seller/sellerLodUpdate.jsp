<%--
  파일명 : sellerLodUpdate.jsp
  생성자 : JDeok
  날짜 : 2025.01.06
  기능 : 사장님 숙소수정 페이지
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>숙소 수정</title>
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link rel="stylesheet" href="/css/sellerSiderbar.css">
    <link rel="stylesheet" href="/css/sellerLodUpdate.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<div class="layout">
    <%-- 왼쪽 사이드바 포함 --%>
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %>

    <%-- 오른쪽 메인 컨텐츠 영역 --%>
    <main class="content">
        <h1>숙소 수정</h1>
        <hr id ="updateHR">
        <form action="/lodgment/UpdateLod.do" method="post" enctype="multipart/form-data">
            <!-- 숙소 소개 -->
            <div class="form-group">
                <label for="description">숙소 소개</label>
                <textarea id="description" name="seller_notice">${lodMap.SELLER_NOTICE}</textarea>
            </div>

            <!-- 예약 공지 -->
            <div class="form-group">
                <label for="reservationNotice">예약 공지</label>
                <textarea id="reservationNotice" name="reservation_notice">${lodMap.RESERVATION_NOTICE}</textarea>
            </div>

            <!-- 체크인/체크아웃 시간 -->
            <div class="time-selection">
                <label class="time-label">체크인/아웃 시간</label>
                <c:set var="checkin" value="${fn:split(lodMap.LOD_CHECK_IN, ':')}" />
                <c:set var="checkout" value="${fn:split(lodMap.LOD_CHECK_OUT, ':')}" />

                <%-- 체크인 --%>
                <select id="checkinAmPm" name="checkinAmPm">
                    <option value="AM" ${checkin[0] lt 12 ? 'selected' : ''}>오전</option>
                    <option value="PM" ${checkin[0] ge 12 ? 'selected' : ''}>오후</option>
                </select>
                <select id="checkinHour" name="checkinHour">
                    <c:forEach var="i" begin="1" end="12">
                        <c:choose>
                            <c:when test="${i < 10}">
                                <option value="0${i}" ${i eq (checkin[0] % 12 == 0 ? 12 : checkin[0] % 12) ? 'selected' : ''}>0${i}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i}" ${i eq (checkin[0] % 12 == 0 ? 12 : checkin[0] % 12) ? 'selected' : ''}>${i}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <select id="checkinMinute" name="checkinMinute">
                    <c:forEach var="i" begin="0" end="59" step="10">
                        <option value="${i == 0 ? '00' : i}" ${i == 0 ? '00' : i eq checkin[1] ? 'selected' : ''}>
                                ${i == 0 ? '00' : i}
                        </option>
                    </c:forEach>
                </select>

                <span>~</span>

                <%-- 체크아웃 --%>
                <select id="checkoutAmPm" name="checkoutAmPm">
                    <option value="AM" ${checkout[0] lt 12 ? 'selected' : ''}>오전</option>
                    <option value="PM" ${checkout[0] ge 12 ? 'selected' : ''}>오후</option>
                </select>
                <select id="checkoutHour" name="checkoutHour">
                    <c:forEach var="i" begin="1" end="12">
                        <c:choose>
                            <c:when test="${i < 10}">
                                <option value="0${i}" ${i eq (checkout[0] % 12 == 0 ? 12 : checkout[0] % 12) ? 'selected' : ''}>0${i}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i}" ${i eq (checkout[0] % 12 == 0 ? 12 : checkout[0] % 12) ? 'selected' : ''}>${i}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <select id="checkoutMinute" name="checkoutMinute">
                    <c:forEach var="i" begin="0" end="59" step="10">
                        <option value="${i == 0 ? '00' : i}" ${i == 0 ? '00' : i eq checkout[1] ? 'selected' : ''}>
                                ${i == 0 ? '00' : i}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <input type="hidden" id="checkinTime" name="lod_check_in" value="<c:out value='${lodMap.LOD_CHECK_IN}'/>">
            <input type="hidden" id="checkoutTime" name="lod_check_out" value="<c:out value='${lodMap.LOD_CHECK_OUT}'/>">

            <!-- 시설/서비스 -->
            <div class="facility-container">
                <div>
                    <div class="facility-input">
                        <label>시설/서비스</label>
                        <input type="text" id="facilityText" placeholder="시설/서비스를 입력하세요">
                        <button id="addFacilityBtn" type="button">추가</button>
                    </div>
                    <div class="selected-facilities">
                        <!-- 시설/서비스 동적 추가 -->
                        <c:forEach var="serviceItem" items="${service}">
                            <span class="facility-tag" data-value="${serviceItem}">
                                ${serviceItem}
                                <button class="remove-btn" type="button" onclick="removeFacility(this)">×</button>
                            </span>
                        </c:forEach>
                    </div>
                    <div id="hidden-fields">
                        <c:forEach var="serviceItem" items="${service}">
                            <input type="hidden" name="lod_facility" value="${serviceItem}">
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- 등록 버튼 -->
            <button type="submit" class="submit-button">숙소 정보 변경하기</button>
        </form>
    </main>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // 초기화 함수
        function initializeFields() {
            // JSP에서 전달된 데이터로 초기화
            const checkinHour = parseInt("<c:out value='${checkin[0]}' />", 10);
            const checkinMinute = "<c:out value='${checkin[1]}' />" === "0" ? "00" : "<c:out value='${checkin[1]}' />";
            const checkinAmPm = checkinHour < 12 ? "AM" : "PM";
            const formattedCheckinHour = checkinHour % 12 === 0 ? 12 : checkinHour % 12;

            // DOM 요소에 초기값 설정
            document.getElementById('checkinAmPm').value = checkinAmPm;
            document.getElementById('checkinHour').value = String(formattedCheckinHour).padStart(2, '0');
            document.getElementById('checkinMinute').value = checkinMinute;

            const checkoutHour = parseInt("<c:out value='${checkout[0]}' />", 10);
            const checkoutMinute = "<c:out value='${checkout[1]}' />" === "0" ? "00" : "<c:out value='${checkout[1]}' />";
            const checkoutAmPm = checkoutHour < 12 ? "AM" : "PM";
            const formattedCheckoutHour = checkoutHour % 12 === 0 ? 12 : checkoutHour % 12;

            document.getElementById('checkoutAmPm').value = checkoutAmPm;
            document.getElementById('checkoutHour').value = String(formattedCheckoutHour).padStart(2, '0');
            document.getElementById('checkoutMinute').value = checkoutMinute;

            updateHiddenFields();
        }

        // 숨겨진 필드 업데이트 함수
        function updateHiddenFields() {
            let checkinHourNumeric = parseInt(document.getElementById('checkinHour').value, 10);
            let checkinMinute = document.getElementById('checkinMinute').value;
            checkinMinute = checkinMinute === "0" ? "00" : checkinMinute; // 0을 00으로 변경
            if (document.getElementById('checkinAmPm').value === "PM" && checkinHourNumeric !== 12) {
                checkinHourNumeric += 12;
            } else if (document.getElementById('checkinAmPm').value === "AM" && checkinHourNumeric === 12) {
                checkinHourNumeric = 0;
            }
            const checkinTime = String(checkinHourNumeric).padStart(2, '0') + ":" + checkinMinute + ":00";
            document.getElementById('checkinTime').value = checkinTime;

            let checkoutHourNumeric = parseInt(document.getElementById('checkoutHour').value, 10);
            let checkoutMinute = document.getElementById('checkoutMinute').value;
            checkoutMinute = checkoutMinute === "0" ? "00" : checkoutMinute; // 0을 00으로 변경
            if (document.getElementById('checkoutAmPm').value === "PM" && checkoutHourNumeric !== 12) {
                checkoutHourNumeric += 12;
            } else if (document.getElementById('checkoutAmPm').value === "AM" && checkoutHourNumeric === 12) {
                checkoutHourNumeric = 0;
            }
            const checkoutTime = String(checkoutHourNumeric).padStart(2, '0') + ":" + checkoutMinute + ":00";
            document.getElementById('checkoutTime').value = checkoutTime;
        }

        // 10분 단위로 값 조정 함수
        function enforceMinuteStep(value) {
            const rounded = Math.round(value / 10) * 10;
            return String(rounded).padStart(2, '0');
        }

        // 이벤트 리스너 추가
        document.querySelectorAll('#checkinAmPm, #checkinHour, #checkinMinute, #checkoutAmPm, #checkoutHour, #checkoutMinute')
            .forEach(element => {
                element.addEventListener('change', function () {
                    if (this.id.includes("Minute")) {
                        this.value = enforceMinuteStep(this.value);
                    }
                    updateHiddenFields();
                });
            });

        // 초기화 실행
        initializeFields();
    });

</script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const updateHiddenFields = () => {
            const selectedFacilities = [];
            document.querySelectorAll('.facility-tag').forEach(tag => {
                const value = tag.getAttribute('data-value');
                if (value) selectedFacilities.push(value);
            });

            const hiddenFieldsContainer = document.getElementById('hidden-fields');
            hiddenFieldsContainer.innerHTML = ''; // 기존 필드 초기화
            selectedFacilities.forEach((facility) => {
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'lod_facility'; // 배열 형태로 전송
                hiddenInput.value = facility;
                hiddenFieldsContainer.appendChild(hiddenInput);
            });
        };

        // "추가" 버튼 클릭 이벤트
        document.getElementById('addFacilityBtn').addEventListener('click', function () {
            const facilityInput = document.getElementById('facilityText'); // 입력 필드
            const facilityValue = facilityInput.value.trim(); // 입력 값 가져오기

            if (facilityValue) {
                // 새 태그 생성
                const newTag = document.createElement('span');
                newTag.classList.add('facility-tag');
                newTag.setAttribute('data-value', facilityValue); // 데이터 값 설정
                newTag.innerHTML =  facilityValue + `<button class="remove-btn" type="button">×</button>`;

                // 화면에 추가
                document.querySelector('.selected-facilities').appendChild(newTag);

                // 새로 생성된 삭제 버튼에 이벤트 추가
                newTag.querySelector('.remove-btn').addEventListener('click', function () {
                    newTag.remove();
                    updateHiddenFields();
                });

                // 입력 필드 초기화 및 숨겨진 필드 업데이트
                updateHiddenFields();
                facilityInput.value = ''; // 입력 필드 초기화
            }
        });

        // 기존 삭제 버튼 이벤트 추가
        document.querySelectorAll('.remove-btn').forEach(button => {
            button.addEventListener('click', function () {
                const tag = this.closest('.facility-tag');
                if (tag) tag.remove();
                updateHiddenFields();
            });
        });

        // 초기 숨겨진 필드 설정
        updateHiddenFields();
    });

</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // JSP 데이터를 JavaScript 변수로 전달
        const success = ${success ? 'true' : 'false'}; // JSP에서 success 값을 Boolean으로 처리
        const errorMessage = "${fn:escapeXml(errorMessage)}"; // JSP의 errorMessage 값 처리 (Null-safe)

        if (success === true) {
            alert("정상적으로 처리됐습니다.");
            window.location.href = "/lodgment/sellerDetailMain.do";
        } else if (errorMessage) {
            alert(errorMessage);
        }
    });
</script>


</body>
</html>