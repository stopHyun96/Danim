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
					<c:choose>
						<c:when test="${pw eq null}">
							<h1 class="text-center">잘못된 이메일입니다.</h1>
							<h1 class="text-center">확인 후 다시 입력해주세요.</h1>
						</c:when>
						<c:otherwise>
							<h1 class="text-center">당신의 비밀번호는</h1>
							<h1 class="text-center">${pw}</h1>
							<h1 class="text-center">입니다.</h1>
						</c:otherwise>
					</c:choose>
				
					<div class="d-flex justify-content-center my-3">
						<a id="backBtn" class="btn btn-outline-primary mx-1">이전</a>
						<a id="closeBtn" class="btn btn-outline-danger">닫기</a>
					</div>
				</div>
				
				<!-- 닫기 버튼 -->
				<script>
					$("#backBtn").click(function(){
						window.history.back();
					});
				
					$("#closeBtn").click(function(){
						window.close();
					});
				</script>
			</div>
		</div>
		
	</body>
</html>