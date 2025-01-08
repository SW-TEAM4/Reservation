<%--
  Created by IntelliJ IDEA.
  User: 이윤채
  Date: 2024-12-24
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>같이가개 - 예약상세</title>
  <!-- Google Fonts에서 Noto Sans KR 불러오기 -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/css/style.css?after"/>
<%--  <link rel="stylesheet" href="/css/mypageStyle.css"/>--%>

  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #ffffff;
    }

    .header-bar {
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
      border-top: 1px solid #929292;
      border-bottom: 1px solid #929292;
      padding: 20px 0;
      margin-top: 50px;
      margin-bottom: 30px;
    }

    .back-button {
      position: absolute;
      left: 10px;
      background: none;
      border: none;
      font-size: 20px;
      cursor: pointer;
    }

    .back-button img {
      width: 24px;
      height: 24px;
    }

    .header-title {
      font-size: 20px;
      color: #352018;
      font-weight: bold;
    }

    .reservation-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;

    }

    .reservation-details {
      display: flex;
      flex-wrap: wrap;
      background-color: #ffffff;
      border-radius: 10px;
      margin-bottom: 50px;
      font-weight: bold;
    }

    .reservation-header {
      width: 100%;
      line-height: 0.8;
      text-align: left;
    }

    /* 예약일시 스타일 */
    .created-date {
      font-size: 20px; /* 폰트 크기 */
      color: #352018; /* 텍스트 색상 */
      opacity: 0.5; /* 50% 불투명 */
    }

    /* 숙소 이름 스타일 */
    .lod-name {
      font-size: 32px; /* 폰트 크기 */
      color: #352018; /* 텍스트 색상 */
      font-weight: bold; /* 굵은 글씨 */
    }

    /* 방 이름 스타일 */
    .room-name {
      font-size: 26px; /* 폰트 크기 */
      color: #352018; /* 텍스트 색상 */
      font-weight: bold; /* 굵은 글씨 */

    }


    .reservation-details img {
      width: 510px;
      height: 319px;
      object-fit: cover;
      border-radius: 10px;
      margin-right: 20px;
    }


    .reservation-details {
      display: flex;
      flex-wrap: wrap; /* 필요한 경우 줄 바꿈 */
      background-color: #ffffff;
      border-radius: 10px;
      margin-bottom: 50px;
    }

    .reservation-info-container {
      display: flex;
      justify-content: space-between; /* 좌우로 배치 */
      align-items: flex-start; /* 상단 정렬 */
      flex: 1;
      gap: 20px; /* 체크인과 체크아웃 사이 간격 */
      margin-top: 150px;
    }

    .reservation-info, .reservation-info2 {
      flex: 1; /* 동일한 비율로 공간 차지 */
      display: flex;
      flex-direction: column;
    }

    .reservation-info p, .reservation-info2 p {
      margin: 5px;
    }

    /* 체크인 제목 스타일 */
    .checkin-title {
      font-size: 20px; /* 폰트 크기 */
      color: #352018; /* 텍스트 색상 */
      opacity: 0.5; /* 50% 불투명 */

    }

    /* 체크인 날짜 스타일 */
    .checkin-date {
      font-size: 26px;
      color: #352018;

    }

    /* 체크인 시간 스타일 */
    .checkin-time {
      font-size: 20px;
      color: #564B4B;
    }

    /* 체크인 사람 수 스타일 */
    .checkin-people {
      font-size: 20px;
      color: #564B4B;
    }

    /* 체크아웃 제목 스타일 */
    .checkout-title {
      font-size: 20px; /* 폰트 크기 */
      color: #352018; /* 텍스트 색상 */
      opacity: 0.5; /* 50% 불투명 */
    }

    /* 체크아웃 날짜 스타일 */
    .checkout-date {
      font-size: 26px;
      color: #352018;
    }

    /* 체크아웃 시간 스타일 */
    .checkout-time {
      font-size: 20px;
      color: #564B4B;
    }

    .reservation-info p img.usericon {
      width: 18px !important; /* 아이콘 크기 */
      height: 19px !important;
      margin-right: -2px;
      vertical-align: middle; /* 아이콘과 텍스트 수평 맞추기 */
    }

    .reservation-footer {
      display: flex; /* flexbox로 배치 */
      justify-content: space-between; /* 양쪽 끝 정렬 */
      align-items: center; /* 세로 가운데 정렬 */
      font-size: 16px;
      font-weight: bold;
      color: #352018;
      border-top: 1px solid #929292; /* 상단 구분선 */
      padding: 20px 0; /* 위아래 여백 */
      border-bottom: 1px solid #929292; /* 상단 구분선 */
      padding: 30px 0; /* 위아래 여백 */
    }

    .reservation-footer .left {
      margin: 0; /* 기본 여백 제거 */
      text-align: left; /* 왼쪽 정렬 */
      font-size: 26px; /* 조금 작은 글씨 */
    }
    .left2 span{
      all: unset;
      display: inline; /* 기본 inline으로 설정 */
      font-size: 14px; /* 조금 작은 글씨 */
      color: #564B4B;

    }

    .reservation-footer .right {
      text-align: right; /* 오른쪽 정렬 */
      font-size: 26px; /* 조금 작은 글씨 */
      color: #352018;
    }

    .reservation-footer .right .notice {
      color: #FF3B3E; /* 빨간색 */
      font-size: 12px; /* 조금 작은 글씨 */
      margin: 0 0 -3px 0; /* 아래쪽에 약간의 간격 */
    }

    .reservation-footer .right p {
      margin: 0; /* 기본 여백 제거 */
    }

    .reservation-request {
      background-color: #ffffff;
      /*padding: 15px;*/
      border-radius: 10px;
      margin-top: 40px;
      margin-bottom: 100px;
    }

    .reservation-request h4 {
      font-size: 26px;
      font-weight: bold;
      color: #352018;
      margin-bottom: 10px;
    }

    .reservation-request .request-text {
      font-size: 20px; /* 요청사항 텍스트 폰트 사이즈 */
      color: #564B4B; /* 요청사항 텍스트 색상 */
    }



  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="header-bar">
  <button class="back-button" onclick="history.back();">
    <img src="/img/arrow-left.svg" alt="Back" />
  </button>
  <span class="header-title">예약상세</span>
