<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<div class="board_modify_main">
		<h2>
			<spring:message code="board.header.read" />
		</h2>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/common/menu.jsp" />

		<!--  메인 작업영역 -->
		<div class="board_modify">

			<h2>
				<spring:message code="board.header.read" />
			</h2>

			<div class="board_modify_inner">

				<form:form id="board" modelAttribute="board" method="post">
					<form:hidden path="boardNo" />
					<!-- 현재 페이지 번호와 페이징 크기를 숨겨진 필드 요소를 사용하여 전달한다. -->
					<input type="hidden" id="page" name="page" value="${pgrq.page}">
					<input type="hidden" id="sizePerPage" name="sizePerPage" value="${pgrq.sizePerPage}">

					<table class="board-table">
						<tr>
							<td><spring:message code="board.title" /></td>
							<td><form:input path="title" /></td>
							<td><font color="red"><form:errors path="title" /></font></td>
						</tr>

						<tr>
							<td><spring:message code="board.writer" /></td>
							<td><form:input path="writer" readonly="true" /></td>
							<td><font color="red"><form:errors path="writer" /></font></td>
						</tr>

						<tr>
							<td><spring:message code="board.content" /></td>
							<td><form:textarea path="content" /></td>
							<td><font color="red"><form:errors path="content" /></font></td>
						</tr>
					</table>
				</form:form>
			</div>

			<!-- 🔷 버튼 영역 -->
			<div class="board-btn-area">

				<sec:authentication property="principal" var="pinfo" />

				<!-- 관리자전용 -->
				<sec:authorize access="hasRole('ROLE_ADMIN')">

					<button type="submit" id="btnModify">
						<spring:message code="action.modify" />
					</button>

					<button type="submit" id="btnRemove">
						<spring:message code="action.remove" />
					</button>

				</sec:authorize>

				<!-- 회원전용 -->
				<!-- 사용자정보를 가져온다. -->
				<sec:authentication property="principal" var="customuser" />

				<sec:authorize access="hasRole('ROLE_MEMBER')">
					<c:if test="${customuser.getMember().userName eq board.writer}">

						<button type="submit" id="btnModify">
							<spring:message code="action.modify" />
						</button>

						<button type="submit" id="btnRemove">
							<spring:message code="action.remove" />
						</button>

					</c:if>
				</sec:authorize>

				<button type="button" id="btnList">
					<spring:message code="action.list" />
				</button>


			</div>

		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(function() {
			let formObj = $("#board");

			$("#btnModify").on("click", function() {
				formObj.submit();
			});

			$("#btnRemove").on("click", function() {
				let boardNo = $("#boardNo").val()
				self.location = "/board/remove?${pgrq.toUriString()}$boardNo=" + boardNo;
			});

			$("#btnList").on("click", function() {
				self.location = "/board/list${pgrq.toUriString()}";
			});

		});
	</script>

</body>
</html>