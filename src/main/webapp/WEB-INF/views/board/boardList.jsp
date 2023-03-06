<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	
	 function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/board/boardList?pageSize="+pageSize+"&pag=${pageVo.pag}";
    }
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
        	<table class="table table-borderless">
				    <tr>
				      <td class="text-left p-0">
				        <a href="${ctp}/board/boardInput?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="btn btn-secondary btn-sm">글쓰기</a>
				      </td>
				      <td class="text-right p-0">
				        <select name="pageSize" id="pageSize" onchange="pageCheck()">
				          <option value="5"  ${pageVo.pageSize==5  ? 'selected' : ''}>5건</option>
				          <option value="10" ${pageVo.pageSize==10 ? 'selected' : ''}>10건</option>
				          <option value="15" ${pageVo.pageSize==15 ? 'selected' : ''}>15건</option>
				          <option value="20" ${pageVo.pageSize==20 ? 'selected' : ''}>20건</option>
				        </select>
				      </td>
				    </tr>
				  </table>
        	<table class="table table-hover text-center">
				    <tr class="table-dark text-dark">
				      <th>글번호</th>
				      <th>글제목</th>
				      <th>글쓴이</th>
				      <th>글쓴날짜</th>
				      <th>조회수</th>
				      <th>좋아요</th>
				    </tr>
				  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
				    <c:forEach var="vo" items="${vos}">
				    	<tr>
				    	  <td>${curScrStartNo}</td>
				    	  <td class="text-left">
				    	    <a href="${ctp}/board/boardContent?idx=${vo.idx}&pageSize=${pageVO.pageSize}&pag=${pageVO.pag}">${vo.title}</a>
				    	    <c:if test="${vo.replyCount != 0}">(${vo.replyCount})</c:if>
				    	    <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
				    	  </td>
				    	  <td>${vo.nickName}</td>
				    	  <%-- <td>${fn:substring(vo.WDate,0,10)}(${vo.day_diff})</td> --%>
				    	  <%-- <td>${vo.day_diff > 0 ? fn:substring(vo.WDate,0,10) : fn:substring(vo.WDate,11,19)}</td> --%>
				    	  <%-- <td>${vo.hour_diff > 24 ? fn:substring(vo.WDate,0,10) : fn:substring(vo.WDate,11,19)}</td> --%>
				    	  <td>
				    	    <!-- 1일(24시간)이 지난것은 날짜만표시, 1일(24시간)이내것은 시간을 표시하되, 24시간 이내중 현재시간보다 이후시간은 날짜와 시간을 함께 표시 -->
				    	    <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
				    	    <%-- 
				    	    <c:if test="${vo.hour_diff < 24}">
				    	      <c:if test="${vo.day_diff le 0}">${fn:substring(vo.WDate,11,19)}</c:if>
				    	      <c:if test="${vo.day_diff > 0}">${fn:substring(vo.WDate,0,19)}</c:if>
				    	    </c:if>
				    	     --%>
				    	    <c:if test="${vo.hour_diff < 24}">
				    	      ${vo.day_diff > 0 ? fn:substring(vo.WDate,0,16) : fn:substring(vo.WDate,11,19)}
				    	    </c:if>
				    	  </td>
				    	  <td>${vo.readNum}</td>
				    	  <td>${vo.good}</td>
				    	</tr>
				    	<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
				    </c:forEach>
				    <tr><td colspan="6" class="m-0 p-0"></td></tr>
				  </table>
        	<!-- 페이징처리 시작 -->
					<div class="text-center">
					  <ul class="pagination justify-content-center">
					    <c:if test="${pageVO.pag > 1}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pag=1&searchStr=${pageVO.searchStr}&part=${pageVO.part}">첫페이지</a></li>
					    </c:if>
					    <c:if test="${pageVO.curBlock > 0}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pag=${(pageVO.curBlock-1)* pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">이전블록</a></li>
					    </c:if>
					    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
					      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
					    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/board/boardList?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
					    	</c:if>
					      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
					    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pag=${i}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">${i}</a></li>
					    	</c:if>
					    </c:forEach>
					    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">다음블록</a></li>
					    </c:if>
					    <c:if test="${pageVO.pag < pageVO.totPage}">
					      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pag=${pageVO.totPage}&searchStr=${pageVO.searchStr}&part=${pageVO.part}">마지막페이지</a></li>
					    </c:if>
					  </ul>
					</div>
					<!-- 페이징처리 끝 -->
        </div>
    </section>

<script type="text/javascript">
	'use strict'
	
	function writeGo(){
		if('${sId}' == ''){
			Swal.fire({
				title : '로그인하신 후 게시글을 작성하실 수 있습니다.',
				icon  : 'info'
			});
			return;
		}
		location.href='${ctp}/board/boardWrite'
	}
	
	
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