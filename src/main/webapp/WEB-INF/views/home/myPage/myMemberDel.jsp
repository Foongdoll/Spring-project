<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>비밀번호 찾기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<script type="text/javascript">
	'use strict'
	
	$(function(){
		(async () => {
		    const { value: getPswd } = await Swal.fire({
		        title: '회원탈퇴 전 본인확인',
		        text: '현재 사용중인 비밀번호를 입력해주세요.',
		        input: 'password',
		        icon: 'info',
		        inputPlaceholder: '비밀번호를 입력해주세요.',
		        showCancelButton: true,
		        cancelButtonColor: '#d33',
		        cancelButtonText: '취소'
      })

		    // 이후 처리되는 내용.
		    if (getPswd) {
					
		    	$.ajax({
		    		type : "get",
		    		url  : "${ctp}/myPage/pswdChange?pswd="+getPswd,
		    		success : function (res){
		    			if(res == '1'){
			    			Swal.fire({
	   	              title: '비밀번호 인증 성공',
	   	              text: "회원탈퇴 페이지로 이동합니다.",
	   	              icon: 'success',
	   	          })
		    			}
			   	    else {
		    				Swal.fire({
			              title: '비밀번호가 일치하지않습니다.',
			              text: "다시 확인해주세요.",
			              icon: 'error',
		 	   	          showCancelButton: true,
	   	              confirmButtonColor: '#3085d6',
	   	              cancelButtonColor: '#d33',
	   	              confirmButtonText: '다시입력',
	   	              cancelButtonText: '마이페이지가기'
		   	          }).then((result) => {
		   	              if (result.isConfirmed) {
		   	            	  location.reload();
		   	              }
		   	              else {
		   	            	  location.href='myPageHome?sw=0';
		   	              }
		       			  });
			   	    	}
    					},
			    		error : function () {
			    			Swal.fire({
	   	              title: '전송 오류',
	   	              text: "다시 확인해주세요.",
	   	              icon: 'error',
	   	          })
		    			}
		    		});
		    	}
		    else {
		    	location.href='myPageHome?sw=0';
		    }
			})()
	});
	
	function delCheck(){
		let delText = $("#delText").val();
		let delText2 = $("#delText").val();
		
		if(delText.trim().indexOf(' ') != -1 && delText2.trim().indexOf(' ') != -1){
			Swal.fire({
				title : '정말 탈퇴라고 입력하신거 맞나요?',
				icon  : 'info'
			});	
			return;
		}
		
		$.ajax({
			type : 'post',
			url  : '${ctp}/myPage/memberDel',
			data : {id:'${sId}'},
			success : function(){
				alert('회원 탈퇴가 완료되었습니다.');
				location.href="${ctp}/logout";
			},
			error : function(){
				alert("전송 오류");				
			}
		});
		
	}

</script>
<body>
<p><br/><p>
<div class="container">
<h2>회원 탈퇴</h2>
	<table class="table">
		<tr>
			<th colspan="2">
				<p>회원 탈퇴 하시려면 '회원탈퇴' 라고 밑에 입력란에 입력해주세요.</p>
			</th>
		</tr>
		<tr>
			<td colspan="2"><input type="text" id="delText" placeholder="정말탈퇴" class="form-control"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="password" id="delText2" placeholder="정말탈퇴...." class="form-control"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="탈퇴" onclick="delCheck()" class="form-control"/></td>
		</tr>
	</table>
</div>
<p><br/><p>
</body>
</html>