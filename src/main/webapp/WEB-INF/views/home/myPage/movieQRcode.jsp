<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>영화qr조회</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/><p>
<div class="container">
	<table class="table table-hover table-bordered">
		<c:if test="${empty vos }"> 
			<tr>
				<td>이런.. 아직 예매하신 영화가 한개도 없군요 ! 😊</td>
			</tr> 
			<tr><td style="background-color: #d4d4f9"><img alt="머쓱어치피" src="${ctp}/images/머쓱피치.png"/></td></tr>
		</c:if>
		<c:if test="${!empty vos }">
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td><img alt="${vo.tk_movieName}" src="${ctp}/resources/qrcode/${vo.tk_QRcode}"/></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<p><br/><p>
</body>
</html>