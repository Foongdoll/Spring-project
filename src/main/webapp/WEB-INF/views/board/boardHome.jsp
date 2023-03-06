<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<script type="text/javascript">
	'use strict'
	
	$(function(){
		if('${sw}' == '1'){
			Swal.fire({
				title : '글쓰기에 성공하셨습니다.',
				icon  : 'success'
			});
		}
	})
</script>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
		<section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${ctp}/resources/img/bg-img/교섭.jpg);">
        <div class="bradcumbContent">
            <h2>영화 게시판</h2>
            <p>궁금한 영화의 자세한 부분까지 한번에 !</p>
        </div>
    </section>
    
    <section class="contact-area section-padding-0-100" style="margin-top: 100px">
        <div class="container">
        	<table class="table">
        		<tr>
        			<th>번호</th>
        			<th>제목</th>
        			<th>글쓴이</th>
        			<th>날짜</th>
        			<th>조회수</th>
        		</tr>
        		<tr>
        			<td colspan="5"><hr/></td>
        		</tr>
        		<c:forEach var="vo" items="${vos}">
        			<tr>	
        				<td>${vo.idx }</td>
        				<td><a href="javascript:contentGo(${vo.idx},${pageVO.pag})">${vo.b_title }</a></td>
        				<td>${vo.b_writer }</td>
        				<td>${vo.b_date }</td>
        				<td>${vo.b_readNum }</td>
        			</tr>
        		</c:forEach>
        		<tr>
        			<th>
        				<button type="button" onclick="location.href='${ctp}/board/boardWrite'">글쓰기</button>
        			</th>
        		</tr>
        	</table>
        	<!-- 페이징처리 시작 -->
					<div class="text-center">
					  <ul class="pagination justify-content-center">
					    <c:if test="${pageVO.pag > 1}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardHome?pag=1&searchStr=${pageVO.searchStr}&part=${pageVO.part}">첫페이지</a></li>
					    </c:if>
					    <c:if test="${pageVO.curBlock > 0}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardHome?pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">이전블록</a></li>
					    </c:if>
					    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
					      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/board/boardHome?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
					    	</c:if>
					      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardHome?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
					    	</c:if>
					    </c:forEach>
					    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardHome?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">다음블록</a></li>
					    </c:if>
					    <c:if test="${pageVO.pag < pageVO.totPage}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardHome?pag=${pageVO.totPage}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">마지막페이지</a></li>
					    </c:if>
					  </ul>
					</div>
					<!-- 페이징처리 끝 -->
        </div>
    </section>

<script type="text/javascript">
	'use strict'
	
	function contentGo(idx,pag){
		
		if('${sId}' == ''){
			Swal.fire({
				title : '로그인하신 후 게시글을 읽으실 수 있습니다.',
				icon  : 'info'
			});
			return;
		}
		
		location.href="${ctp}/board/boardContent?contentIdx="+idx+"&contentPag="+pag;
	}
</script>

<jsp:include page="/WEB-INF/views/include/chatting.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/loginModal.jsp"></jsp:include> 
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>	
</body>
</html>