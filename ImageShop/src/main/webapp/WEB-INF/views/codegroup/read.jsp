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
			<spring:message code="codegroup.header.read" />
		</h2>

		<form:form id="codeGroup" modelAttribute="codeGroup">
			<table class="codegroup-table">
				<tr>
					<td><spring:message code="codegroup.groupCode" /></td>
					<td><form:input path="groupCode" readonly="true" /></td>
					<td><font color="red"> <form:errors path="groupCode" />
					</font></td>
				</tr>

				<tr>
					<td><spring:message code="codegroup.groupName" /></td>
					<td><form:input path="groupName" readonly="true" /></td>
					<td><font color="red"> <form:errors path="groupName" />
					</font></td>
				</tr>
			</table>
		</form:form>

		<div class="btn-area">
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

					let formObj = $("#codeGroup");

					// 수정 이동
					$("#btnEdit").on(
							"click",
							function() {
								let groupCodeValue = $("#groupCode").val();
								self.location = "/codegroup/modify?groupCode="
										+ groupCodeValue;
							});

					// 삭제
					$("#btnRemove").on("click", function() {
						// ⭐ 삭제 확인창
						if (!confirm("삭제하시겠습니까?")) {
							return; // 취소 누르면 종료
						}
						formObj.attr("action", "/codegroup/remove");
						formObj.attr("method", "post");
						formObj.submit();
					});

					// 목록
					$("#btnList").on("click", function() {
						self.location = "/codegroup/list";
					});
				});
	</script>

</body>
</html>