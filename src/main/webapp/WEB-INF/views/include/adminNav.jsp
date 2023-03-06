<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
<script>
	'use strict'
	
	function searchGo(){
		let searchStr = '';		
		if(event.keyCode == 13){
			searchStr = $("#search").val();			
			
			if(searchStr != ''){
				
				let cnt = 0;
				let query = "대시보드,회원목록,1:1문의,1대1문의,신고내역,포인트관리,쿠폰관리,예매관리,이벤트관리,컨텐츠관리";
				let keyWord = query.split(',');
				
				for(let i = 0; i < keyWord.length; i++){
					if(keyWord[i] == searchStr){
						cnt++
					}
				}
				
				if(cnt == 0){
					alert('정확한 키워드를 입력해주세요.\nex) 대시보드, 회원목록, 1:1문의, 1대1문의, 신고내역, 포인트관리, 쿠폰관리, 예매관리, 이벤트관리, 컨텐츠관리');
					return;
				}
				else {
					$.ajax({
						type : 'get',
						url  : '${ctp}/admin/adminNavSearch?searchStr='+searchStr,
						success : function(url){
							location.href="${ctp}/admin/"+url;
						},
						error : function(){
							alert('전송 오류');							
						}
					});
				}				
			}
			
		}
	}
</script>
 <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="${ctp}/admin/adminMain" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>오늘뭐볼까?</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="${ctp}/images/머쓱피치.png" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">${vo.mem_name}</h6>
                        <span>Admin</span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <a href="${ctp}/admin/adminMain" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>대시보드</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>회원관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="${ctp}/admin/adminMember" class="dropdown-item">회원 목록</a>
                            <a href="${ctp}/admin/admin11Contact" class="dropdown-item">1:1문의</a>
                            <a href="${ctp}/admin/adminReport" class="dropdown-item">신고내역</a>
                            <a href="${ctp}/admin/adminPointCoupon" class="dropdown-item">포인트/쿠폰관리</a>
                        </div>
                    </div>
                    <a href="${ctp}/admin/ticket" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>예매관리</a>
                    <a href="${ctp}/admin/event" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>이벤트관리</a>
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>에러페이지</a>
                    <div class="dropdown-menu bg-transparent border-0">
                            <a href="${ctp}/home/home" class="dropdown-item">404</a>
                            <a href="location.href=''" class="dropdown-item">400</a>
                            <a href="#" class="dropdown-item">500</a>
                        </div>
                    <a href="${ctp}/admin/content" class="nav-item nav-link"><i class="fa fa-th me-2"></i>컨텐츠관리</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>크롤링</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="#" class="dropdown-item">! 주의 누르면 바로 크롤링됨 !</a>
                            <a href="${ctp}/admin/dbsave" class="dropdown-item">메인영화목록</a>
                            <a href="${ctp}/admin/dbsave2" class="dropdown-item">무비차트</a>
                            <a href="${ctp}/admin/dbsave3" class="dropdown-item">영화상세정보</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>

        <div class="content">
            <!-- Navbar Start -->	
            <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                </a>
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                <form class="d-none d-md-flex ms-4">
                    <input class="form-control border-0" id="search" onkeypress="searchGo()" type="search" placeholder="Search">
                </form>
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-envelope me-lg-2"></i>
                            <span class="d-none d-lg-inline-flex">Message</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item text-center">See all message</a>
                        </div>
                    </div>   
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-bell me-lg-2"></i>
                            <span class="d-none d-lg-inline-flex">Notificatin</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item text-center">See all notifications</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" alt="머쓱어치피" src="${ctp}/images/머쓱피치.png" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex">${vo.mem_name}</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="${ctp}/" class="dropdown-item">홈으로</a>
                            <a href="${ctp}/logout" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->
