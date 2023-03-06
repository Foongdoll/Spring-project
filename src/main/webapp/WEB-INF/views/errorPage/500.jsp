<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/><p>
<div class="container">
	<section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${ctp}/resources/img/bg-img/교섭.jpg);">
	    <div class="bradcumbContent">
	        <h2>이런.. 500 에러 페이지..</h2>
	        <p><button type="button" onclick="history.back();">뒤로가기</button></p>
	        <p><button type="button" onclick="location.href='${ctp}/'">홈으로</button></p>
	    </div>
	</section>
	<section class="contact-area section-padding-0-100" style="margin-top: 100px">
		500 오류..
	</section>
</div>
<p><br/><p>
</body>
</html>