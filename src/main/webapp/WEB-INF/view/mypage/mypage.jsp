<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>회원정보수정</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- 우편번호 조회 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>

<script type="text/javascript">
	

$(function() {
	// 화면이 열렸을 때, 개인정보 데이터를 받아온다.
	detailUserinfo();
	registerBtnEvent();
	
});
	
function detailUserinfo(loginId){
	
	var param = { loginId: loginId }
		
	var callback = function(res) {
		var detail = res.detail;
		var bizIdx = res.chkRegBiz.bizIdx;
		
		$("#userId").val(detail.loginId);
		$("#userName").val(detail.name);
		$("#userSex").val(detail.sex);
		$("#userBirthday").val(detail.birthday);
		$("#userPhone").val(detail.phone);
		$("#userEmail").val(detail.email);
		$("#userZipCode").val(detail.zipCode);
		$("#userAddress").val(detail.address);
		$("#userDetailAddress").val(detail.detailAddress);
		
		if(bizIdx == 0){
			$("#bizRegister").show();
			$("#bizUpdate").hide();
			} else if(bizIdx > 0){
				$("#bizRegister").hide();
				$("#bizUpdate").show();
				} else {
					$("#bizRegister").hide();
					$("#bizUpdate").hide();
			}
		}
	callAjax("/mypage/userDetail.do", "post", "json", true, param, callback);
}
 
function updatePwModal(){
	$("#passwd").val("");
	$("#newPasswd").val("");
	$("#newPasswdConfirm").val("");
		 
	gfModalPop("#modifyModal");
		 
}
	 
function updatePw(){
	var param = {
			passwd: $("#passwd").val(),
			newPasswd: $("#newPasswd").val(),
			newPasswdConfirm: $("#newPasswdConfirm").val()
			}
		 
	var callback = function(res){
		if(res.result === "success"){
			alert("비밀번호가 변경되었습니다.\n새 비밀번호로 다시 로그인해주세요.");
			gfCloseModal();
			fLogOut();
			} else if(res.result === "fail1"){
				alert("현재 비밀번호가 일치하지 않습니다.");
			} else if(res.result === "fail2"){
				alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
			}
		}
		  callAjax("/mypage/updatePw.do", "post", "json", false, param, callback);
}

/* 회원정보 수정란 입력여부 확인 */
function regNewInfo(){
	
	var newName = $("#userName").val();
	var newSex = $("#userSex").val();
	var newBirthday = $("#userBirthday").val();
	var newPhone = $("#userPhone").val();
	var newEmail = $("#userEmail").val();
	var newZipCode = $("#userZipCode").val();
	var newAddress = $("#userAddress").val();

	
	if(newName.length < 1){
		swal("이름을 입력하세요.").then(function() {
			$('#userName').focus();
		  });
		return false;
	}
	
	if(newSex.length < 1){
		swal("성별을 선택해주세요.").then(function() {
			$('#userSex').focus();
		  });
		return false;
	}
	
	if(newBirthday.length < 1){
		swal("생년월일을 입력하세요.").then(function() {
			$('#userBirthday').focus();
		  });
		return false;
	}
	
	if(newPhone.length < 1){
		swal("전화번호를 입력하세요.").then(function() {
			$('#userPhone').focus();
		  });
		return false;
	}
	
	if(newEmail.length < 1){
		swal("이메일을 입력하세요.").then(function() {
			$('#userEmail').focus();
		  });
		return false;
	}
	
	if(newEmail.length < 1){
		swal("이메일을 입력하세요.").then(function() {
			$('#userEmail').focus();
		  });
		return false;
	}
	if(newZipCode.length < 1){
		swal("우편번호를 입력하세요.").then(function() {
			$('#userZipCode').focus();
		  });
		return false;
	}
	if(newAddress.length < 1){
		swal("우편번호를 입력하세요.").then(function() {
			$('#userAddress').focus();
		  });
		return false;
	}
	return true;
}

	
/* 비밀번호 입력여부 체크 */	 
function pwValidate() {
	var passwd = $('#passwd').val();
	var newPasswd = $('#newPasswd').val();
	var newPasswdConfirm = $('#newPasswdConfirm').val();
		 
	if(passwd.length < 1) {
		swal("비밀번호를 입력하세요.").then(function() {
			$('#passwd').focus();
			});
		return false;
	}
		 
	if(newPasswd.length < 1) {
		swal("새 비밀번호를 입력하세요.").then(function() {
			$('#newPasswd').focus();
			});
		return false;
	}
		 
	if(newPasswdConfirm.length < 1) {
		swal("새 비밀번호 확인을 입력하세요.").then(function() {
			$('#newPasswdConfirm').focus();
			});
		return false;
		}
	return true;
}

	 
	 
