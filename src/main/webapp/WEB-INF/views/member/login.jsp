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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/list.css"/>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>로그인</title>
	</head>
	<body class="bg-secondary">
		<jsp:include page="${pageContext.request.contextPath}/resources/include/header.jsp"/>
		<!-- 아이디가 틀렸을 시 출력 -->
	    <c:if test="${loginError == true}">
		    <div class="alert alert-danger alert-dismissible fade show" role="alert">
		        <strong>로그인 실패:</strong> 이메일 혹은 비밀번호가 잘못되었습니다.
		        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		    <script>
		    	alert("로그인 실패(이메일과 비밀번호를 확인해주세요.)");
		    </script>
		</c:if>
		
		<div class="container bg-white">
			<div class="row justify-content-center mt-5">
				<div class="com-md-3"></div>
				<div class="col-md-6 p-5">
					<h2 class="text-center my-5">로그인</h2>
					<div class="btn-group" style="width: 100%">
						<button id="userBtn" class="btn btn-light active">사용자</button>
						<button id="adminBtn" class="btn btn-light">관리자</button>
					</div>
					
					<!-- 각 버튼 클릭 시 사용자 / 관리자 로그인 전환 -->
					<script>
						$("#userBtn").click(function() {
							$("#userBtn").addClass(" active");
							$("#adminBtn").removeClass(" active");
							$("#loginForm").prop("action", "/member/login.do");
							$("#adminId").addClass("d-none");
							$("#userEmail").prop("name", "userEmail");
							$("#mail").removeClass("d-none");
							$("#loginBtn").removeClass(" d-none");
							$("#adminLoginBtn").addClass(" d-none");
						});
						
						$("#adminBtn").click(function() {
							$("#adminBtn").addClass(" active");
							$("#userBtn").removeClass(" active");
							$("#loginForm").prop("action", "/admin/login.do");
							$("#adminId").removeClass("d-none");
							$("#userEmail").prop("name", "adminEmail");
							$("#mail").addClass("d-none");
							$("#loginBtn").addClass(" d-none");
							$("#adminLoginBtn").removeClass(" d-none");
						});
					</script>
					
					<form id="loginForm" action="/member/login.do" method="post">
						<div class="form-group my-3">
							<label id="mail" class="">이메일</label>
							<label id="adminId" class="d-none">Admin 계정</label>
							<input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요.">
						</div>
						<div class="form-group my-3">
							<label>비밀번호</label>
							<input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요.">
						</div>
						<div class="d-flex justify-content-center my-3">
							<input id="loginBtn" type="submit" class="btn btn-primary mx-1" value="로그인">
							<button type="button" id="adminLoginBtn" class="btn btn-primary mx-1 d-none" onclick="adminLogin()">Admin 로그인</button>
							<a href="/member/join" class="btn btn-outline-primary">회원가입</a>
						</div>
						<div class="d-flex justify-content-center my-3">
							<a id="findPwBtn" class="btn btn-outline-warning">비밀번호 찾기</a>
						</div>
						
						<!-- Admin Login -->
						<script>
							function adminLogin() {
								var adminEmail = $("#userEmail").val();
								var adminPw = $("#userPw").val();
								
								$.ajax({
									url: '/admin/login.do',
									type: 'POST',
									data: {
										adminEmail : adminEmail,
										adminPw : adminPw
									},
									success: function(result) {
										//로그인 실패 시 경고창을 띄우고 이메일과 비밀번호를 비운 뒤 이메일 포커스
										if (result === "fail") {
							                alert('로그인 실패 : 이메일/비밀번호를 확인하세요.');
							                $('#userEmail').val('');
							                $('#userPw').val('');
							                
							                $("#userEmail").focus();
										//로그인 실패 시 경고창을 띄우고 이메일과 비밀번호를 비운 뒤 이메일 포커스
							            } else if (result === "null") {
							                alert('로그인 실패 : 이메일/비밀번호를 입력하세요.');
							                $('#userEmail').val('');
							                $('#userPw').val('');
							                
							                $("#userEmail").focus();
										//로그인 성공 시 이전화면으로 돌아감
							            } else if (result === "success") {
							                alert('로그인 성공 : 관리자님 환영합니다.');
							                window.location.href = "/";
							            } else {
							                alert('올바른 응답을 받지 못했습니다: ' + result);
							            }
									}
								});
							};
						</script>
						
						<!-- 비밀번호 찾기 팝업 창 띄우기 -->
						<script>
							$("#findPwBtn").click(function() {
								var size = "width=650px, height=500px, top=150px, left=450px";
								var url = "/member/findPw";
								
								window.open(url, "findPw", size);
							});
						</script>
						
					</form>
					
				</div>
				<div class="com-md-3"></div>
			</div>
		</div>
		<jsp:include page="${pageContext.request.contextPath}/resources/include/footer.jsp"/>
	</body>
</html>