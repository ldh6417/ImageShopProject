<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<spring:message code="codegroup.header.list" />
		</h2>

		<a href="/codegroup/register" class="btn-link"> <spring:message
				code="action.new" />
		</a>

		<table class="codegroup-table">
			<tr>
				<th width="160"><spring:message code="codegroup.groupCode" /></th>
				<th width="160"><spring:message code="codegroup.groupName" /></th>
				<th width="180"><spring:message code="codegroup.regdate" /></th>
			</tr>

			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="3"><spring:message code="common.listEmpty" /></td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach items="${list}" var="codeGroup">
						<tr>
							<td align="center">${codeGroup.groupCode}</td>
							<td align="left"><a
								href="/codegroup/read?groupCode=${codeGroup.groupCode}">
									${codeGroup.groupName} </a></td>
							<td align="center"><fmt:formatDate
									pattern="yyyy-MM-dd HH:mm" value="${codeGroup.regDate}" /></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
		var result = "${msg}";
		if (result === "SUCCESS") {
			alert("<spring:message code='common.processSuccess' />");
		} else if (result === "FAIL") {
			alert("삭제처리실패");
		}
	</script>
</body>
</html>