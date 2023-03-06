<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>신고관리</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"></jsp:include>
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
</style>
<script type="text/javascript">
	'use strict'
	
	function keyEvent(){
		let keyCode = event.keyCode;
		
		if(keyCode == 13){
			let searchStr = $("#textBox").val();
			let part = $("#part").val();
			
			location.href="${ctp}/admin/adminReport?searchStr="+searchStr+"&part="+part;			
			
		}
	}	
	
</script>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
      	<jsp:include page="/WEB-INF/views/include/adminNav.jsp"></jsp:include>

            <div class="container-fluid pt-4 px-4">
		            <select name="part" id="part" class="form-control">
               		<option value="reporterId">신고자아이디</option>
               		<option value="reportPart">분류</option>
               		<option value="reportStatus">상태</option>
               	</select>
               	<div class="input-group">
                   <div class="input-group-prepend">
                       <span class="input-group-text"><i class="fa fa-search"></i></span>
                   </div>
                   <input type="text" id="textBox" onkeydown="keyEvent(this);" name="searchStr" class="form-control" placeholder="Search..." >
                </div>
							<table class="table">
								<tr>
									<th>접수번호</th>
									<th>분류</th>
									<th>신고게시글번호</th>
									<th>신고자</th>
									<th>신고분류</th>
									<th>신고자메일</th>
									<th>상태</th>
									<th>비고</th>
								</tr>
								<c:forEach var="vo" items="${vos}" varStatus="st"> 
								<tr>
									<td>${vo.idx}</td>
									<td>
										<c:if test="${vo.part == 'CgvReview'}">Review</c:if>
									</td>
									<td><a href="javascript:reportContentShow('${vo.reportContentIdx}','${vo.reportReason}')">${vo.reportContentIdx }</a></td>
									<td><a href="javascript:memberInfor('${vo.reporterId}')">${vo.reporterId }</a></td>
									<td>${vo.reportPart }</td>
									<td>${vo.reporterMail }</td>
									<td>${vo.reportStatus }</td>
									<td>${vo.bigo }
									<c:if test="${vo.reportStatus != '처리완료'}">
									<button id="processBtn${st.count}" onclick="reportProcess('${vo.idx}','${vo.part}','${vo.reportContentIdx}','${vo.reporterId}','${vo.reportPart}','${vo.reporterMail}','${vo.reportStatus}','${st.count}')">처리하기</button>
									</c:if>
									</td>
								</tr>
								</c:forEach>
							</table>			          
							<!-- 페이징처리 시작 -->
								<div class="text-center">
								  <ul class="pagination justify-content-center">
								    <c:if test="${pageVO.pag > 1}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminReport?pag=1&searchStr=${pageVO.searchStr}&part=${pageVO.part}">첫페이지</a></li>
								    </c:if>
								    <c:if test="${pageVO.curBlock > 0}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminReport?pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">이전블록</a></li>
								    </c:if>
								    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
								      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
								    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/adminReport?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
								    	</c:if>
								      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
								    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminReport?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
								    	</c:if>
								    </c:forEach>
								    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminReport?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">다음블록</a></li>
								    </c:if>
								    <c:if test="${pageVO.pag < pageVO.totPage}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminReport?pag=${pageVO.totPage}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">마지막페이지</a></li>
								    </c:if>
								  </ul>
								</div>
								<!-- 페이징처리 끝 -->  
            </div>
            
            
        <div class="modal " id="reportProcessModal" >
				  <div class="modal-dialog modal-lg">
				    <div class="modal-content">
				    
				      <div class="modal-header" >
				        <h4 class="modal-title">신고처리</h4>
				        <button type="button" class="close" onclick="$('#reportProcessModal').hide();">&times;</button>
				      </div>
				      
				      <div class="modal-body" >
								<table class="table ">
									<tr>
										<th>
											<select id="reportStatus" onchange="process(1)" class="form-control">
												<option>진행상태</option>
												<option>처리중</option>
												<option>처리완료</option>
												<option>보류중</option>
											</select>	
										</th>
										<td>
							      	<button class="form-control">진행 상태 변경</button>
							      </td>
									</tr>
									<tr>
										<th>
											<select id="reportStop" onchange="process(2)" class="form-control">
												<option>제재</option>
												<option>1일 게시물 게시정지</option>
												<option>3일 게시물 게시정지</option>
												<option>한달 게시물 게시정지</option>
												<option>계정 영구 정지</option>
											</select>
										</th>
										<td>
				      				<button class="form-control">신고자 제재</button>
										</td>
									</tr>
								</table>
								<span id="processDemo"></span>
						  </div>
				
				      <div class="modal-footer" >
				      </div>
				    </div>
				  </div>
				</div>

