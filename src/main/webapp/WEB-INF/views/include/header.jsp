<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Stylesheet -->
		<link rel="stylesheet" href="${ctp}/resources/css/style.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/animate.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/audioplayer.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/classy-nav.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/font-awesome.min.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/magnific-popup.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/one-music-icon.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/owl.carousel.min.css" type="text/css">
		<link rel="stylesheet" href="${ctp}/resources/css/style.css.map" type="text/css">
		<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	'use strict'
	window.Kakao.init("4d9fc650f3b42a755fd77f61baff8674");
	
	// 카카오 로그아웃
  	function kakaoLogout(kakaoKey) {
  		// 다음에 로그인시에 동의항목 체크하고 로그인할 수 있도록 로그아웃시키기
			Kakao.API.request({
	      url: '/v1/user/unlink',
	    })
  		Kakao.Auth.logout(function() {
  			console.log(Kakao.Auth.getAccessToken(), "토큰 정보가 없습니다.(로그아웃되셨습니다.)");
  			location.href="${ctp}/logout";
  		});
  	}
	var newWindow = "";
	function SignOutG(){
		newWindow = window.open("http://accounts.google.com/logout","blank","width=500,height=600");
		setTimeout(() => {
			if(newWindow != null) newWindow.close();
			location.href="${ctp}/logout"
		}, 300);				
		
	}
	
	function SignOutN(){
		newWindow = window.open("https://nid.naver.com/nidlogin.logout","blank","width=1,height=1");
		setTimeout(() => {
			if(newWindow != null) newWindow.close();
			location.href="${ctp}/logout"
		}, 300);				
		
	}
	
</script>
		
<!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="lds-ellipsis">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="oneMusic-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                        <!-- Nav brand -->
                        <a href="index.html" class="nav-brand"></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- Close Button -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul>
                                    <li><a href="${ctp}/">Home</a></li>
                                    <li><a href="${ctp}/">빠른예매</a></li>
                                    <li><a href="${ctp}/">영화</a>
                                        <ul class="dropdown">
                                            <li><a href="${ctp}/movie/movieChart">영화순위</a></li>
                                            <li><a href="${ctp}/movie/ticketing">예매 및 상영시간표</a></li>
                                            <li><a href="javascript:alert('준비중인서비스입니다.');">스토어</a></li>
                                            <li><a href="javascript:alert('준비중인서비스입니다.');">극장</a></li>
                                            <li><a href="${ctp}/board/boardList">게시판</a></li>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a href="${ctp}/event/eventHome">이벤트</a></li>
                                    <c:if test="${sLevel == 0}">
                                    <li><a href="${ctp}/admin/adminMain">관리자</a></li>
                                    </c:if>
                                    <c:if test="${!empty sLevel}">
                                    <li><a href="${ctp}/myPage/myPageHome">마이페이지</a></li>
                                    </c:if>
                              		  </ul>

                                <div class="login-register-cart-button d-flex align-items-center">
                                    <div class="login-register-btn mr-50">
                                   		<c:if test="${empty sLevel }">
                                      <a href="${ctp}/login" id="loginBtn">Login</a> /
                                      </c:if>
                                   		<c:if test="${!empty sLevel}">
	                                   		<c:if test="${kakaoSw == 'kakao'}">
	                                      	<a href="javascript:kakaoLogout()" id="loginBtn">Logout</a> /
	                                      </c:if>
	                                   		<c:if test="${kakaoSw != 'kakao' && googleSw != 'google' && naverSw != 'naver'}">
                                      		<a href="${ctp}/logout" id="loginBtn">Logout</a> /
	                                      </c:if>
	                                      <c:if test="${googleSw == 'google'}">
	                                      	<a href="javascript:SignOutG()">Logout</a>
	                                      </c:if>
	                                      <c:if test="${naverSw == 'naver'}">
	                                      	<a href="javascript:SignOutN()">Logout</a>
	                                      </c:if>
                                      </c:if>
                                      <a href="${ctp}/join" id="loginBtn">Register</a>
                                    </div>

                                    <div class="cart-btn">
                                        <p><span class="icon-shopping-cart"></span> <span class="quantity">1</span></p>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>