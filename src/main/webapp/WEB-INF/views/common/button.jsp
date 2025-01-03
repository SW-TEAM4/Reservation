<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 버튼 텍스트, URL, 크기를 동적으로 받음 --%>
<%
    String buttonText = (String) request.getAttribute("buttonText");
    String buttonTextSize = (String) request.getAttribute("buttonTextSize");
    String buttonUrl = (String) request.getAttribute("buttonUrl");
    String buttonWidth = (String) request.getAttribute("buttonWidth"); // 동적 너비
    String buttonHeight = (String) request.getAttribute("buttonHeight"); // 동적 높이
    String buttonRadius = (String) request.getAttribute("buttenRadius");

    // 기본값 설정
    if (buttonText == null) buttonText = "예약하기"; // 버튼 텍스트 기본값
    if (buttonTextSize == null) buttonTextSize = "14px";
    if (buttonUrl == null) buttonUrl = ""; // URL 기본값
    if (buttonWidth == null) buttonWidth = "212px"; // 너비 기본값
    if (buttonHeight == null) buttonHeight = "77px"; // 높이 기본값
    if (buttonRadius == null) buttonRadius = "10px"; // 둘레 기본값
%>

<%-- 동적 스타일 적용 --%>
<button
        class="button"
        onclick="location.href='<%= buttonUrl %>'"
        style="width: <%= buttonWidth %>; height: <%= buttonHeight %>;
                radius: <%= buttonRadius%> textSize: <%= buttonTextSize %>">

    <span><%= buttonText %></span>
</button>
