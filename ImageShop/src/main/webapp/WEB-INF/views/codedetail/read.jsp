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
<link rel="stylesheet" href="/css/codedetail.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/menu.jsp" />

	<div class="codedetail_read">
		<h2>
			<spring:message code="codedetail.header.read" />
		</h2>

		<form:form id="codeDetail" modelAttribute="codeDetail">
			<!-- ✅ disabled 필드는 submit 안 되니까 hidden으로 키값 유지 -->
			<form:hidden path="groupCode" />
			<form:hidden path="codeValue" />

			<table>
				<tr>
					<td><spring:message code="codedetail.groupCode" /></td>
					<td><form:select path="groupCode" items="${groupCodeList}"
							itemValue="value" itemLabel="label" disabled="true" /></td>
					<td><font color="red"><form:errors path="groupCode" /></font></td>
				</tr>

				<tr>
					<td><spring:message code="codedetail.codeValue" /></td>
					<td><form:input path="codeValue" readonly="true" /></td>
					<td><font color="red"><form:errors path="codeValue" /></font></td>
				</tr>

				<tr>
					<td><spring:message code="codedetail.codeName" /></td>
					<td><form:input path="codeName" readonly="true" /></td>
					<td><font color="red"><form:errors path="codeName" /></font></td>
				</tr>
			</table>
		</form:form>

		<div>
			<button type="button" id="btnEdit">
				<spring:message code="action.edit" />
			</button>
			<button type="button" id="btnRemove">
				<spring:message code="action.remove" />
			</button>
			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(
				function() {
					let formObj = $("#codeDetail");

					$("#btnEdit").on(
							"click",
							function() {
								let groupCode = $("#groupCode");
								let groupCodeValue = groupCode.val();
								let codeValue = $("#codeValue");
								let codeValueValue = codeValue.val();
								self.location = "modify?groupCode="
										+ groupCodeValue + "&" + "codeValue="
										+ codeValueValue
							});

					$("#btnRemove").on("click", function() {
						formObj.attr("action", "/codedetail/remove");
						formObj.attr("method", "get");
						formObj.submit();
					});

					$("#btnList").on("click", function() {
						self.location = "/codedetail/list";
					});
				});
	</script>
</body>
</html>