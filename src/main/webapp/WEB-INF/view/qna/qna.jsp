<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>
	<c:choose>
    	<c:when test="${userType ne 'M'}">Q&A</c:when>
        <c:otherwise>Q&A 관리자</c:otherwise>
	</c:choose>
</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	
	$(function() {
		if(userType === 'A' || userType === 'M'){
			$("#instaff").addClass("blue");
			$("#outstaff").removeClass("blue");
			$("#qna_type").val('A');
		} else {
			$("#outstaff").addClass("blue");
			$("#instaff").removeClass("blue");
		}
	 	
		qnaSearch();
		registerBtnEvent();
		filePreview();
	});
	
	var userType = "${userType}";
	var login_id = "${loginId}";
	
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
			qnaSearch();
		});
		
		$("#searchMyList").click(function(e){
			e.preventDefault();
			myQnaSearch();
		});
		
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr("id");
			
			switch(btnId) {
			case "qnaFileSave":
				validate(btnId);
				break;
			case "qnaFileUpdate":
				validate(btnId);
				break;
			case "qnaFileDelete":
				qnaFileDelete();
				break;
			}
		})
		
	}
	
	function validate(btnId) {
		var tit = $('#qnaFileTit').val();
		var con = $('#qnaFileCon').val();
		var pass = $('#password').val();
		
		if(tit.length < 1 ) {
			swal("제목을 입력하세요.").then(function() {
				$('#qnaFileTit').focus();
			  });
			return false;
		}
		
		if(con.length < 1 ) {
			swal("내용을 입력하세요.").then(function() {
				$('#qnaFileCon').focus();
			  });
			return false;
		}
		
		if(pass.length < 1 ) {
			swal("비밀번호를 입력하세요.").then(function() {
				$('#password').focus();
			  });
			return false;
		}
		
		switch(btnId) {
        case "qnaFileSave":
        	qnaFileSave();
            break;
        case "qnaFileUpdate":
        	qnaFileUpdate();
            break;
		}
	}
	

	function qnaFileDelete(){
		var getForm = document.getElementById("qnaForm");
		getForm.entype = 'multipart/form-data';
		
		var fileData = new FormData(getForm);
		
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다.");
				gfCloseModal();
				qnaSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/board/qnaFileDelete.do", "post", "json", false, fileData, callback);
	}
	
	function qnaFileUpdate(){
		var getForm = document.getElementById("qnaForm");
		getForm.entype = 'multipart/form-data';
		
		var fileData = new FormData(getForm);
		
		var callback = function(res){
			if(res.result === "success"){
				if(userType != 'M'){
				alert("수정되었습니다.");
				} else {
					alert("답변이 등록되었습니다.");
				}
				gfCloseModal();
				qnaSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/board/qnaFileUpdate.do", "post", "json", false, fileData, callback);
	}
	
	function qnaFileSave(){
		var getForm = document.getElementById("qnaForm");
		getForm.entype = 'multipart/form-data';
		
		var fileData = new FormData(getForm);
		
		var password = $("#password").val();
		
		var callback = function(res){
			if(res.result === "success"){
				alert("저장되었습니다.");
				gfCloseModal();
				qnaSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/board/qnaFileSave.do", "post", "json", false, fileData, callback);
	}
	
	//타입 B 회원인 이함수임 qnaSearch  메서드가 2개니깐 중의 하자. 
	function qnaSearch(currentPage){
	 	
		var qna_type = $("#qna_type").val();
		
		currentPage = currentPage || 1;
		
		// 공지사항 데이터를 불러오는 로직
		var param = {
				searchTitle: $("#searchTitle").val(),
				searchStDate: $("#searchStDate").val(),
				searchEdDate: $("#searchEdDate").val(),
				currentPage: currentPage,
				pageSize: 5,
				qna_type: qna_type,
				requestType: 'all'
				
		}
		
		var callback = function(res){
			$("#resultList").html(res);
			
			var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "qnaSearch");
			$("#pageArea").html(pageNavi);
		}
		//2
		callAjax("/board/qnaList.do", "post", "text", false, param, callback);
	}
	
	function myQnaSearch(currentPage){
	 	
		var qna_type = $("#qna_type").val();
		
		currentPage = currentPage || 1;
		
		// 공지사항 데이터를 불러오는 로직
		var param = {
				searchTitle: $("#searchTitle").val(),
				searchStDate: $("#searchStDate").val(),
				searchEdDate: $("#searchEdDate").val(),
				currentPage: currentPage,
				pageSize: 5,
				qna_type: qna_type,
				requestType: 'my'
				
		}
		
		var callback = function(res){
			$("#resultList").html(res);
			
			//바로위  $("#resultList").html(res); 으로  심은    select count(*) from  where user_type=? $("#totcnt").val() 총 행수이다.
			var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "qnaSearch");
			$("#pageArea").html(pageNavi);
		}
		//1
		callAjax("/board/qnaList.do", "post", "text", false, param, callback);
	}
	
	function personalQna() {
		$("#qna_type").val("A");
		$("#instaff").addClass("blue");
		$("#outstaff").removeClass("blue");
		qnaSearch();
	}
	
	function companyQna() {
		$("#qna_type").val("B");
		$("#outstaff").addClass("blue");
		$("#instaff").removeClass("blue");
		qnaSearch();
	}
	
	function insertFileModal(){
		$("#qnaFileSave").show();
		$("#qnaFileUpdate").hide();
		$("#qnaFileDelete").hide();
		$("#ansContent").hide();
		$("#qnaFileTit").val("");
		$("#qnaFileCon").val("");
		$("#password").val("");
		$("#fileInput").val("");
		$("#preview").val("");
		
		gfModalPop("#fileModal")
	}
	
	function qnaDetailFileModal(qnaSeq){
		
		if(userType === 'M') {
			var param = {
					qnaSeq : qnaSeq
				}
			var callback = function(res){
				var detail = res.detail;
				$("#qnaSeq").val(detail.qnaIdx);
				$("#qnaFileCon").val(detail.content);
				$("#qnaFileTit").val(detail.title);
				$("#password").val(detail.password);
				$("#ans_content").val(detail.ans_content);
				$("#qnaFileSave").hide();
				$("#qnaFileUpdate").show();
				$("#qnaFileDelete").show();
				
				detailImgPreview(detail);
				
				gfModalPop("#fileModal");
				
				}
			callAjax("/board/qnaDetailFile.do", "post", "json", false, param, callback)
			
		} else {
			 showPasswordModal(qnaSeq);
			}
		}
	
    function showPasswordModal(qnaSeq) {
        $("#passwordInput").val("");  
        $("#passwordModal").data("qnaSeq", qnaSeq);
        gfModalPop("#passwordModal");
    }
	 
    function submitPassword() {
        const password = $("#passwordInput").val();
        const qnaSeq = $("#passwordModal").data("qnaSeq");

        if (password.length < 1) {
            swal("비밀번호를 입력하세요.").then(function() {
                $('#passwordInput').focus();
            });
           	return false;
        	}
			
        	var param = {
				qnaSeq : qnaSeq,
				password: password
			}
		
			var callback = function(res){
				if(res.result === "success") {
				var detail = res.detail;
				$("#qnaSeq").val(detail.qnaIdx);
				$("#qnaFileCon").val(detail.content);
				$("#qnaFileTit").val(detail.title);
				$("#password").val(detail.password);
				$("#ans_content").val(detail.ans_content);
				
				if (detail.ans_content !== null && detail.ans_content !== '') { //답변 완료일 때
				    $("#ansContent").show();
				    $("#qnaFileTit").attr("readonly", true);
				    $("#qnaFileCon").attr("readonly", true);
				    $("#password").attr("readonly", true);
				    $("#file_column").hide();
				    $("#qnaFileUpdate").hide();
				} else {
				    $("#ansContent").hide();
				    $("#qnaFileUpdate").show();
				}
				
				if (login_id === detail.author){
				$("#qnaFileDelete").show();
				} else {
				$("#qnaFileUpdate").hide();
				$("#qnaFileDelete").hide();
				}
				
				$("#qnaFileSave").hide();
				
				detailImgPreview(detail);
				
				gfModalPop("#fileModal");
			
		} else {
			swal("비밀번호가 일치하지 않습니다.");
			}
		}
		
		callAjax("/board/qnaDetailFile.do", "post", "json", false, param, callback)
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
		var qnaSeq = $("#qnaSeq").val();
		
		var hiddenInput = "<input type='hidden' name='qnaSeq' value='" + qnaSeq + "' />";
		$("<form action='qnaDownload.do' method='post' id='fileDownload'>" + hiddenInput + "</form>")
		.appendTo('body').submit().remove();
		
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
						<input type="hidden" id="qna_type" name="qna_type" value="${userType}"/>
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">고객센터관리</span> <span class="btn_nav bold">Q&A관리
								</span> <a href="../board/qna.do"" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span><c:choose>
    									<c:when test="${userType ne 'M'}">Q&A</c:when>
        								<c:otherwise>Q&A 관리자</c:otherwise>
									</c:choose>
							</span> <span class="fr">
		                     <c:if test="${userType eq 'M'}">
		                     제목 
		                     <input type="text" id="searchTitle" name="searchtitle">
		                     기간 
		                     <input type="date" id="searchStDate" name="searchstdate"> 
		                     ~ <input type="date" id="searchEdDate" name="searcheddate"> 
	
		                       <a class="btnType blue" href="" id="searchBtn"><span>검색</span></a>
		                       </c:if>
		                       <c:if test="${userType ne 'M'}">
		                       <a class="btnType blue" href=""  id="searchMyList"><span>내가 쓴 글</span></a>
		                       </c:if>
		                       <a class="btnType blue" href="javascript:insertFileModal();" ><span>질문등록</span></a>
		                     </span>
                  		</p>
                  		<div class="btn_area">
							<br>
								<a href="javascript:personalQna();" class="btnType blue" id="instaff"><span>개인회원</span></a>
								<a href="javascript:companyQna();" class="btnType " id="outstaff"><span>기업회원</span></a>
							<br>
						</div>
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
	
	<!-- 파일첨부 모달팝업 -->
	<form action="" method="post" id="qnaForm" name="qnaForm">
	<input type="hidden" id="qnaSeq" name="qnaSeq" />
	<input type="hidden" id="qna_type" name="qna_type" value="${userType}"/>
	<div id="fileModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>Q&A 등록</strong>
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
								<th scope="row">제목<span class="font_red">*</span></th>
								<td colspan=3><input type="text" class="inputTxt p100" name="qnaTit" id="qnaFileTit" /></td>
							</tr>
							<tr>
								<th scope="row">내용<span class="font_red">*</span></th>
								<td colspan="3"><textarea name="qnaCon" id="qnaFileCon" cols="40" rows="5"></textarea></td>
							</tr>
							<tr id="file_column">
								<th scope="row">파일<span class="font_red"></span></th>
								<td colspan=3><input type="file" class="inputTxt p100" name="fileInput" id="fileInput"/></td>
							</tr>
							<tr>
								<th scope="row">미리보기</th>
								<td>
									<div id="preview"></div>
								</td>
							</tr>
							<tr>
    							<th scope="row">비밀번호<span class="font_red">*</span></th>
							    <td colspan=3><input type="password" class="inputTxt p100" name="password" id="password" value="${detail.password}"/></td>
							</tr>
							<tr id="ansContent">
    							<th scope="row">답변<span class="font_red"></span></th>
							    <td colspan=3><textarea name="ans_content" id="ans_content" cols="40" rows="5"<c:if test="${userType ne 'M'}">readonly</c:if>></textarea></td>
							</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="qnaFileSave" name="btn"><span>저장</span></a>
					<c:choose>
    					<c:when test="${userType ne 'M'}"><a href="" class="btnType blue" id="qnaFileUpdate" name="btn"><span>수정</span></a></c:when>
        				<c:otherwise><a href="" class="btnType blue" id="qnaFileUpdate" name="btn"><span>답변등록</span></a></c:otherwise>
					</c:choose> 
					<a href="" class="btnType gray" id="qnaFileDelete" name="btn" ><span>삭제</span></a>
					<a href="" class="btnType gray" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<!-- <a href="javascript:close();" class="closePop3"><span class="hidden">닫기</span></a>  -->
	</div>
    </form>
	<!--// 상세조회/수정 모달팝업 -->	
	
	<!-- 비밀번호 입력 모달 -->
    <div id="passwordModal" class="layerPop layerType2" style="width: 300px;">
        <dl>
            <dt><strong>비밀번호 입력</strong></dt>
            <dd class="content">
                <input type="password" id="passwordInput" name="passwordInput" placeholder="비밀번호" class="inputTxt p100"/>
                <div class="btn_areaC mt30">
                    <a href="javascript:submitPassword();" class="btnType blue"><span>확인</span></a>
                    <a href="javascript:gfCloseModal('#passwordModal');" class="btnType gray"><span>취소</span></a>
                </div>
            </dd>
        </dl>
    </div>
    <!-- // 비밀번호 입력 모달 -->
</body>
</html>