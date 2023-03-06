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
		        title: '비밀번호 변경 전 본인확인',
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
	   	              text: "비밀번호변경 페이지로 이동합니다.",
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

	function fCheck(){
		const regPswd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,}$/;
		let aPswd  = $("#aPswd").val(); 
		let aPswd2 = $("#aPswd2").val();
		
		if(aPswd.trim() == ''){
			Swal.fire({
				title: '새로운 비밀번호를 입력해주세요.',
				text: '비밀번호가 공백이거나 공백이 포함되어있습니다.',
				icon: 'info',
			});
			return;
		}
		else if(aPswd != aPswd2){
			Swal.fire({
				title: '새로운 비밀번호와 확인 비밀번호가 다릅니다.',
				text: '비밀번호를 확인해주세요.',
				icon: 'info',
			});
			return;
		}
		else if(!regPswd.test(aPswd)){
			Swal.fire({
				title : '비밀번호 형식이 잘못되었습니다.',
				text : '다른 비밀번호를 사용해주세요.',
				icon : 'warning',
			});
			return;
		}
		
	$.ajax({
		type : "post",
		url  : "${ctp}/myPage/pswdChange",
		data : {aPswd:aPswd},
		success : function(res){
			if(res == '1'){
				Swal.fire({
					title : '짜잔~ 비밀번호 변경 성공',
					text : '비밀번호 변경에 성공하셨습니다.',
					icon : 'success',
				});
				
				fnLocation();
			}
			else {
				Swal.fire({
					title : '현재 사용중인 비밀번호입니다.',
					text : '같은 비밀번호로 바꾸실순없습니다..😅',
					icon : 'error',
				});
			}
		},
		error : function(){
			Swal.fire({
				title : '전송 오류',
				text : '삐비빅.. 비밀번호 변경에 실패하였습니다.',
				icon : 'error',
			});	
		}
	});
	}
	
	function fnLocation(){
		setTimeout(function(){location.href='myPageHome?sw=0'},1000);
	}
</script>
<body>
<p><br/><p>
<div class="container">
	<table class="table">
		<tr>
			<th colspan="2">비밀번호 변경</th>
		</tr>
		<tr>
			<th style="width: 30%">새로운 비밀번호</th>
			<td style="width: 70%"><input type="password" name="aPswd" id="aPswd" class="form-control"/></td>
		</tr>
		<tr>
			<th style="width: 30%">새로운 비밀번호 확인</th>
			<td style="width: 70%"><input type="password" name="aPswd2" id="aPswd2" class="form-control"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="비밀번호 변경" onclick="fCheck()" class="form-control"/></td>
		</tr>
	</table>
</div>
<p><br/><p>
</body>
</html>