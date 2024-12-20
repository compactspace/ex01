<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Debug: loginId = ${loginId}, scrapIdx = ${list.scrapIdx} -->
<!DOCTYPE html>
<html lang="ko">
<head>
<style>
dd.content {
   font-size: 1.5em;
}
dd.content2 {
   font-size: 1.5em;
}


.bizData {
   border: 2px solid red;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;  
  line-height: 2em;
}
div.requirement {
   display: block;
   border: 2px solid red;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
}
div.benefit{
  border: 2px solid red;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
}

div.postDuration {
   border: 2px solid red;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
  display: flex;
  justify-content: flex-start; /* 왼쪽에 나란히 배치 */
  gap: 5px; /* 두 p 태그 사이의 간격 (원하는 대로 조정 가능) */
 
}
div.hiringProcess {
   border: 2px solid red;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
}
div.attachImg {
   border: 2px solid red;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
}

div.postAppStatus {
   border: 2px solid red;
  border-radius: 5px;
  margin: 5px;
  padding: 5px;
}
</style>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>해피 잡 - 스크랩</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<script src='${CTX_PATH}/js/managepost/apply-modalInList.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<script type="text/javascript">	

$(function() {
	// 화면이 열렸을 때, 공지사항 데이터를 받아온다.
	scrapSearch();
	registerBtnEvent();
	
  
});

//상세조회 이미지
function detailImgPreview(detail){
	if(detail.fileName){
		var ext = detail.fileExt.toLowerCase();
		var imgPath = "";
		var previewHtml = "";
		
		if(ext === "jpg" || ext === "gif" || ext === "png"){
			imgPath = detail.logicalPath;
			previewHtml = "<img src='" +imgPath+ "' id='imgFile' style='width: 500px; height: 300px'>";
		}
		
	//	previewHtml += "</a>"
		
		$("#preview").html(previewHtml);
		  // 중앙 정렬을 위해 부모 요소에 text-align 속성을 적용
        $("#preview").css("text-align", "center");
		
	}
} 
	
function registerBtnEvent(){
	$("#searchBtn").click(function(e){
		e.preventDefault();
		scrapSearch();
	});
	
	$("a[name=btn]").click(function(e){
		e.preventDefault();
		
		var btnId = $(this).attr("id");
		
	switch(btnId) {
	     
	      case "scrapDelete":
	    	  deleteScrap();
	      break;
	      case "applySave":
	            jobPostApply();
	          break;  
	}

    });
}


function scrapSearch(currentPage){
	currentPage = currentPage || 1;
	var loginIdx = "${loginId}";
	console.log(loginIdx);

	// 스크랩 데이터를 불러오는 로직
	var param = {
			searchTitle: $("#searchTitle").val(),
			searchStDate: $("#searchStDate").val(),
			searchEdDate: $("#searchEdDate").val(),
			currentPage: currentPage,
			pageSize: 5,
			loginId: loginIdx
	}
	   
	var callback = function(res){
		
		$("loginIdx").val(loginIdx);
		$("#resultList").html(res);
		
		var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "scrapSearch");
		$("#pageArea").html(pageNavi);
	}
	
	callAjax("/jobs/scrapList.do", "post", "text", false, param, callback);	
}


function deleteScrap(){
	var selectedResumeIdx = $('input[name="scrapSelect"]:checked').val();
	var param = {
			scrapIdx: selectedResumeIdx
	}
	
	var callback = function(res){
		if(res.result === "success"){
			alert("삭제되었습니다");
			gfCloseModal();
			scrapSearch();
		}
	}
	
	callAjax("/jobs/deleteScrap.do", "post", "json", false, param, callback);
}
 

