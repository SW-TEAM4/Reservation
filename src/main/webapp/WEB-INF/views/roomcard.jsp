<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<div class="room-card">
  <!-- 객실 이미지 클릭 시 이동 -->
  <a href="/room/detail?room_idx=${room.room_idx}">
    <img src="${room.room_img_url}" alt="${room.room_name}" class="room-img">
  </a>

  <!-- 객실 정보 -->
  <div class="room-info">
    <h3 class="room-name">${room.room_name}</h3>
    <div class="room-capacity">
      성인 ${room.max_people_cnt}인 / 반려동물 ${room.max_pet_cnt}마리
    </div>
    <div class="room-price">
      <span>가격:</span> ${room.room_price}원
    </div>
    <c:if test="${room.avg_rating != null}">
      <div class="room-rating">
        평점: ${room.avg_rating} / 10
      </div>
    </c:if>
  </div>

  <!-- 예약 버튼 -->
  <button class="booking-button" onclick="location.href='/reserve/reservation.do?room_idx=${room.room_idx}'">
    예약하기
  </button>
</div>