</div>

<div class="reservation-container">

  <!-- 예약 정보 헤더 -->
  <div class="reservation-header">
    <h3 class="created-date">예약일시: ${reservation.created}</h3>
    <h3 class="lod-name">${reservation.lod_name}</h3>
    <h3 class="room-name">${reservation.room_name}</h3>
  </div>

  <div class="reservation-details">
    <!-- 방 사진 -->
    <div>
      <img src="${reservation.room_photo_url}" alt="Room Photo">
    </div>

    <!-- 체크인 및 체크아웃 정보 -->
    <div class="reservation-info-container">
      <!-- 체크인 정보 -->
      <div class="reservation-info">
        <div class="reservation-details-info">
          <p class="checkin-title">체크인</p>
          <p class="checkin-date">${reservation.res_str_date}</p>
          <p class="checkin-time">
            ${fn:substring(reservation.lod_check_in, 0, 5)}
          </p>
          <p class="checkin-people">
            <img src="/img/reservation_icon_user.svg" alt="아이콘" class="usericon"> 성인 ${reservation.res_people_cnt}명 /
            반려동물: ${reservation.res_pets_cnt}마리
          </p>
        </div>
      </div>

      <!-- 체크아웃 정보 -->
      <div class="reservation-info2">
        <div class="reservation-details-info">
          <p class="checkout-title">체크아웃</p>
          <p class="checkout-date">${reservation.res_end_date}</p>
          <p class="checkout-time">
            ${fn:substring(reservation.lod_check_out, 0, 5)}
          </p>
        </div>
      </div>
    </div>
  </div>

    <div class="reservation-footer">
    <p class="left">총 결제 금액:</p>
    <div class="right">
      <p class="notice">취소 및 환불불가</p>
      <p class="left2">
        <span  style="font-size: 14px; color: #564B4B;">숙박 / ${reservation.total_res_day} 박</span>
        <span  style="font-size: 26px; color: #352018;font-weight: bold;">총</span>
        <span id="formattedMoney" style="font-size: 26px; color: #352018; font-weight: bold;">${reservation.paid_money}원</span>

      </p>
    </div>
  </div>

  <!-- 요청사항 -->
  <div class="reservation-request">
    <h4>요청사항</h4>
    <p class="request-text">${reservation.request}</p>
  </div>




</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script>
  let paidMoney = document.getElementById("formattedMoney").textContent;
  paidMoney = paidMoney.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  document.getElementById("formattedMoney").textContent = paidMoney;
</script>
</body>
</html>
