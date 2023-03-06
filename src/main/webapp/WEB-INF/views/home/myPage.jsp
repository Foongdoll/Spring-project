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
    <title>마이페이지</title>

    <!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Stylesheet -->
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
<script type="text/javascript">
	'use strict'
	
	$(function(){
		
		let vLevel = '';
		
		let vPoint  = '${vo.mem_point}';
		
		
		if(Number(vPoint) > 5000){
			vLevel = '<font color="green">그린</font>';
		}
		else if(Number(vPoint) > 50000){
			vLevel = '<font color="red">레드</font>';
		} 
		else if(Number(vPoint) > 100000){
			vLevel = '<font color="purple">퍼플</font>';
		} 
		else if(Number(vPoint) > 1000000){
			vLevel = '<font color="black">블랙</font>';
		}
		else {
			vLevel = '<font color="#FFC999">베이지</font>';
		}
		
		
		$("#vipLevelDemo").html(vLevel+'등급');
		
	})
	
</script>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
		
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${ctp}/resources/img/bg-img/상견니.jpg);">
        <div class="bradcumbContent">
            <h2>마이 페이지</h2>
        </div>
    </section>

<c:if test="${!empty jsonData}">
<script type="text/javascript">
	'use strict'
	
	$(function(){
		let data = '${jsonData}';
		
		let json = JSON.parse(data);		
		let movieTitle = json.tk_movieName;
		
	$.ajax({
			type : 'post',
			url  : '${ctp}/admin/ticketImg',
			data : {movieTitle:movieTitle},
			success : function (img){
				$("#imgSample").attr("src",img);
			},
			error : function () {
				Swal.fire({
					title : '전송 오류',
					icon  : 'error'
				});				
			}
		});  
		
		let seatA = '';
		let seatArr = json.tk_seat.split('/');
		let no = 0;
		let resno = '';
		for(let i = 0; i < seatArr.length-1; i++){
			no = seatArr[i];
			
			if (no > 144 && no < 151) seatA = 'A';
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
	
			resno += seatA + no + '번' 			
		}
	
			
		$("#movieTitleDemo").html('<h3 style="text-align:center">'+json.tk_movieName+'</h3>');
		$("#tk_cd").html(json.tk_cd);
		$("#tk_Id").html(json.tk_Id);
		$("#tk_town").html(json.tk_town);
		for(let i = 0; i < resno.split('번').length; i++){
			$("#tk_seat").append(resno.split('번')[i]+" ");
		}
		$("#tk_no").html('성인:'+json.tk_adultno+"명 "+'청소년:'+json.tk_teenno+"명 "+'어린이:'+json.tk_childno+"명 "+'우대:'+json.tk_preferentialno+'명');
		$("#tk_screen").html(json.tk_screen);
		$("#tk_screenDate").html(json.tk_screenDate);
		$("#tk_screenTime").html(json.tk_screenTime);
		$("#tk_totPrice").html(json.tk_totPrice+'원');
		
	});
	
	
