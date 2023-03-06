<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>쿠폰 관리</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/><p>
<div class="container">
	<table class="table table-hover">
		<tr>
			<th>쿠폰 이름</th>
			<th>쿠폰 코드</th>
			<th>쿠폰 내용</th>
			<th>사용 기간</th>
			<th>상태</th>
		</tr>
		<c:forEach var="vo" items="${vos}">
		<tr>
			<td>${vo.c_name}</td>
			<td>${vo.c_cd}</td>
			<td>${vo.c_content}%할인</td>
			<td>${fn:substring(vo.c_lastDate,0,10)}</td>
			<td>${vo.c_status}</td>
		</tr>
		</c:forEach>
	</table>
</div>
<p><br/><p>
</body>
</html>