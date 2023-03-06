<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>예매한내역</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<script type="text/javascript">
	'use strict'
	
	$(function(){
		let res = '';
		<c:forEach var="seat" items="${seatVos}"  varStatus="st">
			$("#seatDemo${st.index}").html('${seat}');
		</c:forEach>
		
	});
	
	
	function ticketCancel(cd){
			
		Swal.fire({
				title: "정말로 예매 취소하시겠습니까?",
			text: "결제때 적립된 포인트는 반환됩니다.",
			icon: "info",
      showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '예매취소',
	    cancelButtonText: '돌아가기'
			}).then((result) => {
     		if (result.isConfirmed) {
     			ticketCancel(cd);
     		}
	  	});
	}
	
	
	function ticketCancel(cd){
		
			$.ajax({
				type : "post",
				url  : "${ctp}/movie/ticketCancel",
				data : {cd:cd},
				success : function(){
					Swal.fire({
						title:'예매취소되셨습니다.',
						icon : 'success'
					});
					
					setTimeout(function(){location.reload()},1500);
				},
				error : function(){
					Swal.fire({
						title : "전 송 오 류",
						icon  : "error"
					});
				}
			});  
		}
	
</script>
<body>
<p><br/><p>
<div class="container">
	<table class="table table-borderless">
	<c:if test="${empty vos}"><tr><td>어이쿠 예매하신적이 없으시군요 ! 영화 순위에서 재미있어보이는 영화를 예매해보세요 ! 😁</td></tr><tr><td style="background-color: #d4d4f9"><img alt="머쓱어치피" src="${ctp}/images/머쓱피치.png"/></td></tr></c:if>
	<c:if test="${!empty vos}">
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<tr>
			<th rowspan="2" style="justify-content: center;">포스터</th>
			<td rowspan="2"><img alt="${vo.tk_movieName }" src="${ctp}/resources/cgv/cgvMainImg/${vo.tk_movieImg}"></td>
		</tr>
		<tr>
		</tr>
		<tr>
			<th style="width: 20%">티켓 번호</th>
			<td>${vo.tk_cd}</td>
		</tr>
		<tr>
			<th>영화 이름</th>
			<td>${vo.tk_movieName}</td>
		</tr>
		<tr>
			<th>예매자</th>
			<td>${vo.tk_Id}</td>
		</tr>
		<tr>
			<th>장소,시간</th>
			<td>${vo.tk_town}&nbsp;${vo.tk_screenDate}&nbsp;${vo.tk_screenTime}</td>
		</tr>
		<tr>
			<th>예매하신 자리</th>
			<td><span id="seatDemo${st.index}"></span></td>
		<tr>
			<th>예매한 인원</th>
			<td>
				<c:if test="${vo.tk_adultno != 0}">성인 : ${vo.tk_adultno}명</c:if>
				<c:if test="${vo.tk_teenno != 0}">청소년 : ${vo.tk_teenno}명</c:if>
				<c:if test="${vo.tk_childno != 0}">어린이 : ${vo.tk_childno}명</c:if>
				<c:if test="${vo.tk_preferentialno != 0}">우대 : ${vo.tk_preferentialno}명</c:if>
			</td>
		</tr>
		<tr>
			<th>총 금액</th>
			<td><fmt:formatNumber value="${vo.tk_totPrice}" pattern="#,###" />원</td>
		</tr>
		<tr>
			<td colspan="3">
			<c:if test="${vo.tk_cancelSw == 0}">
				<button type="button" onclick="ticketCancel('${vo.tk_cd}')" >예매 취소</button>
			</c:if>
			<c:if test="${vo.tk_cancelSw != 0}">
				취소된 티켓입니다.. 😂
			</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="3"></td>
		</tr>
		</c:forEach>
	</c:if>
	</table>	
</div>
<p><br/><p>
</body>
</html>