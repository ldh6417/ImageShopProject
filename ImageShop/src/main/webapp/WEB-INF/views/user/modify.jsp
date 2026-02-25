<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>
<link rel="stylesheet" href="/css/user.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="user">
		<h2>
			<spring:message code="user.header.modify" />
		</h2>

		<form:form id="member" modelAttribute="member" action="/user/modify"
			method="post">

			<table>
				<tr>
					<td><spring:message code="user.userId" /></td>
					<td><form:input path="userId" readonly="true" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.userName" /></td>
					<td><form:input path="userName" /></td>
				</tr>

				<tr>
					<td><spring:message code="user.job" /></td>
					<td><form:input path="job" /></td>
				</tr>
			</table>
		</form:form>

		<div class="user-btn-area">
			<button type="button" id="btnModify">
				<spring:message code="action.modify" />
			</button>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			const formObj = $("#member");

			$("#btnModify").on("click", function() {
				formObj.submit();
			});

			$("#btnList").on("click", function() {
				self.location = "/user/list";
			});
		});
	</script>

</body>
</html>