/* 비밀번호 변경 완료 */	 
function CompleteUpdatePw() {
	
	/*패스워드 정규식*/
	var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	var param = {
			passwd: $("#passwd").val(),
			newPasswd: $("#newPasswd").val(),
			newPasswdConfirm: $("#newPasswdConfirm").val()	
	}
	
	/* validation 체크 */
	if(!pwValidate()){
		return;
	}
	console.log("vaildation 체크까지 완료");
	
	if(!passwordRules.test($("#newPasswd").val())){
		swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
			$("#newPasswd").focus();
			console.log("비번 확인 진행");
		  });
	} else {
		
	console.log("callback 시작합니다.");
	
	// 모든 결과를 통과하면
	var callback = function(res) {
			if(res.result === "success"){
				alert("비밀번호가 변경되었습니다.\n다시 로그인해주세요.");
				fLogOut();
			} else if(res.result === "fail1"){
				swal("현재 비밀번호가 일치하지 않습니다.");
				$("#passwd").focus();
		} else if(res.result === "fail2"){
			swal("새 비밀번호와 확인이 일치하지 않습니다.");
			$("#newPasswd").focus();
		}
	}
	callAjax("/mypage/updatePw.do", "post", "json", true, param, callback);
	}
}

	 
/* 휴대폰 번호 필터링 */
function formatPhoneNumber() {
	var searchWord_std = document.getElementById("userPhone");
	     
	// 숫자로만 이루어진 문자열인지 확인
	var phoneNumber = searchWord_std.value.replace(/[^0-9]/g, "");
	     
	// 처음 3자리가 허용된 번호인지 확인
	if (phoneNumber.length==3){
		var prefix = phoneNumber.substring(0, 3);
		if (["010", "019", "011", "016", "017"].indexOf(prefix) === -1) {
			alert("정확한 전화번호를 입력해주세요.");
	 	    $("#userPhone").val("").focus();
	 	    return;  // 허용되지 않은 번호이면 함수를 종료
	 	    }
		}
	// 휴대폰 번호 형식에 맞게 하이픈 추가
	if (phoneNumber.length >= 3 && phoneNumber.length <= 7) {
		phoneNumber = phoneNumber.replace(/(\d{3})(\d{1,4})/, "$1-$2");
		} else if (phoneNumber.length >= 8) {
			phoneNumber = phoneNumber.replace(/(\d{3})(\d{3,4})(\d{0,4})/, "$1-$2-$3");
			}
	     
	// 13자리까지만 입력받기 (한국기준)
	if (phoneNumber.length > 13) {
		phoneNumber = phoneNumber.substring(0, 13);
		}
	     
	// 입력된 내용을 변경된 번호로 업데이트
	searchWord_std.value = phoneNumber;
}
	 
// 우편번호 api
function execDaumPostcode(q) {
	new daum.Postcode({
		oncomplete : function(data) {
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
	 	if (data.userSelectedType === 'R') {
	 		// 법정동명이 있을 경우 추가한다. (법정리는 제외)
	 		// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	 		if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	 			extraAddr += data.bname;
	 			}
	 		// 건물명이 있고, 공동주택일 경우 추가한다.
	 		if (data.buildingName !== '' && data.apartment === 'Y') {
	 			extraAddr += (extraAddr !== '' ? ', '
	 					  + data.buildingName : data.buildingName);
	 			}
	 		}

	 	// 우편번호와 주소 정보를 해당 필드에 넣는다.
	 	document.getElementById("userZipCode").value = data.zonecode;
	 	document.getElementById("userAddress").value = addr;
	 	// 커서를 상세주소 필드로 이동한다.
	 	document.getElementById("userDetailAddress").focus();
	 	}
	}).open({
		q : q
		});
}

/* 회원정보수정 완료*/
function CompleteUpdateMyInfo() {
	
	var param = $("#UpdateForm").serialize();
 	/*이메일 정규식*/
	var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var email = $("#userEmail").val();
	
	/* validation 체크 */
	if(!regNewInfo()){
		return;
	}
	
	console.log("vaildation 체크까지 완료");
		
	if(!emailRules.test($("#userEmail").val())){
		swal("이메일 형식을 확인해주세요.").then(function() {
			$("#userEmail").focus();
			console.log("이메일 형식 확인 진행");
		  }); 
	} else{
		console.log("callback 시작합니다.");
		
		// 모든 결과를 통과하면
		var callback = function(res) {
			if(res.result === "success"){
				swal("수정되었습니다");
			} 
		}
	
		callAjax("/mypage/updateUserInfo.do", "post", "json", false, param, callback);
		}
	}

</script>


