<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2024-12-12
  Time: 오전 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
    <title>같이가개 회원가입</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<%--    <link rel="stylesheet" href="/css/sellerHeader.css">--%>
    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .total {
            width: 1280px;
            height: 800px;
        }

        body {
            font-family: "Noto Sans KR";
            background-color: #fff;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .header {
            width: 100%;
            background-color: #8A5642;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .header .logo {
            height: 44px;
            width: 150.91px;
            position: absolute;
            left: 20px;
            cursor: pointer;
            top: 5px;
        }

        .header .register {
            width: 74px;
            height: 22px;
            margin: 0 auto;
            cursor: pointer;
        }

        .container {
            width: 100%;
            max-width: 1280px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .register-form {
            width: 100%;
            max-width: 600px;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 30px;
        }

        .name_wrap {
            width: 486px;
        }

        .SELLER_NAME {
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin: 5px;
        }

        .name_wrap input {
            width: 100%;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .name_wrap input::placeholder {
            color: #aaaaaa;
            font-family: "Noto Sans KR";
        }

        .nick_name_wrap {
            width: 486px;
        }

        .SELLER_NICK_NAME {
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin: 2px;
        }

        .nick_name_wrap input {
            width: 100%;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .nick_name_wrap input::placeholder {
            color: #aaaaaa;
            font-family: "Noto Sans KR";
        }

        .phone_number_wrap {
            width: 486px;
        }

        .SELLER_PHONE_NUMBER {
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin: 2px;
        }

        .phone_number_wrap input {
            width: 100%;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .phone_number_wrap input::placeholder {
            color: #aaaaaa;
            font-family: "Noto Sans KR";
        }

        .id_wrap {
            width: 486px;
        }

        .SELLER_ID {
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin: 2px;
        }

        .id_wrap input {
            width: 100%;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .id_wrap input::placeholder {
            color: #aaaaaa;
            font-family: "Noto Sans KR";
        }

        .pw_wrap {
            width: 486px;
        }

        .SELLER_PWD {
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin: 2px;
        }

        .pw_wrap input {
            width: 100%;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .pw_wrap input::placeholder {
            color: #aaaaaa;
            font-family: "Noto Sans KR";
        }

        .pwck_wrap {
            width: 486px;
        }

        .SELLER_PWD_CK {
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin: 2px;
        }

        .pwck_wrap input {
            width: 100%;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .pwck_wrap input::placeholder {
            color: #aaaaaa;
            font-family: "Noto Sans KR";
        }

        .email_wrap {
            width: 486px;
        }

        .SELLER_EMAIL {
            color: #8A5642;
            font-family: "Noto Sans KR";
            margin: 2px;
        }

        .email_wrap input {
            width: 100%;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .email_wrap input::placeholder {
            color: #aaaaaa;
            font-family: "Noto Sans KR";
        }

        .email_send_button {
            width: 486px;
            height: 40px;
            background-color: #8A5642;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 2px;
            text-align: center;
        }

        .email_check_input {
            width: 486px;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
        }

        .register_button {
            width: 486px;
            height: 40px;
            padding: 10px;
            margin: 2px;
            border: 2px solid #8A5642;
            border-radius: 5px;
            cursor: pointer;
            background-color: #8A5642;
            color: white;
            margin-bottom: 10px;
        }

        /* 아이디가 존재하지 않을 경우 */
        .id_input_re_1 {
            color: green;
            display: none;
            font-size: 14px;
            margin-left: 5px;
        }

        /* 아이디가 존재하는 경우 */
        .id_input_re_2 {
            color: red;
            display: none;
            font-size: 14px;
            margin-left: 5px;
        }

        /* 아이디가 현식엥 만족하지 않을 경우 */
        .id_input_re_3 {
            color: red;
            display: none;
            font-size: 14px;
            margin-left: 5px;
        }

        .footer {
            width: 100%; /* 푸터의 너비를 전체로 설정 */
            text-align: center;
            border-top: 1px solid #929292; /* 상단 테두리 설정: 너비, 스타일, 색상 */
        }

        .footer > .size {
            height: 156px;
            margin: 0 auto;
        }

        .size {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .footer > .size > .info > p {
            line-height: 20px;
            color: gray;
            font-weight: bold;
            margin: 0;
        }

    </style>
</head>
<body>
    <div class="header">
        <a href="/home.do">
            <img src="/img/main_logo.svg" class="logo" alt="logo">
        </a>
        <a href="/sellerregister">
            <img src="/img/register.svg" class="register" alt="register">
        </a>
    </div>
<div class="total">
    <div class="container">
        <form class="register-form" id="register_form" method="post" onsubmit="return registerCheck();">
            <div class="name_wrap">
                <div class="SELLER_NAME">이름</div>
                <div class="name_input_box">
                    <input type="text" class="name_input" id="SELLER_NAME" name="SELLER_NAME" placeholder="홍길동" required>
                </div>
            </div>
            <div class="nick_name_wrap">
                <div class="SELLER_NICK_NAME">닉네임</div>
                <div class="nick_name_input_box">
                    <input type="text" class="nick_name_input" id="SELLER_NICK_NAME" name="SELLER_NICK_NAME" placeholder="밍구" required>
                </div>
            </div>
            <div class="phone_number_wrap">
                <div class="SELLER_PHONE_NUMBER">휴대폰번호</div>
                <div class="seller_phone_number_input_box">
                    <input type="text" class="Seller_Phone_Number_input" id="SELLER_PHONE_NUMBER" name="SELLER_PHONE_NUMBER" placeholder="01012345678" required>
                    <span id="phone_error_message" style="display: none; color: red; font-size: 14px; margin-left: 5px;">올바른 전화번호 형식을 입력하시오.</span>
                </div>
            </div>
            <div class="id_wrap">
                <div class="SELLER_ID">아이디</div>
                <div class="seller_id_input_box">
                    <input type="text" class="seller_id_input" id="SELLER_ID" name="SELLER_ID" minlength="4" maxlength="20" placeholder="영문 혹은 영문+숫자 4~20자" required>
                </div>
                <span class="id_input_re_1">사용 가능한 아이디입니다.</span>
                <span class="id_input_re_2">아이디가 이미 존재합니다.</span>
                <span class="id_input_re_3">사용 불가능한 아이디입니다. 형식에 맞춰 입력해주세요</span>
            </div>
            <div class="pw_wrap">
                <div class="SELLER_PWD">비밀번호</div>
                <div class="pwd_input_box">
                    <input type="password" class="pwd_input" id="SELLER_PWD" name="SELLER_PWD" maxlength="16" placeholder="영문+숫자+특수기호 8자 이상 16자 이하" required>
                    <span id="passwordWarning" style="color: red; display: none; font-size: 14px; margin-left: 5px;">사용할 수 없는 비밀번호입니다.</span>
                </div>
            </div>
            <div class="pwck_wrap">
                <div class="SELLER_PWD_CK">비밀번호 확인</div>
                <div class="pwck_input_box">
                    <input type="password" class="pwck_input" id="SELLER_PWD2" name="SELLER_PWD2" onkeyup="passConfirm()" placeholder="비밀번호 재입력" required>
                    <span id="confirmMsg" style="font-size: 14px; margin-left: 5px;"></span>
                </div>
            </div>
            <div class="email_wrap">
                <div class="SELLER_EMAIL">이메일 주소</div>
                <div class="email_input_box">
                    <input type="email" class="email_input" name="SELLER_EMAIL" id="SELLER_EMAIL" placeholder="이메일 주소" required>
                    <input type="button" value="인증번호 전송" class="email_send_button" id="email_auth">
                    <div class="timerDisplay" id="timerDisplay"></div>
                    <input type="text" class="email_check_input" placeholder="인증번호 6자리를 입력해주세요." maxlength="6" name="authCode" id="authCode">
                    <span id="emailAuthWarn" style="font-size: 14px; margin-left: 5px;"></span>
               </div>
            </div>
            <div>
                <input type="submit" value="가입하기" class="register_button" id="register_button">
            </div>
        </form>
    </div>
</div>
    <div class="footer">
        <div class="size">
            <div class="info">
                <p>이용약관 | 개인정보처리방침 | 고객센터</p><br>
                <p>ⓒ4Team Corp.</p>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // 회원가입 버튼(회원가입 기능 작동)
            $(".register_button").click(function() {
                $("#register_form").attr("action", "/sellerregister");
                $("#register_form").submit();
            });
        });

        // 아이디 공백 입력 방지
        $('.seller_id_input').on("input", function() {
            var value = $(this).val();
            $(this).val(value.replace(/\s/g, "")); // 공백 제거
        });

        // 비밀번호 입력 필드에서 공백 입력 방지
        $('.pwd_input').on("input", function() {
            var value = $(this).val();
            $(this).val(value.replace(/\s/g, "")); // 공백 제거
        });

        // 이름 공백 입력 방지
        $('.name_input').on("input", function() {
            var value = $(this).val();
            $(this).val(value.replace(/\s/g, "")); // 공백 제거
        });

        // 닉네임 공백 입력 방지
        $('.nick_name_input').on("input", function() {
            var value = $(this).val();
            $(this).val(value.replace(/\s/g, "")); // 공백 제거
        });

        // 이메일 공백 입력 방지
        $('.email_input').on("input", function() {
            var value = $(this).val();
            $(this).val(value.replace(/\s/g, "")); // 공백 제거
        });

        // 아이디 중복검사
        $('.seller_id_input').on("propertychange change keyup paste input", function() {

            var SELLER_ID = $('.seller_id_input').val();

            // 입력값에서 한글 및 특수기호 제거 (영문, 숫자, 언더스코어(_)만 허용)
            var filteredID = SELLER_ID.replace(/[^a-zA-Z0-9_]/g, '');
            if (SELLER_ID !== filteredID) {
                $(this).val(filteredID); // 잘못된 문자가 포함된 경우 필터링된 값으로 업데이트
                SELLER_ID = filteredID; // 필터링된 값을 변수에 다시 할당
            }

            var data = {SELLER_ID : SELLER_ID}

            // 정규 표현식, 최소 4자 이상, 영문, 숫자, 언더스코어(_)만 허용
            var idPattern = /^[a-zA-Z0-9]{4,}$/;

            if (SELLER_ID === "") {
                // 입력 필드가 비어 있을 경우
                $('.id_input_re_1').css("display", "none"); // "사용 가능한 아이디입니다." 숨김
                $('.id_input_re_2').css("display", "none"); // 경고 메시지 표시 x
                $('.id_input_re_3').css("display", "none"); // 아이디 형식에 만족하지 않을 경우 경고 메시지
                return false;
            } else if(!idPattern.test(SELLER_ID)) {
                // 유효성 검사 실패
                $('.id_input_re_1').css("display", "none"); // "사용 가능한 아이디입니다." 숨김
                $('.id_input_re_2').css("display", "none"); // 경고 메시지 표시 x
                $('.id_input_re_3').css("display", "inline-block"); // 아이디 형식에 만족하지 않을 경우 경고 메시지
                return false;
            } else {
                //유효성 검사 통과
                $('.id_input_re_3').css("display", "none");

                $.ajax({
                    type: "POST",
                    url: "/SELLER_ID_CHECK",
                    data: data,
                    success: function (result) {
                        console.log("성공 여부 : " + result);
                        if (result != 'fail') {
                            $('.id_input_re_1').css("display", "inline-block");
                            $('.id_input_re_2').css("display", "none");
                        } else {
                            $('.id_input_re_2').css("display", "inline-block");
                            $('.id_input_re_1').css("display", "none");
                        }
                    } // success 종료
                }); // ajax 종료
            }
        }); // function 종료

        // 비밀번호 유효성 검사
        function validatePassword() {
            var SELLER_PWD = document.getElementById('SELLER_PWD');
            var passwordWarning = document.getElementById('passwordWarning');

            // 정규식: 영문 대소문자, 숫자, 특수문자 포함 8자 이상
            var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$/;

            if (passwordRegex.test(SELLER_PWD.value)) {
                passwordWarning.style.display = 'inline'; // 비밀번호가 유효한 경우 경고 메시지 숨김
                passwordWarning.textContent = "사용 가능한 비밀번호입니다.";
                passwordWarning.style.color = 'green';
                return true;
            } else {
                passwordWarning.style.display = 'inline'; // 비밀번호가 유효하지 않으면 경고 메시지 표시
                passwordWarning.textContent = "사용할 수 없는 비밀번호입니다.";
                passwordWarning.style.color = 'red';
                return false;
            }
        }
        // 비밀번호 입력 시 유효성 검사
        document.getElementById('SELLER_PWD').addEventListener('input', validatePassword);

        // 빈 입력칸 alert문 및 회원가입 버튼 클릭 예외 처리
        function registerCheck() {
            if ($("#SELLER_NAME").val() == '') {
                alert("이름을 입력해 주세요");
                $("#SELLER_NAME").focus();
                return false;
            }
            if ($("#SELLER_NICK_NAME").val() == '') {
                alert("닉네임을 입력해 주세요");
                $("#SELLER_NICK_NAME").focus();
                return false;
            }
            const PHONE_NUMBER = $("#SELLER_PHONE_NUMBER").val();
            const phonePattern = /^(\d{3})-(\d{4})-(\d{4})$/;

            if(PHONE_NUMBER === '') {
                alert("전화번호를 입력해 주세요");
                $("#SELLER_PHONE_NUMBER").focus();
                return false;
            } else if(!phonePattern.test(PHONE_NUMBER)) {
                alert("올바른 전화번호 형식을 입력해 주세요. 예) : 010-1234-5678 ");
                $("#SELLER_PHONE_NUMBER").focus();
                return false;
            }
            const idPattern = /^[a-zA-Z0-9]{4,}$/;
            const SELLER_ID = $("#SELLER_ID").val();

            if(SELLER_ID === '') {
                alert("아이디를 입력해 주세요");
                $("#SELLER_ID").focus();
                return false;
            } else if(!idPattern.test(SELLER_ID)) {
                alert("올바른 아이디 형식을 입력해 주세요.");
                $("#SELLER_ID").focus();
                return false;
            }
            if ($("#SELLER_PWD").val() == '') {
                alert("비밀번호를 입력해 주세요");
                $("#SELLER_PWD").focus();
                return false;
            }
            if (!validatePassword()){
                alert("조건을 만족하는 비밀번호를 입력해 주세요")
                $("#SELLER_PWD").focus();
                return false;
            }
            if ($("#SELLER_PWD2").val() == '') {
                alert("비밀번호를 재입력해 주세요");
                $("#SELLER_PWD2").focus();
                return false;
            }
            if ($("#SELLER_PWD").val() !== $("#SELLER_PWD2").val()) {
                alert("비밀번호가 일치하지 않습니다");
                $("#SELLER_PWD2").focus();
                return false;
            }
            if ($("#SELLER_EMAIL").val() == '') {
                alert("이메일을 입력해 주세요");
                $("#SELLER_EMAIL").focus();
                return false;
            }
            if ($("#authCode").val() == '') {
                alert("이메일 인증 후 인증번호를 입력해 주세요");
                $("#authCode").focus();
                return false;
            }
            const inputCode = $("#authCode").val();

            if (Number(inputCode) !== code) {
                alert("인증번호가 일치하지 않습니다. 다시 확인해주세요!");
                $("#authCode").focus();
                return false;
            }
        }

        // 전화번호 입력 시 자동으로 "-" 추가
        document.getElementById("SELLER_PHONE_NUMBER").addEventListener("input", function(e) {
            let input = e.target.value;

            // 숫자만 남기기
            input = input.replace(/\D/g, "");

            // 포맷팅 (010-1234-5678 형식)
            if (input.length <= 3) {
                e.target.value = input;
            } else if (input.length <= 7) {
                e.target.value = input.slice(0, 3) + "-" + input.slice(3);
            } else {
                e.target.value = input.slice(0, 3) + "-" + input.slice(3, 7) + "-" + input.slice(7, 11);
            }

            // 전화번호 유효성 검사 (010-xxxx-xxxx 형식으로만 허용)
            const phonePattern = /^(\d{3})-(\d{4})-(\d{4})$/;

            if (phonePattern.test(e.target.value)) {
                // 유효한 전화번호일 경우 경고 메시지 숨기기
                document.getElementById("phone_error_message").style.display = "none";
            } else {
                // 유효하지 않은 전화번호일 경우 경고 메시지 표시
                document.getElementById("phone_error_message").style.display = "block";
                return false;
            }
        });

        // 인증번호 코드 변수 선언
        let code;

        // 인증번호 타이머 함수
        $(document).ready(function() {
            let timer;
            let timeLeft = 180; // 3분

            // 타이머 함수
            function startTimer() {
                clearInterval(timer); // 이전 타이머가 있다면 초기화
                timeLeft = 180; // 타이머 초기화

                timer = setInterval(function() {
                    if(timeLeft <= 0) {
                        clearInterval(timer);
                        alert("인증번호 입력 시간이 만료되었습니다. 다시 인증번호를 요청해주세요.");
                        $("#email_auth").attr("disabled", false); // 인증번호 전송 버튼 활성화
                        $("#authCode").val("").attr("disabled", true); // 인증번호 입력 비활성화
                    } else {
                        timeLeft--;
                        const minutes = Math.floor(timeLeft / 60);
                        const seconds = timeLeft % 60;
                        if(seconds > 9) {
                            $(".timerDisplay").text("남은 시간: " + minutes + ":" + seconds);
                        } else {
                            $(".timerDisplay").text("남은 시간: " + minutes + ":0" + seconds);
                        }
                    }
                }, 1000);
            };

            // 인증번호 이메일 전송
            $("#authCode").attr("disabled", true); // 인증번호 입력 비활성화

            $("#email_auth").click(function() {
                const SELLER_EMAIL = $("#SELLER_EMAIL").val(); // 사용자가 입력한 이메일 값 얻어오기

                // Ajax로 전송
                $.ajax({
                    url : "./seller_email_auth",
                    data : {
                        SELLER_EMAIL : SELLER_EMAIL
                    },
                    type : "POST",
                    dataType : "json",
                    success : function(result) {
                        $("#authCode").attr("disabled", false); // 인증번호 입력 활성화
                        $("#email_auth").attr("disabled", true); // 인증번호 전송 버튼 비활성화
                        code = result;
                        alert("인증번호가 입력하신 이메일로 전송 되었습니다.");
                        startTimer(); // 타이머 시작
                    }, // success 종료
                    error: function() {
                        alert("인증번호 전송에 실패했습니다. 다시 시도해주세요.");
                    }
                }); // ajax 종료
            });
            // 인증 코드 비교
            $("#authCode").on("focusout", function() {
                const inputCode = $("#authCode").val(); // 인증번호 입력 칸에 작성한 내용 가져오기

                if(Number(inputCode) === code) {
                    $("#emailAuthWarn").html('인증번호가 일치합니다.');
                    $("#emailAuthWarn").css('color', 'green');
                    $("#email_auth").attr('disabled', true);
                    $("#SELLER_EMAIL").attr('readonly', true);
                    clearInterval(timer); // 타이머 중지
                } else {
                    $("#emailAuthWarn").html('인증번호가 불일치합니다. 다시 확인해주세요!');
                    $("#emailAuthWarn").css('color', 'red');
                }
            });
            // 초기 타이머 표시 업데이트
            const initialMinutes = Math.floor(timeLeft / 60);
            const initialSeconds = timeLeft % 60;
            $("#timerDisplay").text("남은 시간: " + initialMinutes + ":0" + initialSeconds);
        });

        // 비밀번호 비교 함수
        function passConfirm() {
            var SELLER_PWD = document.getElementById('SELLER_PWD');
            var SELLER_PWD2 = document.getElementById('SELLER_PWD2');
            var confirmMsg = document.getElementById('confirmMsg');
            var correctColor = "#008000FF"
            var wrongColor = "#FF0000FF"

            if ( SELLER_PWD.value == "" || SELLER_PWD2.value == "") {
                confirmMsg.style.color = wrongColor;
                confirmMsg.innerHTML = "비밀번호를 입력해주세요.";
                return false;
            } else if(SELLER_PWD.value === SELLER_PWD2.value) {
                confirmMsg.style.color = correctColor;
                confirmMsg.innerHTML = "비밀번호가 일치합니다.";
            } else {
                confirmMsg.style.color = wrongColor;
                confirmMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
                return false;
            }
        }

        // 사용자가 USER_PWD 또는 USER_PWD2 입력란에서 타이핑을 마치면 passConfirm() 호출
        document.getElementById('SELLER_PWD').addEventListener('blur', passConfirm);
        document.getElementById('SELLER_PWD2').addEventListener('blur', passConfirm);
    </script>
</body>
</html>
