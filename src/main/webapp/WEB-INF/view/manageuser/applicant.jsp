<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>구직자회원관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

$(function() {
	// 화면이 열렸을 때, 개인정보 데이터를 받아온다.
	applicantSearch();
	registerBtnEvent();
});
	
function registerBtnEvent(){
	$("#searchBtn").click(function(e){
		e.preventDefault();
		applicantSearch();
		});
		
	$("a[name=btn]").click(function(e){
		e.preventDefault();
			
		var btnId = $(this).attr("id");
			
		switch(btnId) {
		case "btnPwReset":
			pwReset();
			break;
			}
		})
}

/* 개인회원 리스트 조회 */
function applicantSearch(currentPage){
	currentPage = currentPage || 1;
		
	var param = {
			searchName: $("#searchName").val(),
			currentPage: currentPage,
			pageSize: 5
			}
		
	var callback = function(res){
		$("#resultList").html(res);
			
		var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "applicantSearch");
		$("#pageArea").html(pageNavi);
		}
	callAjax("/manage-user/applicantList.do", "post", "text", false, param, callback);
}

/* 클릭한 개인회원정보 가져오기(모달) */
function applicantManageModal(loginId){
	var param = { loginId : loginId }
		
	var callback = function(res) {
		var detail = res.detail;
		$("#newUserType").val(detail.userType);
		$("#loginId").val(detail.loginId);
		$("#newName").val(detail.name);
		$("#newSex").val(detail.sex);
		$("#newBirthday").val(detail.birthday);
		$("#newPhone").val(detail.phone);
		$("#newEmail").val(detail.email);
		$("#newRegdate").val(detail.regdate);
		$("#newStatusYn").val(detail.statusYn);
		$("#newZipCode").val(detail.zipCode);
		$("#newAddress").val(detail.address);
		$("#newDetailAddress").val(detail.detailAddress);
		gfModalPop("#appplicantManageModal");
		}
	callAjax("/manage-user/applicantManageDetail.do", "post", "json", false, param, callback)
}

/* 비밀번호 초기화 */
function pwReset(loginId){
	var param = { loginId : $("#loginId").val() }
	var callback = function(res){
		if(res.result === "success"){
			alert("비밀번호가 초기화되었습니다");
			}
		}
	callAjax("/manage-user/applicantPwReset.do", "post", "json", false, param, callback)
}

/* 회원정보 수정란 입력여부 확인 */
function regNewInfo(){
	
	var newName = $("#newName").val();
	var newSex = $("#newSex").val();
	var newBirthday = $("#newBirthday").val();
	var newPhone = $("#newPhone").val();
	var newEmail = $("#newEmail").val();
	var newRegdate = $("#newRegdate").val();
	var newStatusYn = $("#newStatusYn").val();
	var newZipCode = $("#newZipCode").val();
	var newAddress = $("#newAddress").val();
	
	if(newName.length < 1){
		swal("이름을 입력하세요.").then(function() {
			$('#newName').focus();
		  });
		return false;
	}
	
	if(newSex.length < 1){
		swal("성별을 선택해주세요.").then(function() {
			$('#newSex').focus();
		  });
		return false;
	}
	
	if(newBirthday.length < 1){
		swal("생년월일을 입력하세요.").then(function() {
			$('#newBirthday').focus();
		  });
		return false;
	}
	
	if(newPhone.length < 1){
		swal("전화번호를 입력하세요.").then(function() {
			$('#newPhone').focus();
		  });
		return false;
	}
	
	if(newEmail.length < 1){
		swal("이메일을 입력하세요.").then(function() {
			$('#newEmail').focus();
		  });
		return false;
	}
	
	if(newRegdate.length < 1){
		swal("가입일자를 입력하세요.").then(function() {
			$('#newRegdate').focus();
		  });
		return false;
	}
	if(newZipCode.length < 1){
		swal("우편번호를 입력하세요.").then(function() {
			$('#newZipCode').focus();
		  });
		return false;
	}
	if(newAddress.length < 1){
		swal("주소를 입력하세요.").then(function() {
			$('#newAddress').focus();
		  });
		return false;
	}
	return true;
}

/* 개인회원정보 수정완료 */
function CompleteApplicantInfoUpdate(){
	
	var param = $("#applicantUpdateForm").serialize();
	
	/*이메일 정규식*/
	var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var email = $("#newEmail").val();
	
	/* validation 체크 */
	if(!regNewInfo()){
		return;
	}
	console.log("vaildation 체크까지 완료");
	
	if(!emailRules.test($("#newEmail").val())){
		swal("이메일 형식을 확인해주세요.").then(function() {
			$("#newEmail").focus();
			console.log("이메일 형식 확인 진행");
		  }); 
	} else{
		console.log("callback 시작합니다.");
		
		// 모든 결과를 통과하면
		var callback = function(res) {
			if(res.result === "success"){
				swal("개인회원 정보가 수정되었습니다");
				gfCloseModal();
				applicantSearch();
				}
			}
		callAjax("/manage-user/applicantInfoUpdate.do", "post", "json", false, param, callback);
		}
}
	
