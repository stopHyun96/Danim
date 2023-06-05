<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark p-2">
  <a class="navbar-brand" href="/">
    Danim
  </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse d-flex justify-content-between p-1" id="navbarNav">
    <ul class="navbar-nav ml-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/">메인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/board/reviewList?currentPage=1">리뷰 게시판</a>
      </li>
    </ul>
    <ul class="navbar-nav ml-auto">
      <c:if test="${userEmail eq null && adminEmail eq null}">
	      <li class="nav-item">
	        <a class="nav-link text-decoration-none btn btn-outline-secondary mx-1" href="/member/login">로그인</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-decoration-none btn btn-outline-secondary" href="/member/join">회원가입</a>
	      </li>
      </c:if>
      <c:if test="${userEmail != null}">
	      <li class="nav-item">
	        <a class="nav-link btn btn-outline-secondary mx-1" href="/member/myPage">마이페이지</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link btn btn-outline-secondary" href="/member/logout">로그아웃</a>
	      </li>
      </c:if>
      <c:if test="${adminEmail != null}">
	      <li class="nav-item">
	        <a class="nav-link btn btn-outline-secondary mx-1" href="/admin/reviewManagePage">관리자 페이지</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link btn btn-outline-secondary" href="/admin/logout">로그아웃</a>
	      </li>
      </c:if>
    </ul>
  </div>
</nav>