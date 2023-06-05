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
		<title>비밀번호찾기</title>
	</head>
	<body class="p-5">
		<div class="container p-5">
			<div class="row p-5">
				<div class="col-md-12 p-5">
					<h1 class="text-center">비밀번호 찾기</h1>
					<form action="/member/findPwGet" method="get" class="p-5">
						<input type="email" name="userEmail" class="form-control" placeholder="이메일을 입력하세요.">
						<div class="d-flex justify-content-center my-3">
							<input type="submit" class="btn btn-outline-primary mx-1" value="찾기">
							<a id="closeBtn" class="btn btn-outline-danger">취소</a>
						</div>
						
						<script>
							$("#closeBtn").click(function(){
								window.close();
							});
						</script>
					</form>
				</div>
			</div>
		</div>
		
	</body>
</html>