/* 휴대폰 번호 필터링 */
function formatPhoneNumber() {
	var searchWord_std = document.getElementById("newPhone");
	
	// 숫자로만 이루어진 문자열인지 확인
	var phoneNumber = searchWord_std.value.replace(/[^0-9]/g, "");
	     
	// 처음 3자리가 허용된 번호인지 확인
	if (phoneNumber.length==3){
		var prefix = phoneNumber.substring(0, 3);
		if (["010", "019", "011", "016", "017"].indexOf(prefix) === -1) {
			alert("정확한 전화번호를 입력해주세요.");
			$("#newPhone").val("").focus();
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
	
/* 우편번호 api */
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
			document.getElementById("zipCode").value = data.zonecode;
			document.getElementById("address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("detailAddress").focus();
			}
	}).open({
		q : q
		});
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
								class="btn_nav bold">회원관리</span> <span class="btn_nav bold">개인회원
								</span> <a href="/manage-user/applicant.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>개인회원관리</span> <span class="fr">
		                     
		                     회원명
		                     <input type="text" id="searchName" name="searchname">
		      
		                       <a class="btnType blue" href="" id="searchBtn"><span>검색</span></a>
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">회원번호</th>
										<th scope="col">회원ID</th>
										<th scope="col">회원명</th>
										<th scope="col">이메일</th>
										<th scope="col">회원가입날짜</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody id="resultList"></tbody>
							</table>
						</div>
						
						<div class="paging_area" id="pageArea"> </div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 개인회원 정보수정 모달 -->
	<div id="appplicantManageModal" class="layerPop layerType2" style="width: 500px;">
		<form id="applicantUpdateForm" action="" method="post">
		<dl>
			<dt>
				<br>
				<br>
				<strong style="font-size:150%; padding-left: 5%;">개인회원정보</strong>
				<br>
				<br>
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
								<th scope="row">유저타입</th>
								<td colspan="3"><select name="userType" id="newUserType" style="width: 128px; height: 28px;">
										<option selected disabled>선택</option>
										<option value="A">개인회원</option>
										<option value="B">기업회원</option>
								</select></td>
							</tr>
							
							<tr>
								<th scope="row">아이디</th>
								<td colspan=3><input type="text" class="inputTxt" name="loginId" id="loginId" readonly/></td>
							</tr>
							
							<tr>
								<th scope="row">비밀번호</th>
								<td colspan="3"><a class="btnType gray"  name="btn" id="btnPwReset"><span>초기화</span></a></td>
							</tr>
							
							<tr>
								<th scope="row">이름</th>
								<td colspan="3"><input type="text" class="inputTxt" name="name" id="newName" /></td>
							</tr>
							
							<tr>
								<th scope="row">성별</th>
								<td colspan="3"><select name="sex" id="newSex" style="width: 128px; height: 28px;">
										<option selected disabled>선택</option>
										<option value="1">남자</option>
										<option value="2">여자</option>
								</select></td>
							</tr>
							
							<tr>
								<th scope="row">생년월일</th>
								<td colspan=3><input type="date" class="inputTxt" name="birthday" id="newBirthday" /></td>
							</tr>
							
							<tr>
								<th scope="row">전화번호</th>
								<td colspan=3><input type="text" class="inputTxt" name="phone" id="newPhone"
								placeholder="숫자만 입력" oninput="javascript:formatPhoneNumber()" /></td>
							</tr>
							
							<tr>
								<th scope="row">이메일</th>
								<td colspan=3><input type="text" class="inputTxt" name="email" id="newEmail" /></td>
							</tr>
							
							<tr>
								<th scope="row">가입일자</th>
								<td colspan=3><input type="date" class="inputTxt" name="regdate" id="newRegdate" /></td>
							</tr>
							
							<tr>
								<th scope="row">활성화</th>
								<td colspan="3"><select name="statusYn" id="newStatusYn" style="width: 128px; height: 28px;">
										<option selected disabled>선택</option>
										<option value="1">활성</option>
										<option value="2">비활성</option>
								</select></td>
							</tr>
							
							<tr>
								<th scope="row">우편번호</th>
								<td colspan="2"><input type="text" class="inputTxt p100" name="zipCode" id="newZipCode" /></td>
								<td><input type="button" value="우편번호 찾기" onclick="execDaumPostcode()" style="width: 130px; height: 28px;" /></td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="address" id="newAddress" /></td>
							</tr>
							<tr>
								<th scope="row">상세주소</th>
								<td colspan="3"><input type="text" class="inputTxt p100" name="detailAddress" id="newDetailAddress" /></td>
							</tr>
							
					</tbody>
				</table>
				
				<div class="btn_areaC mt30" style="margin-bottom: 30px;">
					<a href="javascript:CompleteApplicantInfoUpdate();" class="btnType blue" name="" id=""><span>수정</span></a> 
					<a href="" class="btnType gray" ><span>취소</span></a>
				</div>
				</dd>
			</dl>
			</form>
		</div>
	 
	
	
</body>
</html>