<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>DASHMIN - Bootstrap Admin Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"></jsp:include>
</head>
<script type="text/javascript">
	'use strict'
	
	$(function(){
		let msw = '${sw}';
		let addForm = '';
		if(msw == '1'){ // 쿠폰 관리 뷰
			addForm += '<h2>쿠폰 관리</h2>'
			addForm += '<table class="table" style="padding:10px">';
			addForm += '<tr>';
			addForm += '<th>쿠폰이름</th>';
			addForm += '<td><input type="text" id="couponName" class="form-control"/><td>';
			addForm += '</tr>';
			addForm += '<tr>';
			addForm += '<th>쿠폰할인%</th>';
			addForm += '<td><select id="couponPersent" class="form-control">';
			for(let i = 1; i <= 6; i++){
				addForm += '<option value="'+i+'">'+i+'%</option>';
			}
			addForm += '</select><td>';
			addForm += '</tr>';
			addForm += '<tr>';
			addForm += '<th colspan="2"><button onclick="couponCreate()" class="form-control">쿠폰발급</button></th>';
			addForm += '</tr>';
			addForm += '</table>';
					
			
			
			$("#pointCouponDemo").html(addForm);
			return;
		}
		else if(msw == '2') {         // 포인트 관리 뷰
			
				addForm += '<h2>포인트 관리</h2>'
				addForm += '<table class="table" style="padding:10px">';
				addForm += '<tr>';
				addForm += '<th>포인트</th>';
				addForm += '<td><input type="number" id="pointNumber" class="form-control"/><td>';
				addForm += '</tr>';
				addForm += '<tr>';
				addForm += '<th colspan="2"><button onclick="pointJucklip()" class="form-control">포인트지급</button></th>';
				addForm += '</tr>';
				addForm += '</table>';
			$("#pointCouponDemo").html(addForm);
		}
	
	})
	
