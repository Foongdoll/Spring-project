<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>무비 차트</title>

    <!-- Favicon -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="style.css">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${movieChart[0].img});">
        <div class="bradcumbContent">
            <p>요즘 영화 뭐가 재미있지?</p>
            <h2>무비 차트</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Events Area Start ##### -->
    <section class="events-area section-padding-100">
        <div class="container">
            <div class="row">

								<c:forEach var="vo" items="${movieChart}">
	                <div class="col-12 col-md-6 col-lg-4">
	                    <div class="single-event-area mb-30">
	                        <div class="event-thumbnail">
	                            <img src="img/bg-img/e1.jpg" alt="">
	                        </div>
	                        <div class="event-text" >
	                            <div class="event-meta-data">
	                            <h4>${vo.rank}</h4>
	                            <h3> <img alt="${vo.movieTitle}" src="${vo.img}"> </h3>
	                            	<a href="#" class="event-date">
	                            		<span>${vo.movieTitle}</span>
	                                <p>예매율 ${vo.movieRate} | 좋아요 ${vo.likeNum}</p>
	                                <p>${fn:replace(vo.movieOpenDate,':','.')} 개봉</p>
                               	</a>
	                            </div>
	                            <a href="${ctp}/movie/ticketing" class="btn see-more-btn">예매하기</a><br/>
	                            <a href="${ctp}/movie/movieDetail?movieTitle=${vo.movieTitle}" class="btn see-more-btn">상세보기</a>
	                        </div>
	                    </div>
	                </div>
								</c:forEach>

            </div>
        </div>
    </section>

<jsp:include page="/WEB-INF/views/include/chatting.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>

</html>