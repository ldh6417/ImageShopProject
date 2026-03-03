<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Shop</title>
<link rel="stylesheet" href="/css/board.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<!-- 메인 -->
	<div class="notice_register">
		<h2>
			<spring:message code="coin.header.chargeCoin" />
		</h2>

		<form:form modelAttribute="chargeCoin" action="/coin/charge"
			method="post">
			<table>
				<tr>
					<td><spring:message code="coin.amount" /></td>
					<td><form:input path="amount" /></td>
					<td><font color="red"><form:errors path="amount" /></font></td>
				</tr>
			</table>
		</form:form>

		<!-- 회원만 가능  코인충전 -->
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<div>
				<button type="submit" id="btnCharge">
					<spring:message code="action.charge" />
				</button>
				<button type="submit" id="btnList">
					<spring:message code="action.list" />
				</button>
			</div>
		</sec:authorize>

	</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			var formObj = $("#chargeCoin");

			$("#btnCharge").on("click", function() {
				formObj.submit();
			});

			$("#btnList").on("click", function() {
				self.location = "/coin/list";
			});
		});
	</script>
</body>
</html>