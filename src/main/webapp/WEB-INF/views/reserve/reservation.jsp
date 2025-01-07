<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/uuid@8.3.2/dist/umd/uuid.min.js"></script>
    <link rel="stylesheet" href="/css/style.css"/>
    <style>
        .total-container-wrapper{
            width: 1200px;
            display: flex;
            justify-content: center;
            flex-direction: column;
            box-sizing: border-box;
            margin: 40px auto;
        }
        .total-container{
            width: 100%;
            display: flex;
            justify-content: center;
            flex-direction: column;
            align-items: center;
        }
        .reserve-info, .reserver-info, .payment-info{
            width: 100%;
            box-sizing: border-box;
            padding: 35px 20px;
            border-top: 1px solid #ccc; /* 아래쪽 선 */
        }
        .top-container{
            height: 70px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-top: 1px solid #ccc; /* 위쪽 선 */
            padding: 10px 20px; /* 컨테이너 내부 여백 */
            position: relative;
        }
        .top-container .arrow-icon{
            width: 24px;
            height: 24px;
            cursor: pointer;
        }
        .top-container .header-text{
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }
        .reserve-container{
            width: 1200px;
            display: flex;
            justify-content: center;
            flex-direction: column;
            align-items: center;
            max-width: 100%;
            margin-bottom: 14px;
            box-sizing: border-box;
        }
        .star{
            display: inline-block;
            position: absolute;
            font-size: 14px;
            color: #FF3B3E;
            top: 0;
        }
        .error-message {
             color: #FF3B3E; /* 빨간색으로 표시 */
             font-size: 12px; /* 작은 크기로 표시 */
             margin-top: 5px; /* 입력 필드와 오류 메시지 간격 */
         }
        .line-input{
            margin-top:25px
        }
        .line-input input[type="text"] {
            margin-top: 20px;
            border: none; /* 박스 테두리 제거 */
            border-bottom: 2px solid #ccc; /* 밑줄만 보이도록 설정 */
            padding: 5px 0; /* 위 아래 여백만 설정 */
            font-size: 20px; /* 글자 크기 */
            font-family: "Noto Sans KR", serif;
            font-weight: bold;
            outline: none; /* 기본 포커스 외곽선 제거 */
            width: 500px;
            box-sizing: border-box; /* 패딩과 테두리를 포함한 크기 */
        }

        .line-input input[type="text"]:focus {
            border-bottom: 2px solid #007BFF; /* 포커스 시 밑줄 색상 변경 */
            box-shadow: none; /* 포커스 시 그림자 없애기 */
        }

        .line-input input[type="text"]::placeholder {
            color: #888; /* 플레이스홀더 색상 */
            font-family: "Noto Sans KR", serif;
        }
        .payment-button{
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            width: 100%; /* 버튼 크기 설정 */
            height: 77px;
            box-sizing: border-box;
            border-radius: 10px; /* 둥근 모서리 */
            background-color: #352018; /* 배경 색상 */
            color: white; /* 텍스트 색상 */
            font-size: 24px; /* 글씨 크기 설정 */
            font-weight: bold; /* 글씨 굵게 설정 */
            cursor: pointer; /* 클릭 시 포인터 표시 */
            border: none; /* 테두리 제거 */
        }
        .payment-button img{
            margin-right: 20px;
            width: 24px;
            height: auto;
        }
        .lod-info{
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: 100%;
            padding: 20px 0;
            box-sizing: border-box;
            font-weight: bold;
        }
        .lod-info div{
            margin-bottom: 10px;
        }
        .time-info{
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-top: 20px;
        }
        .time-info .checkin {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            flex: 1;
            text-align: left;
        }
        .time-info .checkout {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            flex: 1;
            text-align: center;
            position: relative; /* 텍스트 위치 조정 */

        }
        .time-info * .date{
            font-family: "Noto Sans KR", sans-serif;
            font-weight: bold;
            font-size: 26px;
            color: #352018;
            border: none; /* 테두리 제거 */
            background: none; /* 배경 제거 */
            outline: none; /* 포커스 시 나타나는 아웃라인 제거 */
            padding: 0; /* 내부 여백 제거 */
            cursor: default; /* 기본 포인터로 변경 */
        }
        .time-info * .check-time{
            font-size: 20px;
            color: #564B4B;
        }
        .guest-info {
            display: flex;
            align-items: center; /* 이미지와 텍스트를 수직으로 중앙 정렬 */
            margin-top: 5px; /* 위 요소와 간격 */
            font-size: 15px; /* 텍스트 크기 */
            color: #564B4B; /* 텍스트 색상 */
        }
        .guest-info img {
            width: 16px; /* 아이콘 크기 */
            height: 16px;
            margin-right: 8px; /* 아이콘과 텍스트 간격 */
        }
        .guest-info input[type="number"] {
            width: auto;
            border: none; /* 테두리 제거 */
            background: none; /* 배경 제거 */
            text-align: center; /* 숫자 가운데 정렬 */
            pointer-events: none; /* 사용자가 수정 불가 (readonly 보조) */
            font-size: 15px; /* 텍스트 크기 */
            font-family: "Noto Sans KR", sans-serif;
            font-weight: bold;
            color: #564B4B; /* 텍스트 색상 */
        }
        .amount-info{
            margin-top: 40px;
            display: flex;
            justify-content: end;
        }
        .payment-info {
            display: flex;
            justify-content: space-between; /* 양쪽 끝에 배치 */
            align-items: center; /* 세로 정렬 */
        }
        .payment-info input[type="number"] {
            font-family: "Noto Sans KR", sans-serif;
            font-weight: bold;
            font-size: 20px;
            color: #FF3B3E;
            text-align: right; /* 가격 입력칸의 숫자 오른쪽 정렬 */
            border: none; /* 테두리 제거 */
            background: none; /* 배경 제거 */
            padding: 0; /* 내부 여백 제거 */
        }
    </style>

