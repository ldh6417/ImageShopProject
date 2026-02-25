<div class="codegroup">
	<h2>
		<spring:message code="codegroup.header.register" />
	</h2>

	<form:form id="codeGroup" modelAttribute="codeGroup"
		action="/codegroup/register" method="post">

		<table>
			<tr>
				<td><spring:message code="codegroup.groupCode" /></td>
				<td><form:input path="groupCode" /></td>
				<td><font color="red"><form:errors path="groupCode" /></font></td>
			</tr>
			<tr>
				<td><spring:message code="codegroup.groupName" /></td>
				<td><form:input path="groupName" /></td>
				<td><font color="red"><form:errors path="groupName" /></font></td>
			</tr>
		</table>
	</form:form>

	<div>
		<button type="button" id="btnRegister">
			<spring:message code="action.register" />
		</button>
		<button type="button" id="btnList">
			<spring:message code="action.list" />
		</button>
	</div>
</div>

<script>
	$(function() {
		let formObj = $("#codeGroup");

		$("#btnRegister").on("click", function() {
			formObj.submit();
		});

		$("#btnList").on("click", function() {
			self.location = "/codegroup/list";
		});
	});
</script>