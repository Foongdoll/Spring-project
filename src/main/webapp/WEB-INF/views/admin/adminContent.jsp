<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>메인 헤더 이미지 바꾸기</title>
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
	
	
	$(function(){
		$("#imgDemo").html('<img id="preview"  style="width:200px;"/>');
	})
	
	function movieSelect(){
		$("#imgDemo").html('<img id="preview"  style="width:200px;"/>');
		$("#movieContent").val('');
		$("input:radio[name='raFile']").prop('checked',false);
	}
	
	
	var img = '';
	var asw = 0;
	
	function fileCheck(sw){
		asw = sw;
		if(sw == 1){//DB
			let movieTitle = $("#movieTitle").val();
			
			if(movieTitle == '영화목록'){
				Swal.fire({
					title : '영화를 선택해주세요.',
					text : '영화 선택 후 다시 눌러주세요.',
					imageUrl : '${ctp}/images/머쓱피치.png',
					imageWidth : 500,
					imageHeight: 400
				});
				return;
			}
							
			$.ajax({
				type : 'post',
				url  : '${ctp}/admin/dbFileGet',
				data : {movieTitle:movieTitle},
				async: false,
				success : function (vo){
					img = vo.img;
					
					$("#imgDemo").html('<img alt="'+vo.movieTitle+'" src="'+vo.img+'" style="width:200px;"/>');
					
				},
				error : function(){
					Swal.fire({
						title: '전송 오류',
						text : '삐비빅',
						icon : 'error'
					});
				}
			});
			
			
		}
		else { // 다른 이미지
			$("#imgDemo").html('<img id="preview"  style="width:200px;"/>');
			$("#fileDemo").html('<input type="file" name="file" id="file" onchange="readImage(this)"/>');		
			
			
		}
	}

	//이미지 띄우기
	function readImage(input) {
	    if(input.files && input.files[0]) {
	        const reader = new FileReader();
	        reader.onload = function(e){
	            const previewImage = document.getElementById("preview");
	            previewImage.src = e.target.result;
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	
	function movieInput(){
		let title = $("#movieTitle").val();
		let content = $("#movieContent").val();
		let location = $("#location").val();
		
		
		if(title == ''){
			Swal.fire({
				title : '영화를 골라주세요',
				imageUrl : '${ctp}/images/머쓱피치.png',
				imageWidth: 500,
				imageHeight: 400
			});
		}
		else if(content == ''){
			Swal.fire({
				title : '상세 정보를 입력해주세요',
				imageUrl : '${ctp}/images/머쓱피치.png',
				imageWidth: 500,
				imageHeight: 400
			});
		}
		
		
		
		if(asw == 1){
		
			let query = {
					title,
					content,
					img,
					location,
					asw
			}
			
			$.ajax({
				type : 'post',
				url  : '${ctp}/admin/adminContentInput',
				data : query,
				success : function(){
					Swal.fire({
						title : '등록 완료 !',
						icon  : 'success'						
					});
					
					setTimeout(function (){
						location.reload();
					},1000)
				},
				error : function(){
					Swal.fire({
						title : '전송 오류',
						icon : 'error'
					});					
				}
			});
			
		}		
		else {
			if($("#file")[0].files[0] == '' || $("#file")[0].files[0] == null){
				Swal.fire({
					title : '이미지 파일을 선택해주세요',
					imageUrl : '${ctp}/images/머쓱피치.png',
					imageWidth: 500,
					imageHeight: 400
				});
			} 
			
			var form = new FormData();
			form.append('file',$("#file")[0].files[0]);
			form.append('title',$("#movieTitle").val());	
			form.append('content',$("#movieContent").val());	
			form.append('location',$("#location").val())
			form.append('asw',asw);	
					
			alert($("#movieTitle").val());
			
			$.ajax({
				type : 'post',
				url  : '${ctp}/admin/mainContentInput2',
				processData : false,
				contentType : false,
				data : form,
				success : function(){
					Swal.fire({
						title : '메인 이미지 등록 성공',
						icon  : 'success'
					});					
					setTimeout(function(){location.reload()}, 2000);
				},
				error : function(){
					Swal.fire({
						title : '전송 오류',
						icon  : 'error'
					});					
				}
			});
			
			
			
		}
		
	}
	
	function movieDelete(movieTitle){
		Swal.fire({
            title: movieTitle+'를 메인에서 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '삭제',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
							$.ajax({
								type : 'post',
								url  : '${ctp}/admin/mainHeaderImgDelete',
								data : {movieTitle:movieTitle},
								success : function (){
									Swal.fire({
										title : movieTitle+'이 메인헤더에서 삭제되었습니다.',
										icon  : 'success'
									});
									
									setTimeout(function(){location.reload()}, 2000);
								},
								error : function (){
									Swal.fire({
										title : '전 송 오 류',
										icon  : 'error'
									});									
								}
							});
            	
           }
        });
	}
	
</script>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
      	<jsp:include page="/WEB-INF/views/include/adminNav.jsp"></jsp:include>

<!-- 메인헤더에 띄울 이미지와 문구를 수정가능한 폼을 만들고있었음 -->
            <div class="container-fluid pt-4 px-4">
            <form name="myForm" method="post" action="${ctp}/admin/mainContentInput2" enctype="multipart/form-data">
            	<table class="table">
            		<tr>
            			<th colspan="2">
            				<select id="movieTitle" name="movieTitle" class="form-control" onchange="movieSelect()">
            					<option >영화목록</option>
											<c:forEach var="i" begin="0" end="${fn:length(movieTitleArr)}">             					
            					<option>${movieTitleArr[i]}</option>
            					</c:forEach>
            				</select>
            			</th>
            		</tr>
            		<tr>
            		<th>영화 소개<br/>
            		<span id="imgDemo"></span>
            		</th>
            			<td>
            				<textarea id="movieContent" name="movieContent" rows="10" class="form-control"></textarea>
            			</td>
            		</tr>
            		<tr>
									<td colspan="2">
										테이블에 저장된 이미지 업로드 : <input type="radio" onclick="fileCheck(1)" name="raFile" id="dbImg"/>
										새롭게 이미지 업로드 : <input type="radio" onclick="fileCheck(2)" name="raFile" id="fileImg"/>
										<span id="fileDemo"></span>
									</td>
            		</tr>
            		<tr>
            			<td colspan="2">
            				<button type="button" onclick="movieInput()">등록하기</button>
            			</td>
            		</tr>
            	</table>
            	<input type="hidden" name="location" id="location" value="?movieTitle="/>
            	</form>
            	<div class="container p-10" style="background-color:#F0F0F0 ">
	            	<div class="row">
	            		<div class="col mb-2" style="font-size: 2em">등록되어있는 영화</div>
	            	</div>
								<div class="row" style="font-weight: bolder;">
									<div class="col">이미지</div>
									<div class="col">영화</div>
									<div class="col">상세내용</div>
								</div>           
								<c:forEach var="cvo" items="${cvos}"> 	
								<div class="row mt-3">
									<c:if test="${cvo.srcsw == 1}">
										<div class="col">
											<a href="${cvo.img}" title="원본보기">
											<img alt="${cvo.movieTitle}" src="${cvo.img}" style="width: 200px">
											</a>
										</div>
									</c:if>
									<c:if test="${cvo.srcsw == 2}">
										<div class="col">
											<a href="${ctp}/resources/img/bg-img/${cvo.img}" title="원본보기">
											<img alt="${cvo.movieTitle}" src="${ctp}/resources/img/bg-img/${cvo.img}" style="width: 200px">
											</a>
										</div>
									</c:if>
									<div class="col">${cvo.movieTitle}</div>
									<div class="col">${cvo.content}</div>
									<div class="col">
										<button type="button" onclick="movieDelete('${cvo.movieTitle}')" class="form-control mb-2">삭제</button>
									</div>
								</div>
								</c:forEach>
	            </div>
            </div>
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