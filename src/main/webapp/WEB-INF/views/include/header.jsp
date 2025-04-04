<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentURI" value="${pageContext.request.requestURI}"/>
<div class="header">
    <div class="size">
        <div class="logo"><a href="/home.do"><img src="/img/logo.svg" width="1398px" height="216.33px"></a></div>
        <div class="login">
            <c:if test="${empty usersession }">
                <a href="/userlogin">로그인</a>  |
                <a href="/userregister">회원가입</a>
            </c:if>
            <c:if test="${!empty usersession }">
                    <a href="javascript:void(0);" onclick="confirmLogout()">로그아웃</a> |
                <a href="/mypage.do">마이페이지</a>
            </c:if>
        </div>
    </div>
</div>

<!-- 디버깅 currentURI 정보 출력 -->
<%--<p>Request URI: ${pageContext.request.requestURI}</p>--%>

<div class="menu">
    <ul class="depth">
        <li><a href="/home.do" class="${currentURI.endsWith('/WEB-INF/views/home.jsp') ? 'active' : ''}">홈</a></li>
        <li>
            <a href="/search/search.do"
                class="<c:choose>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/search/search.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/reserve/reservation.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/lodgment/lodgment.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/payment/payment.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/lodgment/lodreview.jsp")}'>
                        active
                    </c:when>
                    <c:otherwise>
                        ''
                    </c:otherwise>
                </c:choose>">
                구경하개
            </a>
        </li>
        <li><a href="/gather" class="<c:choose>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/board/gather.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/board/detail.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/board/write.jsp")}'>
                        active
                    </c:when>
                    <c:otherwise>
                        ''
                    </c:otherwise>
                </c:choose>">모여보개</a></li>
        <li><a href="/fun.do" class="<c:choose>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/fun/fun.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/fun/event1.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/fun/event2.jsp")}'>
                        active
                    </c:when>
                    <c:when test='${pageContext.request.requestURI.endsWith("/WEB-INF/views/fun/event3.jsp")}'>
                        active
                    </c:when>
                    <c:otherwise>
                        ''
                    </c:otherwise>
                </c:choose>">재미나개</a></li>
    </ul>
</div>

<script type="text/javascript">
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
            window.location.href = '/userlogout';
        }
    }
</script>
