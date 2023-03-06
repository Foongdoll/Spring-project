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
    <title>예매하기</title>

    <!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">
		<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<script>
	'use strict'
	
	$(function(){
		if('${movie}' == ''){
			
		}
		else {
			let movieName = '${movie}';
			
			$.ajax({
				type : "post",
				url  : "${ctp}/movie/regionView",
				data : {movieName : movieName},
				success : function(region){ // 영화
					let addForm = '<form name="regionForm">';
						addForm += '<ul>';
					for(let i = 0; i < region.length; i++){
						addForm += '<li style="color:#333333;"><a href="javascript:townView('+i+')" id="townA'+i+'" style="display:block">'+region[i]+'</a>';
						addForm += '<input type="hidden" id="region'+i+'" value="'+region[i]+'"/><input type="hidden" id="regionMovieName" value="'+movieName+'"/></li>';
					}
						addForm += '</ul>';
						addForm += '</form>';				
						
						let movieImg = '';
						
					 $.ajax({
							type : "GET",
							url  : "${ctp}/movie/movieImgGet?movieName="+movieName,
							async : false,
							success : function(img){
								movieImg = img;
							},
							error : function(){
								alert('전송 오류');							
							}
						});
					
					let addMovieForm = '<img src="'+movieImg+'" width="150px">';
					addMovieForm += movieName;
						
					$("#curMovieName").html(addMovieForm);
					$("#regionViewDemo").html(addForm); 
				},
				error : function(){
					alert("전송 오류");				
				}
			});
		}
	})
	
	
	
	function regionView(movieName){
		
		$.ajax({
			type : "post",
			url  : "${ctp}/movie/regionView",
			data : {movieName : movieName},
			success : function(region){ // 영화 
				let addForm = '<form name="regionForm">';
					addForm += '<ul>';
				for(let i = 0; i < region.length; i++){
					addForm += '<li style="color:#333333;"><a href="javascript:townView('+i+')" id="townA'+i+'" style="display:block">'+region[i]+'</a>';
					addForm += '<input type="hidden" id="region'+i+'" value="'+region[i]+'"/><input type="hidden" id="regionMovieName" value="'+movieName+'"/></li>';
				}
					addForm += '</ul>';
					addForm += '</form>';				
					
					let movieImg = '';
					
				 $.ajax({
						type : "GET",
						url  : "${ctp}/movie/movieImgGet?movieName="+movieName,
						async : false,
						success : function(img){
							movieImg = img;
						},
						error : function(){
							alert('전송 오류');							
						}
					});
				
				let addMovieForm = '<img src="'+movieImg+'" width="150px">';
				addMovieForm += movieName;
					
				$("#curMovieName").html(addMovieForm);
				$("#regionViewDemo").html(addForm); 
			},
			error : function(){
				alert("전송 오류");				
			}
		});
	}
	
	
	function townView(i){
		let strSw = 0;
		let cnt = 0;
		let region = $("#region"+i).val();
		let movieName = $("#regionMovieName").val();
		
		
		
		$("#curTown").html('');
		$("#curDate").html('');
		$("#timeViewDemo").html('');
		
		$("#curRegion").html('-'+region);
		
		if(region == '서울') strSw = 'town1';
		else if(region == '경기') strSw = 'town2';
		else if(region == '인천') strSw = 'town3';
		else if(region == '강원') strSw = 'town4';
		else if(region == '대전 충청') strSw = 'town5';
		else if(region == '대구') strSw = 'town6';
		else if(region == '부산 울산') strSw = 'town7';
		else if(region == '경상') strSw = 'town8';
		else if(region == '광주 전라 제주') strSw = 'town9';
		
		let query = {
				strSw,
				movieName
		}
		
		$.ajax({
			type : "post",
			url  : "${ctp}/movie/townView",
			data : query,
			success : function(town){ // 영화 
				let addTownForm = '<form name="townForm">';
					addTownForm += '<ul>';
				for(let i = 0; i < town.length; i++){
					addTownForm += '<li><a href="javascript:dateView('+i+')" style="display:block;color:#333333">'+town[i]+'</a>';
					addTownForm += '<input type="hidden" id="town'+i+'" value="'+town[i]+'"/><input type="hidden" id="townMovieName" value="'+movieName+'"/></li>';
				}
					addTownForm += '</ul>';
				addTownForm += '</table></form>';			
				
				
				$("#townViewDemo").html(addTownForm);
				$("#dateViewDemo").html('');
				$("#timeViewDemo").html('');
			},
			error : function(){
				alert("전송 오류");				
			}
		});
	}
	
	function dateView(i){
		let town = $("#town"+i).val();
		let movieName = $("#townMovieName").val();
		
		$("#curDate").html('');
		$("#curTown").html('-'+town);
		
		let query = {
				town,
				movieName
		}
		
		$.ajax({
			type : "post",
			url  : "${ctp}/movie/dateView",
			data : query,
			success : function(vos){
				let addDateForm = '<form name="dateForm">';
				addDateForm += '<table class="table table-bordered table-hover" style="color:black;text-align:center">';
				addDateForm += '<ul>';
			for(let i = 0; i < vos.length; i++){
				addDateForm += '<li><a href="javascript:timeView('+i+')" style="display:block;color:#333333">'+vos[i].screenDate+'</a>';
				addDateForm += '<input type="hidden" id="date'+i+'" value="'+vos[i].screenDate+'"/><input type="hidden" id="dateMovieName" value="'+movieName+'"/><input type="hidden" id="dateTown" value="'+town+'"/></li>';
			}
				addDateForm += '</ul>';
				addDateForm += '</table></form>';
				
				$("#dateViewDemo").html(addDateForm);
			},
			error : function(){
				alert('전송 오류');
			}
		});		
		
	}
	
	function timeView(i){
		let date = $("#date"+i).val();
		let movieName = $("#dateMovieName").val();
		let town = $("#dateTown").val();
		
		$("#curDate").html('-'+date);
		
		let query = {
				date,
				movieName,
				town
		}
		
		$.ajax({
			type : "post",
			url  : "${ctp}/movie/timeView",
			data : query,
			success : function(vos){
					let seatVos = '';
					let resSeat = 0;
					let resTime = '';
				$.ajax({
					type : "post",
					url  : "${ctp}/movie/timeViewSeat",
					async : false,
					data : query,
					success : function(svos){
						seatVos = svos;
					},
					error : function(){
						Swal.fire({
							title : '전송 오류',
							text  : '삐비빅..',
							icon  : 'error',
						});						
					}
				});
				
			 	let addTimeForm = '<form name="timeForm">';
					addTimeForm += '<ul>';
				for(let i = 0; i < vos.length; i++){
					addTimeForm += '<li style="display:block;color:#333333;font-size:1em">'+vos[i].screenType+' '+(i+1)+'관';
					addTimeForm += '<a href="javascript:timeView('+i+')">'+vos[i].screenTime+'</a><br/>';
					addTimeForm += ''+vos[i].seat+'석 <a href="${ctp}/movie/ticketing?movieName='+movieName+'&screenDate='+vos[i].screenDate+'&town='+town+'&screenTime='+vos[i].screenTime+'" class="btn btn-secondary btn-sm">예매하기</a></li>';
					}
				
				for(let i = 0 ; i < seatVos.length; i++){
					for(let j = 0; j < vos.length; j++){
						if(seatVos[i].s_ScreenTime == vos[j].screenTime){
							addTimeForm = addTimeForm.replace(''+vos[j].seat+'석 <a href="${ctp}/movie/ticketing?movieName='+movieName+'&screenDate='+vos[j].screenDate+'&town='+town+'&screenTime='+vos[j].screenTime+'" class="btn btn-secondary btn-sm">예매하기</a></li>',''+seatVos[i].s_Seat+'석 <a href="${ctp}/movie/ticketing?movieName='+movieName+'&screenDate='+seatVos[i].s_ScreenDate+'&town='+town+'&screenTime='+seatVos[i].s_ScreenTime+'" class="btn btn-secondary btn-sm">예매하기</a></li>');							
						}
					}
				}
				
					addTimeForm += '</ul>';
					addTimeForm += '</form>';
				
				$("#timeViewDemo").html(addTimeForm); 
			},
			error : function(){
				alert('전송 오류');
			}
		});		 
	}
	
	
	
	
