<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- Debug: postIdx = ${postIdx}, bizIdx = ${bizIdx} -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>해피 잡 - 채용 공고</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<script src='${CTX_PATH}/js/managepost/apply-modal.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- sweet swal import -->
<style>

/* 전체 컨테이너 */
.container1 {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 20px;
	padding: 20px;
}
/* 머리 채용 공고 css */
div.content div.conTitle {
	padding: 0 24px;
	height: 60px;
	margin-bottom: 10px;
	border: 1px solid #e2e6ed;
	background: #f9fafb;
}

div.conTitle>span:first-child {
	font-family: '나눔바른고딕', NanumBarunGothic;
	line-height: 60px;
	font-size: 28px;
	font-weight: bold;
}

div.conTitle>span.fr {
	margin-top: 15px;
}
/* 전체 액션 컨테이너 */
.action {
	display: flex;
	align-items: center; /* 세로 중앙 정렬 */
	justify-content: space-between; /* 양 끝으로 배치 */
	margin-bottom: 20px;
}

.conTitle {
	display: flex; /* 플렉스박스로 설정하여 요소들을 가로로 배치 */
	justify-content: space-between; /* 양 끝으로 배치 */
	align-items: center; /* 세로 중앙 정렬 */
	margin-bottom: 20px; /* 하단 여백 */
}

.action-buttons a {
	text-decoration: none;
	padding: 10px 15px;
	font-size: 13px;
	border-radius: 5px;
	font-weight: bold;
	margin-left: 10px; /* 버튼 간 간격 조정 */
}
/* 채용 정보 타이틀 */
.action-buttons h2 {
	font-size: 26px;
	color: #333;
	margin: 0;
}

/* 버튼 스타일 */
.action-buttons a {
	text-decoration: none;
	padding: 5px 15px;
	font-size: 13px;
	border-radius: 5px;
	transition: all 0.3s ease;
	margin-left: 10px; /* 버튼 간 간격 조정 */
}

.action-buttons {
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 세로 중앙 정렬 */
	justify-content: flex-end; /* 오른쪽으로 정렬 */
	gap: 10px; /* 버튼 간의 간격 조절 (원하는 만큼 조정 가능) */
	margin-top: 10px; /* 위쪽 마진 추가 (필요 시) */
}


/* 채용 정보 섹션 */
.job-details {
	background-color: #f9f9f9;
	padding: 20px;
	border-radius: 8px;
}

/* 그리드 레이아웃 */
.grid-layout {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 10px;
}

/* 각 섹션의 높이 */
.duties {
	height: 150px;
	line-height: 1.6;
	overflow-y: auto;
}

/* 전체 행을 차지하는 항목 */
.full-width {
	grid-column: span 2;
}

/* 기본 타이포그래피 설정 */
h2 {
	font-size: 28px;
	margin-bottom: 10px;
	color: #333;
}

h3 {
	font-size: 22px;
	margin-bottom: 8px;
	color: #555;
}

p {
	font-size: 16px;
	line-height: 1.6;
}

/* 버튼 스타일 */
button {
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
}

button.btn-close {
	background-color: transparent;
	color: #646362;
	border: 1px solid #646362;
}

button.btn-close:hover {
	background-color: #b9b7b6;
	color: white;
}

button.btn-outline-secondary {
	background-color: transparent;
	color: #007bff;
	border: 1px solid #007bff;
}

button.btn-outline-secondary:hover {
	background-color: #007bff;
	color: white;
}

button.btn-warning {
	background-color: #ffc107;
	color: black;
	border: 1px solid #ffc107;
}

button.btn-warning:hover {
	background-color: #e0a800;
	color: white;
}

/* 기업 정보 섹션 */
.company-info {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
}

.company-info h3 {
	font-size: 24px;
	margin-bottom: 15px;
}

/* 전체 폰트 조절 */
body {
	font-family: 'Arial', sans-serif;
	font-size: 16px;
	color: #333;
	margin: 0;
	padding: 0;
}

