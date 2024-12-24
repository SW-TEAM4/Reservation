<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>인원 선택</title>
    <style>
        .counter-container {
            margin: 20px;
            padding: 10px;
        }
        .counter-item {
            display: flex;
            align-items: center;
            margin: 10px 0;
        }
        .counter-item button {
            padding: 5px 10px;
            margin: 0 10px;
        }
    </style>
</head>
<body>
<div class="counter-container">
    <div class="counter-item">
        <span>성인</span>
        <button onclick="adjust('adult', 'minus')">-</button>
        <span id="adultCount">${adultCount != null ? adultCount : 2}</span>
        <button onclick="adjust('adult', 'plus')">+</button>
    </div>
    <div class="counter-item">
        <span>아동</span>
        <button onclick="adjust('child', 'minus')">-</button>
        <span id="childCount">${childCount != null ? childCount : 1}</span>
        <button onclick="adjust('child', 'plus')">+</button>
    </div>

    <form action="/index.do" method="get">
        <input type="hidden" id="totalAdult" name="adultCount" value="${adultCount != null ? adultCount : 2}">
        <input type="hidden" id="totalChild" name="childCount" value="${childCount != null ? childCount : 1}">
        <button type="submit">확인</button>
    </form>
</div>

<script>
    function adjust(type, operation) {
        const countElement = document.getElementById(type + 'Count');
        const hiddenField = document.getElementById('total' + type.charAt(0).toUpperCase() + type.slice(1));
        let count = parseInt(countElement.innerText) || (type === 'adult' ? 2 : 1); // 기본값 설정

        if (operation === 'plus' && count < 9) {
            count++;
        } else if (operation === 'minus' && ((type === 'adult' && count > 1) || (type === 'child' && count > 0))) {
            count--;
        }

        countElement.innerText = count;
        hiddenField.value = count;
    }
</script>
</body>
</html>