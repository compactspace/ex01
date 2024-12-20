<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>기업회원관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	

$(function() {
	// 화면이 열렸을 때, 기업회원 데이터를 받아온다.
	bizSearch();
	registerBtnEvent();
});
	
function registerBtnEvent(){
	$("#searchBtn").click(function(e){
		e.preventDefault();
		bizSearch();
		});
}

/* 기업회원 리스트 조회 */	
function bizSearch(currentPage){
	currentPage = currentPage || 1;
		
	var param = {
			searchName: $("#searchName").val(),
			currentPage: currentPage,
			pageSize: 5
			}
		
	var callback = function(res){
		$("#resultList").html(res);
			
		var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "bizSearch");
		$("#pageArea").html(pageNavi);
		}
	callAjax("/manage-user/bizList.do", "post", "text", false, param, callback);
}

/* 클릭한 기업회원정보 가져오기(모달) */	
function bizManageModal(bizIdx){
	var param = { bizIdx : bizIdx }
		
	var callback = function(res) {
		var detail = res.detail;
		$("#bizIdx").val(detail.bizIdx);
		$("#bizName").val(detail.bizName);
		$("#bizCeoName").val(detail.bizCeoName);
		$("#bizEmpCount").val(detail.bizEmpCount);
		$("#bizRevenue").val(detail.bizRevenue);
		$("#bizContact").val(detail.bizContact);
		$("#bizAddr").val(detail.bizAddr);
		$("#bizWebUrl").val(detail.bizWebUrl);
		$("#bizFoundDate").val(detail.bizFoundDate);
		$("#bizIntro").val(detail.bizIntro);
			
		gfModalPop("#bizManageModal");
		}
	callAjax("/manage-user/bizManageDetail.do", "post", "json", false, param, callback)
}

/* 기업회원 정보수정란 입력여부 확인 */
function regNewInfo(){
	
	var newBizName = $("#bizName").val();
	var newBizCeoName = $("#bizCeoName").val();
	var newBizEmpCount = $("#bizEmpCount").val();
	var newBizRevenue = $("#bizRevenue").val();
	var newBizContact = $("#bizContact").val();
	var newBizAddr = $("#bizAddr").val();
	var newBizWebUrl = $("#bizWebUrl").val();
	var newBizFoundDate = $("#bizFoundDate").val();
	var newBizIntro = $("#bizIntro").val();
	
	if(newBizName.length < 1){
		swal("사업자명을 입력하세요.").then(function() {
			$('#bizName').focus();
		  });
		return false;
	}
	
	if(newBizCeoName.length < 1){
		swal("대표자를 입력하세요.").then(function() {
			$('#bizCeoName').focus();
		  });
		return false;
	}
	
	if(newBizEmpCount.length < 1){
		swal("사원수를 입력하세요.").then(function() {
			$('#bizEmpCount').focus();
		  });
		return false;
	}
	
	if(newBizRevenue.length < 1){
		swal("매출액을 입력하세요.").then(function() {
			$('#bizRevenue').focus();
		  });
		return false;
	}
	
	if(newBizContact.length < 1){
		swal("연락처를 입력하세요.").then(function() {
			$('#bizContact').focus();
		  });
		return false;
	}
	
	if(newBizAddr.length < 1){
		swal("사업자 주소를 입력하세요.").then(function() {
			$('#bizAddr').focus();
		  });
		return false;
	}
	if(newBizWebUrl.length < 1){
		swal("홈페이지 주소를 입력하세요.").then(function() {
			$('#bizWebUrl').focus();
		  });
		return false;
	}
	if(newBizFoundDate.length < 1){
		swal("설립일을 입력하세요.").then(function() {
			$('#bizFoundDate').focus();
		  });
		return false;
	}
	if(newBizIntro.length < 1){
		swal("회사소개를 입력하세요.").then(function() {
			$('#bizIntro').focus();
		  });
		return false;
	}
	return true;
}

/* 기업회원정보 수정완료 */
function CompleteBizInfoUpdate(){
	
	var param = $("#bizUpdateForm").serialize();
	
	/* validation 체크 */
	if(!regNewInfo()){
		return;
	console.log("vaildation 체크까지 완료");
	} else{
		console.log("callback 시작합니다.");
		
		// 모든 결과를 통과하면
		var callback = function(res) {
			if(res.result === "success"){
				swal("기업회원 정보가 수정되었습니다");
				gfCloseModal();
				bizSearch();
				}
			}
		callAjax("/manage-user/bizInfoUpdate.do", "post", "json", false, param, callback);
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
								class="btn_nav bold">회원관리</span> <span class="btn_nav bold">기업회원
								</span> <a href="/manage-user/biz.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>기업회원관리</span>
		                     	<span class="fr">기업명
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
									<col width="15%">
									<col width="20%">
									<col width="25%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">사업자번호</th>
										<th scope="col">사업자명</th>
										<th scope="col">대표자</th>
										<th scope="col">연락처</th>
										<th scope="col">홈페이지</th>
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
	
	<!-- 기업회원 정보수정 모달 -->
	<div id="bizManageModal" class="layerPop layerType2" style="width: 500px;">
	<form id="bizUpdateForm" action="" method="post">
		<dl>
			<dt>
				<br>
				<br>
				<strong style="font-size:150%; padding-left: 5%;">기업회원정보</strong>
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
								<th scope="row">사업자번호</th>
								<td colspan=3><input type="text" class="inputTxt" name="bizIdx" id="bizIdx" readonly/></td>
							</tr>
							<tr>
								<th scope="row">사업자명</th>
								<td colspan="3"><input type="text" class="inputTxt" name="bizName" id="bizName" /></td>
							</tr>
							<tr>
								<th scope="row">대표자</th>
								<td colspan=3><input type="text" class="inputTxt" name="bizCeoName" id="bizCeoName" /></td>
							</tr>
							<tr>
								<th scope="row">사원수</th>
								<td colspan=3><input type="text" class="inputTxt" name="bizEmpCount" id="bizEmpCount" /></td>
							</tr>
							<tr>
								<th scope="row">매출액</th>
								<td colspan=3><input type="text" class="inputTxt" name="bizRevenue" id="bizRevenue" /></td>
							</tr>
							<tr>
								<th scope="row">연락처</th>
								<td colspan=3><input type="text" class="inputTxt" name="bizContact" id="bizContact" /></td>
							</tr>
							<tr>
								<th scope="row">사업자 주소</th>
								<td colspan="3"><input type="text" class="inputTxt" name="bizAddr" id="bizAddr" /></td>
							</tr>
							<tr>
								<th scope="row">홈페이지 주소</th>
								<td colspan=3><input type="url" class="inputTxt" name="bizWebUrl" id="bizWebUrl" /></td>
							</tr>
							<tr>
								<th scope="row">설립일</th>
								<td colspan=3><input type="date" class="inputTxt" name="bizFoundDate" id="bizFoundDate" /></td>
							</tr>
							<tr>
								<th scope="row">회사소개</th>
								<td colspan=3><input type="text" class="inputTxt" name="bizIntro" id="bizIntro" /></td>
							</tr>
							
					</tbody>
				</table>
				
				<div class="btn_areaC mt30" style="margin-bottom: 30px;">
					<a href="javascript:CompleteBizInfoUpdate();" class="btnType blue" name="" id=""><span>수정</span></a> 
					<a href="" class="btnType gray" ><span>취소</span></a>
				</div>
				</dd>
			</dl>
			</form>
		</div>
	 
	
	
</body>
</html>