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
		<title>회원가입</title>
	</head>
	<body class="bg-secondary">
		<jsp:include page="${pageContext.request.contextPath}/resources/include/header.jsp"/>
		<div class="container bg-white">
			<div class="row justify-content-center mt-5">
				<div class="com-md-3"></div>
				<div class="col-md-6 p-5">
					<h1 class="text-center my-5">회원가입</h1>
					<form action="/member/join.do" method="POST">
						<div class="form-group my-3">
							<label for="userEmail">이메일:</label>
							<div class="input-group">
								<input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요." required>
								<button type="button" id="checkEmailBtn" class="btn btn-secondary" onclick="emailChk()" value="0">중복확인</button>
							</div>
						</div>
						
						<!-- 이메일 중복 체크 -->
						<script>
							function emailChk() {
								var userEmail = $('#userEmail').val();
								
								$.ajax({
									url: '/member/emailDupChk',
									type: 'POST',
									data: {userEmail : userEmail},
									success: function(result) {
							            if (result === "dup") {
							                alert('이미 사용중인 이메일입니다.');
							                $('#userEmail').val('');
							                $('#userEmail').focus();
							                $("#checkEmailBtn").val("0");
							            } else if (result === "nodup") {
							                alert('사용 가능한 이메일입니다.');
							                $("#checkEmailBtn").val("1");
							            } else if (result === "null") {
							                alert('사용할 이메일을 입력해주세요.');
							                $('#userEmail').val('');
							                $('#userEmail').focus();
							                $("#checkEmailBtn").val("0");
							            } else {
							                alert('올바른 응답을 받지 못했습니다: ' + result);
							            }
							        },
							        error: function() {
							            alert('데이터 전송 에러');
							        }
								});
							};
						</script>
						
						<div class="form-group my-3">
							<label for="userPw">비밀번호:</label>
							<input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요." required>
						</div>
						<div class="form-group my-3">
							<label for="userPw">비밀번호 확인:</label>
							<input type="password" class="form-control" id="userPwConfirm" placeholder="비밀번호 확인" required>
							<div class="d-flex justify-content-center">
								<div class="confirm-alert"></div>
							</div>
						</div>
						
						<!-- 비밀번호 확인 -->
						<script>
							$("#userPw").change(function() {
								let userPw = $("#userPw").val();
								let userPwConfirm = $("#userPwConfirm").val();
								
								console.log(userPw);
								console.log(userPwConfirm);
								
								if(userPw === userPwConfirm) {
									$(".confirm-alert").html("<p class='my-1 text-primary pwChk'>비밀번호가 일치합니다.</p>");
								}else if(userPw == ""){
									$(".confirm-alert").html("<p class='my-1 text-warning pwChk'>비밀번호를 입력해주세요.</p>");
								}else if(userPw != userPwConfirm) {
									$(".confirm-alert").html("<p class='my-1 text-danger pwChk'>비밀번호가 일치하지 않습니다.</p>");
								}
							});
							
							$("#userPwConfirm").change(function() {
								let userPw = $("#userPw").val();
								let userPwConfirm = $("#userPwConfirm").val();
								
								console.log(userPw);
								console.log(userPwConfirm);
								
								if(userPw === userPwConfirm) {
									$(".confirm-alert").html("<p class='my-1 text-primary pwChk'>비밀번호가 일치합니다.</p>");
								}else if(userPw == ""){
									$(".confirm-alert").html("<p class='my-1 text-warning pwChk'>비밀번호를 입력해주세요.</p>");
								}else if(userPw != userPwConfirm) {
									$(".confirm-alert").html("<p class='my-1 text-danger pwChk'>비밀번호가 일치하지 않습니다.</p>");
								}
							});
						</script>
						
						<div class="form-group my-3">
							<label for="userName">이름:</label>
							<input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력하세요." required>
						</div>
						<div class="form-group my-3">
							<label for="userNickname">별명:</label>
							<div class="input-group">
								<input type="text" class="form-control" id="userNickname" name="userNickname" placeholder="별명을 입력하세요." required>
								<button type="button" id="checkNickBtn" class="btn btn-secondary" onclick="nickNameChk()" value="0">중복확인</button>
							</div>
						</div>
						
						<!-- 닉네임 중복 체크 -->
						<script>
							function nickNameChk() {
								var userNickname = $('#userNickname').val();
								
								$.ajax({
									url: '/member/nickNameChk',
									type: 'POST',
									data: {userNickname : userNickname},
									success: function(result) {
							            if (result === "dup") {
							                alert('이미 사용중인 닉네임입니다.');
							                $('#userNickname').val('');
							                $('#userNickname').focus();
							                $("#checkNickBtn").val("0");
							            } else if (result === "nodup") {
							                alert('사용 가능한 닉네임입니다.');
							                $("#checkNickBtn").val("1");
							            } else if (result === "null") {
							                alert('사용할 닉네임을 입력해주세요.');
							                $('#userNickname').val('');
							                $('#userNickname').focus();
							                $("#checkNickBtn").val("0");
							            } else {
							                alert('올바른 응답을 받지 못했습니다: ' + result);
							            }
							        },
							        error: function() {
							            alert('데이터 전송 에러');
							        }
								});
							};
						</script>
						
						<div class="form-group my-3 d-flex justify-content-start">
							<label for="userGender">성별:</label>
							<div class="form-check mx-2">
								<input class="form-check-input" type="radio" name="userGender" id="userGender" value="1" required>
								<label class="form-check-label">
								  남성
								</label>
							</div>
							<div class="form-check mx-2">
								<input class="form-check-input" type="radio" name="userGender" id="userGender" value="2" required>
								<label class="form-check-label">
								  여성
								</label>
							</div>
						</div>
						<div class="form-group my-3">
							<label for="userBirth">생일:</label>
							<input type="date" class="form-control-sm" id="userBirth" name="userBirth" required>
						</div>
						<div class="form-group my-3">
							<label for="userDo">지역:</label>
							<select class="form-select-sm" id="userDo" name="userDo">
								<c:forEach items="${selectDo}" var="selectDo">
								<option value="${selectDo.doId}">${selectDo.doName}</option>
							</c:forEach>
							</select>
						</div>

						<!-- <div class="form-group my-3">
							<label for="userAddr">상세 주소:</label>
							<input type="text" class="form-control" id="userAddr" name="userAddr" placeholder="나머지 주소 입력" required>
						</div> -->
						
						<div class="form-group">
							<label>주소:</label>
							<div class="d-flex my-1">
								<input type="text" id="userAddr1" class="form-control me-1" name="userAddr1" placeholder="우편번호">
								<input type="button" onclick="findAddress()" class="btn btn-secondary" value="우편번호 찾기">
							</div>
							<input class="form-control" type="text" id="userAddr2" name="userAddr2" placeholder="주소">
							<div class="d-flex">
								<input class="form-control" type="text" id="userAddr3" name="userAddr3" placeholder="상세주소">
								<input class="form-control" type="text" id="userAddr4" name="userAddr4" placeholder="참고항목">
							</div>
						</div>
						
						<!-- 주소찾기 API javascript -->
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
						
						<div class="d-flex justify-content-end my-3">
							<input id="joinBtn" type="button" value="회원가입" class="btn btn-primary" onclick="duplicationChk()">
						</div>
						
						<!-- 이메일과 닉네임의 중복체크를 해야만 회원가입이 가능 -->
						<script>
							function duplicationChk() {
								if($("#checkEmailBtn").val() == 0) {
									alert("이메일 중복 확인 후 이용해주세요.");
									$("#userEmail").focus();
								}else if($("#checkNickBtn").val() == 0) {
									alert("닉네임 중복 확인 후 이용해주세요.");
									$("#userNickname").focus();
								}else if($('.pwChk').html() != "비밀번호가 일치합니다.") {
									alert("비밀번호를 확인해주세요.");
									$("#userPw").val("");
									$("#userPwConfirm").val("");
									$("#userPw").focus();
								}else {
									$("#joinBtn").prop("type", "submit");
								}
							}
						</script>
						
					</form>
				</div>	
				<div class="com-md-3"></div>
			</div>
		</div>
		<jsp:include page="${pageContext.request.contextPath}/resources/include/footer.jsp"/>
	</body>
</html>