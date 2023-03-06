<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript">
		var naver_id_login = new naver_id_login("PqKrA03M4FASBnKGgGIk", "http://localhost:9090/green2209S_10/naverLoginTx");
		
	  // 접근 토큰 값 출력
	  // 네이버 사용자 프로필 조회
	  naver_id_login.get_naver_userprofile("naverSignInCallback()");
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	  function naverSignInCallback() {
		  
		  let mem_email = naver_id_login.getProfileData('email');
		  let mem_nickName = naver_id_login.getProfileData('nickname');
		  let mem_name = naver_id_login.getProfileData('name');
		  let mem_photo = naver_id_login.getProfileData('profile_image');
		  
		  opener.location.href="${ctp}/naverLogin?mem_email="+mem_email+"&mem_nickName="+mem_nickName+"&mem_name="+mem_name+"&mem_photo="+mem_photo;
		  
		  /* console.log('email'+naver_id_login.getProfileData('email'));
		  console.log('nickname'+naver_id_login.getProfileData('nickname'));
		  console.log('age'+naver_id_login.getProfileData('age'));
		  console.log('birthday'+naver_id_login.getProfileData('birthday'));
		  console.log('gender'+naver_id_login.getProfileData('gender'));
		  console.log('profile_image'+naver_id_login.getProfileData('profile_image'));
		  console.log('id'+naver_id_login.getProfileData('id'));
		  console.log('name'+naver_id_login.getProfileData('name')); */
	
		  window.close();
	  }
</script>
<body>
<p><br/><p>
<div class="container">
	<img alt="" src="${ctp}/images/신사어피치.pne">
	<h2>네이버 로그인 중~</h2>
</div>
<p><br/><p>
</body>
</html>