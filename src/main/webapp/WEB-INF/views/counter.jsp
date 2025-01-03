<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="counter-container">
    <h3>인원</h3>
    <p>유아 및 아동도 인원수에 포함해주세요.</p>

    <div class="counter">
        <label>성인</label>
        <div class="counter-controls">
            <button onclick="updateCount('adults', 'decrease')">-</button>
            <span id="adults-count">2</span>
            <button onclick="updateCount('adults', 'increase')">+</button>
        </div>
    </div>

    <div class="counter">
        <label>아동</label>
        <div class="counter-controls">
            <button onclick="updateCount('children', 'decrease')">-</button>
            <span id="children-count">1</span>
            <button onclick="updateCount('children', 'increase')">+</button>
        </div>
    </div>
</div>


<script>
    let adults = 2;
    let children = 1;
    const maxPeople = 9;

    function updateCount(type, action) {
        const adultsCountEl = document.getElementById('adults-count');
        const childrenCountEl = document.getElementById('children-count');

        if (type === 'adults') {
            if (action === 'increase' && adults + children < maxPeople) {
                adults++;
            } else if (action === 'decrease' && adults > 1) {
                adults--;
            }
            adultsCountEl.innerText = adults;
        } else if (type === 'children') {
            if (action === 'increase' && adults + children < maxPeople) {
                children++;
            } else if (action === 'decrease' && children > 0) {
                children--;
            }
            childrenCountEl.innerText = children;
        }

        // 부모 페이지에 값 전달
        const selectedMaxEl = document.getElementById('selected-max');
        selectedMaxEl.innerText = `성인 ${adults}명, 아동 ${children}명`;
    }
</script>
