<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>join</title>
   <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>

</head>
<script>
	'use strict'
		$(function(){
		(async () => {
		    const { value: getPswd } = await Swal.fire({
		        title: '회원정보수정 전 본인확인',
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
	   	              text: "회원정보수정 페이지로 이동합니다.",
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

	
	
	var idSw = '';
	var emailSw = '1';
	var rEmail = '';
	var countDown = 60 * 3;
	
	function emailCheck(){
		const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		let email = $("#emailC").val();
		rEmail = email;
		if(!regEmail.test(email)){
			alert('이메일형식을 확인해주세요.');
			return;
		 }		
		
		$.ajax({
			type : "GET",
			url  : "${ctp}/emailCheck?email="+email,
			success : function(res){
				if(res == "0"){
					countDown = 60 * 3;
					emailSw = '0';
					alert('인증번호 전송완료');
					let addForm = '<div id="authEmailDiv" class="form-group">'
					addForm +='<label for="exampleInputPassword1">이메일</label>'
					addForm +='<input type="text" class="form-control" id="authNumber" name="authNumber" placeholder="인증번호를 입력해주세요.">'
					addForm +='<small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정확히 입력해주세요.</small>'
					addForm +='<button type="button" onclick="authNumberCheck()">인증<button>'
					addForm +='<input type="hidden" name="authYn" id="authYn" value="">'
					addForm +='<div id="input_timer"></div>'
					addForm +='</div>'
					
					$("#formGroupDemo").html(addForm);
					
					fn_countDown();
					
					$("#emailCheckBtn").attr('disabled',true);
					
					setTimeout(function(){
						$("#emailCheckBtn").attr('disabled',false);
					},10000);
				}
				else if(res == "1"){
					Swal.fire({
						title: '이메일 인증 간격이 너무 짧습니다.',
						text: '인증번호 발급받으신 후 3분지나셔야 재발급 가능하십니다.',
						icon: 'info',
					});
				}
			
			},
			error : function(){
				alert('전송 오류');		
			}
		});
	}

	var myTimer;
	
	function fn_countDown(){
		myTimer = setInterval(alertFunc,1000);
	}
	
	function alertFunc(){
		var min = countDown/60;
		min = Math.floor(min);
		
		var sec = countDown - (60 * min);
		
		if(min.toString.length == 1){
			min = "0"+min;
		}
		
		if(sec.toString().length == 1){
			sec = "0"+sec;
		}
		
		$("#input_timer").html('남은시간 : '+min+' : '+sec);
		
		if(countDown == 0){
			clearInterval(myTimer);
		}
		countDown--;
		
		var authYn = $("#authYn").val();
		
		if(authYn != ''){
			clearInterval(myTimer);
			$("#input_timer").html('');
			return;
		}
		
		if(min == 0 && sec == 0){
			clearInterval(myTimer);
			$("#input_timer").html('');
			$("#emailC").html('');
			alert('인증 시간이 초과되었습니다. \n인증 번호를 다시 발급받아주세요.');
			$("#emailCheckBtn").attr('disabled',false);
			$("#authEmailDiv").hide();
		}
	}
	
	function authNickName(){
		let nickName = $("#nickName").val();
		$("#authNickName").val(nickName);
	}
	
	function authNumberCheck(){
		let authNumber = $("#authNumber").val();	
		
		if(authNumber.length != 8){
			alert('인증번호 8자리 확인해주세요.');
			return;
		}
		
		
		let query = {
				rEmail,
				authNumber
		}
		
		$.ajax({
			type : "post",
			url  : "${ctp}/authNumberCheck",
			data : query,
			success : function (res){
				
				if(res == '0'){
					alert('인증 번호를 확인해주세요');
					return;
				}
				else {
					emailSw = '1';
					alert('인증 성공 \n인증창을 닫고 회원가입을 마무리해주세요.');
					$("#authYn").val('Y');
					$("#emailCheckBtn").attr('disabled',true);
					$("#authEmailDiv").hide();
					$("#email").val(rEmail);
					$("#email").attr("readonly",true);
				}
			},
			error : function (){
				Swal.fire({
					title: '전송 오류',
					text: '삐비빅...',
					icon: 'error',
				});
			}
		});
		
		
}
	
	
	
	
	function fCheck(){
		const regName = /^[a-zA-Z가-힣]{2,20}$/i;
		const regScNumber = /^[0-9]+$/; 
		const regTel = /^\d{3}-\d{3,4}-\d{4}$/;
		const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		let id = $("#id").val();
		let pswd = $("#pswd").val();
		let pswd2 = $("#pswd2").val();
		let name = $("#name").val();
		let nickName = $("#nickName").val();
		let scnumber1 = $("#scNumber1").val();
		let scnumber2 = $("#scNumber2").val();
		let scnumber = scnumber1 +'-'+scnumber2;
		$("#scNumber").val(scnumber);
		let tel = $("#tel").val();
		let email = $("#email").val();
		let photo = $("#photo").val();
		
		let pswdQ = $("#pswdQ").val();
		let pswdA = $("#pswdA").val();
		
		
		let yearCheck = scnumber1.substr(0,4);
		let monthCheck1 = scnumber1.substr(4,1);
		let monthCheck2 = scnumber1.substr(5,1);
		let dayCheck1 = scnumber1.substr(6,1);
		let dayCheck2 = scnumber1.substr(7,1);
		
		let maxSize = 10 * 1024 * 1024;
		
		if(photo.size > maxSize){
			alert('사진의 크기가 최대 용량을 초과하였습니다.');
			return;
		}
		
		
		if(!regName.test(name)){
			Swal.fire({
				title : '이름 형식이 잘못되었습니다.',
				text : '다른 이름을 사용해주세요.',
				icon : 'warning',
			});
			return;
		 }
		else if(!regScNumber.test(scnumber1) || !regScNumber.test(scnumber2) || scnumber1.length != 8 || scnumber2.length != 1){ 
			Swal.fire({
				title : '생년월일의 형식이 잘못되었습니다.',
				text : '다시 입력해주세요.',
				icon : 'warning',
			});
			return;
		 }
		else if(monthCheck1 == 1 && monthCheck2 > 2 || monthCheck1 <= 0 && monthCheck2 < 1 || dayCheck1 == 3 && dayCheck2 > 1 || dayCheck1 <= 0 && dayCheck2 < 1){
			Swal.fire({
				title : '생년월일의 형식이 잘못되었습니다.',
				text : '다시 입력해주세요.',
				icon : 'warning',
			});
			return;
		}
		else if(yearCheck <= 1999 && scnumber2 != 1 && scnumber2 != 2){
			Swal.fire({
				title : '생년월일의 형식이 잘못되었습니다.',
				text : '다시 입력해주세요.',
				icon : 'warning',
			});
				return;
			}
		else if(yearCheck >= 2000 && scnumber2 != 3 && scnumber2 != 4){
			Swal.fire({
				title : '생년월일의 형식이 잘못되었습니다.',
				text : '다시 입력해주세요.',
				icon : 'warning',
			});
				return;
			}  
		else if(!regTel.test(tel)){
			Swal.fire({
				title : '전화번호의 형식이 잘못되었습니다.',
				text : '다시 입력해주세요.',
				icon : 'warning',
			});
			return;
		 }		
		else if(!regEmail.test(email)){
			Swal.fire({
				title : '이메일의 형식이 잘못되었습니다.',
				text : '다시 입력해주세요.',
				icon : 'warning',
			});
			return;
		 }		
		else if(pswdA == ""){
			Swal.fire({
				title : '비밀번호 질문에 대한 대답을 입력해주세요.',
				text : '기억하실수있는 대답으로 입력해주세요.',
				icon : 'warning',
			});
			return;
		}
		else if(emailSw != '1'){
			Swal.fire({
				title : '이메일인증을 진행해주세요 !',
				text : '실제 사용하시는 이메일을 입력해주세요 !',
				icon : 'warning',
			});
			return;
		}
		else {
			myform.submit();
		} 
	}
</script>
<style>
				button {
			    color: #444444;
			    background: #F3F3F3;
			    border: 1px #DADADA solid;
			    padding: 5px 10px;
			    border-radius: 2px;
			    font-weight: bold;
			    font-size: 9pt;
			    outline: none;
			}
			
			button:hover {
			    border: 1px #C6C6C6 solid;
			    box-shadow: 1px 1px 1px #EAEAEA;
			    color: #333333;
			    background: #F7F7F7;
			}
			
			button:active {
			    box-shadow: inset 1px 1px 1px #DFDFDF;   
			}
       @font-face {
           font-family: 'GangwonEdu_OTFBoldA';
           src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
           font-weight: normal;
           font-style: normal;
       }
       html {font-family: 'GangwonEdu_OTFBoldA'}
       .uploadImg {margin:10px;margin-top:150px;}
       img#previewImg{cursor:pointer;max-height:200px; max-width:100%;display:block;}

       .filebox {display:inline-block;margin:10px;}
       .filebox label {display: inline-block; padding: 4px 8px; margin-left:5px; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; border-radius: .25em; cursor: pointer; color: #fff; background-color: #895fc0; border: 1px solid #683d8b;}
       .filebox input[type="file"] {position: absolute;width: 1px;height: 1px;padding: 0;margin: -1px;overflow: hidden;clip:rect(0,0,0,0);border: 0;}
       .filebox .upload-name{display: inline-block; padding: 0.3em 0.4em; font-size: inherit; font-family: inherit; line-height: normal; vertical-align: middle; background-color: #f5f5f5; 
                             border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; -webkit-appearance: none; -moz-appearance: none; appearance: none; }
</style>
<body>
<div class="container">
  <h3>회원정보 수정</h3>
  <!-- Login Form -->
  <div class="login-form">
      <form name="myform" method="post" action="${ctp}/myPage/myInforUpdate" enctype="multipart/form-data"> <!-- enctype="multipart/form-data" -->
          <div class="form-group">
              <label for="id">아이디</label>
              <input type="text" class="form-control" id="id" name="mem_id" value="${mvo.mem_id}" aria-describedby="emailHelp" readonly="readonly">
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>아이디는 변경 불가능하십니다 !</small>
          </div>
          <div class="form-group">
              <small id="emailHelp" class="form-text text-muted"><h4><i class="fa fa-lock mr-2"></i>비밀번호변경은 비밀번호 변경 메뉴를 이용해주세요 !!</h4></small>
          </div>
          <div class="form-group">
              <label for="name">성명</label>
              <input type="text" class="form-control" id="name" name="mem_name" value="${mvo.mem_name}" maxlength="20" placeholder="이름을 입력해주세요.">
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영어 대/소문자와 한글만 가능하며 최소 2자리 최대 20자리입니다.</small>
          </div>
          <div class="form-group">
              <label for="name">닉네임</label>
              <input type="text" class="form-control" id="nickName" name="mem_nickName" value="${mvo.mem_nickName}" aria-describedby="emailHelp" readonly="readonly">
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>닉네임은 변경 불가능하십니다.</small>
          </div>
          <div class="form-group">
              <label for="scNumber1">생년월일 | 성별</label>
              <input type="text" class="form-control" id="scNumber1"  value="${fn:split(mvo.mem_scNumber,'-')[0]}" maxlength="8" placeholder="생년월일 8자리를 입력해주세요.">
              <input type="text" class="form-control" id="scNumber2" value="${fn:split(mvo.mem_scNumber,'-')[1]}" maxlength="1" placeholder="주민번호 뒤에 1자리를 입력해주세요.">
              <input type="hidden" id="scNumber" name="mem_scNumber" />
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>숫자만 입력가능합니다.</small>
          </div>
          <div class="form-group">
              <label for="tel">전화번호</label>
              <input type="text" class="form-control" id="tel" name="mem_tel" value="${mvo.mem_tel}" maxlength="13" placeholder="전화번호를 입력해주세요. ex)000-0000-0000">
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>숫자와 '-'만 입력가능합니다.</small>
          </div>
          <div class="form-group">
              <label for="email">이메일</label>
              <button type="button" id="authEmailbtn" data-toggle="modal" data-target="#myModal1">이메일 인증</button>
              <input type="text" class="form-control" id="email" name="mem_email" value="${mvo.mem_email}" placeholder="이메일을 입력해주세요. ex)ID1234@naver.com">
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>변경안하신다면 인증안하셔도됩니다 !</small>
          </div>
          <div class="form-group">
              <label for="pswdQ">비밀번호 찾기 질문</label>
              <select name="mem_pswdQ" class="form-control">
              	<option value="1" <c:if test="${mvo.mem_pswdQ == 1}">selected</c:if>>출신초등학교</option>
              	<option value="2" <c:if test="${mvo.mem_pswdQ == 2}">selected</c:if>>어렸을때별명</option>
              	<option value="3" <c:if test="${mvo.mem_pswdQ == 3}">selected</c:if>>내가 가장 좋아했던 장소</option>
              	<option value="4" <c:if test="${mvo.mem_pswdQ == 4}">selected</c:if>>부모님 이름</option>
              	<option value="5" <c:if test="${mvo.mem_pswdQ == 5}">selected</c:if>>어렸을때 살았던 동네</option>
              </select>
              <input type="text" class="form-control" id="pswdA" name="mem_pswdA" value="${mvo.mem_pswdA}" maxlength="30" placeholder="비밀번호 찾기 질문의 대답을 입력해주세요.">
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>기억하실수있는 대답으로해주세요 !.</small>
          </div>
          <div class="form-group">
              <label for="photo">프로필사진등록</label><br/>
              <input class="upload-name" value="선택된 파일 없음" disabled="disabled">
						  <input type="file" id="photo" name="file"  class="upload-hidden">
              <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>사진의 수위가 쌔거나 부적절하다 판단되면 프로필사진이 기본프로필사진으로 경고없이 변경될수있습니다.</small>
              <div style="background-color: #f4f4d9;width: 100%;height: 400px;">
              <img src="${ctp}/images/memberprofile/${mvo.mem_sPhoto}" id="preview" style="width: 100%;height: 400px"/>
              <input type="hidden" name="bFile" value="${mvo.mem_photo}"/>
              <input type="hidden" name="bsFile" value="${mvo.mem_sPhoto}"/>
              </div>
          </div>
          <button type="button" onclick="fCheck()" class="btn mt-30">회원정보수정</button>
        </form>
    </div>
</div>
<script>
	'use strict'
	$('input[name="file"]').change(function(){
		readImage(this); //미리보기
	});
	
	//이미지 띄우기
	function readImage(input) {
	    if(input.files && input.files[0]) {
	        const reader = new FileReader();
	        reader.onload = function(e){
	            const previewImage = document.getElementById("preview");
	            previewImage.src = e.target.result;
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
</script>
<jsp:include page="/WEB-INF/views/home/authModal.jsp"></jsp:include>		
</body>

</html>