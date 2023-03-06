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
    <title>예매하기</title>

    <!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">
    
		<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<script>
	'use strict'
	
	window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-F1RTS0P1CD');
  
  
	function fCheck(){
		const regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{6,16}$/g;
		const regPswd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,}$/;
		
		let id = $("#id").val();
		let pswd = $("#pswd").val();
		
		if(id.trim() == 'admin' &&  pswd.trim() == '1234') {
			loginForm.submit();
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
			loginForm.submit();
		}
	}
	
	
	
</script>
<style>
		.screentype .forDX {
		    background-position: 0 -112px;
		}

	.screentype span, .screentype a {
    display: inline-block;
    width: 80px;
    height: 56px;
    background: url(https://img.cgv.co.kr/R2014/images/sprite/sprite_screentype_v3.png) no-repeat;
    font: 0/0 a;
    zoom: 1;
    }
    
    body{margin-top:20px;}
.accordion-style .card {
    background: transparent;
    box-shadow: none;
    margin-bottom: 15px;
    margin-top: 0 !important;
    border: none;
}
.accordion-style .card:last-child {
    margin-bottom: 0;
}
.accordion-style .card-header {
    border: 0;
    background: none;
    padding: 0;
    border-bottom: none;
}
.accordion-style .btn-link {
    color: #ffffff;
    position: relative;
    background: #15395a;
    border: 1px solid #15395a;
    display: block;
    width: 100%;
    font-size: 18px;
    border-radius: 3px;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    text-align: left;
    white-space: normal;
    box-shadow: none;
    padding: 15px 55px;
    text-decoration: none;
}
.accordion-style .btn-link:hover {
    text-decoration: none;
}
.accordion-style .btn-link.collapsed {
    background: #ffffff;
    border: 1px solid #15395a;
    color: #1e2022;
    border-radius: 3px;
}
.accordion-style .btn-link.collapsed:after {
    background: none;
    border-radius: 3px;
    content: "+";
    left: 16px;
    right: inherit;
    font-size: 20px;
    font-weight: 600;
    line-height: 26px;
    height: 26px;
    transform: none;
    width: 26px;
    top: 15px;
    text-align: center;
    background-color: #15395a;
    color: #fff;
}
.accordion-style .btn-link:after {
    background: #fff;
    border: none;
    border-radius: 3px;
    content: "-";
    left: 16px;
    right: inherit;
    font-size: 20px;
    font-weight: 600;
    height: 26px;
    line-height: 26px;
    transform: none;
    width: 26px;
    top: 15px;
    position: absolute;
    color: #15395a;
    text-align: center;
}
.accordion-style .card-body {
    padding: 20px;
    border-top: none;
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
    border-left: 1px solid #15395a;
    border-right: 1px solid #15395a;
    border-bottom: 1px solid #15395a;
}
@media screen and (max-width: 767px) {
    .accordion-style .btn-link {
        padding: 15px 40px 15px 55px;
    }
}
@media screen and (max-width: 575px) {
    .accordion-style .btn-link {
        padding: 15px 20px 15px 55px;
    }
}
.card-style1 {
    box-shadow: 0px 0px 10px 0px rgb(89 75 128 / 9%);
}
.border-0 {
    border: 0!important;
}
.card {
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid rgba(0,0,0,.125);
    border-radius: 0.25rem;
}

section {
    padding: 120px 0;
    overflow: hidden;
    background: #fff;
}
.mb-2-3, .my-2-3 {
    margin-bottom: 2.3rem;
}

.section-title {
    font-weight: 600;
    letter-spacing: 2px;
    text-transform: uppercase;
    margin-bottom: 10px;
    position: relative;
    display: inline-block;
}
.text-primary {
    color: #ceaa4d !important;
}

#movieDetailNav{
	color: #eee;
}
    
#movieDetailNav a {
	font-size: 1.3em;
	color: #eee;
	text-align: center;
	font-weight: bolder;
	margin: 0px auto;
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


