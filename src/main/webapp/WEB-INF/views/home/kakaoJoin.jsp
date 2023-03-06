<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	
	var idSw = '';
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
		const regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{6,16}$/g
		const regPswd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,}$/;
		const regName = /^[a-zA-Z가-힣]{2,20}$/i;
		const regNickName = /^[a-zA-Z가-힣0-9]{2,20}$/i;
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
		
		
		if(id.trim() == 'admin' &&  pswd.trim() == '1234') {
			myform.submit();
			return;
		} 
		
		if(!regId.test(id)){
			Swal.fire({
				title : '아이디 형식이 잘못되었습니다.',
				text : '다른 아이디를 사용해주세요.',
				icon : 'warning',
			});
			return;
		}		
		else if(id == pswd){
			Swal.fire({
				title : '아이디와 비밀번호가 같습니다.',
				text : '아이디와 비밀번호는 다르게만들어주세요.',
				icon : 'warning',
			});
			return
		}
		else if(!regPswd.test(pswd)){
			Swal.fire({
				title : '비밀번호 형식이 잘못되었습니다.',
				text : '다른 비밀번호를 사용해주세요.',
				icon : 'warning',
			});
			return;
		}
		else if(pswd != pswd2){
			Swal.fire({
				title : '비밀번호와 확인비밀번호가 다릅니다.',
				text : '확인 후 다시 비밀번호를 입력해주세요.',
				icon : 'warning',
			});
			return;
		}
		else if(!regName.test(name)){
			Swal.fire({
				title : '이름 형식이 잘못되었습니다.',
				text : '다른 이름을 사용해주세요.',
				icon : 'warning',
			});
			return;
		 }
		else if(!regNickName.test(nickName)){
			Swal.fire({
				title : '별명의 형식이 잘못되었습니다.',
				text : '다른 별명을 사용해주세요.',
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
		else if(idSw != '1'){
			Swal.fire({
				title : '아이디 중복체크를 해주세요.',
				text : '중복체크 부탁드립니다 !',
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
</style>
<body>
   <jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(resources/img/bg-img/교섭.jpg);">
        <div class="bradcumbContent">
            <p>보고싶은 영화가 한곳에 !!</p>
            <h2>카카오 회원가입</h2>
        </div>
    </section>

    <section class="login-area section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h3>Welcome</h3>
                        <!-- Login Form -->
                        <div class="login-form">
                            <form name="myform" method="post" action="${ctp}/join" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="id">아이디</label>
                                    <button type="button" id="authIDbtn" onclick="authId()" data-toggle="modal" data-target="#myModal2">아이디 중복 체크</button>
                                    <input type="text" class="form-control" id="id" name="mem_id" aria-describedby="emailHelp" maxlength="16" placeholder="아이디를 입력해주세요.">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영어 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 8자리 최대 16자리입니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="pswd">비밀번호</label>
                                    <input type="password" class="form-control" id="pswd" name="mem_pswd" maxlength="20" placeholder="비밀번호를 입력해주세요.">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영어 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 10자리 최대 20자리입니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="pswd2">비밀번호 확인</label>
                                    <input type="password" class="form-control" id="pswd2" maxlength="20" placeholder="확인 비밀번호를 입력해주세요.">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영어 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 10자리 최대 20자리입니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="name">성명</label>
                                    <input type="text" class="form-control" id="name" name="mem_name" maxlength="20" placeholder="이름을 입력해주세요.">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영어 대/소문자와 한글만 가능하며 최소 2자리 최대 20자리입니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="name">닉네임</label>
                                    <input type="text" class="form-control" id="nickName" name="mem_nickName" value="${nickName}" readonly maxlength="20" placeholder="이름을 입력해주세요.">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영어 대/소문자와 한글과 숫자만 가능하며 최소 2자리 최대 20자리입니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="scNumber1">생년월일 | 성별</label>
                                    <input type="text" class="form-control" id="scNumber1" maxlength="8" placeholder="생년월일 8자리를 입력해주세요.">
                                    <input type="text" class="form-control" id="scNumber2" maxlength="1" placeholder="주민번호 뒤에 1자리를 입력해주세요.">
                                    <input type="hidden" id="scNumber" name="mem_scNumber" />
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>숫자만 입력가능합니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="tel">전화번호</label>
                                    <input type="text" class="form-control" id="tel" name="mem_tel" maxlength="13" placeholder="전화번호를 입력해주세요. ex)000-0000-0000">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>숫자만 입력가능합니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <input type="text" class="form-control" id="email" name="mem_email" value="${email}" readonly>
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정상적인 이메일 형식에 맞춰주세요.</small>
                                </div>
                                <div class="form-group">
                                    <label for="pswdQ">비밀번호 찾기 질문</label>
                                    <select name="mem_pswdQ" class="form-control">
                                    	<option value="1">출신초등학교</option>
                                    	<option value="2">어렸을때별명</option>
                                    	<option value="3">내가 가장 좋아했던 장소</option>
                                    	<option value="4">부모님 이름</option>
                                    	<option value="5">어렸을때 살았던 동네</option>
                                    </select>
                                    <input type="text" class="form-control" id="pswdA" name="mem_pswdA" maxlength="30" placeholder="비밀번호 찾기 질문의 대답을 입력해주세요.">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정상적인 이메일 형식에 맞춰주세요.</small>
                                </div>
                                <div class="form-group">
                                    <label for="photo">프로필사진등록</label><br/>
                                    <input type="file" id="photo" name="file" style="width: 270px; height: 46px;">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>사진의 수위가 쌔거나 부적절하다 판단되면 프로필사진이 기본프로필사진으로 경고없이 변경될수있습니다.</small>
                                    <div style="background-color: #f4f4d9;width: 100%;height: 300px;">
                                    <img src="" id="preview" width="1000px" style="position: absolute;z-index: 1;width: 300px"/>
                                    </div>
                                </div>
                                <button type="button" onclick="fCheck()" class="btn oneMusic-btn mt-30">회원가입</button>
                                <input type="hidden" name="kakaoSw" value="1"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

<script>
	'use strict'
	$('input[name="file"]').change(function(){
    setImageFromFile(this, '#preview');
	});
	
	function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    $(expression).attr('src', e.target.result);
	  }
	  reader.readAsDataURL(input.files[0]);
	  }
	}
	
	
	function authId(){
			let id = $("#id").val();
			$("#authId").val(id);
			
	}

	function authNickName(){
		let nickName = $("#nickName").val();
		$("#authNickName").val(nickName);
	}
	
	function authIdSearch(){
		
		const regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{6,16}$/g
		let id = $("#authId").val();
		
		if(id == ''){
			alert('아이디를 입력해주세요.');
			return
		}
		else if(!regId.test(id)){
			alert('아이디형식을 확인해주세요.');
			return;
		}
		
		$.ajax({
			type : "post",
			url  : "${ctp}/idCheck",
			data : {id : id},
			success : function(vo){
				if(vo.mem_id != null){
					$("#idSearchDemo").html('이미 존재하는 아이디입니다.');
				}
				else {
					idSw = '1';
					$("#idSearchDemo").html('사용가능한 아이디입니다.');
					let ans = confirm('사용가능한 아이디입니다.\n사용하시겠습니까?');
					
					if(ans){
						$("#id").val(id);
						$("#id").attr("readonly",true);
					}
				}
			},
			error : function(){
				alert('전송 오류');				
			}
		});		
	}
	
	function authNickNameSearch(){
		const regNickName = /^[a-zA-Z가-힣0-9]{2,20}$/i;
		let nickName = $("#authNickName").val();
		
		if(nickName == ''){
			alert('닉네임을 입력해주세요.');
			return
		}
		else if(!regNickName.test(nickName)){
			alert('닉네임형식을 확인해주세요.');
			return;
		}
		
		$.ajax({
			type : "post",
			url  : "${ctp}/nickNameCheck",
			data : {nickName : nickName},
			success : function(vo){
				if(vo.mem_nickName != null){
					$("#nickNameSearchDemo").html('이미 존재하는 닉네임입니다.');
				}
				else {
					idSw = '1';
					$("#nickNameSearchDemo").html('사용가능한 닉네임입니다.');
					let ans = confirm('사용가능한 닉네임입니다.\n사용하시겠습니까?');
					
					if(ans){
						$("#nickName").val(id);
						$("#nickName").attr("readonly",true);
					}
				}
			},
			error : function(){
				alert('전송 오류');				
			}
		});		
	}
	
	
</script>

 <!-- 아이디 인증 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal2">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">회원가입 아이디 중복체크</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	 	<form name="authIdForm">
		      	 		<h3>아이디<h3>
		      	 		<input type="text" id="authId" name="authId" class="form-control" placeholder="아이디을 입력해주세요."/>
		      	 		<button type="button" onclick="authIdSearch()">중복체크</button><span id="idSearchDemo"></span>
		      	 	</form>
		      </div>
		
		  <!--     Modal footer
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
		      </div> -->
		
		    </div>
		  </div>
		</div>
		
 <!-- 이메일 인증 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">회원가입 이메일 인증</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	 <div class="login-form">
                <form name="authEmailForm">
                    <div class="form-group">
                        <label for="exampleInputPassword1">이메일</label>
                        <input type="text" class="form-control" id="emailC" name="email" placeholder="이메일을 입력해주세요.">
                        <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정확히 입력해주세요.</small>
                    </div>
                    <span id="formGroupDemo"></span>
                    <button type="button" id="emailCheckBtn" onclick="emailCheck()" class="btn oneMusic-btn mt-30">인증번호받기</button>
                </form>
            </div>
		      </div>
		    </div>
		  </div>
		</div>
		
 <!-- 닉네임 인증 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal3">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">회원가입 닉네임 중복체크</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	<div class="login-form">
        			<form name="authIdForm">
		      	 		<h3>닉네임</h3>
		      	 		<input type="text" id="authNickName" name="authNickName" class="form-control" placeholder="닉네임을 입력해주세요."/>
		      	 		<button type="button" onclick="authNickNameSearch()">중복체크</button><span id="nickNameSearchDemo"></span>
		      	 	</form>
            </div>
		      </div>
		    </div>
		  </div>
		</div>
		
  <jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>

</html>