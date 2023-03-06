<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
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
                   <div class="form-group">
                      <label for="pswdQ">비밀번호 찾기 질문</label>
                      <select name="mem_pswdQ" id="pswdQ" class="form-control">
                       	<option value="1">출신초등학교</option>
                       	<option value="2">어렸을때별명</option>
                       	<option value="3">내가 가장 좋아했던 장소</option>
                       	<option value="4">부모님 이름</option>
                       	<option value="5">어렸을때 살았던 동네</option>
                      </select>
                      <input type="text" class="form-control" id="pswdA" name="mem_pswdA" maxlength="30" placeholder="비밀번호 찾기 질문의 대답을 입력해주세요.">
                      <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>본인이 기억하시는 정확한 대답을 입력해주세요.</small>
                   </div>
                   <span id="pswdSearchDemo"></span>
                   <button type="button" onclick="pswdSearch()" id="pswdSearchBtn" class="btn oneMusic-btn mt-30">비밀번호찾기</button>
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