.star-rating {
  display:flex;
  flex-direction: row-reverse;
  font-size:1.5em;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating input {
  display:none;
}

.star-rating label {
  color:#ccc;
  cursor:pointer;
}

.star-rating :checked ~ label {
  color:#f90;
}

.star-rating label:hover,
.star-rating label:hover ~ label {
  color:#fc0;
}

.star-res{
	color:#f90;
}

/* explanation */

article {
  background-color:#ffe;
  box-shadow:0 0 1em 1px rgba(0,0,0,.25);
  color:#006;
  font-family:cursive;
  font-style:italic;
  margin:4em;
  max-width:30em;
  padding:2em;
}

</style>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${vo.img});">
        <div class="bradcumbContent">
            <h2>영화 상세보기</h2>
            <p>궁금한 영화의 자세한 부분까지 한번에 !</p>
        </div>
    </section>

    
<!-- 영화 상세 정보 뷰  -->
    <section class="contact-area section-padding-0-100" style="margin-top: 100px">
        <div class="container">
        	<table class="table table-borderless" style="font-weight: 10px">
        		<tr>
        			<th rowspan="2" colspan="2" style="width: 30%">
        				<div class="box-image">
	       					<a href="${vo.img}" title="포스터 크게 보기 새창" target="_blank">
	       			    <span class="thumb-image"> 
                	<img src="${vo.img}" width="300px" alt="${vo.movieTitleKo} 새창 " onerror="errorImage(this)">
            			</span> 
        					</a> 
                	위시리스트추가<a href="javascript:wishListAdd('${vo.movieTitleKo}','${vo.img}')" style="color:red">❤</a>
  			  				</div>
  			  		</th>
        		</tr>
        		<tr>
        			<th></th>
        			<th>
        				<h2>${vo.movieTitleKo}</h2>
         	 		  <p>${vo.movieTitleEn }</p>
        				${vo.movieRate} / <c:if test="${!empty starAvg}">${starAvg} 
        				<c:if test="${fn:split(starAvg,'.')[0] == 5}"><span style="color: #f90;font-size: 2em">&#9733;&#9733;&#9733;&#9733;&#9733;</span></c:if>
        				<c:if test="${fn:split(starAvg,'.')[0] == 4}"><span style="color: #f90;font-size: 2em">&#9733;&#9733;&#9733;&#9733;</span></c:if>
        				<c:if test="${fn:split(starAvg,'.')[0] == 3}"><span style="color: #f90;font-size: 2em">&#9733;&#9733;&#9733;</span></c:if>
        				<c:if test="${fn:split(starAvg,'.')[0] == 2}"><span style="color: #f90;font-size: 2em">&#9733;&#9733;</span></c:if>
        				<c:if test="${fn:split(starAvg,'.')[0] == 1}"><span style="color: #f90;font-size: 2em">&#9733;</span></c:if>
        				</c:if>
        				<c:if test="${empty starAvg}"> 0 <span style="color: #ddd;font-size: 2em">&#9733;&#9733;&#9733;&#9733;&#9733;</span></c:if>
        				<hr/>
        				<p>${vo.movieDirector} / ${vo.movieActor }</p>
        				<p>${vo.movieGenre }</p>
        				<p>${vo.movieOpenDate } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        				<span class="screentype">
        				<c:if test="${fn:contains(vo.screenType,'IMAX') }">
		                <a href="#" class="imax" title="IMAX 상세정보 바로가기" data-regioncode="07">IMAX</a>
	        			</c:if>	
        				<c:if test="${fn:contains(vo.screenType,'4DX') }">
		                <a href="#" class="forDX" title="4DX 상세정보 바로가기" data-regioncode="4D14">4DX</a>
	        			</c:if>	
	        				</span>
        				</p>
        			</th>
        		</tr>
        	</table>
        	<p>${vo.movieStory }</p>
        	<div style="width: 50%; height: 30px;background-color: #e33;margin: 0px auto;">
        		<div id="movieDetailNav"><a href="" style="margin-left: 60px">주요정보</a> | <a href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&sw=1">트레일러</a> | <a href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&sw=2">스틸컷</a> | <a href="">평점/리뷰</a> | <a href="">상영시간표</a></div>
        	</div>
        </div>
    </section>