.detail-item {
	padding: 10px;
	border-radius: 5px;
	background-color: transparent; /* 구분이 덜 티나도록 */
	box-shadow: none;
	font-size: 16px; /* 여기에서 폰트 크기 조정 */
}
/*기업상세보기 버튼 */
.company-info-link {
	display: inline-block;
	padding: 5px 10px;
	background-color: white; /* 흰색 배경 */
	color: black; /* 글자색 검정 */
	text-align: center;
	text-decoration: none; /* 밑줄 제거 */
	border-radius: 5px; /* 모서리 둥글게 */
	font-size: 12px;
	cursor: pointer; /* 마우스 커서 포인터로 변경 */
	border: 1px solid black; /* 검정 테두리 */
	transition: background-color 0.3s ease, color 0.3s ease;
	/* 호버 시 부드러운 효과 */
}

.company-info-link:hover {
	background-color: black; /* 호버 시 배경 검정 */
	color: white; /* 글자색 흰색 */
}

.align {
    text-align: center; /* 내부 요소 가로 중앙 정렬 */
    margin-bottom: 15px;
}
.align img{
	border-radius: 5px; 
}
/* 날짜 부분 css */
.company-info {
    margin-top: 20px; /* 위쪽 여백 조정 */
}

.date {
    text-align: center; /* 가운데 정렬 */
    font-size: 1.2em; /* 글자 크기 조정 */
    margin-top: 30px; /* 남은 기간과 위 요소들 사이 간격 조정 */
}

.remaining {
    font-weight: bold; /* 남은 기간 텍스트 강조 */
    font-size: 1.5em; /* 남은 기간 글자 크기 조정 */
    margin-bottom: 10px; /* 아래쪽 여백 조정 */
}

.date-details {
    display: flex; /* Flexbox를 사용하여 아이템을 나란히 정렬 */
    justify-content: space-around; /* 공간을 균등하게 배분 */
    margin-top: 10px; /* 날짜 항목과 상위 요소 간격 조정 */
}

.date-item {
    text-align: center; /* 각 날짜 항목 중앙 정렬 */
}

.date-label {
    margin-bottom: 10px; /* 레이블과 값 사이의 아래쪽 여백 */
    color: red; /* 레이블 색상 빨간색 */
}

.date-value {
    margin-top: 10px; /* 값과 레이블 사이의 위쪽 여백 */
    color: red; /* 값 색상 빨간색 */
}


.downloadDiv {
    font-size: 1.2em; /* 글자 크기 조정 */
    margin-top: 60px; /* 남은 기간과 위 요소들 사이 간격 조정 */
}

#resumeContainer {
    display: flex;
    flex-direction: column;
    gap: 20px; /* 각 이력서 블록 사이의 간격 */
}

.resume-block {
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 8px;
    background-color: #f9f9f9;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    width: 100%;
}

#resumeTable tbody tr {
    display: flex;
    flex-direction: row;
    border: 1px solid #ddd; /* Optional: Add border for block effect */
    padding: 10px;
    margin-bottom: 5px;
    align-items: center;
}

#resumeTable tbody td {
    flex: 1;
    padding: 5px; /* Space between columns */
}

.spaceBetweenRB {
   display: flex; 
   justify-content: space-between; 
   align-items: center;
}

.resumeTitle {
   margin:20px 5px 20px; 
   float:left;
}

</style>
<script type="text/javascript">
  