</script>
	<div class="blog-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-9">
                    <!-- Single Post Start -->
                    <div class="single-blog-post mb-100 wow fadeInUp" data-wow-delay="100ms">
                        <!-- Post Thumb -->
                        <div class="blog-post-thumb mt-30">
                            <a href="#"><img src="" alt="" id="imgSample"></a>
                            <!-- Post Date -->
                            <div class="post-date">
                                <span>${dd}</span>
                                <span>${yy}/${MM}</span>
                            </div>
                        </div>

                        <!-- Blog Content -->
                        <div class="blog-content">
                        	<h3><span id="movieTitleDemo"></span></h3>
                        </div>
                    </div>
                    <div class="single-blog-post mb-100 wow fadeInUp" data-wow-delay="100ms">
                    	<div class="blog-content">
                    		<div class="container">
                    			<table class="table">
                    				<tr>
                    					<th>티켓고유번호</th>
                    					<td><span id="tk_cd"></span></td>
                    				</tr>
                    				<tr>
                    					<th>티켓구매자아이디</th>
                    					<td><span id="tk_Id"></span></td>
                    				</tr>
                    				<tr>
                    					<th>영화관</th>
                    					<td><span id="tk_town"></span></td>
                    				<tr>
                    					<th>날짜/시간</th>
                    					<td>
                    					  <span id="tk_screenDate"></span>
                                <span id="tk_screenTime"></span>
                    					</td>
                    				</tr>
                    				<tr>
                    					<th>자리</th>
                    					<td><span id="tk_seat"></span></td>
                    				</tr>
                    				<tr>
                    					<th>인원</th>
                    					<td><span id="tk_no"></span></td>
                    				</tr>
                    				<tr>
                    					<th>총 가격</th>
                    					<td><span id="tk_totPrice"></span></td>
                    				</tr>
                    			</table>
                    			<div><span id="tk_screen"></span></div>
                    		</div>
                    	</div>
										</div>

                    <!-- Pagination -->
                    <div class="oneMusic-pagination-area wow fadeInUp" data-wow-delay="300ms">
                    </div>
                </div>
             </div>
           </div>
         </div>
			</c:if>
