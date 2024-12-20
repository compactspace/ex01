<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공고 심사</title>
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">	

$(function() {
	updateTitleBasedOnURL();
	 
	// 화면이 열렸을 때, 공지사항 데이터를 받아온다.
	managePostSearch();
	registerBtnEvent();
});

function registerBtnEvent(){
	$("#searchBtn").click(function(e){
		e.preventDefault();
		managePostSearch();
	});
	
	$("a[name=btn]").click(function(e){
		e.preventDefault();
		
	var btnId = $(this).attr("id");
	
	switch(btnId) {
	
	}
})

}

function updateTitleBasedOnURL() {
	 var url = window.location.href;
	    var newTitle = url.includes('/manage-post/approval.do') ? "공고 심사" : "공고 보기";
	    
	    // 조건에 따라 여러 요소의 텍스트 변경
	    $('#lastTitle').text(newTitle);
	    $('#secondTitle').text(newTitle);
}

function managePostSearch(currentPage){
	currentPage = currentPage || 1;
	
	var url = window.location.href;
	console.log(url);

	
	// 공지사항 데이터를 불러오는 로직
	var param = {
			searchTitle: $("#searchTitle").val(),
			searchStDate: $("#searchStDate").val(),
			searchEdDate: $("#searchEdDate").val(),
			currentPage: currentPage,
			pageSize: 5
	}
	
	
	var callback = function(res){
		$("#resultList").html(res);
		
		var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "managePostSearch");
		$("#pageArea").html(pageNavi);
	}
	
	console.log("Parameter:", param); // callAjaxSendUrl 호출 직전에 확인
	callAjaxSendUrl("/manage-post/readPostList.do", "post", "text", false, param, callback);
	
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
							<a href="/WEB-INF/view/manage-post/approval.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">
							    <c:choose>
                               <c:when test="${userType eq 'A'}">
                                 <span>채용 정보</span>
                                 </c:when>
                              <c:when test="${userType eq 'M'}">
                               <span>채용공고관리</span>
                                </c:when>
                                  <c:otherwise>
                           <span>채용 공고</span> <!-- 기본 텍스트가 필요한 경우 설정 -->
                                 </c:otherwise>
                            </c:choose>
                            </span> 
                            
						<span class="btn_nav bold" id="secondTitle">공고 보기</span><a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>
		                     
		                      <c:choose>
                      <c:when test="${userType eq 'A'}">
                     <span>채용 공고</span>
                      </c:when>
              
                     <c:when test="${userType eq 'M'}">
                     <span id="lastTitle">공고 보기</span>
                       </c:when>
                       
                <c:otherwise>
                <span>공고 보기</span> <!-- 기본 텍스트가 필요한 경우 설정 -->
            </c:otherwise>
        </c:choose>
		                     </span> 
		                     
		                     
		                     <span class="fr">

		                     제목
		                     <input type="text" id="searchTitle" name="searchtitle">
		                     기간
		                     <input type="date" id="searchStDate" name="searchstdate"> 
		                     ~ <input type="date" id="searchEdDate" name="searcheddate"> 
	
		                       <a class="btnType blue" href="" id="searchBtn"><span>검색</span></a>
		                       
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									 <c:if test="${userType eq 'M'}">
									<col width="5%">
										</c:if>
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
								<!--    <th scope="col">사업자명</th> -->	
										<th scope="col">제목</th>
										<th scope="col">근무지역</th>
										<th scope="col">경력여부</th>
										<th scope="col">마감일</th>
										<th scope="col">등록일</th>
										
										 <c:if test="${userType eq 'M'}">
										<th scope="col">승인 여부</th>
										</c:if>
										
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
	
</body>
</html>