$(function() {
	
	const postIdx = '${postIdx}';
	const bizIdx = '${bizIdx}';
	const url = '${url}';
	
	console.log("Script is running"); 
	console.log(postIdx);
	console.log(bizIdx);
	console.log(url);
	  
	 if (bizIdx) {
	        managePostDetailModal(postIdx, bizIdx);
	    }
	 
	registerBtnEvent(); // 버튼 이벤트 등록

	});
	

	//버튼을 클릭하면 동작하는 함수
	function registerBtnEvent() {
		
		$("a[name=btn]").click(function(e) {
			e.preventDefault(); // 앵커 태그 기본 동작 방지

			var btnId = $(this).attr("id"); // 클릭된 버튼의 ID 가져오기
			console.log("btnId : "+btnId);
			
			var appStatus = $(this).data("status");	
			
			switch (btnId) { 
			}
		});
		$("button[name=btn]").click(function(e) {
			e.preventDefault(); // 앵커 태그 기본 동작 방지
			

			var btnId = $(this).attr("id"); // 클릭된 버튼의 ID 가져오기
			console.log("btnId : "+btnId);
			
			var appStatus = $(this).data("status");	
			
			switch (btnId) {
			case "updateAppStatusY":
		    case "updateAppStatusN":
		       	 updateAppStatus(appStatus);
			  break;  
		    case "backToList":
		    	history.back();
		      break;	
		    case "applySave":
	            jobPostApply();
	          break;  	
			}
		});	
	}

	  
	  function managePostDetailModal(postIdx, bizIdx){
		var param = {
				    postIdx: postIdx,
					bizIdx : bizIdx
			}
			
		console.log(postIdx);
		console.log(bizIdx);
			var callback = function(res){
				var postDetail = res.postDetail;
				console.log(postDetail);
				$("#postIdx").val(postDetail.postIdx);
				
				
				$("#postTitle").text(postDetail.title);
				var bizIdx = postDetail.bizIdx;
				$("#bizIdx").val(bizIdx);
				
				// 경력 여부
			    if (postDetail.expRequired != null) {
			        $("#postExpReq").text(postDetail.expRequired);
			    } else {
			        $("#postExpReq").text(""); // null일 경우 빈 텍스트
			    }

			    // 경력 연수
			    if (postDetail.expYears != null) {
			        $("#postExpYears").text("(" + postDetail.expYears + ")");
			    } else {
			        $("#postExpYears").text(""); // null일 경우 빈 텍스트
			    }
				
				$("#postSalary").text("연봉 " + postDetail.salary + "만원");
				$("#postWorLoc").text(postDetail.workLocation);
				$("#postOpenings").text(postDetail.openings + "명");
				$("#postDescription").text(postDetail.posDescription);
								
				 if (postDetail.duties != null) {
				        $("#postDuties").text(postDetail.duties);
				    } else {
				        $("#postDuties").text(""); // null일 경우 빈 텍스트
				    }
				 if (postDetail.reqQualifications != null) {
				        $("#postreqQual").text(postDetail.reqQualifications);
				    } else {
				        $("#postreqQual").text(""); // null일 경우 빈 텍스트
				    }
				 if (postDetail.prefQualifications != null) {
				        $("#postprefQual").text(postDetail.prefQualifications);
				    } else {
				        $("#postprefQual").text(""); // null일 경우 빈 텍스트
				    }
				 if (postDetail.benefits != null) {
				        $("#postBenefits").text(postDetail.benefits);
				    } else {
				        $("#postBenefits").text(""); // null일 경우 빈 텍스트
				    } 
				
				$("#postDate").text(res.startDate + "시");
				$("#postEndDate").text(res.endDate + "시");
				$("#postHireProc").text(postDetail.hirProcess);
				
				 if (postDetail.fileName != null) {
				        $("#fileName").text(postDetail.fileName);
				    } else {
				        $("#fileName").text(""); // null일 경우 빈 텍스트
				    } 
				 
				$("#appStatus").val(postDetail.appStatus);

				var bizDetail = res.bizDetail;
				console.log(bizDetail);
				$("#bizName").text(bizDetail.bizName);
				$("#bizName2").text(bizDetail.bizName);
				  // 이미지 src와 alt 속성 설정
			    $("#bizLogo").attr("src", bizDetail.logicalPath);
			    $("#bizLogo").attr("alt", bizDetail.bizName + " 로고");
			    
				$("#bizContact").text(bizDetail.bizContact);
				$("#bizEmpCount").text(bizDetail.bizEmpCount);
				$("#bizAddr").text(bizDetail.bizAddr);
				$("#bizCeoName").text(bizDetail.bizCeoName);
				
				
				var loginId = res.loginId;
				console.log(loginId);
				$("#loginIdx").val(loginId);
				
				console.log(bizIdx);

			}
			
			callAjax("/manage-post/managePostDetail.do", "post", "json", false, param, callback)
		}  
	  
     
	  function download() {
			var bizIdx = $("#bizIdx").val();
			console.log("bizIdx in download:", bizIdx);
			
			var hiddenInput = "<input type='hidden' name='bizIdx' value='" + bizIdx + "' />";
			$("<form action='/manage-hire/managehireDownload.do' method='post' id='fileDownload'>" + hiddenInput + "</form>")
			.appendTo('body').submit().remove();
		}
	  

	  
	  function updateAppStatus(appStatus){
		  var bizIdx = $("#bizIdx").val();
		  var postIdx = $("#postIdx").val();
		var param = {
				postIdx: postIdx,
				appStatus: appStatus
	};
			var callback = function(res){
				if(res.result === "success"){
					alert("처리되었습니다");
					// appStatus에 따라 이동할 URL 설정
		            if (appStatus === '승인') {
		                window.location.href = "http://localhost/manage-post/post.do";
		            } else if (appStatus === '불허') {
		                window.location.href = "http://localhost/manage-post/approval.do";
		            }
		        }
		    };
			callAjax("/manage-post/statusUpdate.do", "post", "json", false, param, callback);
		}	
	

	
	  function jobPostScrap(){
			var param = {
					postIdx: $("#postIdx").val(),
					loginIdx: $("#loginIdx").val()
			}
			console.log(param.postIdx);
			console.log(param.loginIdx);
			
			var callback = function(res){
				if(res.result === "success"){
					alert("저장되었습니다");
				}else if(res.result === "fail" && res.message === "이미 존재하는 스크랩입니다."){
					 alert("이미 스크랩된 공고입니다.");
				}else{
					 alert("스크랩에 실패했습니다.");
				}
			}
			
			callAjax("/jobs/saveScrap.do", "post", "json", false, param, callback)
			
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
					postIdx: $("#postIdx").val(),
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
					
				}
			}
			
			callAjax("/jobs/saveApply.do", "post", "json", false, param, callback)
			
		}
	  
	  	  
	  //기업 detail 이동 함수
	 /* function bizIdxDetail(){
			const
			bizIdx = $("#bizIdx").val();
			console.log("bizIdx : " + bizIdx)
			var fileData = {
					bizIdx : bizIdx
			}
			var callback = function(res) {
				if (res.result === "success") {
					 window.location.href = "/company/companyDetailPage.do";
				} else {
				}
			};
			callAjax("/company/companyDetail.do", "post", "json", false,
					fileData, callback);
		}
*/
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
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb (메뉴) 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="/WEB-INF/view/notice/notice.do" class="btn_set home">메인으로</a>
							
							<span class="btn_nav bold">
							<c:choose>
                               <c:when test="${userType eq 'A'}">
                                 <span>채용 정보</span>
                                 </c:when>
                              <c:when test="${userType eq 'M'}">
                               <span>채용공고관리</span>
                                </c:when>
                                  <c:otherwise>
                           <span>채용 관리</span> 
                                 </c:otherwise>
                            </c:choose>
							</span> 
							
							<span class="btn_nav bold">
							<c:choose>
                         <c:when test="${userType eq 'A'}">
                          <span>채용 공고</span>
                          </c:when>
                          
                          <c:when test="${userType eq 'M'}">
                         <c:choose>
                        <c:when test="${fn:contains(requestURI, '/manage-post/approval.do')}">
                           <span>공고 심사</span>
                          </c:when>
                        <c:otherwise>
                         <span>공고 보기</span>
                       </c:otherwise>
                          </c:choose>
                          </c:when>
                    
                            <c:when test="${userType eq 'B'}">
                             <span>채용 공고(채용 관리자)</span>
                            </c:when>
                         <c:otherwise>
                          <span>기타</span>
                        </c:otherwise>
                         </c:choose> 
							</span> 
							
								<a	href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
						<form >
							<input type="hidden" id="postIdx" name="postIdx">
							<input type="hidden" id="bizIdx" name="bizIdx" value="${bizIdx }">
							<input type="hidden" id="loginIdx" name="loginIdx">
						</form>
						<div class="conTitle">
						<c:choose>
						   <c:when test="${userType eq 'A' or 'B'}">
                          <span>채용 공고</span>
                          </c:when>
                          <c:when test="${userType eq 'M'}">
                         <c:choose>
                        <c:when test="${fn:contains(requestURI, '/manage-post/approval.do')}">
                           <span>공고 심사</span>
                          </c:when>
                        <c:otherwise>
                         <span>공고 보기</span>
                       </c:otherwise>
                          </c:choose>
                          </c:when>
                           <c:otherwise>
                          <span>기타</span>
                        </c:otherwise>
                          </c:choose>
						    
		                    
					</div> <!--// content -->
                      <div class="container1">
							<!-- 왼쪽: 채용 정보 -->
							<section class="job-details">
								<div class="grid-layout">
									<!-- 기업명과 채용 제목 -->
									<div class="detail-item">
										<h2 id="bizName">기업명</h2>
										<h3 id="postTitle">공고 제목</h3>
									</div>

									<!-- 스크랩 및 입사지원 버튼 -->
									
									<div class="detail-item action-buttons">
									 <c:if test="${userType eq 'A'}">
									    <button type="button" class="btn btn-outline-secondary" onclick="jobPostScrap()">스크랩</button>
									    <button type="button" class="btn btn-warning" onclick="applyDetailModal()">입사지원</button>
									    </c:if>
									       
									</div>

									<!-- 기본 정보 -->
									<div class="detail-item">
										<strong>경력:</strong><span id="postExpReq"></span>
									</div>

									<div class="detail-item">
										<strong>급여:</strong><span id="postSalary"></span>
									</div>

									<div class="detail-item">
										<strong>모집인원:</strong><span id="postOpenings"></span>
									</div>

									<div class="detail-item">
										<strong>근무지역:</strong><span id="postWorLoc"></span>
									</div>

									<!-- 업무 내용 (높이 설정) -->
									
										<div class="detail-item full-width duties">
											<strong>업무</strong><br><span id="postDuties"></span>
										</div>
							
										<div class="detail-item full-width duties">
											<strong>포지션 소개</strong><br>
											<span id="postDescription"></span>
										</div>
					

								
										<div class="detail-item full-width duties">
											<strong>자격요건</strong><br>
											<span id="postreqQual"></span>
										</div>
															
										<div class="detail-item full-width duties">
											<strong>우대사항</strong><br>
										
										</div>

										<div class="detail-item full-width duties">
											<strong>혜택 & 복지</strong><br>
                                            <span id="postBenefits"></span>
										</div>
						
								</div>
							</section>
							<!-- 오른쪽: 기업 정보 -->
							<aside class="company-info">
								<div class="align">
									<img id="bizLogo" src="" alt="" width="150" height="150">
								</div>
								<h4>기업 정보</h4>
								<p>
									<strong>기업명:</strong>  <span id="bizName2"></span>
								</p>
								<p>
									<strong>연락처:</strong>   <span id="bizContact"></span>
								</p>
								<p>
									<strong>사원수:</strong>  <span id="bizEmpCount"></span>
								</p>
								<p>
									<strong>주소:</strong>   <span id="bizAddr"></span>
								</p>
								<p>
									<strong>대표명:</strong>  <span id="bizCeoName"></span>
								</p>
								<div class="align">	
								 <a href="/company/companyDetailPage.do/${postIdx}/${bizIdx}" class="company-info-link">기업정보→</a> 
								</div>
								<div class="date">
							        <span class="remaining">남은 기간</span>
							        <div class="date-details">
							            <div class="date-item">
							                <span class="date-item">시작일</span><br>
							                <span class="date-item">마감일</span>
							            </div>
							            <div class="date-item">
							                <span class="date-item" id="postDate"></span><br>
							                <span class="date-item" id="postEndDate"></span>
							            </div>
							        </div>
							    </div>
							    <div class="downloadDiv">
							        <span class="remaining">첨부파일</span>
							        <span class="remaining">
										    <a href='javascript:download()'><span id="fileName"></span></a>
							        </span>
							    </div>
							  
							</aside>
							
        </div> <!--// content -->
                		<div class="btn_areaC mt30"> 
				 <c:if test="${userType eq 'M'}">
				    <button type="button" id="updateAppStatusY" name="btn" class="btn btn-outline-secondary" data-status="승인">승인</button>
				<button type="button" id="updateAppStatusN" name="btn" class="btn btn-outline-secondary" data-status="불허">불허</button>
                </c:if>
                 <button type="button" id="backToList" name="btn" class="btn btn-close">뒤로 가기</button>
             
                        </div>
<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
		
		
	
</div>
		<!-- <a href="javascript:close();" class="closePop3"><span class="hidden">닫기</span></a>  -->

	
	 <!-- 입사지원 모달 -->
	<div id="applyModal" class="layerPop layerType2" style="width: 1000px;">
      
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
				 <button type="button" id="applySave" class="btn btn-warning" name="btn">입사지원</button>
                </c:if>
                <button type="button" onclick="gfCloseModal();" class="btn btn-close">닫기</button>
                 </div>
			</dd>
		</dl>
		<!-- <a href="javascript:close();" class="closePop3"><span class="hidden">닫기</span></a>  -->
	</div>
                             
</body>
</html>