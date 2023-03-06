<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <title>예매 최종 결제</title>

    <!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">

		<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>

</head>
		<!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
	'use strict'
	
	let addForm = '';
	let seatNu = '';
	$(function(){
		
		$("#priceDemo").html('<fmt:formatNumber value="${vo.tk_totPrice}" pattern="#,###" />원');
		$("#pointDemo").html('<span style="font-size:0.5em ">적립금을 사용하시려면 눌러주세요. <button type="button" id="jucklipBtn" onclick="point()">적립금사용</button><br/>쿠폰을 사용하시려면 눌러주세요.<button type="button" id="couponBtn" onclick="coupon()">쿠폰사용</button></span>');
		
		for(let i = 1; i <= 150; i++){
			if(i == 145) {
				addForm += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			}
			addForm += '<span id="seat'+i+'">👓</span>';
			if(i % 3 == 0) {
				addForm += '&nbsp;&nbsp;&nbsp;';
			}
			if(i % 9 == 0) addForm += '<br/>';
		}
		$("#movieSeatDemo").html(addForm);
		
		let seatArr = '${vo.tk_seat}'
		let arr2 = seatArr.split('번 ');
		
		const regex = /[^0-9]/g;
		let result = '';
		for(let i = 0; i < arr2.length-1; i++){
		  result = arr2[i].replace(regex, "");
			arr2[i] = result;
			seatNu += result + '/';
		}
		
		
		for(let i = 0; i < arr2.length; i++){
			$("#seat"+arr2[i]).html('❌');
		}
		
	});
	
	var bcnt = 0;
	function back(sw){
		bcnt++;
		
		if(bcnt == 2){
			$("#pointDemo").html('<span style="font-size:0.5em ">적립금과 쿠폰을 다시 사용하시려면 새로고침을 눌러주세요<button type="button" onclick="location.reload();">새로고침</button></span>');
			return;
		}
		else if(sw == '1'){
			$("#pointDemo").html('<span style="font-size:0.5em ">쿠폰을 사용하시려면 눌러주세요.<button type="button" id="couponBtn" onclick="coupon()">쿠폰사용</button></span>');
		}
		else if(sw == '2'){
			$("#pointDemo").html('<span style="font-size:0.5em ">적립금을 사용하시려면 눌러주세요. <button type="button" id="jucklipBtn" onclick="point()">적립금사용</button></span>');
		}
	}
	
	var time = new Date().getTime();
	var IMP = window.IMP; 
     IMP.init("imp08876846"); 

     function requestPay() {
    	 
         // IMP.request_pay(param, callback) 결제창 호출
         IMP.request_pay({ // param
             pg: "html5_inicis.INIpayTest",
             pay_method: "card",
             merchant_uid: 'GGV_'+time,
             name: '${vo.tk_movieName} 티켓',
             /* amount: '${vo.tk_totPrice}', */
             amount : 10,
             buyer_email: "${vo.tk_email}",
             buyer_name: "${sName}",
             buyer_tel: "${vo.tk_tel}",
             buyer_addr: "",
             buyer_postcode: ""
         }, function (rsp) { // callback
             if (rsp.success) {
            	 paymentCheck();
             } else {
            		Swal.fire({
	                    title: '결제에 실패하셨습니다.',
	                    text: "다시 시도 하시겠습니까?",
	                    icon: 'info',
	                    showCancelButton: true,
	                    confirmButtonColor: '#3085d6',
	                    cancelButtonColor: '#d33',
	                    confirmButtonText: '다시 시도',
	                    cancelButtonText: '홈으로'
	                }).then((result) => {
                    if (result.isConfirmed) {
                    		requestPay();
	                    }
                    else {
											location.href='${ctp}/';                    	
                    }
	                })
             }
         });
       }
	
		  let mPoint = 0;
		 	var resPoint = 0;
		 	var totPrice = '${vo.tk_totPrice}';
		 	
		 	function point(){
		 		let id = '${sId}';
		 		
		 		$.ajax({
		 			type : "post",
		 			url  : "${ctp}/admin/memberPointGet",
		 			data : {id:'${sId}'},
		 			async: false,
		 			success : function(point){
		 				mPoint = point
		 				if(Number(point) < 5000){
		 					Swal.fire({
		 						title : '이런..포유하신 포잍트가 최소 5000포인트 이상부터 사용가능하십니다.',
		 						text  : '보유하신 포인트는 '+point+'원입니다.',
		 						icon  : 'info'
		 					});
		 				}
		 				else { 
		    				let addForm = '';
		    				
		    				addForm += '<span style="font-size:0.5em">사용가능하신포인트는'+point+'원이있으십니다.';
		    				addForm += '사용하실 포인트를 입력 후 엔터를 눌러주세요.<input type="number" name="point" id="point" onchange="changePrice()" class="form-control"/>';
		    				addForm += '포인트 입력은 한번만가능하시고 다시 입력하시려면 새로고침 후 다시입력해주세요.<button onclick="back(1)">뒤로가기</button></span>';
		    				$("#pointDemo").html(addForm);
		 				} 
		 			},
		 			error : function(){
		 				Swal.fire({
		 					title : "전송 오류",
		 					icon : "error"
		 				});
		 			}
		 		});
		 	}
		 	
		 	function changePrice(){
		
		 		let usepoint = $("#point").val();
		 		
		 		if(usepoint > Number(mPoint)){
		 			Swal.fire({
		 				title : '포인트가 부족합니다.',
		 				text  : '보유하신 포인트보다 많은 포인트를 입력하셨습니다.다시입력해주세요',
		 				icon  : 'warning'
		 			});
		 			
		 		}
		 		else {
		 			
		 			let temp = 0;
		 			
		 					temp = totPrice;
		    		
		    		let resPrice = temp - usepoint;
		    		
		    		resPoint = usepoint;
		    		totPrice = resPrice;
		    		
		    		
		    		$("#priceDemo").html(totPrice+'원');
		    		$("#point").attr('readonly',true);
		 		}
		 	}
		
		 	
		 function coupon(){
		 		
		 $.ajax({
		 	type : 'post',
		 	url  : '${ctp}/movie/myCouponGet',
		 	success : function (vos) {
		 		
		 		let addForm = '';
		 		
		 		addForm += '<span style="font-size:0.5em "><select name="coupon" id="coupon" onchange="couponApply()">';
		 		addForm += '<option value="0">쿠폰리스트</option>';
		 		for(let i = 0 ; i<vos.length; i++){
		 			addForm += '<option value="'+vos[i].c_content+'">'+vos[i].c_name+' '+vos[i].c_content+'%</option>';
		 		}
		 			addForm += '</select><button onclick="back(2)">뒤로가기</button></span>';
		 		
		 		$("#pointDemo").html(addForm);
		 	},
		 	error : function(){
		 		Swal.fire({
		 			title : "전송 오류",
		 			icon  : 'error'
		 		});				
		 	}
		 }); 
		
		 }
		
		
		 var couPonPercent = 0; 	
		 var affterPrice = 0;
		 function couponApply(){
		 let coupon = $("#coupon").val();
		 couPonPercent = coupon;
		 		
		 let mPrice = totPrice / 100 * Number(coupon);
		
		 totPrice = totPrice - mPrice;
		 if(coupon == 0){
		 	totPrice = '${vo.tk_totPrice}';			
		 }
		 
		 $("#priceDemo").html(totPrice+'원');
		 }


   	
	
	function paymentCheck(){ // 원래 결제 모달 뜨고 결제해야함 일단 db에 저장하도록 짜겠음
		Swal.fire({
			title: '예매진행중입니다 !!',
			text: '결제 중입니다 잠시만 기다려주세요. 결제가 완료되면 현장발권 대신 사용가능하신 QR코드를 메일로 보내드리니 확인바랍니다.',
			imageUrl: '${ctp}/images/머쓱피치.png',
			imageWidth: 500,
			imageHeight: 500,
			imageAlt : '어피치'
		});
		
		let query = {
				  tk_movieName : '${vo.tk_movieName}',
				  tk_screenType : '${vo.tk_screenType}',
				  tk_town : '${vo.tk_town}',
				  tk_screenDate : '${vo.tk_screenDate}',
				  tk_screenTime : '${vo.tk_screenTime}',
				  tk_seat : seatNu,
				  tk_movieImg : '${vo.tk_movieImg}',
				  tk_adultno : '${vo.tk_adultno}',
				  tk_teenno : '${vo.tk_teenno}',
				  tk_childno : '${vo.tk_childno}',
				  tk_preferentialno : '${vo.tk_preferentialno}',
				  tk_totPrice : '${vo.tk_totPrice}',
					tk_usePoint : resPoint, 
				  tk_useCoupon: couPonPercent
		}  

	
	$.ajax({
			type : "post",
			url  : '${ctp}/movie/ticketingPaymentOk',
			data : query,
			success : function(){
				
			
			$.ajax({
					type : "post",
					url  : "${ctp}/movie/pointInput",
					data : query,
					success : function(){ 
						
						let jucklip = '${vo.tk_totPrice / 100 * 3}';
						
						jucklip = jucklip.substring(0,jucklip.lastIndexOf('.'));
						
						let dataQuery = {
								usePoint:resPoint,
								jucklip : jucklip
						}
						
						$.ajax({
							type : "post",
							url  : "${ctp}/movie/usePointCheck",
							data : dataQuery,
							success : function(){
								console.log('사용포인트 차감완료');
							},
							error : function(){
								Swal.fire({
									title:'전송 오류',
									icon : 'error'
								});								
							}
						}); 			 		
						
					},
					error : function(){
						Swal.fire({
							title : "전 송 오 류",
							icon  : "error"
						});
					}
				}); 
				
				
				
				Swal.fire({
					title:'예매에 성공하셨습니다.',
					text:'성공 !!',
					icon:'success',
				});
				  
				fnlocation();
			},
			error : function(){
				Swal.fire({
					title:'전송오류',
					text:'삐비빅..',
					icon:'error',
				});
			}
	  }); 
	 
	}        
	
    
	function fnlocation(){
		setTimeout(() => {
			location.href='${ctp}/';	
		}, 2000);
		
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

span {
	font-size: 1.4em
}

</style>
<body>
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
    <div class="breadcumb-area bg-img bg-overlay" style="background-image: url(${ctp}/resources/img/bg-img/아바타.jpg);">
        <div class="bradcumbContent">
            <h2>영화 결제</h2>
            <h2><span id="loadingDemo"></span></h2>
        </div>
    </div>

    <section class="elements-area mt-30 section-padding-100-0" >
        <div class="container">
            <div class="row">
                <div class="col-4">
                    <div class="elements-title mb-70">
                        <h2>${sId}님께서 ${vo.tk_movieName} 예매중이십니다.</h2>
                    </div>
                    <!-- Buttons -->
                    <img alt="${vo.tk_movieName}" src="${ctp}/resources/cgv/cgvMainImg/${vo.tk_movieImg}" width="300px"><br/>
               	</div>
                <div class="col-8"><!-- ❌  -->
                <span id="movieSeatDemo"></span>
                <p style="background-color: #c4d4f9;width: 52%;font-weight: bold;text-align: center;">SCREEN</p>
               	</div>
              </div>
               	<table class="table table-hover" style="font-size: 2em;text-align: center">
               		<tr>
               			<th colspan="2">극장</th>
               			<td colspan="2">${vo.tk_town}지점</td>
               		</tr>
               		<tr>
               		  <th colspan="2">날짜와 시간</th>
               			<td colspan="2">${vo.tk_screenDate} ${vo.tk_screenTime}</td>
               		</tr>
               		<tr>
               			<th colspan="2">선택하신 자리</th>
               			<td colspan="2">${vo.tk_seat}</td>
               		</tr>
               		<tr>
               			<td>성인 : ${vo.tk_adultno}</td>
               			<td>청소년 : ${vo.tk_teenno}</td>
               			<td>어린이 : ${vo.tk_childno}</td>
               			<td>우대 : ${vo.tk_preferentialno}</td>
               		</tr>
               		<tr>
               			<th colspan="2">총 금액</th>
               			<td colspan="2">
               			<span id="priceDemo"></span>
               			</td>
               		</tr>
               		<tr>
               			<th colspan="2">적립금</th>
               			<td colspan="2"><c:set var="point" value="${vo.tk_totPrice / 100 * 3}"></c:set>
               			+<fmt:formatNumber value="${fn:substring(point,0,fn:indexOf(point,'.'))}" pattern="#,###" /> 원
               			</td>
               		</tr>
               		<tr>
               			<th colspan="4">
               				<span id="pointDemo"></span>
               			</th>
               		</tr>
               		<tr>
               			<td colspan="4">
               				<button type="button" onclick="requestPay()">결제하기</button>
               				<button type="button" onclick="">뒤로가기</button>
               				<button type="button" onclick="">메인으로</button>
               			</td>
               		</tr>
               	</table>
              </div>
           </section>
<jsp:include page="/WEB-INF/views/include/chatting.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>

</html>