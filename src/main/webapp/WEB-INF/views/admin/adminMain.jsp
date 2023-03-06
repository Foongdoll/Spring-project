<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>관리자</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"></jsp:include>
</head>
<script type="text/javascript">
	'use strict'
	
	$(function(){
		let res = '';
		<c:forEach var="seat" items="${seatVos}"  varStatus="st">
			$("#tvoSeatDemo${st.index}").html('${seat}');
		</c:forEach>
	});
</script>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
		<jsp:include page="/WEB-INF/views/include/adminNav.jsp"></jsp:include>
     <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-line fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘 총 방문자 수</p>
                                <h6 class="mb-0">${avo.today}</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘 결제 총 금액</p>
                                <h6 class="mb-0">${avo.todayAmount}</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-area fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘 회원가입자 수</p>
                                <h6 class="mb-0">${avo.todayJoin}</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">전체 총 방문자 수</p>
                                <h6 class="mb-0">${avo.allDay}</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">자유게시판</h6>
                                <a href="${ctp}/board/boardList">more</a>
                            </div>
                            <div>
                            	<table class="table">
                            		<tr>
                            			<th>번호</th>
                            			<th>제목</th>
                            			<th>글쓴이</th>
                            			<th>시간</th>
                            			<th>조회수</th>
                            		</tr>
                            		<c:forEach var="bvo" items="${bvos}">
                            		<tr>
                            			<td>${bvo.idx }</td>
                            			<td><a href="${ctp}/board/boardContent?idx=${bvo.idx}">${bvo.title }</a></td>
                            			<td>${bvo.nickName }</td>
                            			<td>${fn:substring(bvo.WDate,0,10) }</td>
                            			<td>${bvo.readNum }</td>
                            		</tr> 
                            		</c:forEach>
                            	</table>
                            </div>
                            <canvas id="worldwide-sales"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">신고내역</h6>
                                <a href="${ctp}/admin/adminReport">more</a>
                            </div>
                            <div>
                            		<table class="table">
                            			<tr>
                            				<th>분류</th>
                            				<th>신고게시물번호</th>
                            				<th>신고자아이디</th>
                            				<th>신고상태</th>
                            			</tr>
                            	<c:forEach var="rvo" items="${rvos}">
                            			<tr>
                            				<td>${rvo.part }</td>
                            				<td>${rvo.reportContentIdx }</td>
                            				<td>${rvo.reporterId }</td>
                            				<td>${rvo.reportStatus }</td>
                            			</tr>
                            	</c:forEach>
                            		</table>
                            </div>
                            <canvas id="salse-revenue"></canvas>
                        </div>
                    </div>
                </div>
            </div>


            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <span class="mb-0" style="font-size: 1.5em;font-weight: bolder">실시간 예매 현황(최신순)</span><span style="float: right"><a href="${ctp}/admin/ticket">전체보기</a></span>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                   <th scope="col">티켓코드</th>
                                   <th scope="col">예매자</th>
                                   <th scope="col">영화이름</th>
                                   <th scope="col">영화관</th>
                                   <th scope="col">날짜/시간</th>
                                   <th scope="col">자리</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="tvo" items="${tvos}" varStatus="st">
                                <tr>
                                   <td>${tvo.tk_cd }</td>
                                   <td>${tvo.tk_Id}</td>
                                   <td>${tvo.tk_movieName }</td>
                                   <td>${tvo.tk_town }</td>
                                   <td>${tvo.tk_screenDate}/${tvo.tk_screenTime}</td>
                                   <td><span id="tvoSeatDemo${st.index}"></span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <!-- Widgets Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-md-6 col-xl-4">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h6 class="mb-0">Messages</h6>
                                <a href="">Show All</a>
                            </div>
						                   <div class="card chat-app" >
									            <div id="plist" class="people-list" >
									                <div class="input-group">
									                    <div class="input-group-prepend">
									                        <span class="input-group-text"><i class="fa fa-search"></i></span>
									                    </div>
									                    <input type="text" class="form-control" placeholder="Search...">
									                </div>
									                <ul class="list-unstyled chat-list mt-2 mb-0" >
									                <c:if test="${empty senders}">받은 메시지가 없습니다.<img src="${ctp}/images/신사어피치.png" /> </c:if>
									                <c:if test="${!empty senders}">
									                <c:forEach var="sender" items="${senders}" varStatus="st">
									                <c:if test="${st.count == 6}"><c:set var="st.count" value="1"></c:set></c:if>
									                    <li class="clearfix">
									                    	<a href="javascript:chatRoomGo('${sender.sender}')">
									                        <img src="https://bootdey.com/img/Content/avatar/avatar${st.count}.png" alt="avatar" style="width: 50px">
									                        <div class="about">
								                            <div class="name">${sender.sender}</div>
								                            <div class="status">
								                            	<c:forEach var="mvo" items="${mvos}">
								                            	<c:if test="${sender.sender == mvo.mem_nickName}">
								                            	<c:if test="${mvo.mem_onoff == 0}">
								                            		<i class="fa fa-circle offline"></i>
							                            		</c:if>
								                            	<c:if test="${mvo.mem_onoff == 1}">
								                            		<i class="fa fa-circle online"></i>
							                            		</c:if>
							                            		</c:if>
								                            	</c:forEach>
								                            	</div>       
									                        </div>
								                       	</a> 
									                    </li>
									                 </c:forEach>
									                 </c:if>
									                </ul>
									            </div>
									          </div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6 col-xl-4">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">Calender</h6>
                                <a href="">Show All</a>
                            </div>
                            <div id="calender"></div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6 col-xl-4">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">이번달티켓판매량</h6>
                            </div>
                            <c:forEach var="tottkvo" items="${tottkvos}">
	                            <div class="d-flex align-items-center border-bottom py-2">
	                                <div class="w-100 ms-3">
	                                    <div class="d-flex w-100 align-items-center justify-content-between">
	                                        <span>${tottkvo.tk_movieName}&nbsp; ${tottkvo.tk_saleCnt}장</span>
	                                        <button class="btn btn-sm"><i class="fa fa-times"></i></button>
	                                    </div>
	                                </div>
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Widgets End -->


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
                        </br>
                        Distributed By <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
    </div>
<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
<jsp:include page="/WEB-INF/views/include/adminfooter.jsp"></jsp:include>
</body>
</html>