<!-- 영화 상세 정보 뷰 끝 -->
<script>
	'use strict'
	
	function wishListAdd(movieTitle,img){
		$.ajax({
			type : "GET",
			url  : "${ctp}/movie/wishListAdd?movieTitle="+movieTitle+"&img="+img,
			success : function (sw){
				
				if(sw == 0){
				 Swal.fire({
		              icon: 'success',
		              title: '위시리스트에 추가되었습니다',
		              text: '마이페이지에서 확인해주세요 !!',
		          });
				}
				else if(sw == 1) {
				 Swal.fire({
		              icon: 'success',
		              title: '위시리스트에서 제거되었습니다.',
		              text: '언제든 마음대로 추가해주세요 !!',
		          });
				}
				else if(sw == 3){
					Swal.fire({
	                    title: '로그인하신 후에 위시리스트를 추가하실수있습니다.',
	                    text: "로그인 하시겠습니까?",
	                    icon: 'info',
	                    showCancelButton: true,
	                    confirmButtonColor: '#3085d6',
	                    cancelButtonColor: '#d33',
	                    confirmButtonText: '로그인',
	                    cancelButtonText: '취소'
	                }).then((result) => {
	                    if (result.isConfirmed) {
	                    		  $('#myModal').show();
	                    }
	                })
				}
				 
			},
			error : function(){
				alert('전송 오류');				
			}
		});		
	}
	
	
