<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>내가봤던영화리스트</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/><p>
<div class="container">
	<table class="table">
	<c:if test="${empty vos}"><tr><td>이런.. 아직 예매하신 영화가 한개도 없군요 ! 😊</td></tr><tr><td style="background-color: #d4d4f9"><img alt="머쓱어치피" src="${ctp}/images/머쓱피치.png"/></td></tr></c:if>
	<c:if test="${!empty vos}">
	<c:forEach var="vo" items="${vos}">
		<tr>
			<th>티켓 번호</th>
			<td>${vo.tk_cd }</td>
			<th>영화 이름</th>
			<td>${vo.tk_movieName }</td>
		</tr>
		<tr>
			<th>예매자아이디</th>
			<td>${vo.tk_Id }</td>
			<th>장소,시간</th>
			<td>${vo.tk_town}${vo.tk_screenDate}${vo.tk_screenTime }</td>
		</tr>
		<tr>
			<th>예매하신 자리</th>
			<td>${vo.tk_seat }</td>
			<th>예매한 인원</th>
			<td>
				<c:if test="${vo.tk_adultno != 0}">${vo.tk_adultno}</c:if>
				<c:if test="${vo.tk_teenno != 0}">${vo.tk_teenno}</c:if>
				<c:if test="${vo.tk_childno != 0}">${vo.tk_childno}</c:if>
				<c:if test="${vo.tk_preferentialno != 0}">${vo.tk_preferentialno}</c:if>
			</td>
			<th>총 금액</th>
			<td>${vo.tk_totPrice }</td>
		</tr>
		</c:forEach>
		</c:if>
	</table>	
</div>
<p><br/><p>
</body>
</html>