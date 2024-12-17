<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentURI" value="${pageContext.request.requestURI}"/>
<div class="header">
    <div class="size">
        <div><a href="/home.do"><img src="/img/logo.svg" width="1398px" height="216.33px"></a></div>
        <div class="login">
            <c:if test="${empty login }">
                <a href="/member/login.do">로그인</a>  |
                <a href="/member/regist.do">회원가입</a>
            </c:if>
            <c:if test="${!empty login }">
                <a href="/member/edit.do">마이페이지</a>
            </c:if>
        </div>
    </div>
</div>

<!-- 디버깅 currentURI 정보 출력 -->
<%--<p>Request URI: ${pageContext.request.requestURI}</p>--%>

<div class="menu">
    <ul class="depth">
        <li><a href="/home.do" class="${currentURI.endsWith('/WEB-INF/views/home.jsp') ? 'active' : ''}">홈</a></li>
        <li><a href="/search/search.do" class="${currentURI.endsWith('/WEB-INF/views/search/search.jsp') ? 'active' : ''}">구경하개</a></li>
        <li><a href="/gather.do" class="${currentURI.endsWith('/gather.do') ? 'active' : ''}">모여보개</a></li>
        <li><a href="/fun.do" class="${currentURI.endsWith('/fun.do') ? 'active' : ''}">재미나개</a></li>
    </ul>
</div>