<script type="text/javascript">
	'use strict'
	
	var idx = '';
	var part = '';
	var reportContentIdx = '';
	var reporterId = '';
	var reportPart = '';
	var reporterMail = '';
	var reportStatus = '';
	var reCnt = 0;
	
	
	function reportProcess(rIdx,rPart,rReportContentIdx,rReporterId,rReportPart,rReporterMail,rReportStatus,cnt){
		idx = rIdx;   
		part = rPart;  
		reportContentIdx = rReportContentIdx;
		reporterId = rReporterId;
		reportPart = rReportPart;
		reporterMail = rReporterMail; 	
		reportStatus = rReportStatus;
		reCnt = cnt;
		
		$("#reportProcessModal").show();
	} 
	
	function process(sw){
		
		if(sw == 1){// 진행상태 변경
			reportStatus = $("#reportStatus").val();
		
			if(reportStatus == '진행상태'){
				return;
			}
		
			let query = {
					idx, 
					part,
					reportContentIdx,
					reporterId,
					reportPart,
					reporterMail,
					reportStatus,
			}
		
			$.ajax({
				type : 'post',
				url  : '${ctp}/admin/reportStatusUpdate',
				data : query,
				success : function (){
					Swal.fire({
						title : '상태가 변경되었습니다.',
						icon : 'success'
					});
					setTimeout(function(){location.reload();},1000)
				},
				error : function (){
					Swal.fire({
						title : '전송 오류',
						icon : 'error'
				});
			}
		});			
			
			
			if(reportStatus == '처리완료'){
				
				$("#processBtn"+reCnt).prop('disabled',false);
				
				$.ajax({
					type : 'post',
					url  : '${ctp}/admin/reportComplete',
					data : query,
					success : function(){
						console.log('신고처리완료 안내메일 발송');
					},
					error : function(){
						Swal.fire({
							title : '전송오류',
							icon : 'error'
						});
					}
				}); 
				
				
			}
			
		}
		else { // 신고자 제재
			
			reportStatus = $("#reportStop").val();
		
			if(reportStatus == '제재'){
				return;
			}
			
			let query = {
					idx, 
					part,
					reportContentIdx,
					reporterId,
					reportPart,
					reporterMail,
					reportStatus,
			}
			
			$.ajax({
				type : 'post',
				url  : '${ctp}/admin/reportMemberStatusUpdate',
				data : query,
				success : function(){
					Swal.fire({
						title : reportStatus+'처분을 내렸습니다.',
						icon  : 'success'
					});
				},
				error : function(){
					Swal.fire({
						title : '전송오류',
						icon  : 'error'
					});
				}
				
			});
			
		}
	}
	
	
	
	function reportContentShow(idx,reportReason){
		
		$.ajax({
			type : 'post',
			url  : '${ctp}/admin/reportContentMemberGet',
			data : {idx:idx},
			success : function (vo){
				$("#titleDemo").html(vo.re_Title);
				$("#idDemo").html(vo.re_Id);
				$("#contentDemo").html(vo.re_Content);
				$("#typeDateDemo").html(vo.re_ScreenType+" &nbsp;"+vo.re_Date.substring(0,10));
				
				let rating = '<span style="color: #f90;">';
				
				for(let i = 0 ; i < vo.re_Rating; i++){
					rating += '&#9733;';
				}				
				rating += '</span>';
				
				$("#ratingDemo").html(rating);
				
				$("#reportReasonDemo").val(reportReason);
				
				$("#reportContentModal").show();
				
				
			},
			error : function (){
				Swal.fire({
					title : '전송 오류',
					icon : 'error'
				});				
			}
		});
		
	}
	
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
				 let gender = vo.mem_scNumber.substr(7,1);
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
				 $("#memberInforModal").show();
			 },
			 error : function(){
				 Swal.fire({
					 title: '전송 오류 !!',
					 icon: 'error',
				 });
			 }
		 });
		 
	 }
	
</script>
				<div class="modal " id="reportContentModal" >
				  <div class="modal-dialog modal-lg">
				    <div class="modal-content">
				    
				      <div class="modal-header" >
				        <h4 class="modal-title">신고접수된 게시물</h4>
				        <button type="button" class="close" onclick="$('#reportContentModal').hide();">&times;</button>
				      </div>
				      
				      <div class="modal-body" >
				      	 <div id="accordion" class="accordion-style">
                      <div class="card mb-3">
                          <div class="card-header" id="heading">
                              <h5 class="mb-0">
                                  <button class="btn btn-link" data-bs-toggle="collapse" data-bs-target="#collapse${i}" aria-expanded="true" aria-controls="collapse${i}">
                                  <span class="text-theme-secondary me-2"><span id="idDemo"></span>😊
                                  </span>
                                  	<span id="titleDemo"></span> 
      	                          </button>
                              </h5>
                          </div>
                          <div id="collapse" class="collapse show" aria-labelledby="heading" data-bs-parent="#accordion">
                              <div class="card-body">
                              	<p style="color: #666" id="contentDemo"></p>
                       					<p style="font-weight: bolder;color: #666"><span id="typeDateDemo"></span>| 좋아요<a href="javascript:GoodCheck()">❤️</a> ${rVo.re_Good} | 
												<span id="ratingDemo"></span>
												</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <h3>신고 사유</h3>
                  <textarea rows="5" readonly="readonly" class="form-control" id="reportReasonDemo"></textarea>
						  </div>
				
				      <div class="modal-footer" >
				      </div>
				    </div>
				  </div>
				</div>
<!-- 회원 상세 정보 모달 -->
				<div class="modal " id="memberInforModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #97c2ef">
				        <button type="button" class="close" onclick="$('#memberInforModal').hide()">&times;</button>
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
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
      </div>

<jsp:include page="/WEB-INF/views/include/adminfooter.jsp"></jsp:include>
</body>

</html>