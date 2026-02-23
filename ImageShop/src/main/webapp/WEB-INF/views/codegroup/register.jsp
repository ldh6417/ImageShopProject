<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>

<link rel="stylesheet" href="/css/layout.css">
<link rel="stylesheet" href="/css/codegroup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div align="center" class="page-wrapper">
		<h2>
			<spring:message code="codegroup.header.register" />
		</h2>

		<form:form id="codeGroup" modelAttribute="codeGroup"
			action="/codegroup/register" method="post">

			<table class="codegroup-table">
				<tr>
					<td><spring:message code="codegroup.groupCode" /></td>
					<td><form:input path="groupCode" /></td>
					<td><font color="red"> <form:errors path="groupCode" />
					</font></td>
				</tr>

				<tr>
					<td><spring:message code="codegroup.groupName" /></td>
					<td><form:input path="groupName" /></td>
					<td><font color="red"> <form:errors path="groupName" />
					</font></td>
				</tr>
			</table>
		</form:form>

		<div class="btn-area">
			<button type="button" id="btnRegister">
				<spring:message code="action.register" />
			</button>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {

			let formObj = $("#codeGroup");

			// 등록
			$("#btnRegister").on("click", function() {
				formObj.submit();
			});

			// 목록 이동
			$("#btnList").on("click", function() {
				self.location = "/codegroup/list";
			});

		});
	</script>
</body>
</html>