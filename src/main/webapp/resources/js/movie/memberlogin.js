/**
 * 
 */
    	'use strict'
    	
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
	
	
	function pswdSearch(){
		const regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{6,16}$/g
		const regNickName = /^[a-zA-Z가-힣0-9]{2,20}$/i;
		const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		let id = $("#authId").val();
		let nickName = $("#pswdNickName").val(); 
		let email = $("#email").val();
		let pswdQ = $("#pswdQ").val();
		let pswdA = $("#pswdA").val();
		
		
	if(regId.test(id)){
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
	
	