function jobPostApply(){
	// 선택된 라디오 버튼에서 resumeIdx 값을 가져오기
    var selectedResumeIdx = $('input[name="resumeSelect"]:checked').val(); // 선택된 라디오 버튼의 value 값
    var userIdx = $("#userIdx").val();
    
    console.log(selectedResumeIdx);
    // 선택된 resumeIdx 값이 없을 경우 예외 처리
    if (!selectedResumeIdx) {
        alert("이력서를 선택해주세요.");
        return; // 선택이 없으면 함수 종료
    }
    
	var param = {
			postIdx: $("#modalPostIdx").val(),
			loginIdx: $("#loginIdx").val(),
			userIdx: userIdx,
			resumeIdx: selectedResumeIdx
			
	}
	console.log(param.postIdx);
	console.log(param.loginIdx);
	console.log(param.userIdx);
	console.log(param.resumeIdx);
	
	var callback = function(res){
		if(res.result === "success"){
			alert("지원 완료되었습니다");
			gfCloseModal();
		}else if(res.result === "fail" && res.message === "이미 지원 완료된 공고입니다."){
			 alert("이미 지원 완료된 공고입니다.");
			 gfCloseModal();
		}
	}
	
	callAjax("/jobs/saveApply.do", "post", "json", false, param, callback)
	
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
							<a href="/WEB-INF/view/manage-post/approval.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">채용 정보</span> <span class="btn_nav bold">스크랩
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
						

						<p class="conTitle">
		                     <span>스크랩</span> <span class="fr">

		                     제목
		                     <input type="text" id="searchTitle" name="searchtitle">
		                     기간
		                     <input type="date" id="searchStDate" name="searchstdate"> 
		                     ~ <input type="date" id="searchEdDate" name="searcheddate"> 
	
		                       <a class="btnType blue" href="" id="searchBtn"><span>검색</span></a>
		                         <a class="btnType gray" href="" id="scrapDelete" name="btn"><span>삭제</span></a>
		                       

		                      
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
						
						            <col width="5%">
						            <col width="10%">
									<col width="35%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col"></th>
										<th scope="col">기업명</th>
										<th scope="col">공고 제목</th>
										<th scope="col">자격 요건</th>
										<th scope="col">근무지역</th>
										<th scope="col">마감일</th>
										<th scope="col"></th>
										
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
				        
  	 <!-- 입사지원 모달 -->
	<div id="applyModal" class="layerPop layerType2" style="width: 1000px;">
	  <input type="hidden" id="modalPostIdx" name="postIdx" value="" />
        <input type="hidden" id="modalBizIdx" name="bizIdx" value="" />
      
		<dl>
			<dt>
				<strong style="display: block; text-align: center;">
			            입사 지원
				</strong>
			</dt>
			<dd class="content3" style="font-size: 1.5em;">
				<!-- s : 여기에 내용입력 -->
				
				<div><!--기업 이름 -->
				<p id="bizName3" style="text-align: center; font-size: 1.5em; line-height: 2em; float: left;">기업 이름</p>	
				</div>
				<br>
				 <div style="clear: both;"></div>
				<div><!--공고 제목-->
				<p id="bizPostTitle" style="text-align: center; font-size: 1.0em; line-height: 1em; float:left;">공고 제목</p>	
				</div>	
				
				
                     <div style="clear: both;"></div>
                     <br>
                     <br>
             
             <div id="resumeContainer">     
             <div class="resume-block"> 
           <!-- 이력서 정보 테이블 -->
         <table id="resumeTable" border="1" style="width: 100%;">
             <thead>
             <tr>
             <th style="padding: 15px 20px; text-align: left;">지원 이력서</th>
             </tr>
           </thead>
         <tbody id="resumeList"> </tbody>
        </table>
        </div>
          </div>  
				<br>
						

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30"> 
				<c:if test="${userType eq 'A'}">
				 <a id="applySave" href="" name="btn" class="btnType gray"><span>입사지원</span></a>
                </c:if>
                 <a href="" class="btnType gray"><span>닫기</span></a>
                 </div>
			</dd>
		</dl>
		<!-- <a href="javascript:close();" class="closePop3"><span class="hidden">닫기</span></a>  -->
	</div>

</body>
</html>