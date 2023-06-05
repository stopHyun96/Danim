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
		<title>리뷰 게시판 - 상세보기</title>
	</head>
	
	<body class="bg-secondary">
		<jsp:include page="${pageContext.request.contextPath}/resources/include/header.jsp"/>
		<div class="container bg-light p-5">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<h1 class="title my-2 p-2">${reviewDetail.title}</h1>
				</div>
				<div class="col-md-1"></div>
			</div>
			
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10 d-flex">
					<h5 class="my-2 p-2">No.${reviewDetail.num}</h5>
					<h5 class="my-2 p-2">|&nbsp;&nbsp;${reviewDetail.writer}&nbsp;&nbsp;|</h5>
					<h5 class="my-2 p-2"><fmt:formatDate value="${reviewDetail.insertDate}" dateStyle="long"/></h5>
				</div>
				<div class="col-md-1"></div>
			</div>
			
		    <div class="row">
		    	<div class="col-md-1"></div>
		        <div class="col-md-10 border border-dark">
		            <div class="p-5">${reviewDetail.content}</div>
		            <c:if test="${reviewDetail.filename ne null}">
			            <div class="p-3 d-flex justify-content-center">
			            	<c:if test="${reviewDetail.filename ne 'imgNull'}">
	                    		<img src="${pageContext.request.contextPath}/resources/upload/${reviewDetail.filename}" alt="..." width="600px" height="600px">
		                    </c:if>
		                    <c:if test="${reviewDetail.filename eq 'imgNull'}">
		                    	<img src="${pageContext.request.contextPath}/resources/img/default.jpg" alt="..." width="600px" height="600px">
		                    </c:if>
			            </div>
		            </c:if>
		        </div>
		        <div class="col-md-1"></div>
		    </div>
		    
		    <!-- 추천 기능 -->
		    <div class="d-flex justify-content-center my-4">
			    <form action="/board/goodInsert?num=${reviewDetail.num}&userId=${userId}" method="post">
			    	<c:if test="${userId ne null}">
			    		<input type="submit" class="btn btn-outline-primary" value="추천하기&nbsp;${allGoods}">
					</c:if>
					<c:if test="${userId eq null}">
						<a class="btn btn-outline-primary" onclick="loginChkBtn()">추천하기&nbsp;${allGoods}</a>
					</c:if>
			    </form>
		    </div>
		    
		    <!-- 댓글 -->
		    <div class="row my-3">
		    	<div class="col-md-1"></div>
		        <div class="col-md-10 bg-gray">
		            <table class="table">
		            	<colgroup> 
					    	<col style="width: 15%;"/> 
					        <col style="width: 55%;"/>
					        <col style="width: 20%;"/>
					        <col style="width: 10%;"/> 
					    </colgroup>
		            	<thead>
		            		<tr>
		            			<th class="text-center">작성자</th>
		            			<th class="text-center">내용</th>
		            			<th class="text-center">등록일</th>
		            			<th></th>
		            		</tr>
		            	</thead>
		            	<tbody>
		            		<c:forEach items="${commentList}" var="commentList">
			            		<tr>
			            			<td class="text-center">${commentList.writer}</td>
			            			<td class="text-center">${commentList.content}</td>
			            			<td class="text-center"><fmt:formatDate value="${commentList.insertDate}" dateStyle="long"/></td>
			            			<c:if test="${commentList.userId eq userId}">
			            			<td class="text-center">
			            				<a href="/board/commentDelete?num=${reviewDetail.num}&commentNum=${commentList.commentNum}" class="text-decoration-none text-secondary">삭제</a>
			            			</td>
			            			</c:if>
			            		</tr>
		            		</c:forEach>
		            	</tbody>
		            </table>
		            <!-- 댓글 페이징 -->
			       	<div class="d-flex justify-content-center">
			       		<ul class="pagination">
				            <li class="page-item">
				                <a class="page-link <c:if test="${commentPage - 1 < 1}">disabled</c:if>" href="/board/reviewDetail?num=${reviewDetail.num}&commentPage=1">&laquo;</a>
				            </li>
				            <li class="page-item">
				                <a class="page-link <c:if test="${commentPage - 1 < 1}">disabled</c:if>" href="/board/reviewDetail?num=${reviewDetail.num}&commentPage=${commentPage - 1}">&lsaquo;</a>
				            </li>
				            <c:forEach var="pageNum" begin="1" end="${total}">
				                <li class="page-item ${pageNum}">
				                    <a class="page-link <c:if test="${pageNum eq commentPage}">active</c:if>" href="/board/reviewDetail?num=${reviewDetail.num}&commentPage=${pageNum}">${pageNum}</a>
				                </li>
				            </c:forEach>
				            <li class="page-item">
				                <a class="page-link <c:if test="${commentPage + 1 > total}">disabled</c:if>" href="/board/reviewDetail?num=${reviewDetail.num}&commentPage=${commentPage + 1}">&rsaquo;</a>
				            </li>
				            <li class="page-item">
				                <a class="page-link <c:if test="${commentPage + 1 > total}">disabled</c:if>" href="/board/reviewDetail?num=${reviewDetail.num}&commentPage=${total}">&raquo;</a>
				            </li>
			        	</ul>
				    </div>
		        </div>
		        <div class="col-md-1"></div>
		    </div>
		    
		    <!-- 댓글 작성 -->
		    <div class="row my-5">
		    	<div class="col-md-1"></div>
		        <div class="col-md-10 p-2 bg-gray">
		            <div class="p-3">
		                <form action="/board/commentWrite.do?num=${reviewDetail.num}&writer=${writer}&userId=${userId}&content=${content}" method="post">
		                    <div>
		                        <label class="form-label">댓글 작성</label>
		                        <textarea name="content" id="content" rows="5" class="form-control" style="resize: none;"></textarea>
		                    </div>
		                    <div class="d-flex justify-content-end mt-2">
			                    <c:if test="${userId ne null}">
			                        <input type="submit" class="btn btn-secondary" value="댓글작성">
		                        </c:if>
			                    <c:if test="${userId eq null}">
			                    	<a class="btn btn-secondary" onclick="loginChkBtn()">댓글작성</a>
		                        </c:if>
		                    </div>
		                </form>
		            </div>
		        </div>
		        <div class="col-md-1"></div>
		    </div>
		    
		    <!-- 로그인 되어있지 않다면 목록 버튼만 출력 -->
		    <c:if test="${userId eq null && adminEmail eq null}">
			    <div class="row my-5">
				    <div class="col-md-1"></div>
				    	<div class="col-md-10 d-flex justify-content-start">
				    		<a href="/board/reviewList?currentPage=1" class="btn btn-primary">목록</a>
				    	</div>
				    <div class="col-md-1"></div>
			    </div>
		    </c:if>
		    
		    <!-- 로그인한 사용자 정보와 게시글의 작성자 정보가 같다면 수정/삭제 버튼 출력, 관리자가 로그인 했을 시 삭제버튼만 출력 -->
		    <c:if test="${userId ne null || adminEmail ne null}">
		        <div class="row my-5">
		        	<div class="col-md-1"></div>
		        	<div class="col-md-10 d-flex justify-content-between">
					    <c:if test="${reviewDetail.userId eq userId}">
			        		<div>
			        			<a href="/board/reviewList?currentPage=1" class="btn btn-primary">목록</a>
			        		</div>
			        		<div>
				        		<a href="/board/reviewModify?num=${reviewDetail.num}" class="btn btn-success mx-1">수정</a>
						        <a data-filename="${reviewDetail.filename}" data-num="${reviewDetail.num}" class="btn btn-danger deleteBtn">삭제</a>
					        </div>
				        </c:if>
				        <c:if test="${adminEmail ne null}">
				        		<div>
				        			<a href="/board/reviewList?currentPage=1" class="btn btn-primary">목록</a>
				        		</div>
				        		<div>
						        	<a data-filename="${reviewDetail.filename}" data-num="${reviewDetail.num}" class="btn btn-danger deleteBtn">삭제</a>
						        </div>
				        </c:if>
		        	</div>
		        	<div class="col-md-1"></div>
		        </div>
	        </c:if>
		</div>
		
		<!-- 삭제 버튼 클릭 시 경고창 -->
		<script>
			$(".deleteBtn").click(function() {
				//태그에 지정한 data 요소들을 변수로 지정
				var filename = $(this).data("filename");
				var num = $(this).data("num");
				
				//관리자가 확인을 누르면 삭제 취소를 누르면 삭제 취소
				if(confirm("게시물을 삭제합니다.")) {
					window.location.href = "/board/reviewDelete?num=" + num + "&filename=" + filename;
				}
			});
		</script>
		
		<!-- 추천/댓글쓰기 : 로그인 상태가 아니라면 로그인 창으로 이동, 관리자 로그인 상태 시 경고창 출력 -->
		<script>
	    	function loginChkBtn(){
	    		let userEmail = "${userEmail}";
	    		let adminEmail = "${adminEmail}"
	   			if(adminEmail != "") {
	   				alert("관리자는 조회 및 삭제만 가능합니다.");
	   				location.reload();
	   			}else if(userEmail == "") {
	    			alert("로그인 후 이용 가능합니다.");
	    			location.href="/member/login";
	   			}
	    	}
	    </script>
	    
		<jsp:include page="${pageContext.request.contextPath}/resources/include/footer.jsp"/>
	</body>
	<style>
		/* 페이지네이션 색 변경 */
		.page-link {
			color: #777; 
			background-color: #fff;
			border: 1px solid #e9e9e9; 
		}
		
		.page-link.active {
			background-color: #e1e1e1;
			border-color: #e9e9e9;
			z-index: 1;
			color: #555;
			font-weight: bold;
		}
		
		.page-link:focus, .page-link:hover {
			color: #555;
			background-color: #e1e1e1; 
			border-color: #ccc;
		}
	</style>
</html>