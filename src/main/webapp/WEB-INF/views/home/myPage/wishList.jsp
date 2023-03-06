<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<title>위시</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<script>
	'use strict'
	
	
	function reasonCheck(movieTitle) {
		
		let comment = $("#comment").val();
		
		if(comment == ''){
			 Swal.fire({
	              icon: 'warning',
	              title: '저장하시려는 이유가 없는데요!?',
	              text: '내용을 입력해주세요.',
	          });
		}
		
		$.ajax({
			type : "GET",
			url  : "${ctp}/myPage/wishReasonInput?wi_MovieTitle="+movieTitle+"&wi_Comment="+comment,
			success : function (){
				 Swal.fire({
		              icon: 'success',
		              title: '이 영화를 위시리스트에 추가한 이유가 저장되었습니다.',
		              text: '즐거운 이용되세요 !',
		          }).then((result) => {
								 location.reload();
		          })
				 
				 
			},
			error : function(){
				 Swal.fire({
		              icon: 'error',
		              title: '전송 오류',
 		          });
			}
		});
		
	}
	
	function wishDelCheck(movieTitle){
		
		Swal.fire({
            title: '정말 삭제하실건가요?',
            text: "언제든 다시 추가 가능합니다.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '삭제',
            cancelButtonText: '취소'
        }).then((result) => {
        	if(result.isConfirmed){
        		
        	    $.ajax({
        			type : "GET",
        			url  : "${ctp}/myPage/wishDelete?movieTitle="+movieTitle,
        			success : function (){
        				 Swal.fire({
        		              icon: 'success',
        		              title: '위시리스트가 삭제되었습니다.',
        		              text: '즐거운 이용되세요 !',
        		          }).then((result) => {
												 location.reload();
        		          });
        				 
        			},
        			error : function(){
        				 Swal.fire({
        		              icon: 'error',
        		              title: '전송 오류',
         		          });
        			}
        		});	
        	}
        	
        });
	}
	
</script> 
<body>
<p><br/><p>
<div class="container">
	<table class="table table-hover">
		<tr>
			<th style="width:10%">번호</th>
			<th style="width:20%"></th>
			<th style="width:20%">영화</th>
			<th style="width:50%">이유</th>
		</tr>
		<c:if test="${empty vos}">
		<tr>
			<td colspan="4" style="text-align: center">이런.. 아직 추가하신 영화가없네요 ! 😁</td>
		</tr>
		<tr><td style="background-color: #d4d4f9" colspan="4"><img alt="머쓱어치피" src="${ctp}/images/머쓱피치.png"/></td></tr>
		</c:if>	
		<c:if test="${!empty vos}">
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${st.count}. </td>
				<td>
					<img alt="${vo.wi_MovieTitle}" src="${vo.wi_MovieImg}">
				</td>
				<td>${vo.wi_MovieTitle}</td>
				<td>
					<c:if test="${empty vo.wi_Comment}">
						<textarea rows="5" name="wi_Comment" id="comment" class="form-control"></textarea>
						<button type="button" onclick="reasonCheck('${vo.wi_MovieTitle}')">이유 저장 !</button>
					</c:if>
					<c:if test="${!empty vo.wi_Comment}">
						${vo.wi_Comment}
					</c:if>
					<br/><button type="button" onclick="wishDelCheck('${vo.wi_MovieTitle}')">삭제 !</button>
				</td>
			</tr>	
		</c:forEach>
		</c:if>	
	</table>
</div>
<p><br/><p>
</body>
</html>