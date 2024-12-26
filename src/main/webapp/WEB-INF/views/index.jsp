<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>인원 선택 결과</title>
</head>
<body>
<%--<div>--%>
<%--    총 인원: 성인 ${adultCount}명, 아동 ${childCount}명--%>
<%--</div>--%>
<form action="/calendar.do" method="get">
    <button type="submit">Go to Calendar</button>
</form>
<%--<form action="/maxcnt.do" method="get">--%>
<%--    <button type="submit">Go to MaxCnt</button>--%>
<%--</form>--%>
<form action="/lodgment.do" method="get">
    <button type="submit">Go to Lodgment</button>
</form>

<form action="/home.do" method="get">
    <button type="submit">Go to Home Index</button>
</form>

<form action="/test/index.do" method="get">
    <button type="submit">Go to Test Index</button>
</form>

<form action="/reserve/reserve.do" method="get">
    <button type="submit">Go to Reserve Index</button>
</form>

<form action="/common/gos3.do" method="get">
    <button type="submit">Go to s3 test Index</button>
</form>


</body>
</html>
