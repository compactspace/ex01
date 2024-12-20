<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>이력서</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style>

.resumeDetail_body {
	margin: 20px 20px 60px;
}

.resumeDetail_body_basicInfo {
	margin: 20px;
}

.resumeDetail_body_haeder {
	margin-top: 15px;
	padding: 5px;
	font-size: 20px;
	border-bottom: 0.5px solid black;
}

.resumeDetail_body_guide {
	margin: 10px 0px;
	padding: 5px;
	background-color: #eaf2fe;
	border-radius: 5px;
	color: gray;
}

input, textarea {
	font-size: 13px;
	width: 100%;
}

textarea {
	padding: 10px 0px;
	overflow: hidden;
	resize: none;
	min-height: 100px; /* 최소 높이를 설정 */
	
}

button {
	width: 100%;
	padding: 10px 0;
	display: block;
	font-size: 18px;
	font-weight: 600;
	text-align: left;
	border: none;
	border-radius: 0;
	color: #36f;
	background-color: transparent;
	border-bottom: 1px solid #f1f1f1;
}

button:HOVER {
	cursor: pointer;
}

button:active {
	color: red;
}

table {
	margin-top: 10px;
}

table td {
	background-color: #f9f9f9;
}

.deleteBtn {
	color: grey;
	text-align: center;
}

.inputBtnGroup {
	padding-top: 10px;
	text-align: right;
}

.btnGroup {
	border-top: 3px solid black;
	margin: 20px 0 50px 0;
	padding-top: 15px;
	text-align: center;
}
.res-comment{
	padding : 10px 0px;
	color : skyblue;
	text-align: center;
}
.attach-container {
    display: flex;
    align-items: center;
    justify-content: flex-start; 
    padding: 5px 0; 
}

.attach-fileName {
    margin-left: 20px; 
    font-size: 16px;
    color: blue;
    text-decoration: underline;
}

.attach-delete {
    width: 20px; 
    height: 20px; 
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    margin-left: 10px; 
}

.attach-delete svg {
    width: 100%;
    height: 100%;
}



