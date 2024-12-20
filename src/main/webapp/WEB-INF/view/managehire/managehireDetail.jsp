<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공고리스트</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
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
/* 수정 버튼 */
.btn-outline-primary {
	background-color: transparent;
	color: #007bff;
	border: 1px solid #007bff;
}

.btn-outline-primary:hover {
	background-color: #007bff;
	color: white;
}

/* 삭제 버튼 */
.btn-outline-danger {
	background-color: transparent;
	color: #dc3545;
	border: 1px solid #dc3545;
}

.btn-outline-danger:hover {
	background-color: #dc3545;
	color: white;
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

.align img {
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
</style>
<script type="text/javascript">
	$(function() {
		const bizIdx = $("#bizIdx").val();
		const postIdx = $("#postIdx").val();
		console.log("bizIdx : " + bizIdx)
		registerBtnEvent(); // 버튼 이벤트 등록
		$("#btnManagehireUpdate").click(function() {
			window.location.href = "/manage-hire/managehireUpdatePage.do/"+postIdx+"/"+bizIdx;
		});
	});
	//버튼을 클릭하면 동작하는 함수
	function registerBtnEvent() {
		$("a[name=btn]").click(function(e) {
			e.preventDefault(); // 앵커 태그 기본 동작 방지

			var btnId = $(this).attr("id"); // 클릭된 버튼의 ID 가져오기
			console.log("btnId : " + btnId);
			switch (btnId) {
			case "btnManagehireDelete":
				console.log("눌렸습니다 : ");
				// 삭제했을때 스크랩 postIdx를 0으로 수정
				managehireDelete(); // 삭제 함수 호출
				break;
			}
		});
	}

	// 채용공고 삭제 함수
	function managehireDelete() {
		// 날짜가 만료되면 삭제함
		// endDate 요소를 가져옴
		const endDateText = $('#endDate').text();
		
		const bizIdx = $("#bizIdx").val();
		const postIdx = $("#postIdx").val();
		
		scrapUpdate();
		var fileData = {
			bizIdx: bizIdx,
			postIdx : postIdx,
			endDateText : endDateText
		}
		var callback = function(res) {
			if (res.result === "success") {
				alert("삭제되었습니다.");

			} else {
				alert("삭제 실패하였습니다.");
			}
		};
		callAjax("/manage-hire/managehireDelete.do", "post", "json", false,
				fileData, callback);
		window.location.href = "/manage-hire/post.do";
	}
	// 삭제했을때 스크랩 postIdx를 0으로 수정
	function scrapUpdate() {
		var postIdx = $("#postIdx").val();

		var param = {
			postIdx : postIdx
		//input hidden 등으로 넣어줬을 공고 번호(인덱스)
		}

		var callback = function(res) {
			if (res.result === "success") {
				alert("수정되었습니다");
			}
		}
		callAjax("/jobs/updateScrap.do", "post", "json", false, param, callback);
	}
	function download() {
		var bizIdx = $("#bizIdx").val();
		var postIdx = $("#postIdx").val();
		console.log("postIdx : " + postIdx );
		var hiddenInput = "<input type='hidden' name='bizIdx' value='" + bizIdx + "' /> <input type='hidden' name='postIdx' value='" + postIdx + "' />";
		console.log("hiddenInput : " + hiddenInput );
		
		$(
				"<form action='/manage-hire/managehireDownload.do' method='post' id='fileDownload'>"
						+ hiddenInput + "</form>").appendTo('body').submit()
				.remove();
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
							<a href="/WEB-INF/view/notice/notice.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">채용관리</span> <span class="btn_nav bold">채용
								공고(채용관리자) </span> <a href="../system/comnCodMgr.do"
								class="btn_set refresh">새로고침</a>
						</p>
						<form>
							<input type="hidden" id="postIdx" name="postIdx"
								value="${MDetail.postIdx}"> <input type='hidden'
								id='bizIdx' name='bizIdx' value='${MDetail.bizIdx}'>
						</form>
						<div class="conTitle">
							<span>채용 공고</span>
							<c:if
								test="${!empty userType && !empty loginId && userType == 'B' && loginId == CDetail.loginId}">
								<div class="action-buttons">
									<a href="#" class="btn btn-outline-primary"
										id="btnManagehireUpdate" name="btn">수정</a> <a href="#"
										class="btn btn-outline-danger" id="btnManagehireDelete"
										name="btn">삭제</a>
								</div>
							</c:if>
						</div>

						<div class="container1">
							<!-- 왼쪽: 채용 정보 -->
							<section class="job-details">
								<div class="grid-layout">
									<!-- 기업명과 채용 제목 -->
									<div class="detail-item">
										<h2>(주)${CDetail.bizName}</h2>
										<h3>${MDetail.title}</h3>
									</div>

									<!-- 스크랩 및 입사지원 버튼 (지원자들에게만 보이게끔)-->
									<div class="detail-item action-buttons"></div>

									<!-- 기본 정보 -->
									<div class="detail-item">
										<strong>경력:</strong> ${MDetail.expRequired}
										<c:if test="${MDetail.expYears != null}">(${MDetail.expYears})</c:if>
									</div>

									<div class="detail-item">
										<strong>급여:</strong> 연봉 ${MDetail.salary}만원
									</div>

									<div class="detail-item">
										<strong>모집인원:</strong> ${MDetail.openings}명
									</div>

									<div class="detail-item">
										<strong>근무지역:</strong> ${MDetail.workLocation}
									</div>

									<!-- 업무 내용 (높이 설정) -->
									<c:if test="${not empty MDetail.duties}">
										<div class="detail-item full-width duties">
											<strong>업무</strong><br> &emsp;${MDetail.duties}
										</div>
									</c:if>

									<c:if test="${not empty MDetail.posDescription}">
										<div class="detail-item full-width duties">
											<strong>포지션 소개</strong><br>
											&emsp;${MDetail.posDescription}
										</div>
									</c:if>

									<c:if test="${not empty MDetail.reqQualifications}">
										<div class="detail-item full-width duties">
											<strong>자격요건</strong><br>
											&emsp;${MDetail.reqQualifications}
										</div>
									</c:if>

									<c:if test="${not empty MDetail.prefQualifications}">
										<div class="detail-item full-width duties">
											<strong>우대사항</strong><br>
											&emsp;${MDetail.prefQualifications}
										</div>
									</c:if>

									<c:if test="${not empty MDetail.benefits}">
										<div class="detail-item full-width duties">
											<strong>혜택 & 복지</strong><br> &emsp;${MDetail.benefits}
										</div>
									</c:if>
								</div>
							</section>
							<!-- 오른쪽: 기업 정보 -->
							<aside class="company-info">
								<div class="align">
									<img src="${CDetail.logicalPath} " alt="${CDetail.bizName} 로고" width="150" height="150">
								</div>
								<h4>기업 정보</h4>
								<p>
									<strong>기업명:</strong> ${CDetail.bizName}
								</p>
								<p>
									<strong>연락처:</strong> ${CDetail.bizContact}
								</p>
								<p>
									<strong>사원수:</strong> ${CDetail.bizEmpCount}
								</p>
								<p>
									<strong>주소:</strong> ${CDetail.bizAddr}
								</p>
								<p>
									<strong>대표명:</strong> ${CDetail.bizCeoName}
								</p>
								<div class="align">
									<a href="/company/companyDetailPage.do/${MDetail.postIdx}/${CDetail.bizIdx}" class="company-info-link">기업정보→</a>
								</div>
								<div class="date">
									<span class="remaining">남은 기간</span>
									<div class="date-details">
										<div class="date-item">
											<span class="date-item">시작일</span><br> <span
												class="date-item">마감일</span>
										</div>
										<div class="date-item">
											<span class="date-item">${startDate}시</span><br> <span
												class="date-item" id="endDate">${endDate}시</span>
										</div>
									</div>
								</div>
								<c:if test="${not empty MDetail.fileName}">
									<div class="downloadDiv">
										<span class="remaining">첨부파일 :</span> <span class="remaining">
											<a href='javascript:download()'>${MDetail.fileName}</a>
										</span>
									</div>
								</c:if>
							</aside>


						</div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>