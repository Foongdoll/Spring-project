<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
 <!-- 아이디 인증 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal2">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">회원가입 아이디 중복체크</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	 	<form name="authIdForm">
		      	 		<h3>아이디<h3>
		      	 		<input type="text" id="authId" name="authId" class="form-control" placeholder="아이디을 입력해주세요."/>
		      	 		<button type="button" onclick="authIdSearch()">중복체크</button><span id="idSearchDemo"></span>
		      	 	</form>
		      </div>
		
		  <!--     Modal footer
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
		      </div> -->
		
		    </div>
		  </div>
		</div>
		
 <!-- 이메일 인증 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">회원가입 이메일 인증</h4>
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
		
 <!-- 닉네임 인증 모달 창  -->
		<!-- The Modal -->
		<div class="modal" id="myModal3">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">회원가입 닉네임 중복체크</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	<div class="login-form">
        			<form name="authIdForm">
		      	 		<h3>닉네임</h3>
		      	 		<input type="text" id="authNickName" name="authNickName" class="form-control" placeholder="닉네임을 입력해주세요."/>
		      	 		<button type="button" onclick="authNickNameSearch()">중복체크</button><span id="nickNameSearchDemo"></span>
		      	 	</form>
            </div>
		      </div>
		    </div>
		  </div>
		</div>