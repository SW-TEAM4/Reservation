<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>인원 선택 결과</title>
</head>
<body>
<div>
    총 인원: 성인 ${adultCount}명, 아동 ${childCount}명
</div>
<form action="/calendar.do" method="get">
    <button type="submit">Go to Calendar</button>
</form>
<form action="/maxcnt.do" method="get">
    <button type="submit">Go to MaxCnt</button>
</form>
<form action="/lodgment.do" method="get">
    <button type="submit">Go to Lodgment</button>
</form>

<form action="/home.do" method="get">
    <button type="submit">Go to homes</button>
</form>
</body>
</html>