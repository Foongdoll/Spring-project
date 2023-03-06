<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script src="${ctp}/resources/js/ckeditor/ckeditor.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
		<section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${ctp}/resources/img/bg-img/교섭.jpg);">
        <div class="bradcumbContent">
            <h2>영화 상세보기</h2>
            <p>궁금한 영화의 자세한 부분까지 한번에 !</p>
        </div>
    </section>
    
    <section class="contact-area section-padding-0-100" style="margin-top: 100px">
        <div class="container">
				  <form name="boardform" action="${ctp}/board/boardInput" method="post">
				    <h2 class="text-center">게시판 글쓰기</h2>
				    <br/>
				    <table class="table table-bordered">
				      <tr>
				        <th>글쓴이</th>
				        <td>${sNickName}</td>
				      </tr>
				      <tr>
				        <th>글제목</th>
				        <td><input type="text" name="title" id="title" placeholder="글제목을 입력하세요" autofocus required class="form-control"/></td>
				      </tr>
				      <tr>
				        <th>글내용</th>
				        <td><textarea rows="6" name="content" id="content" class="form-control" required></textarea></td>
				        <script>
				          CKEDITOR.replace("content",{
				        	  height:500,
				        	  filebrowserUploadUrl:"${ctp}/board/imageUpload",
				        	  uploadUrl : "${ctp}/board/imageUpload"
				          });
				        </script> 
				      </tr>
				      <tr>
				        <td colspan="2" class="text-center">
				          <input type="button" value="글올리기" onclick="sm()" class="btn btn-success"/> &nbsp;
				          <input type="reset" value="다시입력" class="btn btn-warning"/> &nbsp;
				          <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
				        </td>
				      </tr>
				    </table>
				    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
				    <input type="hidden" name="mid" value="${sMid}"/>
				    <input type="hidden" name="nickName" value="${sNickName}"/>
				  </form>
        </div>
    </section>

<script type="text/javascript">
	'use strict'
	
	function sm(){
		let content = CKEDITOR.instances.content.getData();
		let part = $("#part").val();
		let title = $("#title").val();
		
		if(title == ''){
			Swal.fire({
				title : '제목을 입력해주세요.',
				icon  : 'info'
			});
			return;
		}
		else if(content == ''){
			Swal.fire({
				title : '내용을 입력해주세요.',
				icon  : 'info'
			});
			return;
		}
		else{
			boardform.submit();
		} 
		
	}
</script>
<jsp:include page="/WEB-INF/views/include/chatting.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/loginModal.jsp"></jsp:include> 
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>	
</body>
</html>