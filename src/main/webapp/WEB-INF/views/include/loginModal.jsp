<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
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
</script>
			<!-- 로그인 모달 -->
				<div class="modal " id="myModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #eaa">
				        <h4 class="modal-title">로그인</h4>
				        <button type="button" class="close" onclick="$('#myModal').hide();">&times;</button>
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
						                                <button type="button" onclick="kakaoLogin()" style="margin-top: 5px"><img src="${ctp}/images/kakao_login_medium_narrow.png"/></button>
						                                <input type="hidden" name="movieTitle" value="${vo.movieTitleKo}"/>
						                                <input type="hidden" name="sw" value="1"/>
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