<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>upload test</div>
<form action="/common/s3test.do" method="post" enctype="multipart/form-data" >

    <!-- 파일 업로드 -->
    <input type="file" name="file" class="wid100"/><div/>

    <!-- 이미지 키 텍스트 입력 -->
    <input type="text" name="imgKey" placeholder="Enter imgKey"/><div/>

    <button type="submit">전송</button><div/>
</form>

<div>get image test</div>
<form action="/common/s3test.do" method="get">
    <input type="text" name="imgKey">imageKey</input><div/>
    <button type="submit">전송</button>
</form>

<c:if test="${not empty imgUrl}">
    <div>
        <p>Uploaded Image:</p>
        <img src="${imgUrl}" alt="Uploaded Image" />
    </div>
</c:if>


</body>
</html>