</head>
<body>
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		
		
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb (메뉴) 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="/WEB-INF/view/mypage/mypage.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">마이페이지</span> <span class="btn_nav bold">회원정보수정
								</span> <a href="/mypage/update.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>회원정보수정</span> <span class="fr"></span>
                  		</p>
                  		
						<div class="divComGrpCodList">
						<form id="UpdateForm" action="" method="post">
								   
							<table class="row">
								<caption>caption</caption>
								<colgroup>
								<col width="120px">
								<col width="*">
								<col width="100px">
								<col width="*">
							</colgroup>
							
							<tbody>
							
							<tr class="hidden">
						 		<td><input type="text" name="user_type" id="user_type" /></td>
						 		<td><input type="text" name="bizIdx" id="bizIdx" /></td>
							</tr>
							
		
							<tr>
								<th scope="row">아이디</th>
								<td><input type="text" class="inputTxt" name="userId" id="userId" readonly style="width:200px;" /></td>
							</tr>
							
							<tr>
								<th scope="row">비밀번호</th>
								<td><a class="btnType blue" href="javascript:updatePwModal();"><span>수정</span></a></td>
							</tr>

							<tr>
								<th scope="row" id="registerName_th">이름 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt" name="name" id="userName" style="width:200px;" /></td>
							</tr>
							
							<tr>
								<th scope="row" id="rggender_th">성별 <span class="font_red">*</span></th>
								<td>
									<select name="sex" id="userSex" style="width: 150px; height: 28px;">
										<option value="" disabled>선택</option>
										<option value="1">남자</option>
										<option value="2">여자</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<th scope="row">생년월일<span class="font_red"> *</span></th>
								<td>
									<input type="date" class="inputTxt" name="birthday" id="userBirthday" style="width:200px;" />
								</td>
							</tr>
							
							<tr>
								<th scope="row">전화번호<span class="font_red">*</span></th>
								<td>
									<input type="text" name="phone" id="userPhone" placeholder="숫자만 입력"
									class="inputTxt" oninput="javascript:formatPhoneNumber()" style="width:200px;" />
								</td>
							</tr>
							
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt" name="email" id="userEmail" style="width:200px;" />
								</td> 
							</tr>
		
							<c:if test="${userType eq 'B'}">
							<tr>
								<th scope="row">기업정보</th>
								<td>
									<input type="button" id="bizRegister" value="등록" class="btnType blue" onclick="window.location='/company/companyWritePage.do'" style="width: 130px; height: 28px;" />		
									<input type="button" id="bizUpdate" value="수정" class="btnType blue" onclick="window.location='/company/companyUpdatePage.do'" style="width: 130px; height: 28px;" />
								</td>
							</tr>
							</c:if>
							
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt" name="zipCode" id="userZipCode" style="width:200px;" />
									<input type="button" value="우편번호 찾기" onclick="execDaumPostcode()" style="width: 120px; height: 28px;" />
								</td>
							</tr>
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt" name="address" id="userAddress" style="width:320px;" /></td>
							</tr>
							<tr>
								<th scope="row">상세주소</th>
								<td><input type="text" class="inputTxt" name="detailAddress" id="userDetailAddress" style="width:320px;"/></td>
							</tr>
				
							
							</table>
							<div>
								<a href="javascript:CompleteUpdateMyInfo();" class="btnType blue"><span>수정</span></a>
								<a href="/dashboard/dashboard.do" class="btnType black" id="cancelBtn"><span>취소</span></a>
							</div>
							</form>
						
						</div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 비밀번호 수정팝업 -->
	<div id="modifyModal" class="layerPop layerType2" style="width: 500px;">
		<dl>
			<dt>
				<strong>비밀번호 수정</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
							<tr>
								<th scope="row">현재 비밀번호 <span class="font_red">*</span></th>
									<td colspan=3><input type="password" class="inputTxt p100" name="passwd" id="passwd" /></td>
							</tr>
							<tr>
								<th scope="row">새 비밀번호 <span class="font_red">*</span></th>
									<td colspan="3"> <input type="password" class="inputTxt p100" name="newPasswd" id="newPasswd"
															placeholder="숫자,영문자,특수문자 조합으로 8~15자리"/></td>
							</tr>
							<tr>
								<th scope="row">새 비밀번호 확인 <span class="font_red">*</span></th>
									<td colspan=3><input type="password" class="inputTxt p100" name="newPasswdConfirm" id="newPasswdConfirm" /></td>
							</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="javascript:CompleteUpdatePw()" class="btnType blue" ><span>수정</span></a> 
					<a href="" class="btnType gray" ><span>취소</span></a>
				</div>
				</dl>
		</div>
	 	
	
</body>
</html>