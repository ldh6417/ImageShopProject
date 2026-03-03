<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="/css/common.css">

<div class="app-menu" align="right">
	<table>
		<tr>
			<!-- 비회원 인증을 하지 않았을 때 메뉴 -->
			<sec:authorize access="!isAuthenticated()">
				<td class="nav-item"><a href="/board/list" class="nav-link">
						<spring:message code="board.header.list" />
				</a></td>
				<!-- 공지사항을 메뉴에 추가한다. -->
				<td class="nav-link"><a href="/notice/list" class="nav-link"><spring:message
							code="menu.notice.member" /></a></td>
			</sec:authorize>

			<!-- 인증을 했을 때 메뉴 (인가: 관리자, 회원, 매니저) -->
			<sec:authorize access="isAuthenticated()">

				<!-- 인증완료 인가 : 관리자 -->
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<td class="nav-item"><a href="/codegroup/list"
						class="nav-link"> <spring:message code="menu.codegroup.list" />
					</a></td>
					<td class="nav-item"><a href="/codedetail/list"
						class="nav-link"> <spring:message code="menu.codedetail.list" />
					</a></td>
					<td class="nav-item"><a href="/user/list" class="nav-link">
							<spring:message code="menu.user.admin" />
					</a></td>
					<td class="nav-item"><a href="/board/list" class="nav-link">
							<spring:message code="board.header.list" />
					</a></td>
					<!-- 공지사항을 메뉴에 추가한다. -->
					<td class="nav-item"><a href="/notice/list" class="nav-link"><spring:message
								code="menu.notice.member" /></a></td>
					<!-- 상품 관리를 메뉴에 추가한다. -->
					<td width="120"><a href="/item/list"><spring:message
								code="menu.item.member" /></a></td>
				</sec:authorize>


				<!-- 인증완료 인가 : 회원 -->
				<!-- 회원 게시판 목록을 메뉴에 추가한다. -->
				<sec:authorize access="hasRole('ROLE_MEMBER')">
					<td class="nav-item"><a href="/board/list" class="nav-link">
							<spring:message code="board.header.list" />
					</a></td>
					
					<!-- 공지사항을 메뉴에 추가한다. -->
					<td class="nav-item"><a href="/notice/list" class="nav-link"><spring:message
								code="menu.notice.member" /></a></td>
								
					<!-- 상품 관리를 메뉴에 추가한다. -->
					<td width="120"><a href="/item/list"><spring:message
								code="menu.item.member" /></a></td>
								
					<!-- 코인 충전과 충전 내역을 메뉴에 추가한다. -->
					<td width="120"><a href="/coin/charge"><spring:message
								code="menu.coin.charge" /></a></td>
					<td width="120"><a href="/coin/list"><spring:message
								code="menu.coin.list" /></a></td>
				</sec:authorize>
			</sec:authorize>
		</tr>
	</table>
</div>
<hr>