</script>
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
	
	function keyEvent(sw){
		let keyCode = event.keyCode;
		if(keyCode == 13){
			let searchStr = $("#textBox").val();
			let part = $("#part").val();
			
			
			if(sw == '1'){
				location.href="${ctp}/admin/adminPointCoupon?searchStr="+searchStr+"&part="+part+"&sw=1";			
			}
			else {
				location.href="${ctp}/admin/adminPointCoupon?searchStr="+searchStr+"&part="+part+"&sw=2";			
			}
		}
	}	
	
	
	function couponCreate(){
		let c_id = $("#memberList").val(); 
		let c_name = $("#couponName").val();
		let c_content = $("#couponPersent").val();
		
		let query = {
				c_id,
				c_name,
				c_content
		}
		
		
		if(c_id == '회원목록'){
			Swal.fire({
				title : '생성한 쿠폰을 발급받을 회원을 골라주세요.',
				icon  : 'info'
			});
			return
		}
		else if(c_name == ''){
			Swal.fire({
				title : '발급하실 쿠폰의 이름을 입력해주세요.',
				icon  : 'info'
			});
			return
		}
		else if(c_content == ''){
			Swal.fire({
				title : '발급하실 쿠폰의 할인율을 입력해주세요.',
				icon  : 'info'
			});
			return
		}
		else {
			$.ajax({
				type : 'post',
				url  : '${ctp}/admin/couponCreate',
				data : query,
				success : function(){
					Swal.fire({
						title : c_id+'님에게 쿠폰발급 완료되었습니다.',
						icon  : 'success'
					});
					setTimeout(function(){
						location.reload();
					},1000);
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
	
	function pointJucklip(){
		let id = $("#memberList").val(); 
		let point = $("#pointNumber").val();
		
		let query = {
				id,
				point
		}
		
		if(id == '회원목록'){
			Swal.fire({
				title : '생성한 쿠폰을 발급받을 회원을 골라주세요.',
				icon  : 'info'
			});
			return;
		}
		else if(point == 0){
			Swal.fire({
				title : '지급할 포인트를 입력해주세요.',
				icon  : 'info'
			});
			return;
		}
		
		$.ajax({
			type : 'post',
			url  : '${ctp}/admin/adminPointJuckLip',
			data : query,
			success : function(){
				Swal.fire({
					title : '정상적으로 적립되었습니다.',
					icon  : 'success'
				});
				setTimeout(function(){location.reload()},1000);
			},
			error : function(){
				Swal.fire({
					title : '전송 실패',
					icon  : 'error'
				});
			}
			
		});
		
	}
	let i = 0;
	var ridx = 0;
	function btnShow(cnt,idx){
		ridx = idx;
		if(i % 2 == 0){
			$("#btnsDemo"+cnt).html('<button type="button" onclick="couponDelete()">삭제</button>');
		}
		else {
			$("#btnsDemo"+cnt).html('');
		}
		i++
	}
	
	function couponDelete(){
		
		$.ajax({
			type : 'post',
			url  : '${ctp}/admin/adminCouponDelete',
			data : {idx:ridx},
			success : function (){
				Swal.fire({
					title : '쿠폰이 삭제되었습니다.',
					icon  : 'success'
				});
				setTimeout(function (){
					location.reload();
				},1000);
			},
			error : function(){
				Swal.fire({
					title : '전 송 오 류',
					icon  : 'error'
				});
			}
		});
		
	}
	var rridx = 0;
	var rrpoint = 0;
	function btnShow2(cnt,idx,point){
		rridx = idx;
		rrpoint = point;
		if(i % 2 == 0){
			$("#btnsDemo2"+cnt).html('<button type="button" onclick="pointDeduction()">차감</button>');
		}
		else {
			$("#btnsDemo2"+cnt).html('');
		}
		i++
	}
	
	function pointDeduction(){
		var totPoint = 0;
		(async () => {
		    const { value: res } = await Swal.fire({
		        title: '차감하실 포인트를 입력해주세요.',
		        input: 'number',
		        inputPlaceholder: '포인트 입력..',
		        showCancelButton: true,
		        cancelButtonColor: '#d33',
		        cancelButtonText: '취소'
		    })
		 
		    // 이후 처리되는 내용.
		    if (res) {
		    	totPoint = res;
		    	
		    	let query = {
		    			idx : rridx,
		    			point : totPoint
		    	}
		    	
		    $.ajax({
					type : 'post',
					url  : '${ctp}/admin/adminPointDeduction',
					data : query,
					success : function () {
						Swal.fire({
							title : '해당 회원의 포인트가 '+totPoint+'점 차감되었습니다.',
							icon  : 'success'
						});
						setTimeout(function(){
							location.reload();
						},1000);
					},
					error : function () {
						Swal.fire({
							title : '전송오류',
							icon  : 'error'
						});				
					}
				}); 
		    }
		})() 
		
		/* 포인트 입력받고 그만큼 차감 */
		
	}
	
</script>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
      	<jsp:include page="/WEB-INF/views/include/adminNav.jsp"></jsp:include>

            <div class="container-fluid pt-4 px-4">	
							<div class="row">
								<div class="col">
									<table class="table">
										<tr>
											<th><a href="javascript:demoView(1);">쿠폰</a></th>
											<th><a href="javascript:demoView(2)">포인트</a></th>
										</tr>
									 </table>
								</div>
								<div class="col">
									<select id="memberList" class="form-control">
										<option>회원목록</option>
										<c:forEach var="mvo" items="${mvos}">
										<option>${mvo.mem_id}</option>
										</c:forEach>										
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<div id="pointCouponDemo" style="width: 100%;height: 250px;background-color: #eee"></div>
									<c:if test="${sw == 1}">
									<table class="table">
										<tr>
											<th>쿠폰코드</th>
											<th>쿠폰이름</th>
											<th>아이디</th>
											<th>할인</th>
											<th>발급일</th>
											<th>사용기간</th>
											<th>상태</th>
										</tr>
										<c:forEach var="cvo" items="${cvos}" varStatus="st">
										<tr>
											<td>${cvo.c_cd }</td>
											<td>${cvo.c_name }</td>
											<td>${cvo.c_id }</td>
											<td>${cvo.c_content }%</td>
											<td>${fn:substring(cvo.c_startDate,0,10) }</td>
											<td>${fn:substring(cvo.c_lastDate,0,10) }</td>
											<td>
												<p>${cvo.c_status }
												<a href="javascript:btnShow(${st.count },${cvo.idx})">...</a>
												<span id="btnsDemo${st.count }"></span>
												</p>
											</td>
										</tr>
										</c:forEach>
									</table>
										<!-- 페이징처리 시작 -->
								<div class="text-center">
								  <ul class="pagination justify-content-center">
								    <c:if test="${pageVO.pag > 1}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=1&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">첫페이지</a></li>
								    </c:if>
								    <c:if test="${pageVO.curBlock > 0}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">이전블록</a></li>
								    </c:if>
								    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
								      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
								    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/adminPointCoupon?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">${i}</a></li>
								    	</c:if>
								      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
								    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">${i}</a></li>
								    	</c:if>
								    </c:forEach>
								    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">다음블록</a></li>
								    </c:if>
								    <c:if test="${pageVO.pag < pageVO.totPage}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${pageVO.totPage}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">마지막페이지</a></li>
								    </c:if>
								  </ul>
										<select name="part" id="part" class="form-control">
	                		<option value="c_id">아이디</option>
	                		<option value="c_name">쿠폰이름</option>
	                		<option value="c_status">쿠폰상태</option>
	                	</select>
	                	<div class="input-group">
	                    <div class="input-group-prepend">
	                        <span class="input-group-text"><i class="fa fa-search"></i></span>
	                    </div>
	                    <input type="text" id="textBox" onkeyup="keyEvent(this,1)" name="searchStr" class="form-control" placeholder="Search..." >
		                </div>								
		               </div>
								<!-- 페이징처리 끝 -->
									</c:if>
									<c:if test="${sw == 2}">
									<table class="table">
										<tr>
											<th>회원아이디</th>
											<th>회원닉네임</th>
											<th>회원포인트</th>
											<th>회원상태</th>
										</tr>
										<c:forEach var="memvo" items="${memvos}" varStatus="st">
										<tr>
											<td>${memvo.mem_id }</td>
											<td>${memvo.mem_nickName }</td>
											<td>${memvo.mem_point }</td>
											<td>
												${memvo.mem_mStatus }
												<a href="javascript:btnShow2(${st.count },${memvo.mem_idx},${memvo.mem_point })">...</a>
												<span id="btnsDemo2${st.count }"></span>
											</td>
										</tr>
										</c:forEach>
									</table>
										<!-- 페이징처리 시작 -->
								<div class="text-center">
								 <ul class="pagination justify-content-center">
								    <c:if test="${pageVO.pag > 1}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=1&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">첫페이지</a></li>
								    </c:if>
								    <c:if test="${pageVO.curBlock > 0}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">이전블록</a></li>
								    </c:if>
								    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
								      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
								    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/adminPointCoupon?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">${i}</a></li>
								    	</c:if>
								      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
								    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">${i}</a></li>
								    	</c:if>
								    </c:forEach>
								    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">다음블록</a></li>
								    </c:if>
								    <c:if test="${pageVO.pag < pageVO.totPage}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/adminPointCoupon?pag=${pageVO.totPage}&searchStr=${pageVO.searchStr}&part=${pageVO.part}&sw=${sw}">마지막페이지</a></li>
								    </c:if>
								  </ul>
								  <select name="part" id="part" class="form-control">
	                		<option value="mem_id">아이디</option>
	                		<option value="mem_nickName">닉네임</option>
	                		<option value="mem_mStatus">상태</option>
	                	</select>
	                	<div class="input-group">
	                    <div class="input-group-prepend">
	                        <span class="input-group-text"><i class="fa fa-search"></i></span>
	                    </div>
	                    <input type="text" id="textBox" onkeydown="keyEvent(this,2)" name="searchStr" class="form-control" placeholder="Search..." >
		                </div>
								</div>
								<!-- 페이징처리 끝 -->
									</c:if>
								</div>
							</div>            	
            </div>
<script type="text/javascript">
	'use strict'
	
	function demoView(sw){
		
	location.href="${ctp}/admin/adminPointCoupon?sw="+sw;		
		
	}
	
</script>



            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Your Site Name</a>, All Right Reserved. 
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                    </div>
                </div>
            </div>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
      </div>

<jsp:include page="/WEB-INF/views/include/adminfooter.jsp"></jsp:include>
</body>

</html>