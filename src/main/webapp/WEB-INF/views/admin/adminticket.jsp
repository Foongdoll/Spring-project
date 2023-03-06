<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>예매관리</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
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
	
	$(document).ready(function(){
		let tic = '';
		<c:forEach var="svo" items="${vos}" varStatus="st">
		if("${svo.tk_cancelSw}" == '0'){
			$("#ticketCancel${st.count}").html('정상');
		}
		else if("${svo.tk_cancelSw}" == '1'){
			$("#ticketCancel${st.count}").html('<button type="button" onclick="ticketCancel()">예매취소</button><input type="hidden" id="ticketCd" value="${svo.tk_cd}"/><input type="hidden" id="cnt" value="${st.count}"/>');
		}		
		else if("${svo.tk_cancelSw}" == '2'){
			$("#ticketCancel${st.count}").html('취소완료');
		}		
		
		</c:forEach>
	});
	
	function ticketCancel(){
		let cd = $("#ticketCd").val();
		let cnt = $("#cnt").val();
		
		$.ajax({
			type : "post",
			url  : "${ctp}/admin/ticketCancel",
			data : {cd:cd},
			success : function(){
				Swal.fire({
					title: '취소/환불처리되었습니다.',
					icon : 'success'
				});
				setTimeout(function(){location.reload()},1500)
			},
			error : function(){
				Swal.fire({
					title : "전송 오류",
					icon  : "error"
				});
			}
		});
				
	}
	
</script>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
<jsp:include page="/WEB-INF/views/include/adminNav.jsp"></jsp:include>

            <div class="container-fluid pt-4 px-4">
            	<table class="table table-hover" style="text-align: center">
            		<tr>
            			<th>상태</th>
            			<th>티켓고유번호</th>
            			<th>영화</th>
            			<th>영화관</th>
            			<th>상영시간</th>
            			<th>자리</th>
            			<th>성인</th>
            			<th>청소년</th>
            			<th>어린이</th>
            			<th>우대</th>
            			<th>가격</th>
            			<th>구매한회원아이디</th>
            			<th>사용포인트</th>
            		</tr>
            		<c:forEach var="vo" items="${vos}" varStatus="st">
            		<tr>
            			<td>
            				<span id="ticketCancel${st.count}"></span>
            			</td>
            			<td>${vo.tk_cd}</td>
            			<td>${vo.tk_movieName}</td>
            			<td>${vo.tk_town}</td>
            			<td>${vo.tk_screenDate}/${vo.tk_screenTime}</td>
            			<td>
            			<c:forEach var="i" begin="0" end="${fn:length(fn:split(seats,'/'))}">
            			${fn:split(seats[i],'/')[i]}	
            			</c:forEach>
           				</td>
            			<td>${vo.tk_adultno }</td>
            			<td>${vo.tk_teenno }</td>
            			<td>${vo.tk_childno }</td>
            			<td>${vo.tk_preferentialno }</td>
            			<td>${vo.tk_totPrice }</td>
            			<td>${vo.tk_Id }</td>
            			<td>${vo.tk_usePoint }</td>
            		</tr>
            		</c:forEach>
            	</table>
            	<!-- 페이징처리 시작 -->
								<div class="text-center">
								  <ul class="pagination justify-content-center">
								    <c:if test="${pageVO.pag > 1}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/ticket?pag=1">첫페이지</a></li>
								    </c:if>
								    <c:if test="${pageVO.curBlock > 0}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/ticket?pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}">이전블록</a></li>
								    </c:if>
								    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
								      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
								    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}//admin/ticket?pag=${i}">${i}</a></li>
								    	</c:if>
								      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
								    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/ticket?pag=${i}">${i}</a></li>
								    	</c:if>
								    </c:forEach>
								    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/ticket?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li>
								    </c:if>
								    <c:if test="${pageVO.pag < pageVO.totPage}">
								      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/ticket?pag=${pageVO.totPage}">마지막페이지</a></li>
								    </c:if>
								  </ul>
								</div>
								<!-- 페이징처리 끝 -->
            </div>


            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Your Site Name</a>, All Right Reserved. 
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

  <jsp:include page="/WEB-INF/views/include/adminfooter.jsp"></jsp:include>
</body>

</html>