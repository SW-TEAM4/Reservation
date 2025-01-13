<%--
  파일명 : sellerHeader.jsp
  생성자 : JDeok
  날 짜  : 2024.12.23
  시 간  : 오후 12:19
  기 능  : 사장님 header 페이지
  변경사항
     - 2024.12.23 : JDeok(최초작성)

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header">
    <h1 class="logo">같이가개</h1>
    <img src="/img/seller_header.svg" alt="로고" class="logo-image">

    <%-- 페이지 식별 변수로 조건 처리 --%>
    <%
        String pageName = (String) request.getAttribute("currentPage");
        if (pageName != null && "lodRegister".equals(pageName)) {
    %>
            <span class="header-extra">숙소 등록</span>
    <%
        }
    %>
    <%
        String lod_name = (String) request.getAttribute("lodgmentName");
        if(lod_name != null && !lod_name.equals("")){
    %>
         <span class="header-lodgment"> ${lodgmentName}</span>
         <a href="javascript:void(0);" onclick="confirmLogout()" class="sellerlogout">로그아웃</a>

    <%
        }
    %>
</header>
<script type="text/javascript">
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
            window.location.href = '/sellerlogout';
        }
    }
</script>


