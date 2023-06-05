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
		<title>마이페이지</title>
	</head>
	<body class="bg-secondary">
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
	
		<div class="container bg-white my-5 p-5">
			<div class="row">
			   <div class="col-md-12">
			      <h1>MyPage</h1>
					<form action="/member/myPageUpdate" method="post">
						<c:forEach var="userInfo" items="${userInfo}">
						<div class="form-group my-3">
						    <label for="name">No. : </label>
						    <input type="text" class="form-control-sm border-0" id="userId" name="userId" required value="${userInfo.userId}" readonly="readonly">
						</div>
						<div class="form-group my-3">
						    <label for="name">이름:</label>
						    <input type="text" class="form-control" id="userName" name="userName" required value="${userInfo.userName}" disabled="disabled">
						</div>
						<div class="form-group my-3">
						   	<label for="nickname">닉네임:</label>
						   	<div class="input-group">
						   		<input type="text" class="form-control" id="userNickname" name="userNickname" required value="${userInfo.userNickname}" onchange="nickNameChange()" readonly="readonly">
						   		<a id="nickChangeBtn" class="btn btn-secondary">수정</a>
						   	</div>
						</div>
						
						<!-- 닉네임 수정 버튼 클릭 시 값을 비우고 focus -->
						<script>
						$("#nickChangeBtn").click(function() {
							$("#userNickname").removeAttr("readonly");
							$("#userNickname").val("");
							$("#userNickname").focus();
						});
						</script>
						
						<div class="form-group my-3">
						   <label for="email">이메일:</label>
						   <input type="email" class="form-control" id="userEmail" name="userEmail" required value="${userInfo.userEmail}" disabled="disabled">
						</div>
						<div class="form-group my-3">
						   <label for="password">비밀번호:</label>
						   <div class="input-group">
						    <input type="password" class="form-control" id="userPw" name="userPw" required value="${userInfo.userPw}" readonly="readonly">
						    <a id="pwChangeBtn" class="btn btn-secondary">수정</a>
						   </div>
						</div>
						
						<!-- 비밀번호 수정 버튼 클릭 시 값을 비우고 focus -->
						<script>
						$("#pwChangeBtn").click(function() {
							$("#userPw").removeAttr("readonly");
							$("#userPw").val("");
							$("#userPw").focus();
						});
						</script>
						         
						<div class="form-group my-3 my-3 d-flex justify-content-start">
							<label for="userGender">성별:</label>
							<div class="form-check mx-2">
								<input class="form-check-input" type="radio" name="userGender" id="male" value="1" required disabled="disabled">
								<label class="form-check-label">
								남성
								</label>
							</div>
							<div class="form-check mx-2">
								<input class="form-check-input" type="radio" name="userGender" id="female" value="2" required disabled="disabled">
								<label class="form-check-label">
								여성
								</label>
							</div>
						</div>
						
						<!-- 유저의 성별이 체크되어 있는 상태 -->
						<script>
						$(function() {
							var male = 1;
							var female = 2;
							var selected = ${userInfo.userGender};
							
							if(male === selected) {
								$("#male").attr('checked', 'checked');
							}else if(female === selected) {
								$("#female").attr('checked', 'checked');
							}
						});
						</script>
						
						<div class="form-group my-3">
							<label for="dob">생일:</label>
							<input type="text" class="form-control" id="userBirth" name="userBirth" required value="${userInfo.userBirth }" disabled="disabled">
						</div>
						
						<div class="form-group my-3">
							<label for="userDo">지역:</label>
							<select class="form-select-sm" id="userDo" name="userDo" required="required">
								<c:forEach items="${selectDo}" var="selectDo">
									<option id="area_${selectDo.doId}" value="${selectDo.doId}">${selectDo.doName}</option>
									
									<!-- 회원의 주소 아이디와 주소 선택란의 아이디가 같으면 selected 속성 추가 -->
									<script>
										$(function() {
											var choice = ${selectDo.doId};
											var selected = ${userInfo.userDo};
											
											if(choice == selected) {
												$("#area_" + selected).attr('selected', 'selected');
											}
										});
									</script>
									
								</c:forEach>
							</select>
						</div>
						
						<label>주소:</label>
						<div id="oldAddress" class="input-group">
				            <input type="text" name="oldAddr" class="form-control" value="${userInfo.userAddr }" required readonly="readonly">
							<a id="addrChangeBtn" class="btn btn-secondary">수정</a>
						</div>
						
						<script>
						    $(document).on("click", "#addrChangeBtn", function() {
						        $("#newAddress").removeClass("d-none");
						        $("#addrChangeBtn").html("수정 취소");
						        $("#addrChangeBtn").removeClass("btn-secondary");
						        $("#addrChangeBtn").addClass("btn-danger");
						        $("#addrChangeBtn").prop("id", "addrCancelBtn");
						    });
						
						    $(document).on("click", "#addrCancelBtn", function() {
						        $("#newAddress").addClass("d-none");
						        $("#addrCancelBtn").html("수정");
						        $("#addrCancelBtn").addClass("btn-secondary");
						        $("#addrCancelBtn").removeClass("btn-danger");
						        $("#addrCancelBtn").prop("id", "addrChangeBtn");
						    });
						</script>
						
						<div id="newAddress" class="form-group d-none">
							<div class="d-flex my-1">
								<input type="text" id="userAddr1" class="form-control me-1" name="userAddr1" placeholder="우편번호">
								<input type="button" onclick="findAddress()" class="btn btn-secondary" value="우편번호 찾기">
							</div>
							<input class="form-control" type="text" id="userAddr2" name="userAddr2" placeholder="주소">
							<div class="d-flex my-1">
								<input class="form-control" type="text" id="userAddr3" name="userAddr3" placeholder="상세주소">
								<input class="form-control" type="text" id="userAddr4" name="userAddr4" placeholder="참고항목">
							</div>
						</div>
						
						<!-- 주소찾기 API, javascript -->
						<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script>
						    function findAddress() {
						        new daum.Postcode({
						            oncomplete: function(data) {
						                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						
						                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
						                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						                var addr = ''; // 주소 변수
						                var extraAddr = ''; // 참고항목 변수
						
						                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						                    addr = data.roadAddress;
						                } else { // 사용자가 지번 주소를 선택했을 경우(J)
						                    addr = data.jibunAddress;
						                }
						
						                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						                if(data.userSelectedType === 'R'){
						                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
						                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						                        extraAddr += data.bname;
						                    }
						                    // 건물명이 있고, 공동주택일 경우 추가한다.
						                    if(data.buildingName !== '' && data.apartment === 'Y'){
						                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						                    }
						                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						                    if(extraAddr !== ''){
						                        extraAddr = ' (' + extraAddr + ')';
						                    }
						                    // 조합된 참고항목을 해당 필드에 넣는다.
						                    document.getElementById("userAddr4").value = extraAddr;
						                
						                } else {
						                    document.getElementById("userAddr4").value = '';
						                }
						
						                // 우편번호와 주소 정보를 해당 필드에 넣는다.
						                document.getElementById('userAddr1').value = data.zonecode;
						                document.getElementById("userAddr2").value = addr;
						                // 커서를 상세주소 필드로 이동한다.
						                document.getElementById("userAddr3").focus();
						            }
						        }).open();
						    }
						</script>
						
						<div class="form-group my-3">
						   <label for="join-date">가입일:</label>
						   <input type="text" class="form-control" id="joinDate" name="joinDate" value='<fmt:formatDate value="${userInfo.joinDate}" dateStyle="long"/>' required disabled>
						</div>
						</c:forEach>
						
						<div class="d-flex justify-content-end">
							<input type="submit" class="btn btn-outline-primary mx-1" value="저장">
							<a id="pageBack" class="btn btn-outline-danger">취소</a>
						</div>
						
						<!-- 취소 버튼 클릭시 이전 페이지로 이동 -->
						<script>
							$("#pageBack").click(function() {
								window.history.back();
							});
						</script>
					</form>
					<div class="d-flex justify-content-center my-5">
						<button id="userDeleteBtn" class="btn btn-danger">회원탈퇴</button>
					</div>
					
					<!-- 회원 탈퇴 버튼을 클릭 시 경고문을 출력하고 확인을 누르면 회원탈퇴 진행 -->
					<script>
						$("#userDeleteBtn").click(function() {
							if(window.confirm("정말 탈퇴하시겠습니까?")) {
								location.href = "/member/userDelete";
							}
						});
					</script>
					
			   </div>
			</div>
		</div>
	<jsp:include page="${pageContext.request.contextPath}/resources/include/footer.jsp"/>
	</body>
</html>