</script>

		<!-- 트레일러 뷰 시작  -->
		<c:if test="${sw == 1}">
			<section class="contact-area section-padding-0-100">
	        <div class="container">
	        <h2 style="font-weight: bolder;">트레일러</h2>
	        	<div class="row">
	        	<c:set var="i" value="1"></c:set>
	        	<c:forEach var="dVo" items="${vos}">
	        		<div class="col">
	        			<video width="100%" height="100%" poster="${dVo.trailerImg}" controls="" >
	       				 <source src="${dVo.src}" deletecommandtype="video/mp4">
	   				  	</video>
	        		</div>
	        	<c:set var="i" value="${i+1}"></c:set>
	        	</c:forEach> 
	        	</div>
	        </div>
	    </section>
    </c:if>
		<!-- 트레일러 뷰 끝 -->
		
		<!-- 스틸컷 뷰 시작 -->
		<c:if test="${sw == 2}">
			<section class="contact-area section-padding-0-100">
	        <div class="container">      
	        <h2 style="font-weight: bolder;">스틸컷</h2>
	        		<table class="table table-hover" style="background-color: #fdd">
	        			<c:set var="i" value="1"></c:set>
								<c:forEach var="sVo" items="${vos}">
								<c:if test="${i % 3 == 0 || i == 1}"><tr></c:if>
									<td><img src="${sVo.stillCutImg}" alt="${sVo.movieTitle}"></td>
								<c:if test="${i % 3 == 0 || i == 1}"></tr></c:if>
	        			<c:set var="i" value="${i + 1}"></c:set>
								</c:forEach>
	        		</table>
	        </div>
	    </section>
		</c:if>
		<!-- 스틸컷 뷰 끝 -->
		
		<!-- 영화 리뷰 뷰 시작  -->
		<section style="background-color: #eea">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="card card-style1 border-0">
                            <div class="card-body p-4 p-md-5 p-xl-6">
                                <div class="text-center mb-2-3 mb-lg-6">
                                    <span class="section-title">이 영화 어떤지 사람들에게 알리고싶을땐?</span>
                                    <h2 class="h1 mb-0 text-secondary">영화 리뷰</h2>
                                </div>
                                <c:set var="i" value="1"></c:set>
                                <c:if test="${empty rVos}"><h3>이런.. 아직 리뷰가 한개도없네요🤨</h3></c:if>
                                <c:forEach var="rVo" items="${rVos}">
	                                <div id="accordion" class="accordion-style">
	                                    <div class="card mb-3">
	                                        <div class="card-header" id="heading${i}">
	                                            <h5 class="mb-0">
	                                                <button class="btn btn-link" data-bs-toggle="collapse" data-bs-target="#collapse${i}" aria-expanded="true" aria-controls="collapse${i}">
	                                                <span class="text-theme-secondary me-2">${rVo.re_Id}😊
	                                                </span>
	                                                	<span id="titleDemo${i}">${rVo.re_Title}</span> <c:if test="${rVo.re_reportSw == 2 && rVo.re_Id == sId}"><span style="float: right;">신고접수</span></c:if>
	                                                </button>
	                                            </h5>
	                                        </div>
	                                        <div id="collapse${i}" class="collapse show" aria-labelledby="heading${i}" data-bs-parent="#accordion">
	                                            <div class="card-body">
	                                            	<p style="color: #666" id="contentDemo${i}">${rVo.re_Content}</p>
	                                     					<p style="font-weight: bolder;color: #666">${rVo.re_ScreenType}  ${fn:substring(rVo.re_Date,0,10)} | 
	                                     					<a href="javascript:goodCheck(${rVo.idx})"><font color="red">❤</font></a> ${rVo.re_Good}
																								<span id="ratingDemo${i}">
																								<c:if test="${rVo.re_Rating == 1}"><span style="color: #f90;">&#9733;</span></c:if>
																								<c:if test="${rVo.re_Rating == 2}"><span style="color: #f90;">&#9733;&#9733;</span></c:if>
																								<c:if test="${rVo.re_Rating == 3}"><span style="color: #f90;">&#9733;&#9733;&#9733;</span></c:if>
																								<c:if test="${rVo.re_Rating == 4}"><span style="color: #f90;">&#9733;&#9733;&#9733;&#9733;</span></c:if>
																								<c:if test="${rVo.re_Rating == 5}"><span style="color: #f90;">&#9733;&#9733;&#9733;&#9733;&#9733;</span></c:if>
																								</span>
																								<c:if test="${sId == rVo.re_Id}">
																								<span style="float: right;padding: 5px"><a href="javascript:reviewUpdate('${i}','${rVo.idx}','${rVo.re_Rating}','${rVo.re_Content}','${rVo.re_Title}')">수정</a></span>
																								<span style="float: right;padding: 5px"><a href="javascript:reviewDelete(${rVo.idx})">삭제</a></span>
																								</c:if>
																								<a href="javascript:reviewReport('${rVo.idx}','${rVo.re_Title}','${rVo.re_Content}','${rVo.re_Id}','${fn:substring(rVo.re_Date,0,10)}','${rVo.re_reportSw }')">
																									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell-fill" viewBox="0 0 16 16">
																									  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
																									</svg>신고
																								</a>
																								</p>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
                                <c:set var="i" value="${i + 1}"></c:set>
                                </c:forEach>
                                <form name="reviewForm">
                             				<div class="card mb-3" style="background-color: #f4f4d9">
                                      <div class="card-header" id="writeBox">
                                          <h5 class="mb-0">
                                              <span class="text-theme-secondary me-2"></span>
                                              <c:if test="${empty sId}">
	                                              <button type="button" class="btn" data-toggle="modal" data-target="#myModal" style="background-color: #f4f4a9;margin-bottom: 3px">
	                                              로그인
																								</button>해주세요.
																							</c:if>  
																							<c:if test="${!empty sId}">
																							<div class="star-rating">
																							  <input type="radio" id="5-stars" name="re_Rating" value="5" />
																							  <label for="5-stars" class="star">&#9733;</label>
																							  <input type="radio" id="4-stars" name="re_Rating" value="4" />
																							  <label for="4-stars" class="star">&#9733;</label>
																							  <input type="radio" id="3-stars" name="re_Rating" value="3" />
																							  <label for="3-stars" class="star">&#9733;</label>
																							  <input type="radio" id="2-stars" name="re_Rating" value="2" />
																							  <label for="2-stars" class="star">&#9733;</label>
																							  <input type="radio" id="1-star" name="re_Rating" value="1" />
																							  <label for="1-star" class="star">&#9733;</label>
																							</div>
																							😊 ${sId}
																							 <input type="text" name="re_Title" id="re_Title" placeholder="제목을 입력해주세요." class="form-control"/> 
																							</c:if>
																							<textarea rows="4" name="re_Content" id="re_Content" placeholder="내용를 입력해주세요." class="form-control"></textarea>
                                          </h5>
                                      </div>
                                      <div id="writeBox" class="collapse show" aria-labelledby="writeBox" data-bs-parent="#accordion">
                                          <div class="card-body m-0 p-2">
                                       	   <span style="float: right;margin-bottom: 3px"><button type="button" onclick="reviewCheck()">리뷰등록</button></span> 
                                          </div>
                                      </div>
                                   </div>
                                </form>
                                <!-- 페이징처리 시작 -->
																	<div class="text-center">
																	  <ul class="pagination justify-content-center">
																	    <c:if test="${pageVO.pag > 1}">
																	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&pag=1">첫페이지</a></li>
																	    </c:if>
																	    <c:if test="${pageVO.curBlock > 0}">
																	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}">이전블록</a></li>
																	    </c:if>
																	    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
																	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
																	    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&pag=${i}">${i}</a></li>
																	    	</c:if>
																	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
																	    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&pag=${i}">${i}</a></li>
																	    	</c:if>
																	    </c:forEach>
																	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
																	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li>
																	    </c:if>
																	    <c:if test="${pageVO.pag < pageVO.totPage}">
																	      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitleKo}&pag=${pageVO.totPage}">마지막페이지</a></li>
																	    </c:if>
																	  </ul>
																	</div>
																	<!-- 페이징처리 끝 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script>
        	'use strict'
        	
        	function goodCheck(idx){
        		
        		if('${sId}' == ''){
        			Swal.fire({
        				title : '로그인을 먼저 해주세요!',
        				icon  : 'info'
        			});
        			return;
        		}
        		
        		$.ajax({
        			type : 'post',
        			url  : '${ctp}/movie/goodCheck',
        			data : {idx:idx},
        			success : function (res){
        				
        				if(res == '0'){
									Swal.fire({
										title : '로그인 시 같은 게시물은 1회만 좋아요를 누를 수 있습니다.',
										icon  : 'info'
									});
									return;
        				}
        				else {
									location.reload();        				
        				}
        			},
        			error : function(){
        				Swal.fire({
        					title : '전 송 오 류',
        					icon  : 'error'
        				});
        			}
        		}); 
        		
        	}
        	
        	
        	function reviewCheck(){
        		
        		
        		$.ajax({
        			type : 'post',
        			url  : '${ctp}/movie/duplicationReviewCheck',
        			data : {id:'${sId}',
        			movieTitle:'${vo.movieTitleKo}'},
        			success : function(id){
        				if(id == '1'){
        					Swal.fire({
        						title : '이미 리뷰를 작성하셨습니다.',
        						icon  : 'info'
        					});
        					return;
        				}
        				
      				$.ajax({
              			type : 'post',
              			url  : '${ctp}/movie/memberReportCheck',
              			data : {id:'${sId}'},
              			success : function(res){
              			if(res != ''){
              				Swal.fire({
              					title : '현재 고객님께서는 '+res+'상태이십니다.',
              					text  : '제재가 풀린 후 이용해주세요.',
              					icon  : 'info'
              				});
              				return
              			}	
              			
      		        		let content = $("#re_Content").val();
      		        		let title = $("#re_Title").val();
      		        		let id = '${sId}';
      		        		let movieTitle = '${vo.movieTitleKo}';
      		        		let rating = reviewForm.re_Rating.value;
      		        		
      		        		if(title == ''){
      		        			alert('제목을 입력해주세요.');
      		        			return;
      		        		}
      		        		else if(content == ''){
      		        			alert('내용을 입력해주세요.');
      		        			return;
      		        		}
      		        		else if(rating == ''){
      		        			alert('별점은 최소 1점은 주셔야합니다.');
      		        			return;
      		        		}
      		        		
      		        		let query = {
      		        				movieTitle,
      		        				id
      		        		}
      		        		
      		        	$.ajax({
      		        			type : 'post',
      		        			url  : '${ctp}/movie/movieReviewCheck',
      		        			data : query,
      		        			success : function (cd){
      		        				if(cd == '0'){
      		        					Swal.fire({
      		        						title : '영화 '+movieTitle+'를 예매하신적이 있으셔야 리뷰 작성가능하십니다.',
      		        						icon  : 'info'
      		        					});
      		        					return;
      		        				}
      		        				else{ 
      		        					$.ajax({
      		                			type : "GET",
      		                			url  : "${ctp}/movie/movieReviewInput?re_Id="+id+"&re_MovieTitle="+movieTitle+"&re_Title="+title+"&re_Content="+content+"&re_Rating="+rating,
      		                			success : function(){
      		                				location.reload();
      		                			},
      		                			error : function(){
      		                				alert('전송 오류');
      		                			}
      		                		});        					
      		        				}
      		                		
      		        			},
      		        			error : function(){
      										Swal.fire({
      											title : '전송오류',
      											icon  : 'error'
      										});        				
      		        			}
      		        		}); 
      		        		
              			},
              			error : function(){
      								alert('전송 오류');        				
              			}
              		});
      				
	      			},
	      			error : function(){
							alert('전송 오류');        				
	      			}
	      		});
        	}
        	
        	function reviewUpdate(i,idx,rating,content,title,reportsw) {
        		
        		if(reportsw == 2){
        			Swal.fire({
        				title : '이미 신고접수된 게시물입니다.',
        				icon  : 'info'
        			});
        			return;
        		}
        		
        		let ratingForm = '';
        		ratingForm += '<form name="reviewUpForm'+idx+'">	<div class="star-rating">'
        		ratingForm += '<input type="radio" id="5-upstars'+idx+'" name="reUp_Rating'+idx+'" value="5" />'
        		ratingForm += '<label for="5-upstars'+idx+'" class="star">&#9733;</label>'
        		ratingForm += '<input type="radio" id="4-upstars'+idx+'" name="reUp_Rating'+idx+'" value="4" />'
        		ratingForm += '<label for="4-upstars'+idx+'" class="star">&#9733;</label>'
        		ratingForm += '<input type="radio" id="3-upstars'+idx+'" name="reUp_Rating'+idx+'" value="3" />'
        		ratingForm += '<label for="3-upstars'+idx+'" class="star">&#9733;</label>'
        		ratingForm += '<input type="radio" id="2-upstars'+idx+'" name="reUp_Rating'+idx+'" value="2" />'
        		ratingForm += '<label for="2-upstars'+idx+'" class="star">&#9733;</label>'
        		ratingForm += '<input type="radio" id="1-upstars'+idx+'"  name="reUp_Rating'+idx+'" value="1" />'
        		ratingForm += '<label for="1-upstars'+idx+'" class="star">&#9733;</label>'
        		ratingForm += '</div><button type="button" class="form-control" onclick="revirewUpdateOk()">수정완료</button><button type="button" class="form-control" onclick="location.reload()">취소</button></form>';
        		
        		$("#ratingDemo"+i).html(ratingForm);
        		
					  if(rating == '1'){
        			$("#1-upstars"+idx).prop('checked',true);
        		}
        		else if(rating == '2'){
        			$("#2-upstars"+idx).prop('checked',true);
        		}
        		else if(rating == '3'){
        			$("#3-upstars"+idx).prop('checked',true);
        		}
        		else if(rating == '4'){
        			$("#4-upstars"+idx).prop('checked',true);
        		}
        		else if(rating == '5'){
        			$("#5-upstars"+idx).prop('checked',true);
        		}
        
        		
        		let titleForm = '<input type="text" name="re_Title" id="reUp_Title" placeholder="제목을 입력해주세요." value="'+title+'" class="form-control"/><input type="hidden" id="idx" value="'+idx+'"/>';
        		$("#titleDemo"+i).html(titleForm);
        		
        		let contentDemo = '<textarea rows="4" name="re_Content" id="reUp_Content" placeholder="내용를 입력해주세요." class="form-control">'+content+'</textarea>';
        		$("#contentDemo"+i).html(contentDemo);
        		
        	}
        	
        	function revirewUpdateOk(){
        		let idx = $("#idx").val();
        		let content = $("#reUp_Content").val();
        		let title = $("#reUp_Title").val();
        		let id = '${sId}';
        		let movieTitle = '${vo.movieTitleKo}';
        		let rating = $('input[name="reUp_Rating'+idx+'"]:checked').val();
        		
        		
        	 if(title == ''){
        			alert('제목을 입력해주세요.');
        			return;
        		}
        		else if(content == ''){
        			alert('내용을 입력해주세요.');
        			return;
        		}
        		else if(rating == ''){
        			alert('별점은 최소 1점은 주셔야합니다.');
        		} 
        		
        		let query = {
        				idx:idx,
        				re_Content:content,
        				re_Title:title,
        				re_Id:id,
        				re_MovieTitle:movieTitle,
        				re_Rating:rating
        		}
        		
        		$.ajax({
        			type : 'post',
        			url  : '${ctp}/movie/movieReviewUpdate',
        			data : query,
        			success : function(){
        				Swal.fire({
        					title : '리뷰가 수정되었습니다 !!',
        					imageUrl : '${ctp}/images/신사어피치.png',
        					imageWidth : 500,
        					imageHeight: 400
        				});
        				
        				setTimeout(function(){location.reload()},1000)
        			},
        			error : function(){
        				Swal.fire({
        					title : '전송 오류',
        					icon  : 'error'
        				});
        			}
        		});
        	}
        	
        	function reviewDelete(idx){
        		Swal.fire({
                    title: '해당 댓글을 삭제하시겠습니까?',
                    text: "삭제하시면 복구는 불가능합니다.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '삭제',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                    	$.ajax({
                    		type : 'post',
                    		url  : '${ctp}/movie/movieReviewDelete',
                    		data : {idx:idx},
                    		success : function (){
                    			Swal.fire({
                    				title : '댓글이 삭제되었습니다.',
                    				imageUrl : '${ctp}/images/신사어피치.png',
	                					imageWidth : 500,
	                					imageHeight: 400
                    			});
                    			
                    			setTimeout(function(){
                    				location.reload();
                    			},2000);
                    		},
                    		error : function (){
                    			Swal.fire({
                    				title : '전송 오류',
                    				icon  : 'error'
                    			});
                    		}
                    	});
                    	
                    }
                });
        	}
        	
        	
        	function reviewReport(idx,title,content,id,date){
        		if('${sId}' == ''){
        			Swal.fire({
	                    title: '로그인하신 후에 신고하기기능을 이용가능합니다.',
	                    text: "로그인 하시겠습니까?",
	                    icon: 'info',
	                    showCancelButton: true,
	                    confirmButtonColor: '#3085d6',
	                    cancelButtonColor: '#d33',
	                    confirmButtonText: '로그인',
	                    cancelButtonText: '취소'
	                }).then((result) => {
	                    if (result.isConfirmed) {
	                    		  $('#myModal').show();
	                    }
	                });
        			return;
        		}
        		
        		$("#reportModal").fadeIn();
        		
        		$("#title").html('<span id="modalTitle">'+title+'</span><input type="hidden" id="modalIdx" value="'+idx	+'"/>');
        		$("#content").html('<span id="modalContent">'+content+'</span>');
        		$("#reviewId").html('<span id="modalId">'+id+'</span>');
        		$("#date").html('<span id="modalDate">'+date+'</span>');
        		
        	}
        	
        	function reviewReportOk(){
        		let part = 'CgvReview';
        		let reportContentIdx = $("#modalIdx").val();
        		let reporterId = '${sId}';
						let reportPart = $("#reportPart").val();
						let reportReason = $("#reportReason").val();
        		
        		
        		let query = {
        				part,
        				reportContentIdx,
        				reporterId,
        				reportPart,
        				reportReason
        		}
        		
        		$.ajax({
        			type : 'post',
        			url  : '${ctp}/movie/reviewReportOk',
        			data : query,
        			success : function () {
        				Swal.fire({
        					title : '신고가 완료되었습니다.',
        					text  : '메일로 접수확인 메일 보내드렸습니다.',
        					imageUrl : '${ctp}/images/신사어피치.png',
        					imageWidth : 500,
        					imageHeight: 400
        				});
        				
        				setTimeout(function(){
        					location.reload()
        				},1000)
        			},
        			error : function (){
        				Swal.fire({
        					title : '전 송 오 류',
        					icon  : 'error'
        				});
        			}
        		});
        	}
        	
        	
        </script>
        <!-- 신고 모달 -------- -->
        
        <div class="modal " id="reportModal" >
				  <div class="modal-dialog modal-lg">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #efa">
				        <h4 class="modal-title">신고하기</h4>
				        <button type="button" class="close" data-dismiss="modal" onclick="$('#reportModal').fadeOut();">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #eea;" >
				      	<div class="row">
				      		<div class="col" style="font-size: 1.7em">현재 신고 중인 리뷰</div>
				      	</div>
				      	<div class="row">
				      		<div class="col" style="font-size: 1.3em;font-weight: bolder;margin-bottom: 5px">
				      			리뷰 제목   &nbsp;&nbsp;&nbsp;:&nbsp; <span id="title"></span>
				      		</div>
				      	</div>
				      	<div class="row">
				      		<div class="col" style="font-size: 1.3em;font-weight: bolder;margin-bottom: 5px">
				      			리뷰 글쓴이 :&nbsp; <span id="reviewId"></span>
				      		</div>
				      	</div>
				      	<div class="row">
				      		<div class="col" style="font-size: 1.3em;font-weight: bolder;margin-bottom: 5px">
				      			리뷰 내용  &nbsp;&nbsp;&nbsp;:&nbsp; <span id="content"></span>
				      		</div>
				      	</div>
				      	<div class="row">
				      		<div class="col" style="font-size: 1.3em;font-weight: bolder;margin-bottom: 5px">
				      			리뷰 제목  &nbsp;&nbsp;&nbsp;:&nbsp; <span id="date"></span>
				      		</div>
				      	</div>
				      	<table class="table" style="font-size: 1.5em">
				      		<tr>
				      			<th>신고 카테고리</th>
				      			<td>
				      				<select name="reportPart" id="reportPart" class="form-control">
				      					<option>스팸홍보/도배글입니다.</option>
				      					<option>음란물입니다.</option>
				      					<option>불법정보를 포함하고 있습니다.</option>
				      					<option>청소년에게 유해한 내용입니다.</option>
				      					<option>욕설/생명경시/혐오/차별적 표현입니다.</option>
				      					<option>개인정보 노출 게시물입니다.</option>
				      					<option>불쾌한 표현이 있습니다.</option>
				      				</select>
				      			</td>
				      		</tr>
				      		<tr>
				      			<th>신고 사유</th>
				      			<td>
				      				<textarea rows="5" name="reportReason" id="reportReason" class="form-control"></textarea>
				      			</td>
				      		</tr>
				      		<tr>
				      			<td colspan="2">
				      				<button type="button" onclick="reviewReportOk()">신고하기</button>
				      			</td>
				      		</tr>
				      	</table>
				      	
				      	
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #efa">
				      </div>
				    </div>
				  </div>
				</div>
				        
        <!-- 영화 리뷰 뷰 끝  -->

		<script> // 아이디찾기 찾기
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
						alert('전송완료');    				
    			}
    		});
    		
    	}
			
			
			
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
			success : function(uid){
					authUid = uid;	
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
			},
			error : function(){
				alert('전송 오류');		
			}
		});
	}

	var countDown = 60 * 3;
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
		else if(authUid != authNumber){
			alert('인증 번호를 확인해주세요');
			$("#authYn").val('N');
			return;
		}
		else {
			emailSw = '1';
			alert('인증 성공 \n인증창을 닫고 회원가입을 마무리해주세요.');
			$("#authYn").val('Y');
			$("#emailCheckBtn").attr('disabled',true);
			$("#authEmailDiv").hide();
			$("#email").val(rEmail);
			$("#email").attr('disabled',true);
	}
}
	
	
	function pswdSearch(){
		const regId = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
		const regNickName = /^[a-zA-Z가-힣0-9]{2,20}$/i;
		const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		let id = $("#authId").val();
		let nickName = $("#pswdNickName").val(); 
		let email = $("#email").val();
		
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
	  
		else {
			
			$.ajax({
				type : "GET",
				url  : "${ctp}/pswdSearch?id="+id+"&nickName="+nickName+"&email="+email,
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
		</script>
		
<jsp:include page="/WEB-INF/views/include/chatting.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/loginModal.jsp"></jsp:include> 
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
    </body>
</html>