</script>
<style>
#ticketingContainer{
	width: 100%;
	height: 600px;
	overflow: auto;
	background-color: #eea;
}

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

#ticketingModalPtag {
		font-size: 2em;
}

</style>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${ctp}/resources/img/bg-img/교섭.jpg);">
        <div class="bradcumbContent">
            <p>상상 그 이상의 감동 !!</p>
            <h2>예매하기</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Contact Area Start ##### -->
    <section class="contact-area section-padding-0-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading">
                    <c:if test="${!empty vo}">          <!-- 먼저 예매를 하고들어왔을 경우 vo에 영화 정보가 담겨 있을경우 나오는 뷰(바로 그 영화 예매 도와줌)  -->
                       <p> <img alt="${vo.movieName}" src="${ctp}/resources/cgv/cgvMainImg/${movieImg}" style="margin-top: 15px"> </p>
                        <h2>${vo.movieName}</h2>
                        
                        <section class="contact-area section-padding-100-0">
									        <div class="container">
									            <div class="row">
									                <div class="col-12">
									                    <!-- ##### Google Maps ##### -->
									                    <div class="map-area mb-100">
									                    	<table class="table table-hover table-bordered">
									                    		<tr>
									                    			<th>영화 이름</th>
									                    			<th>극장</th>
									                    			<th>선택하신날짜</th>
									                    			<th>선택하신시간</th>
									                    			<th>남은 좌석</th>
									                    		</tr>
									                    		<tr>
									                    			<td>${vo.movieName } </td>
									                    			<td>${vo.town }      </td>
									                    			<td>${vo.screenDate }</td>
									                    			<td>${vo.screenTime }</td>
									                    			<td>${resSeat}       </td>
									                    		</tr>
									                    		<tr>
									                    			<td colspan="5">
									                    				<button type="button" onclick="loginCheck()" class="btn" style="background-color: #f4f4a9;margin-bottom: 3px">예매하기</button>
									                    			</td>
									                    		</tr>
									                    	</table>
									                    </div>
									                </div>
									            </div>
									        </div>
									    </section>
                    </c:if>    
                    <!-- 예매할 영화를 선택하지 않고 그냥 바로 예매하기를 눌러들어올경우 (여기서 부터 영화를 고르게 해줘야함  -->
                    <c:if test="${empty vo}">
           				  <!-- 영화 예매 시작  -->
								    <section class="oneMusic-buy-now-area has-fluid bg-gray section-padding-100">
								        <div class="container-fluid">
								            <div class="row">
								                <div class="col-12">
								                    <div class="section-heading style-2" style="overflow: auto">
								                        <p>보고싶은 영화를 마음대로</p>
								                        <h2>영화 예매</h2>
								                        <hr/>
								                				<div id="ticketingContainer">
								                     		<table class="table table-bordered" style="font-size: 2em;text-align: center;">
								                        	<tr style="background-color: black;color:white;font-size: 1.2em;text-align: center">
									                   				<th style="width: 25%">영화</th>
									                   				<th colspan="2" style="width: 25%">극장</th>
									                   				<th style="width: 10%">날짜</th>
									                   				<th style="width: 40%">시간</th>
									                   			</tr>
								                   			<tr style="color:white;font-size: 1em;text-align: center;height: 500px">
								                   				<td style="width: 25%">
								                   					<table class="table table-hover table-bordered" style="height:500px;text-align: center;">
								     	              				<c:forEach var="movieVO" items="${movieVOS}">
								                   						<tr>
								                   							<td style="color:#333333;"><a href="javascript:regionView('${movieVO.movieName}')" style="display: block">${movieVO.movieName}</a></td>
								                   						</tr>
									    	               			</c:forEach>	
								                   					</table>
								                   				</td>
								                   				<td style="width: 10%">
								                   					<span id="regionViewDemo"></span>
								                   				</td>
								                   				<td style="width: 15%">
								                   					<span id="townViewDemo"></span>
								                   				</td>
								                   				<td style="width: 10%">
								                   					<span id="dateViewDemo"></span>
								                   				</td>
								                   				<td style="width: 40%">
								                   					<span id="timeViewDemo"></span>
								                   				</td>
									                   			</tr>
								                        	</table>
								                        	</div>
								                        	<h3>선택하신 영화</h3>
								                        	<section class="deneb_cta">
																						<div class="container">
																							<div class="cta_wrapper">
																								<div class="row align-items-center">
																									<div class="col-lg-7">
																										<div class="cta_content" style="background-color: #eeb;width: 950px;height: 250px;margin: 0px auto;">
																											<h4><span id="curMovieName"></span><span id="curRegion"></span><span id="curTown"></span><span id="curDate"></span></h4>
																										</div>
																									</div>
																								</div>
																							</div>
																						</div>
																					</section>
								                        </div>
								                    </div>
								                </div>
								            </div>
								   			 </section>
     								  </c:if>    
               	 </div>
              </div>
          </div>
      </div>
 </section>
 
			<div class="modal " id="ticketModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #fffcbd">
				        <h4 class="modal-title">예매하기</h4>
				        <button type="button" class="close" onclick="location.reload()">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #fffcbd" >
						       <div class="container">
						       		<table class="table text-center">
						       			<tr>
						       				<th></th>
						       				<th></th>
						       				<th colspan="5" style="width: 70%;font-weight: bolder;">좌석</th>
						       				<th></th>
						       				<th></th>
						       				<th colspan="2" style="width: 30%;font-weight: bolder;">예매중인 영화</th>
						       				<th></th>
						       			</tr>
						       			<tr>
						       				<td></td>
						       				<td>
						       				</td>
						       				<td colspan="5"><!-- 예매한 자리는 x로 표시 아직 남은 자리는 의자모양으로 표시  -->
						       					<c:forEach var="i" begin="1" end="150">
							       						<span style="width: 15px;font-size: 1.5em"><a href="javascript:seatCheck(${i})" id="seat${i}">👓</a></span> 
						       						<c:if test="${i % 3 == 0}">&nbsp;&nbsp;&nbsp;</c:if>
						       						<c:if test="${i % 9 == 0}"><br/></c:if>
						       					</c:forEach>
						       				</td>
						       				<td></td>
						       				<td></td>
						       				<td colspan="2">
						       					${vo.movieName }<br/>
						       					<img alt="${vo.movieName}" src="${ctp}/resources/cgv/cgvMainImg/${movieImg}" style="margin-top: 15px"><br/>
						       					<a href="javascript:screenTypeCheck('${fn:split(screenType,' ')[0]}')">${fn:split(screenType,' ')[0]}</a>
						       					<a href="javascript:screenTypeCheck('${fn:split(screenType,' ')[1]}')">${fn:split(screenType,' ')[1]}</a>
						       					<a href="javascript:screenTypeCheck('3D')">3D</a>
						       					<a href="javascript:screenTypeCheck('2D')">2D</a>
						       					<p>성인 : <select name="adult" id="adult" onchange="ageLevelCheck(3)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명<br/>
						       						 청소년 : <select name="teen" id="teen" onchange="ageLevelCheck(2)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명 <br/>
						       						 어린이 : <select name="child" id="child" onchange="ageLevelCheck(1)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명<br/>
						       						 우대 : <select name="preferential" id="preferential" onchange="ageLevelCheck(0)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명</p>
						       					<p>금액 : <span id="resultPriceDemo"></span></p>
						       					<button type="button" onclick="ticketingCheck()">예매하기</button>
						       				</td> 
						       				<td></td>
						       			</tr>
						       			<tr>
						       				<td colspan = "5" style="background-color: #d6d6f9">SCREEN</td>
						       			</tr>
						       			<tr>
						       				<td colspan = "5">선택하신 자리 : <span id="selectSeatDemo"></span></td>
						       			</tr>
						       		</table>       	
						       </div>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #fffcbd">
				      </div>
				    </div>
				  </div>
				</div>
				
				<script type="text/javascript">
					'use strict'

					let nos = '';
					let addForm = '';
					let selectCnt = 0;
					let noArr = '';
					function seatCheck(no) {
						let seatA = '';
						let cnt = 0;
						
						
						nos += no+'/';
						
						noArr = nos.split('/');
						
						for(let i = 0; i < noArr.length; i++){
							if(noArr[i] == no) cnt++;
						}						
						
						if(no > 144 && no < 151) seatA = 'A';
						else if(no > 135 && no < 145) seatA = 'B';
						else if(no > 126 && no < 136) seatA = 'C';
						else if(no > 117 && no < 127) seatA = 'D';
						else if(no > 108 && no < 118) seatA = 'E';
						else if(no > 99 && no < 109) seatA = 'F';
						else if(no > 90 && no < 100) seatA = 'G';
						else if(no > 81 && no < 91) seatA = 'H';
						else if(no > 72 && no < 82) seatA = 'I';
						else if(no > 63 && no < 73) seatA = 'J';
						else if(no > 54 && no < 64) seatA = 'K';
						else if(no > 45 && no < 55) seatA = 'L';
						else if(no > 36 && no < 46) seatA = 'M';
						else if(no > 27 && no < 37) seatA = 'N';
						else if(no > 18 && no < 28) seatA = 'O';
						else if(no > 9 && no < 19) seatA = 'P';
						else seatA = 'Q';
						
						if(cnt % 2 == 1){
							
							 addForm += seatA+no+"번 &nbsp;";
							
							$("#selectSeatDemo").html(addForm);
							$("#seat"+no).html('❌');// 눌린 좌석은 이모티콘으로 표시되도록 처리
							selectCnt++;
						}
						else {
							
							addForm = addForm.replace(seatA+no+'번 &nbsp;',' ');
							
							$("#selectSeatDemo").html(addForm);
							$("#seat"+no).html('👓');
							selectCnt--;
						}
					}
					
					let screenType = '';
					
					let totPrice = 0;
					let adultPrice = 0;
					let teenPrice = 0;
					let childPrice = 0;
					let preferentialPrice = 0;
					let selectCnt2 = 0;
					
					let dayOfWeek = '${dayOfWeek}';
					let adultWd = 14000;
					let adultWe = 15000;
					let teenWd = 9000;
					let teenWe = 10000;
					let childWd = 6000;
					let childWe = 7000;
					let preferentialWd = 6000;
					let preferentialWe = 7000;
					
					function screenTypeCheck(type){
						screenType = type;
						if(type == 'IMAX'){
							adultWd = 14000 + 3000;
							adultWe = 15000 + 3000;
							teenWd = 9000 + 3000;
							teenWe = 10000 + 3000;
							childWd = 6000 + 3000;
							childWe = 7000 + 3000;
							preferentialWd = 6000 + 3000;
							preferentialWe = 7000 + 3000;
						}
						else if(type == '4DX'){
							adultWd = 14000 + 2000;
							adultWe = 15000 + 2000;
							teenWd = 9000 + 2000;
							teenWe = 10000 + 2000;
							childWd = 6000 + 2000;
							childWe = 7000 + 2000;
							preferentialWd = 6000 + 2000;
							preferentialWe = 7000 + 2000;
						}
						else if(type == '3D'){
							adultWd = 14000 + 1000;
							adultWe = 15000 + 1000;
							teenWd = 9000 + 1000;
							teenWe = 10000 + 1000;
							childWd = 6000 + 1000;
							childWe = 7000 + 1000;
							preferentialWd = 6000 + 1000;
							preferentialWe = 7000 + 1000;
						}
						else if(type == '2D'){
							adultWd = 14000;
							adultWe = 15000;
							teenWd = 9000;
							teenWe = 10000; 
							childWd = 6000; 
							childWe = 7000; 
							preferentialWd = 6000;
							preferentialWe = 7000;
						}
						
						let aChangePrice = $("#adult").val();
						let tChangePrice = $("#teen").val();
						let cChangePrice = $("#child").val();
						let pChangePrice = $("#preferential").val();
						
						let changeResTotPirce = 0;
						if('${dayOfWeek}' == '7' || '${dayOfWeek}' == '0'){
	 						changeResTotPirce =  pChangePrice * preferentialWe + tChangePrice * teenWe + cChangePrice * childWe + aChangePrice * adultWe;
						}
						else {
	 						changeResTotPirce =  pChangePrice * preferentialWd + tChangePrice * teenWd + cChangePrice * childWd + aChangePrice * adultWd;
						}
						
						
						
						
						$("#resultPriceDemo").html(changeResTotPirce+'원');
						
					}

					function ageLevelCheck(sw){
						
						
						if(sw == 3){// 성인
							
							let adultno = $("#adult").val();
							
							if(dayOfWeek == 1 || dayOfWeek == 7){
								adultPrice = adultWe * adultno;
							}
							else adultPrice = adultWd * adultno; 
							
						}
						else if(sw == 2){ // 청소년
							let teenno = $("#teen").val();
							
							if(dayOfWeek == 1 || dayOfWeek == 7){
								teenPrice = teenWe * teenno;
							}
							else teenPrice = teenWd * teenno;
							
						}
						else if(sw == 1){ // 어린이
							let childno = $("#child").val();
						
							if(dayOfWeek == 1 || dayOfWeek == 7){
								childPrice = childWe * childno;
							}
							else childPrice = childWd * childno;
						}
						else if(sw == 0){ // 우대
							let preferentialno = $("#preferential").val();
						
							if(dayOfWeek == 1 || dayOfWeek == 7){
								preferentialPrice = preferentialWe * preferentialno;
							}
							else preferentialPrice = preferentialWd * preferentialno;
						}
						
						
						totPrice = adultPrice + teenPrice + childPrice + preferentialPrice;
						$("#resultPriceDemo").html(totPrice+"원");
						
					}	
					
					function ticketingCheck(){
						let adultno = $("#adult").val();
						let teenno = $("#teen").val();
						let childno = $("#child").val();
						let preferentialno = $("#preferential").val();
						
						selectCnt2 = Number(adultno) + Number(teenno) + Number(childno) + Number(preferentialno);
						
						if(selectCnt != selectCnt2) alert('선택하신자리와 인원수가 틀립니다.');
						else {
							Swal.fire({
			                    title: '영화 '+'${vo.movieName}'+'의 예매를 진행하시겠습니까?',
			                    text: addForm.replaceAll('&nbsp;','')+" 자리\n 성인: "+adultno+"명 청소년: "+teenno+"명 어린이: "+childno+"명 우대: "+preferentialno+"명 총 금액: "+totPrice+"원 입니다.",
			                    icon: 'info',
			                    showCancelButton: true,
			                    confirmButtonColor: '#3085d6',
			                    cancelButtonColor: '#d33',
			                    confirmButtonText: '예매진행',
			                    cancelButtonText: '취소'
			                }).then((result) => {
			                    if (result.isConfirmed) {
			                    	if(screenType == '') screenType = '2D';
														location.href='${ctp}/movie/ticketingPayment?tk_movieName=${vo.movieName}&tk_town=${vo.town}&tk_screenDate=${vo.screenDate}&tk_screenTime=${vo.screenTime}&tk_seat='+addForm.replaceAll('&nbsp;','')+'&tk_adultno='+adultno+'&tk_teenno='+teenno+'&tk_childno='+childno+'&tk_preferentialno='+preferentialno+'&tk_totPrice='+totPrice+"&tk_movieImg=${movieImg}&seatArr="+noArr+"&tk_screenType="+screenType;	
			                   }
			                });
										};
									}
					
					function loginCheck(){
						if('${sId}' == ''){
							Swal.fire({
			                    title: '로그인하신 후에 예매를 진행하실수있습니다.',
			                    text: "로그인 하시겠습니까?",
			                    icon: 'info',
			                    showCancelButton: true,
			                    confirmButtonColor: '#3085d6',
			                    cancelButtonColor: '#d33',
			                    confirmButtonText: '로그인',
			                    cancelButtonText: '취소'
			                }).then((result) => {
			                    if (result.isConfirmed) {
			                    		  $('#LoginModal').show();
			                    }
			                });
    					}
    					else {
    						<c:forEach var="i" begin="0" end="${fn:length(resArr)}">						
    							$("#seat${resArr[i]}").html('<a href="javascript:alertfn();">❌</a>');
    						</c:forEach>
    						$('#ticketModal').show();
    					}
					}
				
					function alertfn(){
						alert("이미 예약된 좌석입니다.");
					}
				</script>
				
				<div class="modal " id="ticketingModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #fffcbd">
				        <h4 class="modal-title">예매하기</h4>
				        <button type="button" class="close" onclick="$('#ticketingModal').hide();">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #fffcbd" >
						       <div class="container">
						       		<table class="table text-center">
						       			<tr>
						       				<th></th>
						       				<th></th>
						       				<th colspan="5" style="width: 70%;font-weight: bolder;">좌석</th>
						       				<th></th>
						       				<th></th>
						       				<th colspan="2" style="width: 30%;font-weight: bolder;">예매중인 영화</th>
						       				<th></th>
						       			</tr>
						       			<tr>
						       				<td></td>
						       				<td>
						       				</td>
						       				<td colspan="5"><!-- 예매한 자리는 x로 표시 아직 남은 자리는 의자모양으로 표시  -->
						       					<c:forEach var="i" begin="1" end="150">
							       						<span style="width: 15px;font-size: 1.5em">👓</span> 
						       						<c:if test="${i % 3 == 0}">&nbsp;&nbsp;&nbsp;</c:if>
						       						<c:if test="${i % 9 == 0}"><br/></c:if>
						       					</c:forEach>
						       				</td>
						       				<td></td>
						       				<td></td>
						       				<td colspan="2">
						       					${vo.movieName }<br/>
						       					<img alt="${vo.movieName}" src="${ctp}/resources/cgv/cgvMainImg/${movieImg}" style="margin-top: 15px"><br/>
						       					${fn:split(screenType,' ')[0]}
						       					${fn:split(screenType,' ')[1]}
						       					<p>성인 : <select name="adult" id="adult" onchange="ageLevelCheck(3)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명<br/>
						       						 청소년 : <select name="teen" id="teen" onchange="ageLevelCheck(2)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명 <br/>
						       						 어린이 : <select name="child" id="child" onchange="ageLevelCheck(1)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명<br/>
						       						 우대 : <select name="preferential" id="preferential" onchange="ageLevelCheck(0)"><option selected>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option></select>명</p>
						       					<p>금액 : <span id="resultPriceDemo"></span></p>
						       					<button type="button" onclick="ticketingCheck()">예매하기</button>
						       				</td> 
						       				<td></td>
						       			</tr>
						       			<tr>
						       				<td colspan = "5" style="background-color: #d6d6f9">SCREEN</td>
						       			</tr>
						       			<tr>
						       				<td colspan = "5">선택하신 자리 : <span id="selectSeatDemo"></span></td>
						       			</tr>
						       		</table>       	
						       </div>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #fffcbd">
				      </div>
				    </div>
				  </div>
				</div>
				
				
				
				
					<!-- 로그인 모달 -->
				<div class="modal " id="LoginModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #eaa">
				        <h4 class="modal-title">로그인</h4>
				        <button type="button" class="close" data-dismiss="modal" onclick="$('#LoginModal').hide();">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #eaa" >
									<section class="login-area section-padding-100">
						        <div class="container">
						            <div class="row justify-content-center">
						                <div class="col-12 col-lg-8">
						                    <div class="login-content">
						                        <h3>Welcome Back</h3>
						                        <!-- Login Form -->
						                        <div class="login-form">
						                            <form name="loginForm" method="post" action="${ctp}/login">
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
						                                <input type="hidden" name="sw" value="3"/>
						                            </form>
						                        </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </section>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer">
				      </div>
				    </div>
				  </div>
				</div>
			

	<!-- 아이디 찾기 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">아이디 찾기</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal body -->
		      <div class="modal-body">
		      	 <div class="login-form">
                <form name="idCheckForm">
                    <div class="form-group">
                        <label for="exampleInputEmail1">성명</label>
                        <input type="text" class="form-control" id="name" name="name" aria-describedby="emailHelp" placeholder="Enter ID">
                        <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정확히 입력해주세요.</small>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">닉네임</label>
                        <input type="text" class="form-control" id="IdNickName" name="nickName" aria-describedby="emailHelp" placeholder="Enter ID">
                        <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정확히 입력해주세요.</small>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">생년월일 | 성별</label>
                        <input type="password" class="form-control" id="scnumber1" name="scnumber1" maxlength="8" placeholder="생년월일 앞 8자리">
                        <input type="password" class="form-control" id="scnumber2" name="scnumber2" maxlength="1" placeholder="주민등록번호 뒤 1자리">
                        <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정확히 입력해주세요.</small>
                    </div>
                    <span id="idSearchDemo"></span>
                    <button type="button" onclick="idSearch()" class="btn oneMusic-btn mt-30">아이디 찾기</button>
                </form>
            </div>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
		      </div>
		
		    </div>
		  </div>
		</div>
    
    <!-- 비밀번호 찾기 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal2">
		  <div class="modal-dialog">
		    <div class="modal-content">
		 
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">비밀번호 찾기</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	 <div class="login-form">
               <form name="pswdCheckForm">
                   <div class="form-group">
                       <label for="exampleInputEmail1">아이디</label>
                       <input type="text" class="form-control" id="authId" name="id" aria-describedby="emailHelp" placeholder="아이디를 입력해주세요.">
                       <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 8자리 최대 16자리입니다.</small>
                   </div>
                   <div class="form-group">
                       <label for="exampleInputPassword1">닉네임</label>
                       <input type="text" class="form-control" id="pswdNickName" name="nickName" placeholder="닉네임을 입력해주세요.">
                       <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 10자리 최대 20자리입니다.</small>
                   </div>
                   <div class="form-group">
                       <label for="email">이메일</label>
                       <button type="button" id="authEmailbtn" data-toggle="modal" data-target="#myModalE">이메일 인증</button>
                       <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요. ex)ID1234@naver.com">
                       <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>정상적인 이메일 형식에 맞춰주세요.</small>
                   </div>
                   <span id="pswdSearchDemo"></span>
                   <button type="button" onclick="pswdSearch()" class="btn oneMusic-btn mt-30">비밀번호찾기</button>
               </form>
           	</div>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		      </div>
		
		    </div>
		  </div>
		</div>
		
		
		<!-- 이메일 인증 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModalE">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">비밀번호 찾기 이메일 인증</h4>
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
<jsp:include page="/WEB-INF/views/include/chatting.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
    </body>
</html>