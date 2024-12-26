<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>
    <style>
        .payment-buttons {
            margin: 20px 0;
        }
    </style>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>
    <form id="reserveForm" action="/reserve/saveReserve.do" method="post">
        <div type="number" id="lod_idx" name="lod_idx">숙소 idx: ${roomDTO.lod_idx}</div><div/>
        <div type="number" id="room_idx" name="room_idx">방 idx: ${roomDTO.room_idx}</div><div/>
        <input type="number" id="user_idx" name="user_idx" value="1">user idx</input><div/>
        <div class="reserve_info">
            <input type="hidden" id="res_merchant_id" name="res_merchant_id">
            <input type="text" id="res_name" name="res_name"><div/>
            <input type="text" id="res_phone_number" name="res_phone_number" ></input><div/>
            <input type="datetime-local" id="res_str_date" name="res_str_date">예약 시작 날짜</input><div/>
            <input type="datetime-local" id="res_end_date" name="res_end_date">예약 종료 날짜</input><div/>
            <input type="number" id="res_people_cnt" name="res_people_cnt">people cnt</input><div/>
            <input type="number" id="res_pets_cnt" name="res_pets_cnt">pet cnt</input><div/>
            <input type="text" id="request" name="request">요청사항</input><div/>
            <input type="hidden" id="req_status" name="req_status" value="A"><div/>
        </div>
        <div class="payment-buttons">
            <button id="port_type_card" name="card" onclick="showPaymentMethods('card')">카드 결제</button>
        </div>
        <input type="submit" value="예약정보 저장" hidden="hidden">
    </form>

    <form id="paymentForm" action="/reserve/saveReserve.do" method="post">
        <div class="payment_info">
            <input type="hidden" name="reservation_idx">
            <input type="number" id="paid_money" name="paid_money"> 가격 <div/>
            <input type="hidden" id="payment_status" name="payment_status" value="N"> <div/>
        </div>
        <input type="submit" value="페이 지불 정보 저장">
    </form>


    <script>
        // 결제 버튼 클릭 시 결제 진행
        document.getElementById('port_type_card').addEventListener('click', function() {
            requestPayment('card');
        });

        // db에 예약 정보 저장 후 결제 수단 띄우기
        function showPaymentMethods(paymentMethod){
            // 기본적으로 form 제출을 막고
            event.preventDefault();
            // db에 예약 정보 저장 (status='N')
            document.getElementById("res_merchant_id").value = "order_test" + document.getElementById("user_idx").value;
            document.getElementById("reserveForm").submit();

            // 결제 정보 처리 - 실제 계정의 주인의 정보로 결제 정보 아임포트에 저장
            const order_id = getElementById("res_merchant_id");
            const amount = 10000; // 금액
            const buyerName = "${user.user_name}"; // 구매자 실제 USERS 테이블의 이름
            const buyerEmail = "${user.user_email}"; // 구매자 이메일
            const buyerTel = "${user.user_phone_number}"; // 구매자 전화번호



            // 아임포트 sdk 초기화
            IMP.init("imp46755844");

            // 결제 요청
            IMP.request_pay(
                {
                    channelKey: "channel-key-de5f405c-2f6f-4272-be09-e103f3485376",
                    pay_method: paymentMethod,
                    merchant_uid: order_id, // 주문번호 로직 처리 필요
                    name: "결제 테스트",
                    amount: amount, // 결제 금액
                    buyer_email: buyerEmail,
                    buyer_name: buyerName,
                    buyer_tel: buyerTel
                },
                function (response) {
                    // 결제 종료 시 호출되는 콜백 함수
                    // response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
                    // 결제 결과를 처리하는 로직을 작성합니다.
                    if(response){
                        console.log("결제성공" + response);
                        // 결제가 성공하면 form을 제출 -> db 저장
                        document.getElementById("reserveForm").submit();
                    } else{
                        alert("결제실패" + response);
                    }
                },
            );
        }
    </script>


</body>
</html>
