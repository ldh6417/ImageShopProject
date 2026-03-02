<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<div class="board_readMain">



		<h2>
			<spring:message code="board.header.read" />
		</h2>

		<div class="board_read_inner">

			<form:form id="board" modelAttribute="board">
				<form:hidden path="boardNo" />
				<!-- 현재 페이지 번호와 페이징 크기를 숨겨진 필드 요소를 사용하여 전달한다. -->
				<input type="hidden" id="page" name="page" value="${pgrq.page}">
				<input type="hidden" id="sizePerPage" name="sizePerPage"
					value="${pgrq.sizePerPage}">

				<table class="board-table">
					<tr>
						<td><spring:message code="board.title" /></td>
						<td><form:input path="title" readonly="true" /></td>
						<td><font color="red"><form:errors path="title" /></font></td>
					</tr>

					<tr>
						<td><spring:message code="board.writer" /></td>
						<td><form:input path="writer" readonly="true" /></td>
						<td><font color="red"><form:errors path="writer" /></font></td>
					</tr>

					<tr>
						<td><spring:message code="board.content" /></td>
						<td><form:textarea path="content" readonly="true" /></td>
						<td><font color="red"><form:errors path="content" /></font></td>
					</tr>
				</table>
			</form:form>

			<div class="reply_view">

				<table class="reply-table">
			
					<tbody>
						<c:choose>
							<c:when test="${empty replyList}">
								<tr>
									<td colspan="3" class="reply-empty"><spring:message
											code="common.listEmpty" /></td>
								</tr>
							</c:when>

							<c:otherwise>
								<c:forEach items="${replyList}" var="reply">
									<tr>
										<td class="reply-writer">${reply.member.userId}</td>
										<td class="reply-content">${reply.content}</td>
										<td class="reply-date"><fmt:formatDate
												pattern="yyyy-MM-dd HH:mm" value="${reply.regDate}" /></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>

			</div>

			<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
				<div class="reply_register">
					<sec:authentication property="principal" var="pinfo" />
					<form action="/reply/replyRegister" method="post">
						<input type="hidden" name="username" value="${pinfo.username}" />
						<input type="hidden" name="boardNo" value="${board.boardNo}" /> <label
							for="reply_content">댓글작성</label>
						<textarea id="reply_content" name="content"> </textarea>
						<button type="submit">댓글작성</button>
					</form>
				</div>
			</sec:authorize>
		</div>




		<!-- 🔷 버튼 영역 -->
		<div class="board-btn-area">

			<sec:authentication property="principal" var="pinfo" />

			<!-- 관리자전용 -->
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="submit" id="btnEdit">
					<spring:message code="action.edit" />
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

					<button type="button" id="btnEdit">
						<spring:message code="action.edit" />
					</button>

					<button type="button" id="btnRemove">
						<spring:message code="action.remove" />
					</button>

				</c:if>
			</sec:authorize>

			<button type="button" id="btnList">
				<spring:message code="action.list" />
			</button>


		</div>

	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		$(document).ready(
				function() {
					let formObj = $("#board");

					$("#btnEdit").on(
							"click",
							function() {
								let boardNo = $("#boardNo").val();
								let page = $("#page").val();
								let sizePerPage = $("#sizePerPage").val();
								self.location = "/board/modify?page=" + page
										+ "&sizePerPage=" + sizePerPage
										+ "&boardNo=" + boardNo;
							});

					$("#btnRemove").on(
							"click",
							function() {
								let boardNo = $("#boardNo").val();
								let page = $("#page").val();
								let sizePerPage = $("#sizePerPage").val();
								self.location = "/board/remove?page=" + page
										+ "&sizePerPage=" + sizePerPage
										+ "&boardNo=" + boardNo;
							});

					$("#btnList").on(
							"click",
							function() {
								let page = $("#page").val();
								let sizePerPage = $("#sizePerPage").val();
								self.location = "/board/list?page=" + page
										+ "&sizePerPage=" + sizePerPage;
							});

				});
	</script>

</body>
</html>