</style>
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">입사지원</span> <span class="btn_nav bold">이력서</span>
							<span class="btn_nav bold">이력서상세보기</span><a
								href="javascript:window.location.reload()" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>이력서 수정/작성</span>
						</p>

						<div class="resumeDetail_body_wrap">
							<div class="resumeDetail_body_basicInfo">
								<div>
									<input
										style="border: none; font-size: 30px; margin-bottom: 20px; padding: 5px"
										id="resumetitle" type="text" value="${result.resTitle}" data-num="${result.resIdx}" placeholder="이력서 제목">
								</div>
								<div>
									<input style="border: none; padding: 5px" id="userName"
										type="text" value="${result.userNm}" placeholder="이름" readonly="readonly">
								</div>
								<div>
									<input style="border: none; padding: 5px" id="userEmail"
										type="text" value="${result.email}" placeholder="이메일" readonly="readonly">
								</div>
								<div>
									<input style="border: none; padding: 5px" id="userPhone"
										type="text" value="${result.phone}" placeholder="연락처" readonly="readonly">
								</div>
							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">간단소개글</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">
										• 본인의 업무 경험을 기반으로 핵심역량과 업무 스킬을 간단히 작성해주세요. <br> • 3~5줄로
										요약하여 작성하는 것을 추천합니다!
									</p>
								</div>
								<div>
									<textarea style="border: none; padding: 5px; height: auto;" id="short_intro" 
										placeholder="소개글을 입력해주세요.">${result.shortIntro}</textarea>
								</div>
							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">경력</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">
										• 담당하신 업무 중 우선순위가 높은 업무를 선별하여 최신순으로 작성해주세요. <br> • 신입의
										경우, 직무와 관련된 대외활동, 인턴, 계약직 경력 등이 있다면 작성해주세요. <br> • 업무 또는
										활동 시 담당했던 역할과 과정, 성과에 대해 자세히 작성해주세요. <br> • 현재 재직중이면 퇴사일을
										해당월로 입력해주세요.
									</p>
								</div>
								<div class="listDiv">
									<button type="button" class="showTableBtn" id="career">+
										추가</button>
									<ul>
										<li class="list" id="careerList">
											<!-- 조회값 여기에 추가 -->
										</li>
										<li id="careerInputTable" style="display: none;">
											<table class="col">
												<tbody>
													<tr>
														<td><input type="text" id="company"
															style="padding: 5px; width: 80%; margin: 0px"
															placeholder="회사명" required="required"></td>
														<td>입사일 : <input type="month" id="startDate"
															style="padding: 5px; width: 80%; margin: 0px" required="required"></td>
														<td>퇴사일 : <input type="month" id="endDate"
															style="padding: 5px; width: 80%; margin: 0px" required="required"></td>
													</tr>
													<tr>
														<td><input type="text" id="dept"
															style="padding: 5px; width: 80%; margin: 0px"
															placeholder="근무부서" required="required"></td>
														<td><input type="text" id="position"
															style="padding: 5px; width: 80%; margin: 0px"
															placeholder="직책/직급" required="required"></td>
														<td><input type="text" id="reason"
															style="padding: 5px; width: 80%; margin: 0px"
															placeholder="퇴사사유" required="required"></td>
													</tr>
													<tr>
														<td colspan="3"
															style="padding: 5px; width: 80%; margin: 0px"><textarea style="height: 100px;" id="crrDesc" required="required"
																placeholder="  담당업무를 입력해주세요.&#13;&#10;&#13;&#10; - 진행한 업무를 다 적기 보다는 경력사항 별로 중요한 내용만 엄선해서 작성하는 것이 중요합니다!&#13;&#10; - 경력별 프로젝트 내용을 적을 경우, 역할/팀구성/기여도/성과를 기준으로 요약해서 작성해보세요!"></textarea></td>
													</tr>
												</tbody>
											</table>
											<div class="inputBtnGroup">
												<a class="btnType gray cancleBtn" id="career" href="#"><span>취소</span></a>
												<a class="btnType blue" href="javascript:insertCareer()"><span>저장</span></a>
											</div>
										</li>
									</ul>
								</div>
							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">학력</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">• 최신순으로 작성해주세요.</p>
								</div>
								<div class="listDiv">
									<button type="button" class="showTableBtn" id="education">+
										추가</button>
									<ul>
										<li class="list" id="educationList">
											<!-- 조회값 여기에 추가 -->
										</li>
										<li id="educationInputTable" style="display: none;">
											<table class="col">
												<tbody>
													<tr>
														<td><select style="width: 80%" id="eduLevel"> 
																<option value="none" selected="selected">학력구분</option>
																<option value="고등학교">고등학교</option>
																<option value="대학교">대학교</option>
																<option value="대학원(석사)">대학원(석사)</option>
																<option value="대학원(박사)">대학원(박사)</option>
														</select></td>
														<td><input type="text" id="schoolName"
															style="padding: 5px; width: 80%; margin: 0px"
															placeholder="학교명"></td>
														<td><input type="text" id="major"
															style="padding: 5px; width: 80%; margin: 0px"
															placeholder="전공명"></td>

													</tr>
													<tr>
														<td>입학일 : <input type="month" id="admDate"
															style="padding: 5px; width: 80%; margin: 0px"></td>
														<td>졸업일 : <input type="month" id="grdDate"
															style="padding: 5px; width: 80%; margin: 0px"></td>
														<td><select style="width: 80%" id="grdStatus">
																<option value="none" selected="selected">졸업여부</option>
																<option value="졸업">졸업</option>
																<option value="재학">재학</option>
																<option value="중퇴">중퇴</option>
																<option value="휴학">휴학</option>
														</select></td>

													</tr>
												</tbody>
											</table>
											<div class="inputBtnGroup">
												<a class="btnType gray cancleBtn" id="education" href="#"><span>취소</span></a> 
												<a class="btnType blue" href="javascript:insertEdu()"><span>저장</span></a>
											</div>
										</li>
									</ul>
								</div>
							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">스킬</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">
										• 개발 스택, 디자인 툴, 마케팅 툴 등 가지고 있는 직무와 관련된 스킬을 추가해보세요. <br> •
										데이터 분석 툴이나 협업 툴 등의 사용해본 경험이 있으신 툴들도 추가해보세요
									</p>
								</div>
								<div class="listDiv">
									<button type="button" class="showTableBtn" id="skill">+
										추가</button>
								</div>
								<ul>
									<li class="list" id="skillList">
										<!-- 조회값 여기에 추가 -->
									</li>
									<li id="skillInputTable" style="display: none;">
										<table class="row">
											<colgroup>
												<col width="30%">
												<col width="70%">
											</colgroup>
											<tbody>
												<tr>
													<td><input type="text" id="skillName"
														style="padding: 5px; width: 80%; margin: 0px"
														placeholder="스킬명"></td>
													<td><textarea style="height: auto;" id="skillDetail" placeholder="&#13;&#10;스킬상세기재"></textarea></td>
												</tr>
											</tbody>
										</table>
										<div class="inputBtnGroup">
											<a class="btnType gray cancleBtn" id="skill" href="#"><span>취소</span></a>
											<a class="btnType blue" href="javascript:insertSkill()"><span>저장</span></a>
										</div>
									</li>
								</ul>

							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">자격증 및 외국어</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">
										• 직무 관련 자격증, 외국어 자격증이나 수료한 교육 등이 있다면 간략히 작성해주세요. <br> •
										지원하는 회사에서 요구하는 경우가 아니라면 운전면허증과 같은 자격증은 생략하는 것이 좋습니다!
									</p>
								</div>
								<div class="listDiv">
									<button type="button" class="showTableBtn" id="certification">+
										추가</button>
								</div>
								<ul>
									<li class="list" id="certificationList">
										<!-- 조회값 여기에 추가 -->
									</li>
									<li id="certificationInputTable" style="display: none;">
										<table class="col">
											<colgroup>
												<col width="20%">
												<col width="20%">
												<col width="20%">
												<col width="40%">
											</colgroup>
											<tbody>
												<tr>
													<td><input type="text" id="certName"
														style="padding: 5px; width: 80%; margin: 0px"
														placeholder="자격증명"></td>
													<td><input type="text" id="grade"
														style="padding: 5px; width: 80%; margin: 0px"
														placeholder="등급"></td>
													<td><input type="text" id="issuer"
														style="padding: 5px; width: 80%; margin: 0px"
														placeholder="발행처"></td>
													<td>취득일자 : <input type="month" id="acqDate"
														style="padding: 5px; width: 80%; margin: 0px"></td>
												</tr>
											</tbody>
										</table>
										<div class="inputBtnGroup">
											<a class="btnType gray cancleBtn" id="certification" href="#"><span>취소</span></a> 
											<a class="btnType blue" href="javascript:insertCert()"><span>저장</span></a>
										</div>
									</li>
								</ul>
							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">링크</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">• 깃허브, 노션으로 작성한
										포트폴리오, 구글 드라이브 파일 등 업무 성과를 보여줄 수 있는 링크가 있다면 작성해주세요.</p>
								</div>
								<div>
									<input style="border: none; padding: 5px" id="pfo_link"
										type="text" value="${result.proLink}" placeholder="https://">
								</div>
							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">자기소개서</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">• 지원동기, 직무역량, 직무관련
										성과와 경험, 포부 등 자유롭게 작성해 주세요.</p>
								</div>
								<div>
									<textarea style="border: none; padding: 5px; height: auto;"
										id="personalStatement" rows="" cols=""
										placeholder="자기소개서를 입력해주세요.">${result.perStatement}</textarea>
								</div>
							</div>

							<div class="resumeDetail_body">
								<div class="resumeDetail_body_haeder">첨부파일</div>
								<div class="resumeDetail_body_guide">
									<p class="resumeDetail_body_guide_text">• 포트폴리오, 경력기술서 등
										첨부파일이 있다면 등록해주세요.</p>
								</div>
								<div>
								<c:if test="${empty result.fileName}">
									<input id="resumeAttach" type="file">
								</c:if>
								<c:if test="${not empty result.fileName}">
								<div class="attach-container">
    								<a href="attachment-download?resumeNum=${result.resIdx}"><span class="attach-fileName">${result.fileName}</span></a>
    								<button class="attach-delete" id="attach-delete" onclick="deleteAttach()">
        								<svg xmlns="http://www.w3.org/2000/svg" height="25px" viewBox="0 -960 960 960" width="25px" fill="#5f6368">
            								<path d="M312-144q-29.7 0-50.85-21.15Q240-186.3 240-216v-480h-48v-72h192v-48h192v48h192v72h-48v479.57Q720-186 698.85-165T648-144H312Zm336-552H312v480h336v-480ZM384-288h72v-336h-72v336Zm120 0h72v-336h-72v336ZM312-696v480-480Z" />
        								</svg>
    								</button>
								</div>
								</c:if>
								</div>
							</div>

						</div>
						<div class="btnGroup">
							<a class="btnType gray" href="resume.do"><span>목록으로</span></a> 
							<a class="btnType blue" href="javascript:saveResume()"><span>저장하기</span></a>
							<a class="btnType gray" href="javascript:previewResume()"><span>미리보기</span></a>
						</div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="previewModal" class="layerPop layerType2" style="width: 50%; background-color: white">
		<dl>
			<dt>
				<strong>이력서 미리보기</strong>
			</dt>
			<dd class="content" id="previewResumeContent">
				

			</dd>
				<div class="btn_areaC mt30 mb30">
					<a href="javascript:gfCloseModal()" class="btnType gray" ><span>닫기</span></a>
					<a href="javascript:printResume()" class="btnType blue" ><span>인쇄</span></a>
				</div>
		</dl>
	</div>


