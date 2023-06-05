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
		<title>리뷰 게시판 - 수정</title>
	</head>
	<body>
		<jsp:include page="${pageContext.request.contextPath}/resources/include/header.jsp"/>
		
		<!-- 로그아웃 시 이전 페이지로 이동 -->
		<c:if test="${userEmail eq null}">
			<script>
				$(function() {
					alert("로그인 후 이용해주십시오.");
					location.href = "/member/login";
				});
			</script>
		</c:if>
		
		<div class="container">
			<div class="row">
	            <div class="col-md-12">
	                <h1 class="bbs-title mb-5 p-5">리뷰 게시판</h1>
	            </div>
	        </div>
			<div class="row">
				<div class="col-md-12">
					<form action="/board/reviewModify.do?num=${review.num}&oldFile=${review.filename}" method="post" enctype="multipart/form-data">
						<div class="form-group my-3">
							<label>제목</label>
							<input type="text" class="form-control" id="title" name="title" value="${review.title}" required>
						</div>
						<c:forEach var="userInfo" items="${userInfo}">
							<div class="form-group my-3">
								<label>작성자</label>
								<input type="text" class="form-control" id="writer" name="writer" value="${userInfo.userNickname}" readonly>
							</div>
						</c:forEach>
						<div class="form-group my-3 d-none">
							<label>userId</label>
							<input type="text" class="form-control" id="userId" name="userId" value="${review.userId}">
						</div>
						<div class="form-group my-3">
							<label for="userDo">지역</label>
							<select class="form-select" id="doId" name="doId">
								<c:forEach items="${selectDo}" var="selectDo">
									<option value="${selectDo.doId}">${selectDo.doName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-gorup my-3">
							<label>첨부 이미지</label>
							<input type="file" class="form-control" id="newFile" name="newFile">
						</div>
						<div class="form-group my-3">
							<label>내용</label>
							<textarea id="content" name="content" rows="10" class="form-control" style="resize: none;" required>${review.content}</textarea>
						</div>
						<div class="d-flex justify-content-between my-5">
							<div>
								<a href="/board/reviewList?currentPage=1" class="btn btn-primary">목록으로</a>
							</div>
							<div>
								<input type="submit" class="btn btn-success" value="작성하기">
								<input type="reset" class="btn btn-danger" value="다시작성">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="${pageContext.request.contextPath}/resources/include/footer.jsp"/>
	</body>
</html>