<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>기업 정보 상세 조회</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	
	
	$(function() {
		var logicalPath = $("#logicalPath").val()
		var detail = {
				bizLogo: "${detail.bizLogo}",
				fileExt: "${detail.fileExt}",
				logicalPath: logicalPath
		};
		
		detailImgPreview(detail);
		// 페이지가 로드되면 기업 상세 정보를 불러온다.
	});


	function detailImgPreview(detail){
		if(detail.bizLogo){
			var ext = detail.fileExt.toLowerCase();
			var imgPath = "";
			var previewHtml = "<a href=''>";
			
			if(ext === "jpg" || ext === "gif" || ext === "png"){
				imgPath = detail.logicalPath;
				previewHtml += "<img src='" +imgPath+ "' id='imgFile' style='width:100px; height: 100px'>";
			}
			
			previewHtml += "</a>"
			
			$("#preview").html(previewHtml);
		} else {
			$("#preview").html("<p>로고 이미지가 없습니다.</p>");
		}
	} 
	function goToManageHire() {
		var userType = $("#userType").val();
		var bizIdx = $("#bizIdx").val();
		var postIdx = $("#postIdx").val();
		console.log("userType :" + userType);
		if (userType === "B") {
	        // "B" 사용자 타입일 때
	        window.location.href = "/manage-hire/managehireDetail.do/"+postIdx+"/"+bizIdx; // index를 쿼리 파라미터로 추가
	    } else if (userType === "M" || userType === "A") {
	        // "M" 또는 "A" 사용자 타입일 때
	        window.location.href = "/manage-post/"+postIdx+"/"+bizIdx; // index를 쿼리 파라미터로 추가
	    } else {
	        // 사용자 타입이 "B", "M", "A"가 아닐 경우의 처리
	        alert("알 수 없는 사용자 타입입니다.");
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
			<input type="hidden" id="logicalPath" name="logicalPath" value="${detail.logicalPath}">
			<input type="hidden" id="postIdx" name="postIdx" value="${sessionScope.postIdx}">
			<input type="hidden" id="userType" name="userType" value="${userType}">
		<form id="manageHireForm" action="/manage-hire/post.do">
			<input type="hidden" name="bizIdx" id="bizIdx"value="${detail.bizIdx }">
		</form>
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
							<a href="/WEB-INF/view/notice/notice.do" class="btn_set home">메인으로</a> 
								<span class="btn_nav bold">회원정보관리</span> 
								<span class="btn_nav bold">기업 상세 조회</span> 
							<a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
		
						<p class="conTitle">
		                     <span>기업 상세 조회</span>
                  		</p>
					<div class="divComGrpCodList">
				   		<table class="col">
							<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
							</colgroup>
					<thead>
						<tr>
							<th scope="col" colspan="4">기업로고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4"><div id="preview"></div></td>
						</tr>
					</tbody>		
					<thead>
						<tr>
							<th scope="col">사업자명</th>
							<th scope="col">사업자 대표</th>
							<th scope="col">연락처</th>
							<th scope="col">사업자 주소</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${detail.bizName}</td>
							<td>${detail.bizCeoName}</td>
							<td>${detail.bizContact}</td>
							<td>${detail.bizAddr}</td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<th scope="col">사원수</th>
							<th scope="col">홈페이지 주소</th>
							<th scope="col">설립일</th>
							<th scope="col">매출액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${detail.bizEmpCount}</td>
							<td>${detail.bizWebUrl}</td>
							<td>${detail.bizFoundDate}</td>
							<td>${detail.bizRevenue}</td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<th scope="col" colspan="4">기업소개</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4">${detail.bizIntro}</td>
						</tr>
					</tbody>
				</table>
				</div>
			<div class="paging_area" id="pageArea"> </div>
					<!--// content -->
								<h3 class="hidden">풋터 영역</h3>
								<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				<div class="btn_area" style="text-align: right; margin-top:10px;">
					<a href="javascript:goToManageHire()" class="btnType blue" ><span>기업 지원공고 확인하기</span></a>
				</div>
				</div>
				<!-- <div class="paging_area" id="pageArea"> </div>  -->
					<!--// content -->
				 <h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include> 
			 	</li>
			</ul>
		</div>
	</div>
</body>
</html>