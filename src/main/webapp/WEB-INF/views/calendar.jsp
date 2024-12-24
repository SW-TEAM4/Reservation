<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
  <style>
    .date-selector {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
      background-color: #fff;
      border-bottom: 1px solid #ddd;
    }
    .date-box {
      text-align: center;
      font-size: 14px;
      color: #666;
    }
    .date-box span {
      font-size: 20px;
      font-weight: bold;
      color: #333;
    }
    .search-button {
      width: 100%;
      padding: 15px;
      background-color: #f47c7c;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 10px;
    }
    #calendar {
      margin: 20px;
    }
    .fc .fc-day-in-range {
      background-color: #f47c7c; !important;
    }
    .fc .fc-day-selected {
      background-color: #f47c7c !important;
      color: white !important;
      border-radius: 50%;
    }
  </style>
</head>
<body>
<div class="date-selector">
  <div class="date-box">
    <label>입실일</label><br>
    <span id="checkin-date"></span>
  </div>
  <div class="date-box">
    <label>퇴실일</label><br>
    <span id="checkout-date"></span>
  </div>
</div>
<div id="calendar"></div>
<button class="search-button">검색</button>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const calendarEl = document.getElementById('calendar');
    const checkinDateEl = document.getElementById('checkin-date');
    const checkoutDateEl = document.getElementById('checkout-date');

    let checkinDate = null;
    let checkoutDate = null;

    const calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      selectable: true,
      select: function (info) {
        const selectedDate = new Date(info.startStr);

        if (!checkinDate || (checkinDate && checkoutDate)) {
          // 입실일 설정
          checkinDate = info.startStr;
          checkinDateEl.textContent = formatDate(selectedDate);
          checkoutDate = null; // 퇴실일 초기화
          checkoutDateEl.textContent = '';
          resetStyles();
        } else if (checkinDate && !checkoutDate) {
          // 퇴실일 설정
          const startDate = new Date(checkinDate);

          if (selectedDate <= startDate) {
            alert('퇴실일은 입실일 이후 날짜를 선택해야 합니다.');
          } else {
            checkoutDate = info.startStr;
            checkoutDateEl.textContent = formatDate(selectedDate);
            applyRangeStyles(startDate, selectedDate);
          }
        }
      },
      unselectAuto: false,
    });

    calendar.render();

    function formatDate(date) {
      const options = { year: 'numeric', month: '2-digit', day: '2-digit', weekday: 'short' };
      return date.toLocaleDateString('ko-KR', options);
    }

    function resetStyles() {
      document.querySelectorAll('.fc-day-in-range').forEach(day => {
        day.classList.remove('fc-day-in-range');
      });
    }

    function applyRangeStyles(startDate, endDate) {
      resetStyles();
      let currentDate = new Date(startDate);
      while (currentDate <= endDate) {
        const dateStr = currentDate.toISOString().split('T')[0];
        const dayCell = document.querySelector(`[data-date='${dateStr}']`);
        if (dayCell) {
          dayCell.classList.add('fc-day-in-range');
        }
        currentDate.setDate(currentDate.getDate() + 1);
      }
    }
  });
</script>
</body>
</html>