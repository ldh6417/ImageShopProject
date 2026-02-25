<div class="codegroup">
	<h2>
		<spring:message code="codegroup.header.read" />
	</h2>

	<form:form id="codeGroup" modelAttribute="codeGroup">
		<table>
			<tr>
				<td><spring:message code="codegroup.groupCode" /></td>
				<td><form:input path="groupCode" id="groupCode" readonly="true" />
				</td>
				<td><font color="red"><form:errors path="groupCode" /></font></td>
			</tr>
			<tr>
				<td><spring:message code="codegroup.groupName" /></td>
				<td><form:input path="groupName" readonly="true" /></td>
				<td><font color="red"><form:errors path="groupName" /></font></td>
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

<script>
	$(function() {
		let formObj = $("#codeGroup");

		$("#btnEdit").on("click", function() {
			let groupCodeValue = $("#groupCode").val();
			self.location = "/codegroup/modify?groupCode=" + groupCodeValue;
		});

		$("#btnRemove").on("click", function() {
			formObj.attr("action", "/codegroup/remove");
			formObj.attr("method", "post");
			formObj.submit();
		});

		$("#btnList").on("click", function() {
			self.location = "/codegroup/list";
		});
	});
</script>