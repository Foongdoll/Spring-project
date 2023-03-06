<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   	
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title></title>
    <script src="${ctp}/resources/js/ckeditor/ckeditor.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css" integrity="sha256-2XFplPlrFClt0bIdPgpz8H7ojnk10H69xRqd9+uTShA=" crossorigin="anonymous" />
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<script>
	'use strict'
	
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
.single-album {margin:0 auto; text-align:center; width:300px;}
.title {line-height:1; position:absolute; left:50%; transform:translateX(-50%); top:200px; height:120px; transition:0.5s all}
.title h3 {font-size:30px;  margin:0}
.title p {font-size:14px; margin-top:15px;}
.more {display:block; font-size:18x; color:#fff; line-height:40px; width:120px; margin-top:30px; opacity:0; transition:0.5s all}

.single-album:hover .more {opacity:1}
.single-album:hover .title {top:150px}

#ticketingContainer{
	width: 100%;
	height: 600px;
	overflow: auto;
	background-color: #eea;
}

#live-chat {
  position: fixed;
  bottom: 20px;
  right: 20px;

  border: none;
  border-radius: 16px;
  background: royalblue;
  color: white;
  padding: 12px;
  font-weight: bold;
  box-shadow: 0px 5px 15px gray;
  cursor: pointer;
  z-index: 10000000000;
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
			
			.ballon {
    display: none;
    position: absolute;
    width: 205px;
    height: 40px;
    left: 448px;
    bottom: 62px;
    background: #484848;
    color: white;
    border-radius: 5px;
    padding: 12px 12.8px;
}


.ballon:after {
    border-top: 10px solid #484848;
    border-left: 10px solid transparent;
    border-right: 10px solid transparent;
    border-bottom: 0px solid transparent;
    content: "";
    position: absolute;
    top: 40px;
    left: 160px;
}
</style>
<body>
    <!-- 헤더 네비메뉴 시작 -->
    <jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
    <!-- 영화 트레일러 시작 -->
    <section class="hero-area">
        <div class="hero-slides owl-carousel">
        
        
						<c:forEach var="hvo" items="${headvos}" varStatus="st">        
            <div class="single-hero-slide d-flex align-items-center justify-content-center">
                <!-- Slide Img -->
                <c:if test="${hvo.srcsw == 1 }">
                <div class="slide-img bg-img" style="background-image: url(${hvo.img});"></div>
                </c:if>
                <c:if test="${hvo.srcsw != 1 }">
                <div class="slide-img bg-img" style="background-image: url(resources/img/bg-img/${hvo.img});"></div>
                </c:if>
                <!-- Slide Content -->
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="hero-slides-content text-center">
                                <h6 data-animation="fadeInUp" data-delay="100ms" style="font-size: 2em; margin-top: 150px">${hvo.content}</h6>
                                <h2 data-animation="fadeInUp" data-delay="300ms">${hvo.movieTitle}<span>${hvo.movieTitle}</span></h2>
                                <a data-animation="fadeInUp" data-delay="500ms" href="${ctp}/movie/ticketing?movieName=${hvo.movieTitle}&strsw=home" class="btn oneMusic-btn mt-50">보러가기<i class="fa fa-angle-double-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </section>
    <!-- 영화 트레일러 끝 -->

    <!-- 영화 순위 시작 -->
    <section class="latest-albums-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading style-2">
                        <h2>영화 목록</h2>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                    <div class="ablums-text text-center mb-70">
                       <p style="font-size: 2em"><a href="#">상영중인 영화</a></p>
                </div>
            </div>
			</div>
            <div class="row">
                <div class="col-12">
                    <div class="albums-slideshow owl-carousel">
                       <!-- Single Album -->
                       <c:forEach var="img" items="${imgs}">
                       <div class="single-album">
                           <img class="imgPoster" src="${ctp}/resources/cgv/cgvMainImg/${img.img}" alt="">
                            <div class="title">
													    <a href="${ctp}/movie/movieDetail?movieTitle=${img.movieName}"" class="more" style="color: black; background: white;">상세보기</a>
													    <a href="${ctp}/movie/ticketing?movieName=${img.movieName}&strsw=home" class="more" style="color: white; background: red">예매하기</a>
												  </div>
                           <div class="album-info">
                               <a href="#">
                                  <h5>${img.movieName}</h5>
                               </a>
                           </div>
                       </div>
											</c:forEach>
                	</div>
           	 </div>
        </div>
    </section>
<!-- 영화 순위 끝  -->

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
																		<div class="cta_content" style="background-color: #eeb;width: 1100px;height: 250px">
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
				
				<!-- 로그인 모달  -->
				<div class="modal " id="myModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #eaa">
				        <h4 class="modal-title">로그인</h4>
				        <button type="button" class="close" data-dismiss="modal" onclick="$('myModal').hide();">&times;</button>
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
						                            </form>
						                        </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </section>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #eaa">
				      </div>
				    </div>
				  </div>
				</div>
 <script type="text/javascript" src="${ctp}/resources/js/movie/memberlogin.js"></script>
 <jsp:include page="/WEB-INF/views/include/chatting.jsp"></jsp:include>
 <jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>