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
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    
    <title>GGV(오늘 뭐 볼까?)</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
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
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
  	'use strict';
  	window.Kakao.init("4d9fc650f3b42a755fd77f61baff8674");
  
    // 카카오 로그인
  	function kakaoLogin() {
  		window.Kakao.Auth.login({
  			scope: 'profile_nickname, account_email',
  			success:function(autoObj) {
  				console.log(Kakao.Auth.getAccessToken(),"로그인 OK");
  				console.log(autoObj);
  				window.Kakao.API.request({
  					url : '/v2/user/me',
  					success:function(res) {
  						const kakao_account = res.kakao_account;
  						console.log(kakao_account);
  						//alert(kakao_account.email + " / " + kakao_account.profile.nickname);
  						location.href="${ctp}/memberKakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email;
  					}
  				});
  			}
  		});
  	}
  	// 카카오 로그아웃
  	function kakaoLogout(kakaoKey) {
  		// 다음에 로그인시에 동의항목 체크하고 로그인할 수 있도록 로그아웃시키기
			Kakao.API.request({
	      url: '/v1/user/unlink',
	    })
  		Kakao.Auth.logout(function() {
  			console.log(Kakao.Auth.getAccessToken(), "토큰 정보가 없습니다.(로그아웃되셨습니다.)");
  		});
  	}
  	
  	
  	 function handleCredentialResponse(response) {
         // decodeJwtResponse() is a custom function defined by you
         // to decode the credential response.
         const responsePayload = parseJwt(response.credential);
         
         console.log("ID: " + responsePayload.sub);
         console.log('Full Name: ' + responsePayload.name);
         console.log('Given Name: ' + responsePayload.given_name);
         console.log('Family Name: ' + responsePayload.family_name);
         console.log("Image URL: " + responsePayload.picture);
         console.log("Email: " + responsePayload.email);
         
         location.href="${ctp}/GoogleLogin?mem_email="+responsePayload.email+"&mem_name="+responsePayload.name+"&mem_photo="+responsePayload.picture;
         
     };

     function parseJwt (token) {
         var base64Url = token.split('.')[1];
         var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
         var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
             return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
         }).join(''));

         return JSON.parse(jsonPayload);
     };

  	
	function fCheck(){
		const regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{6,16}$/g
		const regPswd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,}$/;
		
		let id = $("#id").val();
		let pswd = $("#pswd").val();
		
		if(id.trim() == 'admin' &&  pswd.trim() == '1234') {
			myform.submit();
			return;
		} 
		
		if(!regId.test(id)){
			alert('아이디형식을 확인해주세요.');
			return;
		}		
		else if(!regPswd.test(pswd)){
			alert('비밀번호형식을 확인해주세요.');
			return;
		 }
		else {
			myform.submit();
		}
	}
	
</script>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(resources/img/bg-img/avatar.jpg);">
        <div class="bradcumbContent">
            <p>보고싶은 영화가 한곳에 !!</p>
            <h2>로그인</h2>     
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->	

    <!-- ##### Login Area Start ##### -->
    <section class="login-area section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h3>Welcome Back</h3>
                        <!-- Login Form -->
                        <div class="login-form">
                            <form name="myform" method="post" action="${ctp}/login">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">ID</label>
                                    <input type="text" class="form-control" id="id" name="id" aria-describedby="emailHelp" placeholder="Enter ID">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 8자리 최대 16자리입니다.</small>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input type="password" class="form-control" id="pswd" name="pswd" placeholder="Password">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 10자리 최대 20자리입니다.</small>
                                </div>
                                <button type="button" onclick="fCheck()" class="btn oneMusic-btn mt-30">Login</button>
                                <button type="button" onclick="location.href='${ctp}/join'" class="btn oneMusic-btn mt-30">Join</button>
                                <button type="button" class="btn oneMusic-btn mt-30" data-toggle="modal" data-target="#myModal1">ID찾기</button>
                                <button type="button" class="btn oneMusic-btn mt-30" data-toggle="modal" data-target="#myModal2">비밀번호찾기</button>
