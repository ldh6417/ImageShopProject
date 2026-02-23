<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>

<link rel="stylesheet" href="/css/layout.css">
<link rel="stylesheet" href="/css/home.css">

</head>
<body>

	<!--  헤더 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!--  메뉴  -->
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<!--  본문 -->
	<div align="center" class="home-wrapper">
		<h1>
			<spring:message code="common.homeWelcome" />
		</h1>
		<p>${serverTime}</p>
	</div>

	<!--  푸터 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>