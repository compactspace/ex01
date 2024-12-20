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
    	<c:when test="${userType ne 'M' or userType eq 'B'}">FAQ</c:when>
        <c:otherwise>FAQ 관리자</c:otherwise>
	</c:choose>
</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	
	$(function() {
		// 화면이 열렸을 때, FAQ 데이터를 받아온다.
		faqSearch();
		registerBtnEvent();
	});
	
	function faqSearch(currentPage){
		
		currentPage = currentPage || 1;
		var faq_type = $("#faq_type").val();
		
		var param = {
				searchTitle: $("#searchTitle").val(),
				searchStDate: $("#searchStDate").val(),
				searchEdDate: $("#searchEdDate").val(),
				currentPage: currentPage,
				pageSize: 5,
				faq_type: faq_type
		}
		
		var callback = function(res){
			$("#resultList").html(res);
			
		var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "faqSearch");
			$("#pageArea").html(pageNavi);
		}
		callAjax("/board/faqList.do", "post", "text", false, param, callback);
	}
	
	function personalFaq() {
		$("#faq_type").val("1");
		$("#instaff").addClass("blue");
		$("#outstaff").removeClass("blue");
		faqSearch();
	}
	
	function companyFaq() {
		$("#faq_type").val("2");
		$("#outstaff").addClass("blue");
		$("#instaff").removeClass("blue");
		faqSearch();
	}
	
	function registerBtnEvent(){
		$("#searchBtn").click(function(e){
			e.preventDefault();
			faqSearch();
		});
		
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr("id");
			
			switch(btnId) {
			case "btnSaveFaq":
				validate(btnId);
				break;
			case "btnUpdateFaq":
				validate(btnId);
				break;
			case "btnDeleteFaq":
				faqDelete();
				break;
			}
		})
	}
	
	function insertModal(){
		
		$("#btnSaveFaq").show();
		$("#btnUpdateFaq").hide();
		$("#btnDeleteFaq").hide();
		$("#faqTit").val("");
		$("#faqCon").val("");
		
		gfModalPop("#saveModal")
	}
	
	function faqSave(){
		var param = {
				title: $("#faqTit").val(),
				context: $("#faqCon").val(),
				faq_type: $("input[name='faq_type']:checked").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("저장되었습니다");
				gfCloseModal();
				faqSearch();
			}
		}
		
		callAjax("/board/faqSave.do", "post", "json", false, param, callback)	
	}
	
	function faqUpdate(){
		var param = {
				title: $("#faqTit").val(),
				context: $("#faqCon").val(),
				faqSeq: $("#faqSeq").val(),
				faq_type: $("input[name='faq_type']:checked").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("수정되었습니다");
				gfCloseModal();
				faqSearch();
			}
		}
		callAjax("/board/faqUpdate.do", "post", "json", false, param, callback);
	}
	
	function faqDelete(){
		var param = {
				faqSeq: $("#faqSeq").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다");
				gfCloseModal();
				faqSearch();
			}
		}
		
		callAjax("/board/faqDelete.do", "post", "json", false, param, callback);
	}
	
	function faqDetailModal(faqSeq){
		var param = {
				faqSeq : faqSeq
		}
		
		var callback = function(res){
			var detail = res.detail;
			
			$("#faqSeq").val(detail.faq_idx);
			$("#btnSaveFaq").hide();
			$("#btnUpdateFaq").show();
			$("#btnDeleteFaq").show();
			$("#faqTit").val(detail.title);
			$("#faqCon").val(detail.content);
			$("#faq_type").val(detail.faq_type);
			gfModalPop("#saveModal");
		}
		
		callAjax("/board/faqDetail.do", "post", "json", false, param, callback)
	}
	
	function showContent(faq_idx) {
		$("#faqcontent_"+faq_idx).toggle();
	}
	
	function validate(btnId) {
		var tit = $('#faqTit').val();
		var con = $('#faqCon').val();
		
		if(tit.length < 1 ) {
			swal("제목을 입력하세요.").then(function() {
				$('#faqTit').focus();
			  });
			return false;
		}
		
		if(con.length < 1 ) {
			swal("내용을 입력하세요.").then(function() {
				$('#faqCon').focus();
			  });
			return false;
		}
		
		switch(btnId) {
        case "btnSaveFaq":
            faqSave();
            break;
        case "btnUpdateFaq":
            faqUpdate();
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
								class="btn_nav bold">고객센터관리</span> <span class="btn_nav bold">FAQ관리
								</span> <a href="../board/faq.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                    <span><c:choose>
    									<c:when test="${userType ne 'M'}">FAQ</c:when>
        								<c:otherwise>FAQ 관리자</c:otherwise>
									</c:choose>
							</span> <span class="fr">
							 제목
		                     <input type="text" id="searchTitle" name="searchtitle">
		                     기간
		                     <input type="date" id="searchStDate" name="searchstdate"> 
		                     ~ <input type="date" id="searchEdDate" name="searcheddate"> 
		                     
		                       <a class="btnType blue" href="" id="searchBtn"><span>검색</span></a>
		                      
		                       <!-- 관리자 계정일때만 등록 가능 -->
		                       <c:if test="${userType eq 'M'}"> 
		                       <a class="btnType blue" href="javascript:insertModal();" ><span>신규등록</span></a>
		                       </c:if>
		                     </span>
                  		</p>
						<dd class="content">
				<div class="btn_area">
					<br>
					<a href="javascript:personalFaq();" class="btnType blue" id="instaff"><span>개인회원</span></a>
					<a href="javascript:companyFaq();" class="btnType " id="outstaff"><span>기업회원</span></a>
					<br>
				</div>
					<c:if test="${userType ne 'M'}">
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
					</c:if>
					<c:if test="${userType eq 'M'}">
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
				<tbody id="resultList"></tbody>
							</table>
						</div>
					</c:if>
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
	<input type="hidden" id="faqSeq" name="faqSeq" />
	<input type="hidden" id="faq_type" name="faq_type" value="1" />
		<dl>
			<dt>
				<strong>FAQ 등록</strong>
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
								<th scope="row">유형 <span class="font_red"><c:if test="${userType eq 'M'}">*</c:if></span></th>
								<td colspan=3>
								<label><input type="radio" class="faq_type" name="faq_type" id="instaff" value="1" checked <c:if test="${userType ne 'M'}">disabled</c:if>/>개인회원</label>
								<label><input type="radio" class="faq_type" name="faq_type" id="outstaff" value="2" <c:if test="${userType ne 'M'}">disabled</c:if>/>기업회원</label>
								</td>
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red"><c:if test="${userType eq 'M'}">*</c:if></span></th>
								<td colspan=3><input type="text" class="inputTxt p100" name="faq_tit" id="faqTit" <c:if test="${userType ne 'M'}">readonly</c:if> /></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red"><c:if test="${userType eq 'M'}">*</c:if></span></th>
								<td colspan="3">
									<textarea name="faq_con" id="faqCon" cols="40" rows="5" <c:if test="${userType ne 'M'}">readonly</c:if>></textarea>
								</td>
							</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
				<!-- 관리자 계정일때만 등록 가능 -->
		        <c:if test="${userType eq 'M'}">
					<a href="" class="btnType blue" name="btn" id="btnSaveFaq"><span>등록</span></a> 
					<a href="" class="btnType blue" style="display:none" name="btn" id="btnUpdateFaq"><span>수정</span></a> 
					<a href="" class="btnType blue" name="btn" id="btnDeleteFaq"><span>삭제</span></a>
				</c:if>
					<a href="" class="btnType gray" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</body>
</html>