<c:if test="${empty jsonData}">

    <div class="blog-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-9">

                    <!-- Single Post Start -->
                    <div class="single-blog-post mb-100 wow fadeInUp" data-wow-delay="100ms">
                        <!-- Post Thumb -->
                        <div class="blog-post-thumb mt-30">
                            <a href="#"><img src="" alt=""></a>
                            <!-- Post Date -->
                            <div class="post-date">
                                <span>${dd}</span>
                                <span>${yy}/${MM}</span>
                            </div>
                        </div>

                        <!-- Blog Content -->
                        <div class="blog-content">
                            <!-- Post Title -->
                            <a href="#" class="post-title">회원 정보</a>
                            <!-- Post Meta -->
                            <div class="post-meta d-flex mb-30">
                                <p class="post-author">주기적으로 비밀번호를 변경해주시는 습관은 해커들의 두뇌를 흔들어놓을수있는 엄청난 기술입니다 !!</p>
                            </div>
                            	<table class="table table-hover">
                            		<tr>
                            			<td colspan="4" >
                            			<c:if test="${empty vo.mem_sPhoto}">
                            				억.. 사진등록을 안하셨군요 ! 회원정보수정에서 추가해보세요 !! 😎 
                            			</c:if>
                            			<c:if test="${!empty vo.mem_sPhoto}">
                            			<c:if test="${empty googleSw && empty naverSw}">
                            				<img <c:if test="${!empty vo.mem_sPhoto}">src="${ctp}/images/memberprofile/${vo.mem_sPhoto}"</c:if> style="width: 100%;height: 500px"/>
                            			</c:if>
                            			<c:if test="${!empty googleSw || !empty naverSw}">
                            				<img alt="" src="${vo.mem_sPhoto }">
                            			</c:if>
                            			</c:if> 
                            			
                            			</td>
                            		</tr>
                            		<tr>
                            			<th colspan="2">성함</th>
                            			<th>${vo.mem_name}</th>
                            			<td colspan="2">닉네임</td>
                            			<td>${vo.mem_nickName }</td>
                            		</tr>
                            		<tr>
                            			<th colspan="2">가입일</th>
                            			<th>${fn:substring(vo.mem_startDate,0,10)}</th>
                            			<th colspan="2">멤버십포인트</th>
                            			<th>${vo.mem_point }</th>
                            		</tr>
                            		<tr>
                            			<th colspan="2">
                            				<button type="button" onclick="newCoupon()">오늘의 쿠폰 발급</button>
                            			</th>
                            			<th></th>
                            			<th colspan="2">VIP지수</th>
                            			<th><span id="vipLevelDemo"></span></th>
                            		</tr>
                            	</table>
                        </div>
                    </div>
                    <script type="text/javascript">
                    	'use strict'
                    	
                    	function newCoupon(){
                    		
                    		Swal.fire({
                    			title : '두구두구두구 ~~~',
                    			text  : '오늘의 쿠폰을 발급합니다 !!',
													icon  : 'info',
      		 	   	          showCancelButton: true,
      	   	              confirmButtonColor: '#3085d6',
      	   	              cancelButtonColor: '#d33',
      	   	              confirmButtonText: '쿠폰발급 !!?',
      	   	              cancelButtonText: '아직아닌거같으면..이쪽을..'
      		   	          }).then((result) => {
      		   	              if (result.isConfirmed) {
      		   	            	  $.ajax({
      		   	            		  type : 'post',
      		   	            		  url  : '${ctp}/myPage/myTodayCoupon',
																success : function(res){
																	if(res != '100'){
																		Swal.fire({
																			title : res+'%할인 쿠폰 발급 성공~',
																			text  : '자세한 내용은 쿠폰 관리에서 확인해주세요 !!',
																			icon  : 'success'
																		});
																		location.reload();
																	}
																	else if(res == '100'){
																		Swal.fire({
																			title : '오늘은 이미 발급받으셨어요 !',
																			text  : '쿠폰 발급 실패..',
																			icon  : 'error'
																		});
																	}
																	
																},
																error : function(){
																	Swal.fire({
																		title :'전송 오류',
																		icon  :'error'
																	});																	
																}
      		   	            	  });
      		   	              }
      		       			  });
                    		
                    	}
                    </script>
                    
                    <div class="single-blog-post mb-100 wow fadeInUp" data-wow-delay="100ms">
                    	<div class="blog-content">
                    		<div class="container">
                    			<table class="table table-bordered text-center ">
                    				<tr>
                    					<td colspan="3" style="height: 600px">
                    					<c:if test="${sw == 0}"> <!-- 예매한영화  -->
    	                				<jsp:include page="/WEB-INF/views/home/myPage/myTicketingMovie.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 1}"> <!-- 위시리스트  -->
    	                					<jsp:include page="/WEB-INF/views/home/myPage/wishList.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 2}"> <!-- 내가본영화 -->
  	                  					<jsp:include page="/WEB-INF/views/home/myPage/myViewMovieList.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 3}"> <!-- 예매한 영화 qr코드 조회  -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/movieQRcode.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 4}"> <!-- 쿠폰 관리  -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/movieCoupon.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 5}"> <!-- VIP 맴버쉽 관련 안내 나의 VIP 정보  -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/movieQRcode.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 6}"> <!-- 아이디 변경 -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/movieQRcode.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 7}"> <!-- 비밀번호 변경  -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/pswdChange.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 8}"> <!-- 회원정보수정 -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/myInforUpdate.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 9}"> <!-- 신고리스트 -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/myReportList.jsp"></jsp:include>
                    					</c:if>
                    					<c:if test="${sw == 10}"> <!-- 회원탈퇴 -->
	                    					<jsp:include page="/WEB-INF/views/home/myPage/myMemberDel.jsp"></jsp:include>
                    					</c:if>
                    					</td>
                    				</tr>
                    			</table>
                    		</div>
                    	</div>
										</div>

                    <!-- Pagination -->
                    <div class="oneMusic-pagination-area wow fadeInUp" data-wow-delay="300ms">
                    </div>
                </div>

                <div class="col-12 col-lg-3">
                    <div class="blog-sidebar-area">

                        <!-- Widget Area -->
                        <div class="single-widget-area mb-30">
                            <div class="widget-title">
                                <h5><a href="">MY GGV(오늘뭐볼까?) HOME</a></h5>
                            </div>
                            <div class="widget-content">
                               <ul>
                                 <li><a href="myPageHome?sw=0">나의 예매/취소내역</a></li>
                                 <li><a href="myPageHome?sw=1">위시리스트</a></li>
															   <li><a href="myPageHome?sw=2">내가본영화</a></li>
															   <li><a href="javascript:alert('준비중인서비스입니다.');">예매한영화QR조회</a></li>
															   <li><a href="#" data-toggle="modal" data-target="#myReviewModal" >내가 쓴 리뷰 모아보기</a></li>
                                 <li><a href="myPageHome?sw=4">쿠폰 관리</a></li>
                               </ul>
                            </div>
                        </div>

                        <!-- Widget Area -->
                        <div class="single-widget-area mb-30">
                            <div class="widget-title">
                                <h5>회원 정보관리</h5>
                            </div>
                            <div class="widget-content">
                                <ul>
                                    <li><a href="javascript:alert('준비중인 서비스입니다.');">로그인 2차인증설정</a></li>
                                    <li><a href="myPageHome?sw=7">비밀번호 변경</a></li>
                                    <li><a href="myPageHome?sw=8">상세정보 변경</a></li>
                                    <li><a href="myPageHome?sw=9">나의신고내역</a></li>
                                    <li><a href="myPageHome?sw=10">탈퇴</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
		<!-- 내가 쓴 리뷰 모아보기 모달뷰 시작  -->
		
   	<div class="modal " id="myReviewModal" >
				  <div class="modal-dialog modal-xl ">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #b2d9ff">
				        <h4 class="modal-title">나의리뷰</h4>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #b2d9ff" >
								<section class="login-area section-padding-100">
						       <div class="container">
						       		<c:set var="i" value="1"></c:set>
                        <c:if test="${empty rvos}"><h3>이런.. 아직 리뷰가 한개도없네요🤨</h3></c:if>
                        <c:forEach var="rVo" items="${rvos}">
                         <div id="accordion" class="accordion-style">
                             <div class="card mb-3">
                                 <div class="card-header" id="heading${i}">
                                     <h5 class="mb-0">
                                       <button class="btn btn-link" data-bs-toggle="collapse" data-bs-target="#collapse${i}" aria-expanded="true" aria-controls="collapse${i}">
                                       <span class="text-theme-secondary me-2">${rVo.re_Id}😊 
                                       </span>
                                       	${rVo.re_Title} <span> 영화 : ${rVo.re_MovieTitle}</span>
                                       </button>
                                   </h5>
                               </div>
                               <div id="collapse${i}" class="collapse show" aria-labelledby="heading${i}" data-bs-parent="#accordion">
                                   <div class="card-body">
                                   	<p style="color: #666">${rVo.re_Content}</p>
                            					<p style="font-weight: bolder;color: #666">${rVo.re_ScreenType }  ${fn:substring(rVo.re_Date,0,10)} | 좋아요<a href="javascript:GoodCheck()">❤️</a> ${rVo.re_Good} | 
																				<c:if test="${rVo.re_Rating == 1}"><span style="color: #f90;">&#9733;</span></c:if>
																				<c:if test="${rVo.re_Rating == 2}"><span style="color: #f90;">&#9733;&#9733;</span></c:if>
																				<c:if test="${rVo.re_Rating == 3}"><span style="color: #f90;">&#9733;&#9733;&#9733;</span></c:if>
																				<c:if test="${rVo.re_Rating == 4}"><span style="color: #f90;">&#9733;&#9733;&#9733;&#9733;</span></c:if>
																				<c:if test="${rVo.re_Rating == 5}"><span style="color: #f90;">&#9733;&#9733;&#9733;&#9733;&#9733;</span></c:if>
																			</p>
                                     </div>
                                 </div>
                             </div>
                         </div>
                        <c:set var="i" value="${i + 1}"></c:set>
                        </c:forEach>
						       </div>
						    </section>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #b2d9ff">
				      </div>
				    </div>
				  </div>
				</div>
		<!-- 내가 쓴 리뷰 모아보기 모달뷰 끝  -->
   
</c:if>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>

</html>