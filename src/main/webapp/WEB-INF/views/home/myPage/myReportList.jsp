<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>리뷰 신고 내역</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/><p>
<div class="container">
	<table class="table">
		<tr>
			<th>분류</th>
			<th>게시물번호</th>
			<th>세부분류</th>
			<th style="overflow: auto">신고이유</th>
			<th>진행상태</th>
		</tr>
		<c:if test="${empty reportVos }">
			<tr>
				<td colspan="5">이런.. 아직 신고하신 기록이 없네요 ! 😁</td>
			</tr>
			<tr><td style="background-color: #d4d4f9" colspan="5"><img alt="머쓱어치피" src="${ctp}/images/머쓱피치.png"/></td></tr>
		</c:if>
		<c:if test="${!empty reportVos }">
			<c:forEach var="reVo" items="${reportVos}">
				<tr>
					<td>${reVo.part }</td>
					<td>${reVo.reportContentIdx }</td>
					<td>${reVo.reportPart }</td>
					<td>${reVo.reportReason }</td>  
					<td>${reVo.reportStatus }</td>
				</tr> 
			</c:forEach>
		</c:if>
	</table>
</div>
<p><br/><p>
</body>
</html>