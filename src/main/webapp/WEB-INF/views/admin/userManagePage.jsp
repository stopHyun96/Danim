<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<link rel="stylesheet" href=""/>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Admin Page - User Manage</title>
	</head>
	<body class="bg-secondary">
	<jsp:include page="${pageContext.request.contextPath}/resources/include/header.jsp"/>
	
	<!-- 로그아웃 시 이전 페이지로 이동 -->
	<c:if test="${adminEmail eq null}">
		<script>
			$(function() {
				alert("로그인 후 이용해주십시오.");
				location.href = "/member/login";
			});
		</script>
	</c:if>
	
		<div class="container bg-white my-5 p-5">
			<div class="row">
				<div class="col-md-12">
					<h1>관리자 페이지</h1>
					
					<form id="search" action="" class="mt-5">
						<div class="input-group">
							<input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요.">
							<input type="submit" class="btn btn-info" value="검색">
						</div>
					</form>
					
					<div class="btn-group mt-2" style="width: 100%;">
						<a href="/admin/reviewManagePage?currentPage=1" id="reviewListBtn" class="btn btn-light">게시글 관리</a>
						<a id="userListBtn" class="btn btn-light active">회원 관리</a>
					</div>
					
					<div id="userListTable">
				        <table class="table">
				        	<colgroup>
				                <col style="width: 6%;">
				                <col style="width: 10%;">
				                <col style="width: 10%;">
				                <col style="width: 27%;">
				                <col style="width: 6%;">
				                <col style="width: 20%;">
				                <col style="width: 15%;">
				                <col style="width: 6%;">
				            </colgroup>
				            <thead class="bg-secondary text-white text-center">
				                <tr>
				                    <th>No.</th>
				                    <th>이름</th>
				                    <th>별명</th>
				                    <th>이메일</th>
				                    <th>성별</th>
				                    <th>생년월일</th>
				                    <th>가입일</th>
				                    <th>삭제</th>
				                </tr>
				            </thead>
				            <tbody class="bg-light text-center">
				            <c:forEach var="userList" items="${userList}">
				                <tr>
				                    <td>${userList.userId}</td>
				                    <td>${userList.userName}</td>
				                    <td>${userList.userNickname}</td>
				                    <td>${userList.userEmail}</td>
				                    <td>
					                    <c:if test="${userList.userGender eq 1}">
					                    	남성
					                    </c:if>
					                    <c:if test="${userList.userGender eq 2}">
					                    	여성
					                    </c:if>
				                    </td>
				                    <td>${userList.userBirth}</td>
				                    <td><fmt:formatDate value="${userList.joinDate}" dateStyle="long"/></td>
				                    <td>
		                                <a class="text-danger deleteBtn" data-email="${userList.userEmail}" data-currentpage="${currentPage}" style="text-decoration: none; cursor: pointer;">삭제</a>
		                            </td>
				                </tr>
				            </c:forEach>
				            </tbody>
				        </table>
				        
				        
				        <!-- 페이징 -->
				       	<div class="d-flex justify-content-center">
				       		<ul class="pagination">
					            <li class="page-item">
					                <a class="page-link <c:if test="${currentPage - 1 < 1}">disabled</c:if>" href="/admin/userManagePage?currentPage=1">&laquo;</a>
					            </li>
					            <li class="page-item">
					                <a class="page-link <c:if test="${currentPage - 1 < 1}">disabled</c:if>" href="/admin/userManagePage?currentPage=${currentPage - 1}">&lsaquo;</a>
					            </li>
					            <c:forEach var="pageNum" begin="1" end="${total}">
					                <li class="page-item ${pageNum}">
					                    <a class="page-link <c:if test="${pageNum eq currentPage}">active</c:if>" href="/admin/userManagePage?currentPage=${pageNum}">${pageNum}</a>
					                </li>
					            </c:forEach>
					            <li class="page-item">
					                <a class="page-link <c:if test="${currentPage + 1 > total}">disabled</c:if>" href="/admin/userManagePage?currentPage=${currentPage + 1}">&rsaquo;</a>
					            </li>
					            <li class="page-item">
					                <a class="page-link <c:if test="${currentPage + 1 > total}">disabled</c:if>" href="/admin/userManagePage?currentPage=${total}">&raquo;</a>
					            </li>
				        	</ul>
					    </div>
			        </div>
				</div>
			</div>
		</div>
	<jsp:include page="${pageContext.request.contextPath}/resources/include/footer.jsp"/>
	
	<script>
		$('.deleteBtn').click(function() {
	        //태그에 지정한 data 요소들을 변수로 지정
	        var email = $(this).data('email');
	        var currentPage = $(this).data('currentpage');
	        
	        //관리자가 확인을 누르면 삭제 취소를 누르면 삭제 취소
	        if (confirm('정말 이 유저를 삭제하시겠습니까?')) {
	        	window.location.href = '/admin/adminUserDelete?userEmail=' + email + '&currentPage=' + currentPage;
	        }
	    });
	</script>
	
	</body>
</html>