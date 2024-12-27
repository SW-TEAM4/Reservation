<%--
  파일명 : detailPage.jsp
  생성자 : JDeok
  날 짜  : 2024.12.24
  시 간  : 오전 11:43
  기 능  : 사장님페이지 왼쪽 사이드바
  변경사항
     - 2024.12.24 : JDeok(최초작성)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <h2>객실 정보</h2>
    <ul>
        <li><a href="/lodgment/sellerDetailMain.do" class="${pageTitle == 'roomInformation' ? 'active' : ''}"> * 객실 상세</a></li>
        <li><a href="/lodgment/detailPage.do" class="${pageTitle == 'roomRegister' ? 'active' : ''}"> * 객실 등록</a></li>
    </ul>
</aside>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const sidebarLinks = document.querySelectorAll(".sidebar ul li a");

        // 현재 활성화된 링크를 bold 처리
        const setActiveLink = (activeLink) => {
            sidebarLinks.forEach((link) => {
                link.classList.remove("active"); // 모든 링크의 active 제거
                link.style.fontWeight = "normal"; // 기본 폰트 두께로 설정
            });

            activeLink.classList.add("active"); // 클릭된 링크에 active 추가
            activeLink.style.fontWeight = "bold"; // 클릭된 링크를 bold 처리
        };

        // 링크 클릭 시 활성화 처리
        sidebarLinks.forEach((link) => {
            link.addEventListener("click", (event) => {
                setActiveLink(event.target);
            });
        });

        // 페이지 로드 시 현재 URL에 따라 활성화 처리
        const currentPath = window.location.pathname;
        sidebarLinks.forEach((link) => {
            if (link.getAttribute("href") === currentPath) {
                setActiveLink(link);
            }
        });
    });

</script>