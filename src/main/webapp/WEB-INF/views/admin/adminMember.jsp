<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>회원정보</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"></jsp:include>
</head>
<script type="text/javascript">
 'use strict'
 function memberInfor(id){
	 
	 $.ajax({
		 type : "post",
		 url  : "${ctp}/admin/adminMemberInfor",
		 data : {id:id},
		 async: false,
		 success : function(vo){
			 let year = vo.mem_scNumber.substr(0,4);			 
			 let month = vo.mem_scNumber.substr(4,2);
			 let day = vo.mem_scNumber.substr(6,2);
			 let gender = vo.mem_scNumber.substr(9,1);
			 
			 if(gender == '1') gender = '남자';
			 else gender = '여자';
			 
			 let level = vo.mem_level;
			 if(level == '0') level = '관리자'
			 else if(level == '1') level = '일반회원'
			 else if(level == '2') level = '우수회원'
			 else if(level == '3') level = '최우수회원'
			 
			 let authSw = vo.mem_authSw;
			 if(authSw == '0') authSw = '미인증' 
			 else authSw = '인증완료'
			 
			 $("#name").html(vo.mem_name);
			 $("#nickName").html(vo.mem_nickName);
			 $("#id").html(vo.mem_id);
			 $("#scNumber").html(year+"년"+month+"월"+day+"일"+"/ "+gender);
			 $("#tel").html(vo.mem_tel);
			 $("#email").html(vo.mem_email);
			 $("#startDate").html(vo.mem_startDate.substring(0,10));
			 $("#lastDate").html(vo.mem_lastDate.substring(0,10));
			 $("#point").html(vo.mem_point);
			 $("#level").html(level);
			 $("#mStatus").html(vo.mem_mStatus);
			 $("#authSw").html(authSw);
		 },
		 error : function(){
			 Swal.fire({
				 title: '전송 오류 !!',
				 icon: 'error',
			 });
		 }
	 });
	 
 }
 
 document.addEventListener('keydown', (event) => {
	 	if(event.keyCode == 13){
	 		 let searchStr = $("#textBox").val();
	 		 let part = $("#part").val();
	 		 location.href='${ctp}/admin/adminMember?searchStr='+searchStr+'&part='+part; 
	 	}
	});
 
 function adminMemberDel(id){
	let ans = confirm('정말 탈퇴 시키시겠습니까?');

	if(!ans) return;
	else if(id == 'admin') alert('관리자는 탈퇴시킬 수 없습니다.');
	
	$.ajax({
		type : 'post',
		url  : '${ctp}/admin/adminMemberDel',
		data : {id:id},
		success :function(){
			Swal.fire({
				title : '회원탈퇴처리가 완료되었습니다.',
				icon  : 'success'
			});
			setTimeout(function(){
				location.reload();
			},1000);
		},
		erorr :function(){
			alert('전송오류');			
		}
	});
	
 }
 
