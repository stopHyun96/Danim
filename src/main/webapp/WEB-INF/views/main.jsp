<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<title>메인 페이지</title>
	</head>
	<body class="bg-secondary">
		<jsp:include page="${pageContext.request.contextPath}/resources/include/header.jsp"/>
		<div class="container bg-white">
	        <div class="row">
	            <div class="col-md-12">
	                <h1 class="bbs-title mb-5 p-5">메인 페이지</h1>
	            </div>
	        </div>
	    
	        <!-- 지역별 게시글 목록 이동 -->
			<div id="carouselExample" class="carousel slide my-4">
				<ol class="carousel-indicators">
					<li data-target="#carouselExample" data-slide-to="0" class="active"></li>
					<li data-target="#carouselExample" data-slide-to="1"></li>
					<li data-target="#carouselExample" data-slide-to="2"></li>
					<li data-target="#carouselExample" data-slide-to="3"></li>
					<li data-target="#carouselExample" data-slide-to="4"></li>
					<li data-target="#carouselExample" data-slide-to="5"></li>
				</ol>
				<div class="carousel-inner">
			        <h2 class="title p-2">지역별 게시글 목록</h2>
					<!-- Page 1 -->
					<div class="carousel-item active">
					       <div class="row p-3">
							<c:forEach items="${selectDo}" var="selectDo" begin="0" end="2">
					          <div class="col-md-4">
					              <div class="card">
					                 	<img src="${pageContext.request.contextPath}/resources/img/${selectDo.doName}.jpg" class="card-img-top" alt="..." height="300px">
					                  <div class="card-body">
					                          <h5 class="card-title">${selectDo.doName}</h5>
					                      <div class="d-flex justify-content-end">
					                          <a href="/board/reviewList?currentPage=1&doId=${selectDo.doId}" class="btn btn-primary">더 보기</a>
					                      </div>
					                  </div>
					              </div>
					          </div>
					          </c:forEach>
						</div>
					</div>	   
					
					<!-- Page 2 -->
					<div class="carousel-item">
					       <div class="row p-3">
							<c:forEach items="${selectDo}" var="selectDo" begin="3" end="5">
					          <div class="col-md-4">
					              <div class="card">
					                 	<img src="${pageContext.request.contextPath}/resources/img/${selectDo.doName}.jpg" class="card-img-top" alt="..." height="300px">
					                  <div class="card-body">
					                          <h5 class="card-title">${selectDo.doName}</h5>
					                      <div class="d-flex justify-content-end">
					                          <a href="/board/reviewList?currentPage=1&doId=${selectDo.doId}" class="btn btn-primary">더 보기</a>
					                      </div>
					                  </div>
					              </div>
					          </div>
					          </c:forEach>
						</div>
					</div>	  
					
					<!-- Page 3 -->
					<div class="carousel-item">
					       <div class="row p-3">
							<c:forEach items="${selectDo}" var="selectDo" begin="6" end="8">
					          <div class="col-md-4">
					              <div class="card">
					                 	<img src="${pageContext.request.contextPath}/resources/img/${selectDo.doName}.jpg" class="card-img-top" alt="..." height="300px">
					                  <div class="card-body">
					                          <h5 class="card-title">${selectDo.doName}</h5>
					                      <div class="d-flex justify-content-end">
					                          <a href="/board/reviewList?currentPage=1&doId=${selectDo.doId}" class="btn btn-primary">더 보기</a>
					                      </div>
					                  </div>
					              </div>
					          </div>
					          </c:forEach>
						</div>
					</div>	  
					
					<!-- Page 4 -->
					<div class="carousel-item">
					       <div class="row p-3">
							<c:forEach items="${selectDo}" var="selectDo" begin="9" end="11">
					          <div class="col-md-4">
					              <div class="card">
					                 	<img src="${pageContext.request.contextPath}/resources/img/${selectDo.doName}.jpg" class="card-img-top" alt="..." height="300px">
					                  <div class="card-body">
					                          <h5 class="card-title">${selectDo.doName}</h5>
					                      <div class="d-flex justify-content-end">
					                          <a href="/board/reviewList?currentPage=1&doId=${selectDo.doId}" class="btn btn-primary">더 보기</a>
					                      </div>
					                  </div>
					              </div>
					          </div>
					          </c:forEach>
						</div>
					</div>	  
					
					<!-- Page 5 -->
					<div class="carousel-item">
					       <div class="row p-3">
							<c:forEach items="${selectDo}" var="selectDo" begin="12" end="14">
					          <div class="col-md-4">
					              <div class="card">
					                 	<img src="${pageContext.request.contextPath}/resources/img/${selectDo.doName}.jpg" class="card-img-top" alt="..." height="300px">
					                  <div class="card-body">
					                          <h5 class="card-title">${selectDo.doName}</h5>
					                      <div class="d-flex justify-content-end">
					                          <a href="/board/reviewList?currentPage=1&doId=${selectDo.doId}" class="btn btn-primary">더 보기</a>
					                      </div>
					                  </div>
					              </div>
					          </div>
					          </c:forEach>
						</div>
					</div>	  
					
					<!-- Page 6 -->
					<div class="carousel-item">
				       <div class="row p-3">
						   <c:forEach items="${selectDo}" var="selectDo" begin="15" end="17">
					          <div class="col-md-4">
					              <div class="card">
					                  <img src="${pageContext.request.contextPath}/resources/img/${selectDo.doName}.jpg" class="card-img-top" alt="..." height="300px">
					                  <div class="card-body">
					                     <h5 class="card-title">${selectDo.doName}</h5>
					                     <div class="d-flex justify-content-end">
					                        <a href="/board/reviewList?currentPage=1&doId=${selectDo.doId}" class="btn btn-primary">더 보기</a>
					                     </div>
					                  </div>
					              </div>
					          </div>
				           </c:forEach>
					   </div>
					</div>	  
				</div>
				<a class="carousel-control-prev" href="#carouselExample" role="button" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				</a>
				<a class="carousel-control-next" href="#carouselExample" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
				</a>
			</div>
			
			<!-- 베스트 리뷰 top4 -->
	        <div class="row p-3 my-4">
	            <h2 class="title p-2">베스트 리뷰 보러가기</h2>
				
				<c:forEach items="${bestList}" var="bestList">
	            <div class="col-md-3">
	                <div class="card">
	                	<c:if test="${bestList.filename ne 'imgNull'}">
	                    	<img src="${pageContext.request.contextPath}/resources/upload/${bestList.filename}" class="card-img-top" alt="..." height="200px">
	                    </c:if>
	                    <c:if test="${bestList.filename eq 'imgNull'}">
	                    	<img src="${pageContext.request.contextPath}/resources/img/default.jpg" class="card-img-top" alt="..." height="200px">
	                    </c:if>
	                    <div class="card-body">
	                            <h5 class="card-title">
	                            <!-- 제목 글자 길이 제한 -->
									<c:choose>
										<c:when test="${fn:length(bestList.title) > 14}">
											<c:out value="${fn:substring(bestList.title,0,13)}"/>....
										</c:when>
										<c:otherwise>
											<c:out value="${bestList.title}"/>
										</c:otherwise> 
									</c:choose>
	                            </h5>
	                        <div class="d-flex justify-content-between">
	                            <p>
	                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
	                                    <path d="M12.849 24l-3.96-7.853-4.889 4.142v-20.289l16 12.875-6.192 1.038 3.901 7.696-4.86 2.391zm-3.299-10.979l4.194 8.3 1.264-.617-4.213-8.313 4.632-.749-9.427-7.559v11.984l3.55-3.046z"/>
	                                </svg>
	                                <span>${bestList.viewCount}</span>
	                            </p>
	                            <p>
	                                <svg width="24" height="24" xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" clip-rule="evenodd">
	                                    <path d="M12 1c-6.338 0-12 4.226-12 10.007 0 2.05.739 4.063 2.047 5.625l-1.993 6.368 6.946-3c1.705.439 3.334.641 4.864.641 7.174 0 12.136-4.439 12.136-9.634 0-5.812-5.701-10.007-12-10.007m0 1c6.065 0 11 4.041 11 9.007 0 4.922-4.787 8.634-11.136 8.634-1.881 0-3.401-.299-4.946-.695l-5.258 2.271 1.505-4.808c-1.308-1.564-2.165-3.128-2.165-5.402 0-4.966 4.935-9.007 11-9.007"/>
	                                </svg>
	                                <span>${bestList.commentCount}</span>
	                            </p>
	                            <p>
	                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
	                                    <path d="M12 2c5.514 0 10 4.486 10 10s-4.486 10-10 10-10-4.486-10-10 4.486-10 10-10zm0-2c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm3.698 15.354c-.405-.031-.367-.406.016-.477.634-.117.913-.457.913-.771 0-.265-.198-.511-.549-.591-.418-.095-.332-.379.016-.406.566-.045.844-.382.844-.705 0-.282-.212-.554-.63-.61-.429-.057-.289-.367.016-.461.261-.08.677-.25.677-.755 0-.336-.25-.781-1.136-.745-.614.025-1.833-.099-2.489-.442.452-1.829.343-4.391-.845-4.391-.797 0-.948.903-1.188 1.734-.859 2.985-2.577 3.532-4.343 3.802v4.964c3.344 0 4.25 1.5 6.752 1.5 1.6 0 2.426-.867 2.426-1.333 0-.167-.136-.286-.48-.313z"/>
	                                </svg>
	                                <span>${bestList.goodCount}</span>
	                            </p>
	                        </div>
	                        <div class="d-flex justify-content-end">
	                            <a href="/board/reviewDetail?num=${bestList.num}&commentPage=1" class="btn btn-primary">더 보기</a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            </c:forEach>
	        </div>
			
		</div>
		<jsp:include page="${pageContext.request.contextPath}/resources/include/footer.jsp"/>
	</body>
</html>