<%-- 	                                <button type="button"  onclick="kakaoLogin()" style="margin-top: 5px" ><img src="${ctp}/images/kakao_login_medium_narrow.png" /></button>    
	                                <button type="button" id="g_id_onload" data-client_id="863936726348-7la33orhr3ocm3m3trfommf3ducr27ap.apps.googleusercontent.com" data-callback="handleCredentialResponse" ><span class="g_id_signin" data-type="icon" data-shape="circle" ></span></button> --%>
	                                <a type="button"  onclick="kakaoLogin()" style="margin-top: 5px" ><img src="${ctp}/images/kakao_login_medium_narrow.png" /></a><br/>    
	                                <a type="button" style="margin-top: 10px" id="g_id_onload" data-client_id="863936726348-7la33orhr3ocm3m3trfommf3ducr27ap.apps.googleusercontent.com" data-callback="handleCredentialResponse" ><span class="g_id_signin" data-type="icon" data-shape="circle" ></span></a>
	                               	<div id="naver_id_login" style="margin-top: 13px"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script type="text/javascript">
    var naver_id_login = new naver_id_login("PqKrA03M4FASBnKGgGIk", "http://localhost:9090/green2209S_10/naverLoginTx");
   	var state = naver_id_login.getUniqState();
   	naver_id_login.setButton("white", 2,40);
    naver_id_login.setDomain("http://localhost:9090/green2209S_10/naverLoginTx"); 
   	naver_id_login.setState(state);
   	naver_id_login.setPopup();
   	naver_id_login.init_naver_id_login();
   	
   	
   	
   	
   	
   	
	function idSearch(){
		const regScNumber = /^[0-9]+$/; 
		const regName = /^[a-zA-Z가-힣]{2,20}$/i;
		const regNickName = /^[a-zA-Z가-힣0-9]{2,20}$/i;
		
		let name = $("#name").val();
		let nickName = $("#IdNickName").val();
		let scnumber1 = $("#scnumber1").val();
		let scnumber2 = $("#scnumber2").val();
		let scnumber = scnumber1 +'-'+scnumber2;
		
		let yearCheck = scnumber1.substr(0,4);
		let monthCheck1 = scnumber1.substr(4,1);
		let monthCheck2 = scnumber1.substr(5,1);
		let dayCheck1 = scnumber1.substr(6,1);
		let dayCheck2 = scnumber1.substr(7,1);
		
		if(name == ''){
			alert('이름을 입력해주세요.');
			return;
		}
		else if(nickName == ''){
			alert('닉네임을 입력해주세요.');
			return;
		}
		else if(!regName.test(name)){
			alert('이름형식을 확인해주세요.');
			return;
		 }
		else if(!regNickName.test(nickName)){
			alert('이름형식을 확인해주세요.');
			return;
		 }
		else if(!regScNumber.test(scnumber1) || !regScNumber.test(scnumber2) || scnumber1.length != 8 || scnumber2.length != 1){ 
			alert('주민등록번호형식을 확인해주세요.');
			return;
		 }
		else if(monthCheck1 == 1 && monthCheck2 > 2 || monthCheck1 <= 0 && monthCheck2 < 1 || dayCheck1 == 3 && dayCheck2 > 1 || dayCheck1 <= 0 && dayCheck2 < 1){
			alert('주민등록번호의 생년월일을 확인해주세요.');
			return;
		}
		else if(yearCheck <= 1999 && scnumber2 != 1 && scnumber2 != 2){
				alert('주민등록번호 뒷자리의 첫번째자리를 확인해주세요.');
				return;
			}
		else if(yearCheck >= 2000 && scnumber2 != 3 && scnumber2 != 4){
				alert('주민등록번호 뒷자리의 첫번째자리를 확인해주세요.');
				return;
			}   
		
		
		$.ajax({
			type : "GET",
			url  : "${ctp}/idSearch?name="+name+"&nickName="+nickName+"&scnumber="+scnumber,
			success : function(id){
				if(id != '' || id != null){
    				let addForm = '<p>';
    				addForm += '회원 님의 아이디는 '+id;
    				addForm += ' 입니다';
    				addForm += '</p>';
    				
    				$("#idSearchDemo").html(addForm);
    				$("#name").val('');
    				$("#nickName").val('');
    				$("#scnumber1").val('');
    				$("#scnumber2").val('');
				}
				else {
    				let addForm = '일치하는 정보의 아이디를 찾기못했습니다.\n다시 입력해주세요.';
    				
    				$("#idSearchDemo").html(addForm);
    				$("#name").val('');
    				$("#nickName").val('');
    				$("#scnumber1").val('');
    				$("#scnumber2").val('');
				}
			},
			error : function(){
					alert('전송오류');    				
			}
		});
		
		
	}

	
	var countDown = 60 * 3;
var myTimer;
var emailSw = '';
var rEmail = '';

let authUid = '';
function emailCheck(){
	emailSw = '0';
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
		authUid = '';
		$("#emailCheckBtn").attr('disabled',false);
		$("#authEmailDiv").hide();
	}
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
				alert('인증 성공 \n인증창을 닫고 비밀번호 찾기를 마무리해주세요.');
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


function pswdSearch(){
	const regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{6,16}$/g
	const regNickName = /^[a-zA-Z가-힣0-9]{2,20}$/i;
	const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	let id = $("#authId").val();
	let nickName = $("#pswdNickName").val(); 
	let email = $("#email").val();
	let pswdQ = $("#pswdQ").val();
	let pswdA = $("#pswdA").val();
	
	
	if(!regId.test(id)){
		alert('아이디형식을 확인해주세요.');
		return;
	}		
	else if(!regNickName.test(nickName)){
		alert('이름형식을 확인해주세요.');
		return;
	 }
	else if(!regEmail.test(email)){
		alert('이메일형식을 확인해주세요.');
		return;
	 }		
	else if(emailSw != '1'){
		alert('이메일인증을 해주세요.');
		return;
	}
	else if(pswdA == ''){
		Swal.fire({
			title: "빈칸이있습니다 !!!",
			text: "비밀번호질문의 대답을 입력해주세요.",
			icon: "warning",
		});
	}
	else {
		
		$.ajax({
			type : "GET",
			url  : "${ctp}/pswdSearch?id="+id+"&nickName="+nickName+"&email="+email+"&pswdQ="+pswdQ+"&pswdA="+pswdA,
			success : function(res){
				if(res == 1){
					alert('임시 비밀번호를 이메일인증하신 이메일주소로 보내드렸습니다.\n로그인하신 후 원활한 이용을위해 변경부탁드립니다.');						
					$("#pswdSearchBtn").prop('disabled',true);
				}
				else if(res == 0) {
					alert('일치하는 정보의 비밀번호가 존재하지않습니다.');
					location.reload();
				}
			},
			error : function(){
				alert('전송 오류');					
			}
		});
		
	} 
}

    </script>
 <jsp:include page="/WEB-INF/views/home/loginModal.jsp"></jsp:include>
 <jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>

</html>