</script>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
      	<jsp:include page="/WEB-INF/views/include/adminNav.jsp"></jsp:include>
      
            <!-- 회원 목록 리스트 Start -->
            <div class="container-fluid">
                	<span style="font-size: 1.6em">회원리스트</span>
	                	<select name="part" id="part" class="form-control">
	                		<option value="mem_id">아이디</option>
	                		<option value="mem_nickName">닉네임</option>
	                		<option value="mem_name">이름</option>
	                	</select>
	                	<div class="input-group">
	                    <div class="input-group-prepend">
	                        <span class="input-group-text"><i class="fa fa-search"></i></span>
	                    </div>
	                    <input type="text" id="textBox" name="searchStr" class="form-control" placeholder="Search..." >
		                </div>
                	<table class="table table-hover">
                		<tr>
                			<th>번호</th>
                			<th>이름</th>
                			<th>별명</th>
                			<th>아이디</th>
                			<th>생년월일</th>
                			<th>전화번호</th>
                			<th>이메일</th>
                			<th>현재황동상태</th>
                			<th>2차인증</th>
                		</tr>
                		<c:forEach var="vo" items="${vos}" varStatus="st">
                		<tr>
                			<td>
                				${st.count}
                			</td> 
                			<td><a href="#" onclick="memberInfor('${vo.mem_id}')" data-toggle="modal" data-target="#myModal">${vo.mem_name}</a></td>
                			<td>${vo.mem_nickName }</td>
                			<td>${vo.mem_id }</td>
                			<td>${vo.mem_scNumber }</td>
                			<td>${vo.mem_tel }</td>
                			<td>${vo.mem_email }</td>
                			<td>
                			<c:if test="${vo.mem_mStatus == '활동중'}">
                				${vo.mem_mStatus}
                			</c:if>
                			<c:if test="${vo.mem_mStatus != '활동중'}">
                				<button type="button" onclick="adminMemberDel('${vo.mem_id}')" >회원탈퇴</button>
                			</c:if>
                			</td>
                			<td>
                				<c:if test="${vo.mem_authSw == 0}">
                					미인증
                				</c:if>
                				<c:if test="${vo.mem_authSw == 1}">
                					인증
                				</c:if>
                			</td>
                		</tr>
                		</c:forEach>
                	</table>
               	<!-- 페이징처리 시작 -->
								<div class="text-center">
								  <ul class="pagination justify-content-center">
								    <c:if test="${pageVO.pag > 1}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminMember?pag=1&searchStr=${pageVO.searchStr}&part=${pageVO.part}">첫페이지</a></li>
								    </c:if>
								    <c:if test="${pageVO.curBlock > 0}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminMember?pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">이전블록</a></li>
								    </c:if>
								    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
								      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
								    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/adminMember?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
								    	</c:if>
								      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
								    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminMember?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
								    	</c:if>
								    </c:forEach>
								    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminMember?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">다음블록</a></li>
								    </c:if>
								    <c:if test="${pageVO.pag < pageVO.totPage}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminMember?pag=${pageVO.totPage}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">마지막페이지</a></li>
								    </c:if>
								  </ul>
								</div>
								<!-- 페이징처리 끝 -->
   					  </div>
   					  
   					  <!-- 회원상세정보 모달 -->
				<div class="modal " id="myModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #97c2ef">
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #97c2ef" >
				      	<div class="container-fluid">
                	<h2>회원정보</h2>
                	<table class="table table-hover table-bordered text-center" style="font-size: 1.7em">
                		<tr>
                			<th>이름</th>
                			<td><span id="name"></span></td>
                		</tr>
                		<tr>
                			<th>별명</th>
                			<td><span id="nickName"></span></td>
                		<tr>
                			<th>아이디</th>
                			<td><span id="id"></span></td>
                		</tr>
                		<tr>
                			<th>생년월일/성별</th>
                			<td><span id="scNumber"></span></td>
                		</tr>
                		<tr>
                			<th>전화번호</th>
                			<td><span id="tel"></span></td>
                		</tr>
                		<tr>
                			<th>이메일</th>
                			<td><span id="email"></span></td>
                		</tr>
                		<tr>
                			<th>가입일</th>
                			<td><span id="startDate"></span></td>
                		</tr>
                		<tr>
                			<th>최종접속일</th>
                			<td><span id="lastDate"></span></td>
                		</tr>
                		<tr>
                			<th>VIP점수</th>
                			<td><span id="point"></span></td>
                		</tr>
                		<tr>
                			<th>회원등급</th>
                			<td><span id="level"></span></td>
                		</tr>
                		<tr>
                			<th>현재황동상태</th>
                			<td><span id="mStatus"></span></td>
                		<tr>
                			<th>2차인증상태</th>
                			<td><span id="authSw"></span></td>
                		</tr>
                	</table>
   					  </div>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #97c2ef">
				      </div>
				    </div>
				  </div>
				</div>
            <!-- 회원 목록 리스트 End -->

            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Your Site Name</a>, All Right Reserved. 
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            <!--/*** This template is free as long as you keep the footer authorâs credit link/attribution link/backlink. If you'd like to use the template without the footer authorâs credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
      
</div>
<jsp:include page="/WEB-INF/views/include/adminfooter.jsp"></jsp:include>
</body>
</html>