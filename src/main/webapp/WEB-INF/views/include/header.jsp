<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<div class="header">
            <div class="size">
                <div><a href="/home.do"><img src="/img/logo.svg"></a></div>
                <div class="login">
                <c:if test="${empty login }">
                    <a href="/member/login.do">로그인</a> |
                    <a href="/member/regist.do">회원가입</a>
                </c:if>
                <c:if test="${!empty login }">
                     <a href="/member/logout.do">로그아웃</a> |
                    <a href="/member/edit.do">마이페이지</a>
                </c:if>
                </div>
            </div>
        </div>
        <div class="menu">
            <ul class="depth1">
                <li>
                    <a href="/home.do">홈</a>
                </li>
                <li>
                    <a href="">구경하개</a>
                </li>
                <li>
                    <a href="">모여보개</a>
                </li>
                <li>
                    <a href="">재미나개</a>
                </li>
            </ul>
        </div>