</body>
<script type="text/javascript">

	/**
 	* 이력서 seq(시퀀스) 전역변수 설정
 	*/
	var resIdx = $("#resumetitle").data("num");
	
	/**
	 * 텍스트 영역 자동 높이 조절
	 */
	 $('textarea').each(function() {
		    // 초기 높이 설정
		    $(this).css('height', '100px');
		    $(this).height(this.scrollHeight);
		}).on('input', function() {
		    // 최소 높이 설정 후 자동으로 내용에 맞게 높이 조정
		    $(this).css('height', '100px');
		    $(this).height(this.scrollHeight);
		});
	
	/**
	 * 학력 수준에 따른 전공 입력 필드 활성화/비활성화 설정
	 */
	$('#eduLevel').change(function() {
		var eduLevel = $(this).val();
		if (eduLevel === '고등학교') {
			$('#major').prop('disabled', true).val('');
		} else {
			$('#major').prop('disabled', false);
		}
	});

	/**
	 * 페이지 로드 시 초기화 함수 호출
	 */
	$(function() {
		registerBtn();
		initCareer();
		initEdu();
		initSkill();
		initCert();
	})

	/**
	 * 추가 및 취소 버튼 이벤트 등록
 	*/
	function registerBtn() {
		$(".showTableBtn").click(function(e) {
			e.preventDefault();
			var btnId = $(this).attr("id");
			switch (btnId) {
			case "career":
				$("#careerList").hide();
				$("#careerInputTable").show();
				break;
			case "education":
				$("#educationList").hide();
				$("#educationInputTable").show();
				break;
			case "skill":
				$("#skillList").hide();
				$("#skillInputTable").show();
				break;
			case "certification":
				$("#certificationList").hide();
				$("#certificationInputTable").show();
				break;
			}
		})

		$(".cancleBtn").click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr("id");
			switch (btnId) {
			case "career":
				dataReset("careerInputTable");
				$("#careerList").show();
				$("#careerInputTable").hide();
				break;
			case "education":
				dataReset("educationInputTable");
				$("#educationList").show();
				$("#educationInputTable").hide();
				break;
			case "skill":
				dataReset("skillInputTable");
				$("#skillList").show();
				$("#skillInputTable").hide();
				break;
			case "certification":
				dataReset("certificationInputTable");
				$("#certificationList").show();
				$("#certificationInputTable").hide();
				break;
			}
		})
	}

	/**
	 * 입력 폼 초기화 함수
	 * @param tableId - 초기화할 테이블의 ID
	 */
	function dataReset(tableId) {
		$('#' + tableId).find('select').each(function() {
			this.value = '';
		})
		$('#' + tableId).find('input').each(function() {
			this.value = '';
		})
		$('#' + tableId).find('textarea').each(function() {
			this.value = '';
		})
	}
	
	/**
	 * 이력서의 경력 목록 초기화
	 */
	function initCareer(){
		var param = {
			resIdx : resIdx
		}
		var callback = function(res){
			$("#careerList").html(res);
		}
		callAjax("/apply/careerList.do", "post", "text", false, param, callback)
	}
	
	/**
	 * 이력서의 학력 목록 초기화
	 */
	function initEdu(){
		var param = {
				resIdx : resIdx
			}
			var callback = function(res){
				$("#educationList").html(res);
			}
			callAjax("/apply/EduList.do", "post", "text", false, param, callback)
	}
	
	/**
	 * 이력서의 스킬 목록 초기화
	 */
	function initSkill(){
		var param = {
				resIdx : resIdx
			}
			var callback = function(res){
				$("#skillList").html(res);
			}
			callAjax("/apply/skillList.do", "post", "text", false, param, callback)
	}
	
	/**
	 * 이력서의 자격증 목록 초기화
	 */
	function initCert(){
		var param = {
				resIdx : resIdx
			}
			var callback = function(res){
				$("#certificationList").html(res);
			}
			callAjax("/apply/certList.do", "post", "text", false, param, callback)
	}
	
	/**
	 * 경력 정보  추가
	 */
	function insertCareer() {
	    // 유효성 검사
	    if (!$("#company").val() || !$("#dept").val() || !$("#position").val() || !$("#startDate").val() || !$("#endDate").val() || !$("#reason").val() || !$("#crrDesc").val()) {
	        alert("모든 필드를 입력하세요.");
	        return;
	    }
	    
	    var today = new Date();
	    var endDate = new Date($("#endDate").val() + "-01");
	    
	    if (endDate > today) {
	        alert("퇴사일은 오늘보다 미래일 수 없습니다.");
	        return;
	    }

	    var param = {
	        resIdx: resIdx,
	        company: $("#company").val(),
	        dept: $("#dept").val(),
	        position: $("#position").val(),
	        startDate: $("#startDate").val() + "-01",
	        endDate: $("#endDate").val() + "-01",
	        reason: $("#reason").val(),
	        crrDesc: $("#crrDesc").val()
	    };
	    
	    var callback = function(res) {
	        if (res.result === "success") {
	            alert("추가되었습니다.");
	            dataReset("careerInputTable");
	            $("#careerList").show();
	            $("#careerInputTable").hide();
	            initCareer();
	        } else {
	            alert("잠시 후 다시 시도해주세요");
	        }
	    };

	    callAjax("/apply/insertCareer", "post", "json", false, param, callback);
	}

	/**
	 * 학력 정보  추가
	 */
	function insertEdu() {
	    // 유효성 검사
	    if (!$("#eduLevel").val() || !$("#schoolName").val() || !$("#admDate").val() || !$("#grdDate").val() || !$("#grdStatus").val() || $("#eduLevel").val() === "none" || $("#grdStatus").val() === "none") {
	        alert("모든 필드를 입력하세요.");
	        return;
	    }
	    
	    
	    
	    var today = new Date();
	    var grdDate = new Date($("#grdDate").val() + "-01");
	    
	    if (grdDate > today) {
	        alert("졸업일은 오늘보다 미래일 수 없습니다.");
	        return;
	    }

	    var param = {
	        resIdx: resIdx,
	        eduLevel: $("#eduLevel").val(),
	        schoolName: $("#schoolName").val(),
	        major: $("#major").val(),
	        admDate: $("#admDate").val() + "-01",
	        grdDate: $("#grdDate").val() + "-01",
	        grdStatus: $("#grdStatus").val()
	    };

	    var callback = function(res) {
	        if (res.result === "success") {
	            alert("추가되었습니다.");
	            dataReset("educationInputTable");
	            $("#educationList").show();
	            $("#educationInputTable").hide();
	            initEdu();
	        } else {
	            alert("잠시 후 다시 시도해주세요");
	        }
	    };

	    callAjax("/apply/insertEdu", "post", "json", false, param, callback);
	}

	/**
	 * 스킬 정보  추가
	 */
	function insertSkill() {
	    // 유효성 검사
	    if (!$("#skillName").val() || !$("#skillDetail").val()) {
	        alert("모든 필드를 입력하세요.");
	        return;
	    }

	    var param = {
	        skillName: $("#skillName").val(),
	        skillDetail: $("#skillDetail").val(),
	        resIdx: resIdx
	    };

	    var callback = function(res) {
	        if (res.result === "success") {
	            alert("추가되었습니다.");
	            initSkill();
	            dataReset("skillInputTable");
	            $("#skillList").show();
	            $("#skillInputTable").hide();
	        } else {
	            alert("잠시 후 다시 시도해주세요");
	        }
	    };

	    callAjax("/apply/insertSkill", "post", "json", false, param, callback);
	}

	/**
	 * 자격증 정보 추가
	 */
	function insertCert() {
	    // 유효성 검사
	    if (!$("#certName").val() || !$("#grade").val() || !$("#issuer").val() || !$("#acqDate").val()) {
	        alert("모든 필드를 입력하세요.");
	        return;
	    }
	    
	    var today = new Date();
	    var acqDate = new Date($("#acqDate").val() + "-01");
	    
	    if (acqDate > today) {
	        alert("취득일은 오늘보다 미래일 수 없습니다.");
	        return;
	    }

	    var param = {
	        certName: $("#certName").val(),
	        grade: $("#grade").val(),
	        issuer: $("#issuer").val(),
	        acqDate: $("#acqDate").val() + "-01",
	        resIdx: resIdx
	    };

	    var callback = function(res) {
	        if (res.result === "success") {
	            alert("추가되었습니다.");
	            dataReset("certificationInputTable");
	            $("#certificationList").show();
	            $("#certificationInputTable").hide();
	            initCert();
	        } else {
	            alert("잠시 후 다시 시도해주세요");
	        }
	    };

	    callAjax("/apply/insertCert", "post", "json", false, param, callback);
	}

	/**
	 * 경력 정보  삭제
	 */
	function deleteCareer(num){
		var param = {
			resIdx : resIdx,
			crrIdx : num
		}
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다.");
				initCareer();
			}else{
				alert("잠시 후 다시 시도해주세요");
			}
		}
		callAjax("/apply/deleteCareer", "post", "json", false, param, callback)
	}
	
	/**
	 * 학력 정보  삭제
	 */
	function deleteEdu(num){
		var param = {
			resIdx : resIdx,
			eduIdx : num
		}
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다.");
				initEdu();
			}else{
				alert("잠시 후 다시 시도해주세요");
			}
		}
		callAjax("/apply/deleteEdu", "post", "json", false, param, callback)
	}
	
	/**
	 * 스킬 정보  삭제
	 */
	function deleteSkill(num){
		var param = {
			resIdx : resIdx,
			skillIdx : num
		}
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다.");
				initSkill();
			}else{
				alert("잠시 후 다시 시도해주세요");
			}
		}
		callAjax("/apply/deleteSkill", "post", "json", false, param, callback)
	}
	
	/**
	 * 자격증 정보  삭제
	 */
	function deleteCert(num){
		var param = {
			resIdx : resIdx,
			certIdx : num
		}
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다.");
				initCert();
			}else{
				alert("잠시 후 다시 시도해주세요");
			}
		}
		callAjax("/apply/deleteCert", "post", "json", false, param, callback)
	}
	
	/**
	 * 첨부 파일 삭제
	 */
	function deleteAttach(){
		var param = {resIdx : resIdx}	
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다.");
				location.reload();
			}else{
				alert("잠시 후 다시 시도해주세요.");
			}
		}
		callAjax("/apply/deleteAttach", "post", "json", false, param, callback);
	}
	
	/**
	 * 이력서 수정
	 */
	function saveResume() {
	    var res_title = $("#resumetitle").val();
	    var short_intro = $("#short_intro").val();
	    var pfo_link = $("#pfo_link").val();
	    var per_statement = $("#personalStatement").val();
	    var resumeAttach = null;
	    
	    var fileInputTag = $("#resumeAttach");
	    if (fileInputTag.length > 0 && fileInputTag.is(':visible')){
	    	if(fileInputTag[0].files.length > 0){
	    		resumeAttach = fileInputTag[0].files[0];  		
	    	}
	    }
	    
	    var formData = new FormData();
	    formData.append("resIdx", resIdx);
	    formData.append("res_title", res_title);
	    formData.append("short_intro", short_intro);
	    formData.append("pfo_link", pfo_link);
	    formData.append("per_statement", per_statement);

	    if (resumeAttach) {
	        formData.append("resumeAttach", resumeAttach);
	    }

	    var callback = function(res) {
	        if (res.result === "success") {
	            alert("저장되었습니다.");
	            window.location.href = "/apply/resume-detail.do?resumeNum=" + resIdx;
	        } else {
	            alert("저장에 실패했습니다. 잠시 후 다시 시도해주세요.");
	        }
	    }
	    callAjaxFileUpload("/apply/updateResume", "post", "json", false, formData, callback);
	}
	
	function previewResume(){
		gfModalPopTop("#previewModal");
		var param = {resIdx : resIdx}
		var callback = function(res){
			$("#previewResumeContent").html(res)
		}
		callAjax("/apply/previewResume.do", "post", "text", false, param, callback)
	}
	
	function printResume(){
		var printContent = $("#previewResumeContent").html();
	    var originContent = $("body").html();                  

	    window.onbeforeprint = function() {
	        $("body").html(printContent);
	    };
	    
	    window.onafterprint = function() {
	        window.location.reload();
	    };

	    window.print();
	}
	

	
	
</script>
</html>