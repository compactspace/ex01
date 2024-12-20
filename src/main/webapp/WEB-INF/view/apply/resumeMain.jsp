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
#listTr{
	height: 100px;
	background-color: white;
}
#listTr:HOVER{
	background-color: #eaf2fe;
}
#resumeTitle{
	font-size : 18px;
	font-weight: bold;
	padding : 10px;
}
#attachTitle{
	color : blue;
	text-decoration: underline;
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
							<span class="btn_nav bold">입사지원</span> <span class="btn_nav bold">이력서
							</span> <a href="javascript:window.location.reload()" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>나의 이력서</span> <span class="fr"> <a
								class="btnType blue" href="resume-new.do"><span>새 이력서
										작성</span></a>
							</span>
						</p>

						<div class="box_section">
							<div class="divComGrpCodList">
								<table class="col">
									<caption>이력서제목, 관리, 최종수정일을(를) 제공하는 표</caption>
									<colgroup>
										<col>
										<col width="25%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">이력서 제목</th>
											<th scope="col">관리</th>
											<th scope="col">최종수정일</th>
										</tr>
									</thead>
									<tbody class="" id="">
										<c:if test="${empty result}">
    										<tr>
        										<td colspan="3">작성한 이력서가 없습니다.</td>
    										</tr>
										</c:if>
										<c:forEach var="data" items="${result}">
    										<tr id="listTr">
        										<td>
            										<a href="resume-detail.do?resumeNum=${data.resIdx}">
                										<p id="resumeTitle">${data.resTitle}</p>
            										</a>
            									<c:if test="${not empty data.fileName}">
                									<a href="attachment-download?resumeNum=${data.resIdx}">
                    									<p id="attachTitle">첨부파일 : ${data.fileName}</p>
                									</a>
            									</c:if>
        										</td>

        										<td>
										            <span class="box_btn_group"> 
                										<a class="btnType blue" href="javascript:copyResume(${data.resIdx})"><span>복사하기</span></a>
                										<a class="btnType gray" href="javascript:deleteResume(${data.resIdx})"><span>삭제하기</span></a>
            										</span>
        										</td>
        
        										<td>
            										<span>
                										<fmt:formatDate value="${data.updatedDate}" pattern="yyyy .MM .dd" />
            										</span>
        										</td>
    										</tr>
										</c:forEach>
									</tbody>

								</table>
							</div>
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


	function deleteResume(num){
		if(confirm("삭제하시겠습니까?")){
			var param = {
					resIdx : num
			}
			var callback = function(res){
				if(res.result === "success"){
					alert("삭제되었습니다.");
					location.reload();
				}else{
					alert("잠시 후 다시 시도해주세요");
				}
			}
			callAjax("/apply/resumeDelete.do", "post", "json", false, param, callback);
		}
	}
	
	function copyResume(num){
		var param = {
				resIdx : num
		}
		var callback = function(res){
			if(res.result === "success"){
				location.reload();
			}else{
				alert("잠시 후 다시 시도해주세요");
			}
		}
		callAjax("/apply/resumeCopy.do", "post", "json", false, param, callback);
	}
</script>
</html>