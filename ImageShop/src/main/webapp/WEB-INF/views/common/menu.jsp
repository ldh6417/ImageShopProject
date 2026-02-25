<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<link rel="stylesheet" href="/css/common.css">
<div class="app-header">
  <div class="app-header__inner">

    <nav class="app-header__menu">
      <!-- 회원가입 -->
      <a class="app-header__link" href="/user/register">
        <spring:message code="header.joinMember" />
      </a>

      <!-- 코드그룹관리 -->
      <a class="app-header__link" href="/codegroup/list">
        <spring:message code="menu.codegroup.list" />
      </a>

      <!-- 코드관리 -->
      <a class="app-header__link" href="/codedetail/list">
        <spring:message code="menu.codedetail.list" />
      </a>

      <!-- 회원관리 -->
      <a class="app-header__link" href="/user/list">
        <spring:message code="menu.user.admin" />
      </a>
    </nav>

  </div>
</div>
<hr>