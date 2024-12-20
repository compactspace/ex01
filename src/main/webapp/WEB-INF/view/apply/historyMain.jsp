<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<style type="text/css">
.content input, .content select {
	width: 110px;
	height: 30px;
	border: 1px solid #bbc2cd;
	padding-left: 2px;
	border-radius: 4px;
	border: 1px solid #bbc2cd;
}

table tbody td {
	background-color: white;
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
							<span class="btn_nav bold">이력서보기</span> <a
								href="javascript:window.location.reload()"
								class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>입사지원 내역</span> <span class="fr"> <select
								class="period" id="period">
									<option value="all">조회기간 전체</option>
									<option value="1week">지난 1주일</option>
									<option value="1month">지난 1개월</option>
									<option value="2month">지난 2개월</option>
									<option value="3month">지난 3개월</option>
									<option value="6month">지난 6개월</option>
									<option value="1year">지난 1년</option>
							</select> <select class="view-status" id="view-status">
									<option value="all">열람여부 전체</option>
									<option value="1">열람</option>
									<option value="0">미열람</option>
							</select> <select class="sort-order" id="sort-order">
									<option value="desc">최근지원순</option>
									<option value="asc">과거지원순</option>
							</select> <input type="text" class="keyword" id="keyword"
								placeholder="키워드 입력"> <a class="btnType blue"
								href="javascript:searchHistory()"><span>검색</span></a> <a
								class="btnType gray" href="javascript:reset()"><span>초기화</span></a>
							</span>
						</p>

						<div class="divComGrpCodList">
							<table class="col">
								<caption>지원내역 테이블</caption>
								<colgroup>
									<col width="15%">
									<col width="40%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
								</colgroup>

								<thead>
									<tr>
										<th scope="col">지원일</th>
										<th scope="col">지원내역</th>
										<th scope="col">공고진행상태</th>
										<th scope="col">열람</th>
										<th scope="col">취소/삭제</th>
									</tr>
								</thead>
								<tbody id="resultList">
									<c:if test="${empty result}">
										<tr>
											<td colspan="5" style="height: 400px">
												<p>
													<img
														src="https://www.saraminimage.co.kr/sri/person/resume/img_empty_announce.png">
												</p>
												<p
													style="font-size: 18px; font-weight: bold; color: #868686; padding: 15px">입사
													지원 내역이 없어요.</p>
												<p style="font-size: 14px;">
													<a href="/jobs/posts.do" style="color: #3157dd">현재 채용중인
														공고 보러가기 > </a>
												</p>
											</td>
										</tr>
									</c:if>

									<c:if test="${not empty result}">
										<c:forEach var="data" items="${result}">
											<tr class="resume-entry">
												<td class="application-date">
													<p class="status" style="font-size: 10px">지원완료</p>
													<p class="date">
														<fmt:formatDate value="${data.applyDate}"
															pattern="yyyy .MM .dd" />
												</td>
												<td class="application-details">
													<p class="company-name"
														style="text-align: left; padding-left: 50px; margin-top: 5px; font-size: 14px">
														<a href="/company/companyDetailPage.do/${data.postingId}/${data.bizIdx}">${data.bizName}</a>
													</p>
													<p class="job-title"
														style="text-align: left; padding-left: 50px; margin-top: 5px; font-size: 15px; font-weight: bold">
														<a href="/manage-post/${data.postingId}/${data.bizIdx}">${data.postTitle}</a>
													</p>
													<p class="resume-link"
														style="text-align: left; padding-left: 50px; margin: 5px 0px 5px 0px; font-size: 13px">
														<a href="javascript:previewResume(${data.resIdx})"><span>지원이력서</span></a>
													</p>
												</td>
												<td class="job-status">
													<p class="status">${data.status}</p>
												</td>
												<td class="view-status">
													<p>
														<c:choose>
															<c:when test="${data.viewed == 1}">열람</c:when>
															<c:otherwise>미열람</c:otherwise>
														</c:choose>
													</p>
												</td>
												<td class="cancel"><c:if
														test="${data.status == '지원완료'}">
														<a class="cancleApply"
															href="javascript:cancleApply(${data.appId})"><span>지원취소</span></a>
													</c:if> <c:if test="${data.status != '지원완료'}">
														<span style="color: #868686;">지원취소</span>
													</c:if></td>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>

						<div id="previewModal" class="layerPop layerType2"
							style="width: 50%; background-color: white">
							<dl>
								<dt>
									<strong>이력서 미리보기</strong>
								</dt>
								<dd class="content" id="previewResumeContent"></dd>
								<div class="btn_areaC mt30 mb30">
									<a href="javascript:gfCloseModal()" class="btnType gray"><span>닫기</span></a>
									<a href="javascript:printResume()" class="btnType blue"><span>인쇄</span></a>
								</div>
							</dl>
						</div>

						<div class="paging_area" id="pageArea">
							<!-- 페이징 영역 -->
						</div>

					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
	//페이지네이션 관련 설정 변수
	var currentPage = 1; // 현재 페이지
	var pageRow = 5; // 한 페이지당 표시할 행 수
	var blockPage = 5; // 페이지 블록 크기
	var resultList = $("#resultList"); // 결과 목록 테이블
	var totalCount = $("#resultList").find('tr').length; // 총 데이터 개수

	/**
	 * 페이지에 맞는 데이터를 렌더링합니다.
	 * @param {number} page - 표시할 페이지 번호
	 */
	function renderPage(page) {
		currentPage = page;
		resultList.find('tr').hide(); // 모든 행 숨김
		var startIndex = (currentPage - 1) * pageRow; // 현재 페이지 시작 인덱스
		var endIndex = startIndex + pageRow; // 현재 페이지 끝 인덱스
		resultList.find('tr').slice(startIndex, endIndex).show(); // 현재 페이지에 해당하는 행만 표시

		var pageNavi = getPaginationHtml(currentPage, totalCount, pageRow,
				blockPage, 'renderPage'); // 페이지네이션 생성
		$("#pageArea").html(pageNavi); // 페이지네이션 영역에 HTML 삽입
	}
	renderPage(currentPage);

	/**
	 * 이전 검색조건 히스토리가 존재하는 경우, 검색조건을 리스트에 반영합니다.
	 */
	if (sessionStorage.getItem("filterHistory")) {
		const
		params = new URLSearchParams(sessionStorage.getItem("filterHistory"));

		$("#period").val(params.get("period") || "all");
		$("#view-status").val(params.get("viewStatus") || "all");
		$("#sort-order").val(params.get("sortOrder") || "desc");
		$("#keyword").val(params.get("keyWord") || "");
	}

	/**
	 * 검색 조건을 적용하여 이력서 검색을 수행합니다.
	 * 검색 조건을 세션에 저장하여 새로고침 시에도 적용된 상태로 유지합니다.
	 */
	function searchHistory() {
		var period = $("#period").val();
		var startDate = formatDate(new Date(), period); // 기간에 따른 시작 날짜 계산
		var keyWord = $("#keyword").val() ? $("#keyword").val() : "";

		var params = new URLSearchParams({
			period : period,
			startDate : startDate,
			viewStatus : $("#view-status").val(),
			sortOrder : $("#sort-order").val(),
			keyWord : keyWord
		});

		sessionStorage.setItem("filterHistory", params.toString()); // 필터 설정을 세션에 저장
		window.location.href = "/apply/searchHistory.do?" + params.toString(); // 검색 결과 페이지로 이동
	}

	/**
	 * 필터 초기화 기능. 모든 필터 값을 기본 값으로 초기화한 후 검색 수행.
	 */
	function reset() {
		$("#period").val("all");
		$("#view-status").val("all");
		$("#sort-order").val("desc");
		$("#keyword").val(null);
		searchHistory();
	}

	/**
	 * 지정된 기간을 기준으로 시작 날짜를 계산하여 반환합니다.
	 * @param {Date} today - 현재 날짜
	 * @param {string} period - 선택한 기간 옵션
	 * @return {string} - 계산된 시작 날짜 (형식: YYYY-MM-DD)
	 */
	function formatDate(today, period) {
		switch (period) {
		case "1week":
			today.setDate(today.getDate() - 7);
			break;
		case "1month":
			today.setMonth(today.getMonth() - 1);
			break;
		case "2month":
			today.setMonth(today.getMonth() - 2);
			break;
		case "3month":
			today.setMonth(today.getMonth() - 3);
			break;
		case "6month":
			today.setMonth(today.getMonth() - 6);
			break;
		case "1year":
			today.setFullYear(today.getFullYear() - 1);
			break;
		default:
			today.setFullYear(today.getFullYear() - 3);
			break;
		}
		return today.getFullYear() + '-'
				+ String(today.getMonth() + 1).padStart(2, '0') + '-'
				+ String(today.getDate()).padStart(2, '0');
	}

	/**
	 * 지원 취소 기능. 사용자가 확인 후 지원 내역을 취소하고, 취소 결과에 따라 페이지를 갱신.
	 * @param {number} num - 지원 ID
	 */
	function cancleApply(num) {
		if (confirm("지원취소 하시겠습니까?")) {
			var param = {
				appId : num
			};

			var callback = function(res) {
				if (res.result === "success") {
					alert("지원취소 완료하였습니다.");
					if (sessionStorage.getItem("filterHistory") !== null) {
						window.location.href = "/apply/searchHistory.do?"
								+ sessionStorage.getItem("filterHistory");
					} else {
						window.location.href = "/apply/history.do";
					}
				} else {
					alert("지원 취소에 실패했습니다. 다시 시도해 주세요.");
				}
			};
			callAjax("/apply/cancleApply.do", "post", "json", false, param,
					callback);
		} else {
			return false;
		}
	}

	function previewResume(resIdx) {
		gfModalPopTop("#previewModal");
		var param = {
			resIdx : resIdx
		}
		var callback = function(res) {
			$("#previewResumeContent").html(res)
		}
		callAjax("/apply/previewResume.do", "post", "text", false, param,
				callback)
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
