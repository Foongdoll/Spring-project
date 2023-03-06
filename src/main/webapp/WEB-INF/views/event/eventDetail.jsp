<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	</head>

<body>
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${content});">
        <div class="bradcumbContent">
            <p>깜짝놀랄 오늘 뭐볼까? 만의</p>
            <h2>이벤트</h2>
        </div>
    </section>

    <section class="events-area section-padding-100">
        <div class="container">
        <table class="table">
        	<tr>
        		<th>${title}</th>
        	</tr>
        </table>
        <h3>${edate}</h3>
        	<img alt="${content}" src="${content}">  
        </div>
    </section>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>