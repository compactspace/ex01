<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	
	$(function() {
		// 화면이 열렸을 때, 공지사항 데이터를 받아온다.
		noticeSearch();
		registerBtnEvent();
		filePreview();
	});
	
	function filePreview() {
		$("#fileInput").change(function(e){
			e.preventDefault();
			
			var file = $(this)[0].files[0];
			
			if($(this)[0].files[0]){
				var fileInfo = $("#fileInput").val();
				var fileInfoSplit = fileInfo.split(".");
				var fileLowerCase = fileInfoSplit[1].toLowerCase();
				
				var imgPath = "";
				var previewHtml = "";
				
				if(fileLowerCase === "jpg" || fileLowerCase === "gif" || fileLowerCase === "png"){
					imgPath = window.URL.createObjectURL($(this)[0].files[0]);

					previewHtml = "<img src='" +imgPath+ "' id='imgFile' style='width:100px; height: 100px'>";
				}
				$("#preview").html(previewHtml);
			}
		})
	} 
	
	
	function registerBtnEvent(){
		$("#searchBtn").click(function(e){
			e.preventDefault();
			noticeSearch();
		});
		
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr("id");
			
			switch(btnId) {
			case "btnSaveNotice":
				validate(btnId);
				break;
			case "btnUpdateNotice":
				validate(btnId);
				break;
			case "btnDeleteNotice":
				noticeDelete();
				break;
			case "noticeFileSave":
				validate(btnId);
				break;
			case "noticeFileUpdate":
				validate(btnId);
				break;
			case "noticeFileDelete":
				noticeFileDelete();
				break;
			}
		})
	}
	
	function noticeFileDelete(){
		var getForm = document.getElementById("noticeForm");
		getForm.entype = 'multipart/form-data';
		
		var fileData = new FormData(getForm);
		
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/board/noticeFileDelete.do", "post", "json", false, fileData, callback);
	}
	
	function noticeFileUpdate(){
		var getForm = document.getElementById("noticeForm");
		getForm.entype = 'multipart/form-data';
		
		var fileData = new FormData(getForm);
		
		var callback = function(res){
			if(res.result === "success"){
				alert("수정되었습니다");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/board/noticeFileUpdate.do", "post", "json", false, fileData, callback);
	}
	
	function noticeFileSave(){
		var getForm = document.getElementById("noticeForm");
		getForm.entype = 'multipart/form-data';
		
		var fileData = new FormData(getForm);
		
		var callback = function(res){
			if(res.result === "success"){
				alert("저장되었습니다");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/board/noticeFileSave.do", "post", "json", false, fileData, callback);
	}
	
	
	
	function noticeSearch(currentPage){
		currentPage = currentPage || 1;
		
		// 공지사항 데이터를 불러오는 로직
		var param = {
				searchTitle: $("#searchTitle").val(),
				searchStDate: $("#searchStDate").val(),
				searchEdDate: $("#searchEdDate").val(),
				currentPage: currentPage,
				pageSize: 5
		}
		
		var callback = function(res){
			console.log(res);
			$("#resultList").html(res);
			
			var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "noticeSearch");
			$("#pageArea").html(pageNavi);
		}
		
		callAjax("/board/noticeList.do", "post", "text", false, param, callback);
		
	}
	
	function insertModal(){
		
		$("#btnSaveNotice").show();
		$("#btnUpdateNotice").hide();
		$("#btnDeleteNotice").hide();
		$("#noticeTit").val("");
		$("#noticeCon").val("");
		
		gfModalPop("#saveModal")
	}
	
	function insertFileModal(){
		$("#noticeFileSave").show();
		$("#noticeFileUpdate").hide();
		$("#noticeFileDelete").hide();
		$("#noticeFileTit").val("");
		$("#noticeFileCon").val("");
		$("#fileInput").val("");
		$("#preview").val("");
		
		gfModalPop("#fileModal")
	}
	
	function noticeSave(){
		var param = {
				title: $("#noticeTit").val(),
				context: $("#noticeCon").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("저장되었습니다");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjax("/board/noticeSave.do", "post", "json", false, param, callback)
		
	}
	
	function noticeUpdate(){
		var param = {
				title: $("#noticeTit").val(),
				context: $("#noticeCon").val(),
				noticeSeq: $("#noticeSeq").val()
				
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("수정되었습니다");
				gfCloseModal();
				noticeSearch();
			}
		}
		callAjax("/board/noticeUpdate.do", "post", "json", false, param, callback);
	}
	
	function noticeDelete(){
		var param = {
				noticeSeq: $("#noticeSeq").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjax("/board/noticeDelete.do", "post", "json", false, param, callback);
	}
	
	function noticeDetailModal(noticeSeq){
		var param = {
				noticeSeq : noticeSeq
		}
		
		var callback = function(res){
			var detail = res.detail;
			
			$("#noticeSeq").val(detail.noticeIdx);
			$("#btnSaveNotice").hide();
			$("#btnUpdateNotice").show();
			$("#btnDeleteNotice").show();
			$("#noticeTit").val(detail.title);
			$("#noticeCon").val(detail.content);
			gfModalPop("#saveModal");
		}
		
		callAjax("/board/noticeDetail.do", "post", "json", false, param, callback)
	}
	
	function noticeDetailFileModal(noticeSeq){
		var param = {
				noticeSeq : noticeSeq
		}
		
		var callback = function(res){
			var detail = res.detail;
			$("#noticeSeq").val(detail.noticeIdx);
			$("#noticeFileCon").val(detail.content);
			$("#noticeFileTit").val(detail.title);
			$("#noticeFileSave").hide();
			$("#noticeFileUpdate").show();
			$("#noticeFileDelete").show();
			
			detailImgPreview(detail);
			
			gfModalPop("#fileModal");
		}
		
		callAjax("/board/noticeDetailFile.do", "post", "json", false, param, callback)
	}
	
	// 상세조회 이미지
	function detailImgPreview(detail){
		if(detail.fileName){
			var ext = detail.fileExt.toLowerCase();
			var imgPath = "";
			var previewHtml = "<a href='javascript:download()'>";
			
			if(ext === "jpg" || ext === "gif" || ext === "png"){
				imgPath = detail.logicalPath;
				previewHtml += "<img src='" +imgPath+ "' id='imgFile' style='width:100px; height: 100px'>";
			}
			
			previewHtml += "</a>"
			
			$("#preview").html(previewHtml);
			
		}
	} 
	
	function download() {
		var noticeSeq = $("#noticeSeq").val();
		
		var hiddenInput = "<input type='hidden' name='noticeSeq' value='" + noticeSeq + "' />";
		$("<form action='noticeDownload.do' method='post' id='fileDownload'>" + hiddenInput + "</form>")
		.appendTo('body').submit().remove();
	}
	
	function validate(btnId) {
		var tit = $('#noticeTit').val();
		var con = $('#noticeCon').val();
		var fileTit = $('#noticeFileTit').val();
		var fileCon = $('#noticeFileCon').val();
		
		if (btnId === "btnSaveNotice" || btnId === "btnUpdateNotice") {
			if(tit.length < 1 ) {
				swal("제목을 입력하세요.").then(function() {
					$('#noticeTit').focus();
				  });
				return false;
			}
			
			if(con.length < 1 ) {
				swal("내용을 입력하세요.").then(function() {
					$('#noticeCon').focus();
				  });
				return false;
			}
		}
		
		if (btnId === "noticeFileSave" || btnId === "noticeFileUpdate") {
			if(fileTit.length < 1 ) {
				swal("제목을 입력하세요.").then(function() {
					$('#noticeFileTit').focus();
				  });
				return false;
			}
			
			if(fileCon.length < 1 ) {
				swal("내용을 입력하세요.").then(function() {
					$('#noticeFileCon').focus();
				  });
				return false;
			}
		}
		
		 switch(btnId) {
	        case "btnSaveNotice":
	            noticeSave();
	            break;
	        case "noticeFileSave":
	            noticeFileSave();
	            break;
	        case "btnUpdateNotice":
	            noticeUpdate();
	            break;
	        case "noticeFileUpdate":
	            noticeFileUpdate();
	            break;
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">고객센터관리</span> <span class="btn_nav bold">공지사항관리
								</span> <a href="../board/notice.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>공지사항</span> <span class="fr">
		                     
		                     제목
		                     <input type="text" id="searchTitle" name="searchtitle">
		                     기간
		                     <input type="date" id="searchStDate" name="searchstdate"> 
		                     ~ <input type="date" id="searchEdDate" name="searcheddate"> 
	
		                       <a class="btnType blue" href="" id="searchBtn"><span>검색</span></a>
		                       <!-- 관리자 계정일때만 등록 가능 -->
		                       <c:if test="${userType eq 'M'}"> 
		                       <a class="btnType blue" href="javascript:insertModal();" ><span>신규등록</span></a>
		                       <a class="btnType blue" href="javascript:insertFileModal();" ><span>신규파일등록</span></a>
		                       </c:if>
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="50%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
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
	 
	<!-- 등록모달팝업 -->
	<div id="saveModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록</strong>
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
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan=3><input type="text" class="inputTxt p100" name="notice_tit" id="noticeTit" /></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea name="notice_con" id="noticeCon" cols="40" rows="5"></textarea>
								</td>
							</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" name="btn" id="btnSaveNotice"><span>등록</span></a> 
					<a href="" class="btnType blue" style="display:none" name="btn" id="btnUpdateNotice"><span>수정</span></a> 
					<a href="" class="btnType blue" name="btn" id="btnDeleteNotice"><span>삭제</span></a> 
					<a href="" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 파일첨부 모달팝업 -->
	<form action="" method="post" id="noticeForm" name="noticeForm">
	<input type="hidden" id="noticeSeq" name="noticeSeq" />
	<div id="fileModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항</strong>
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
								<th scope="row">제목 <span class="font_red"><c:if test="${userType eq 'M'}">*</c:if></span></th>
								<td colspan=3><input type="text" class="inputTxt p100" name="noticeTit" id="noticeFileTit" <c:if test="${userType ne 'M'}">readonly</c:if>/></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red"><c:if test="${userType eq 'M'}">*</c:if></span></th>
								<td colspan="3"><textarea name="noticeCon" id="noticeFileCon" cols="40" rows="5" <c:if test="${userType ne 'M'}">readonly</c:if>></textarea></td>
							</tr>
							<c:if test="${userType eq 'M'}">
							<tr>
								<th scope="row">파일 <span class="font_red"></span></th>
								<td colspan=3><input type="file" class="inputTxt p100" name="fileInput" id="fileInput"/></td>
							</tr>
							</c:if>
							<tr>
								<th scope="row">미리보기</th>
								<td>
									<div id="preview"></div>
								</td>
							</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<!-- 관리자 계정일때만 수정/삭제 가능 -->
                    <c:if test="${userType eq 'M'}">
					<a href="" class="btnType blue" id="noticeFileSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="noticeFileUpdate" name="btn"><span>수정</span></a> 
					<a href="" class="btnType gray" id="noticeFileDelete" name="btn" ><span>삭제</span></a>
					</c:if>
					<a href="" class="btnType gray" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<!-- <a href="javascript:close();" class="closePop3"><span class="hidden">닫기</span></a>  -->
	</div>
    </form>
	<!--// 상세조회/수정 모달팝업 -->	
</body>
</html>