</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="total-container-wrapper">
    <div class="top-container">
        <img class="arrow-icon" id="left-arrow" src="/img/home_icon_left_arrow.svg"/>
        <div class="header-text">예약하기</div>
    </div>
    <div class="total-container">
        <form class="reserve-container" id="reserveForm" action="/reservation/saveReservationPayment.do" method="post">
            <div class="reserve-info">
            <%--<div style="font-size: 20px;">숙소 idx: ${roomDTO.lod_idx}</div>--%>
            <%--<div>방 idx: ${roomDTO.room_idx}</div>--%>
                <div class="lod-info">
                    <div class="lod-title" style="font-size: 20px;">숙소</div>
                    <div class="lod-name"  style="font-size: 32px">${lodDTO.lod_name}</div>
                    <div class="room-name" style="font-size: 26px">${roomDTO.room_name}</div>
                </div>
                <div class="time-info">
                    <div class="checkin">
                        <div style="color: #352018; font-size: 20px">체크인</div>
                        <input class="date" type="text" id="res_str_date" name="reservationDTO.res_str_date" value="${reservationDTO.res_str_date}" readonly>
                        <div class="check-time" id="lod_check_in">${formattedCheckinTime}</div>
                        <div class="guest-info">
                            <img src="/img/reservation_icon_user.svg" alt="reservation_user_icon">
                            <span>
                                성인 ${reservationDTO.res_people_cnt}명 / 반려동물 ${reservationDTO.res_pets_cnt}마리
                            </span>
                        </div>
                    </div>
                    <div class="checkout">
                        <div style="color: #352018; font-size: 20px;">체크아웃</div>
                        <input class="date" type="text" id="res_end_date" name="reservationDTO.res_end_date" value="${reservationDTO.res_end_date}" readonly>
                        <div class="check-time" id="lod_check_out">${formattedCheckoutTime}</div>
                    </div>
                </div>
                <div class="amount-info">
                    <span style="font-size: 14px; color: #564B4B;">숙박 / ${dayDifference}</span>
                    <span style="font-size: 20px; font-weight:bold; color: #FF3B3E; margin-left: 5px">${formattedRoomPrice}원</span>
                </div>

                <%-- TODO 유저 정보 로그인 구현 되면 수정 필요 --%>
                <input type="hidden" id="user_idx" name="reservationDTO.user_idx" value="1">
                <input type="hidden" id="lod_idx" name="reservationDTO.lod_idx" value="${roomDTO.lod_idx}"/>
                <input type="hidden" id="room_idx" name="reservationDTO.room_idx" value="${roomDTO.room_idx}"/>
                <input type="hidden" id="res_people_cnt" name="reservationDTO.res_people_cnt" value="${reservationDTO.res_people_cnt}" readonly>
                <input type="hidden" id="res_pets_cnt" name="reservationDTO.res_pets_cnt" value="${reservationDTO.res_pets_cnt}" readonly>
                <input type="hidden" id="res_merchant_id" name="reservationDTO.res_merchant_id"/>
                <input type="text" id="request" name="reservationDTO.request">요청사항</input>
                <input type="hidden" id="reservation_idx" name="paymentDTO.reservation_idx" value="${reservationDTO.reservation_idx}">
                <input type="hidden" id="payment_status" name="paymentDTO.payment_status" value="not_paid"> <p/>
            </div>

            <div class="reserver-info">
                <div style="display: inline-block; margin-top:25px; position: relative; font-size: 26px; font-weight: bold; color: #352018;">예약자 정보<span class="star">*</span></div>
                <div class="line-input">
                    <div style="position: relative; font-size: 20px; color: #564B4B;">성명<span class="star">*</span></div>
                    <input type="text" id="res_name" name="reservationDTO.res_name" placeholder="예약자의 성명을 입력해 주세요." value="${userDTO.USER_NAME}">
                    <div id="nameError" class="error-message"></div> <!-- 이름 오류 메시지 -->

                    <div style="position: relative; margin-top:25px; font-size: 20px; color: #564B4B;">휴대폰 번호<span class="star">*</span></div>
                    <input type="text" id="res_phone_number" name="reservationDTO.res_phone_number" placeholder="예약자의 휴대폰 번호를 입력해 주세요." value="${userDTO.USER_PHONE_NUMBER}"><p/>
                    <div id="phoneError" class="error-message"></div> <!-- 전화번호 오류 메시지 -->
                </div>
            </div>

            <div class="payment-info">
                <div class="payment-left">
                    <span style="font-weight: bold; font-size: 26px; color: #352018;">총 결제 금액</span>
                    <span style="font-size: 20px; color: #564B4B">(세금 및 봉사료 포함)</span>
                </div>
                <div class="payment-right">
                    <input type="number" id="paid_money" name="paymentDTO.paid_money" value="${roomDTO.room_price}">원
                </div>
            </div>

            <button class="payment-button" id="port_type_card" name="card" onclick="showPaymentMethods('card')">
                <img src="/img/button_foot.svg" alt="payment_foot_icon">
                결제하기
            </button>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script>
    document.addEventListener("DOMContentLoaded", function(){

        // 결제 버튼 클릭 시 입력한 폼 검증 및 결제 동작 추가
        document.getElementById('port_type_card').addEventListener('click', function(event) {
            event.preventDefault();
            // 유효성 검사
            const resName = $('#res_name').val().trim();
            const resPhoneNumber = $('#res_phone_number').val().trim();
            const phonePattern = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/; // 전화번호 정규식

            let isValid = true; // 유효성 검사 플래그

            // 이름 검증
            if (!resName) {
                $('#nameError').text("예약자 이름을 입력해주세요.");
                $('#res_name').focus();
                isValid = false;
            } else {
                $('#nameError').text(""); // 오류 메시지 지우기
            }

            // 전화번호 검증
            if (!phonePattern.test(resPhoneNumber)) {
                $('#phoneError').text("전화번호 형식을 올바르게 입력해주세요. (예: 010-1234-5678)");
                $("#res_phone_number").focus();
                isValid = false;
            } else {
                $('#phoneError').text(""); // 오류 메시지 지우기
            }

            // 유효성 검사 통과하지 않으면 결제 요청을 하지 않음
            if (!isValid) {
                return;
            }

            // 고유한 uuid를 이용해 상품 번호 생성
            document.getElementById("res_merchant_id").value = uuid.v4();
            console.log("res_merchant: " + document.getElementById("res_merchant_id").value);
            // 예약 폼 데이터를 수집 -> formData를 비동기 처리에 이용하기 위해 JSON 형태로
            const reserveFormData = new FormData(document.getElementById('reserveForm'));
            const jsonObject = {};

            reserveFormData.forEach((value, key) => {
                const keys = key.split('.');
                let current = jsonObject;
                for (let i = 0; i < keys.length - 1; i++) {
                    if (!current[keys[i]]) current[keys[i]] = {};
                    current = current[keys[i]];
                }
                current[keys[keys.length - 1]] = value;
            });
            console.log("JSON 데이터: ", JSON.stringify(jsonObject));

            // AJAX로 서버에 결제 정보 처리 저장 요청
            fetch('/reservation/saveReservationPayment.do', {
                method: 'POST',
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(jsonObject),
            })
                .then(response => response.json())  // 서버에서 JSON 응답 받기
                .then(data => {
                    if (data.success) {
                        // 예약 정보가 성공적으로 저장되었을 때 결제 예정 정보 저장 후 결제 진행
                        const reservationPaymentDTO = data.reservationPaymentDTO;
                        const userDTO = data.userDTO;
                        // #debug
                        console.log("data.ReservationPaymentDTO: ", reservationPaymentDTO + "message: "+data.message);
                        console.log("userDTO: " + userDTO);
                        showPaymentMethods("card", reservationPaymentDTO, userDTO);
                    } else {
                        console.log(data.message);
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('예약 정보 전송 실패:', error);
                    alert("예약 정보 전송에 실패했습니다.");
                });
        });

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

    // 제출할 예약 폼 검사
    function checkReserveFrom(){
        // 예약자 이름 입력 값 체크
        $('#res_name').on('input', function() {
            const resName = $('#res_name').val().trim();
            if (!resName) {
                $('#nameError').text("예약자 이름을 입력해주세요.");
            } else {
                $('#nameError').text(""); // 오류 메시지 지우기
            }
        });

        // 예약자 전화번호 입력 값 체크
        $('#res_phone_number').on('input', function() {
            const resPhoneNumber = $('#res_phone_number').val().trim();
            const phonePattern = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/; // 전화번호 정규식

            // 전화번호가 올바르지 않으면 오류 메시지 표시
            if (!phonePattern.test(resPhoneNumber)) {
                $('#phoneError').text("전화번호 형식을 올바르게 입력해주세요. (예: 010-1234-5678)");
            } else {
                $('#phoneError').text(""); // 오류 메시지 지우기
            }
        });
    }



    // db에 예약 정보 저장 후 결제 수단 띄우기
    function showPaymentMethods(paymentMethod, reservationPaymentDTO, userDTO){
        const { paymentDTO, reservationDTO } = reservationPaymentDTO;
        // 아임포트 SDK 초기화
        const IMP = window.IMP;
        IMP.init("imp46755844");
        console.log("reeservationPaymentDTO from showPayment:" + reservationPaymentDTO);
        // 결제 요청
        IMP.request_pay(
            {
                channelKey: "channel-key-de5f405c-2f6f-4272-be09-e103f3485376",
                pay_method: paymentMethod,
                merchant_uid: reservationDTO.res_merchant_id, // 서버에서 받은 주문번호
                name:  `결제 테스트 ${lodDTO.lod_name} ${roomDTO.room_name}`,
                amount: paymentDTO.paid_money, // 결제 금액
                buyer_email: userDTO.USER_EMAIL,
                buyer_name:  userDTO.USER_NAME,
                buyer_tel: userDTO.USER_PHONE_NUMBER,
            },
            async function(response) {
                // 결제 과정에서 error 발생시 생성했던 reservation, payment 정보 삭제
                if (response.error_code != null) {
                    // 결제창에서의 결제 과정에서 에러 발생
                    try{
                        const cancel = await fetch("/reservation/deleteReservationPayment.do",{
                            method: "POST",
                            headers: { "Content-Type": "application/json" },
                            body: JSON.stringify({
                                merchant_id: response.merchant_uid
                            })
                        });

                        const cancelResponse = await cancel.json();
                        console.log(cancelResponse);
                    } catch (e) {
                        console.error("결제 취소 및 데이터 삭제 중 오류 발생: ", e);
                    }
                    return alert("결제에 실패하였습니다 : " + response.error_msg);
                }else{
                    try{
                        const notified = await fetch(`https://shinhan.me/payment/complete`,{
                            method: "POST",
                            headers: { "Content-Type": "application/json" },
                            body: JSON.stringify({
                                imp_uid: response.imp_uid,
                                merchant_uid: response.merchant_uid,
                            }),
                        });

                        const serverResponse = await notified.json(); // JSON 파싱

                        if (serverResponse.success) {
                            console.log("서버 응답 처리 완료: " + serverResponse.message);

                            window.location.href = "/payment/payment.do";
                        } else {
                            alert(serverResponse.message);
                            try{
                                const cancel = await fetch("/reservation/deleteReservationPayment.do",{
                                    method: "POST",
                                    headers: { "Content-Type": "application/json" },
                                    body: JSON.stringify({
                                        merchant_id: response.merchant_uid
                                    })
                                });

                                const cancelResponse = await cancel.json();
                                console.log(cancelResponse);
                            } catch (e) {
                                console.error("결제 취소 및 데이터 삭제 중 오류 발생: ", e);
                            }
                        }
                    } catch (e){
                        console.error("서버 통신 에러:", e);
                        alert("결제 검증 중 통신 오류가 발생했습니다.");
                    }
                }
            }
        );
    }
</script>
</body>
</html>
