<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
.container {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 20px;
	padding: 20px;
}

.conTitle {
	display: flex; /* 플렉스박스로 설정하여 요소들을 가로로 배치 */
	justify-content: space-between; /* 양 끝으로 배치 */
	align-items: center; /* 세로 중앙 정렬 */
	margin-bottom: 20px; /* 하단 여백 */
}


/* 전체 폰트 조절 */
body {
	font-family: 'Arial', sans-serif;
	font-size: 16px;
	color: #333;
	margin: 0;
	padding: 0;
}

#selectText{
	display: flex; 
	align-items: flex-start;
	font-size: 20px;
	font-weight: bold;
}

.inputSelect {
	display: flex; 
	align-items: end; 
	justify-content: space-between; 
	width: 100%;
	margin-top:20px;

}
.inputSelect span{
	text-align: center; flex-grow: 1
}


/* 테이블 스타일 */
 		.paging_area{
            width: 990px;
             background-color: #f2f2f2;
        }
         /* 테이블 스타일 */
        #listTable {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        #listTable th {
            background-color: #f2f2f2;
            font-weight: bold;
            padding: 10px;
    		text-align: center; 
    		 vertical-align: middle;
        }
        #listTable td {
            padding: 8px;
            vertical-align: top;
            font-family: Arial, sans-serif; /* 폰트 설정 */
            font-size: 14px; /* 폰트 크기 설정 */
             vertical-align: middle;
        }
        /* 버튼 스타일 */
        .btn {
            display: inline-block;
            padding: 6px 12px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
            text-align: center;
            color: #fff; /* 기본 텍스트 색상 */
            text-decoration: none;
            margin-right: 5px;
        }
        .btn-primary {
            border: 1px solid ;
            color: #000; /* 텍스트 색상: 검은색 */
        }
        .btn-danger {
            border: 1px solid #dc3545;
            color: #dc3545;
        }
        .btn-resume {
            border: 1px solid #007bff;
            color: #007bff;
        }
        .btn:hover {
            opacity: 0.9;
        }
        /* 폰트 스타일 */
        .highlight {
        	font-weight: bold;	
            color: #333; /* 텍스트 색상 */
        }
		.resTitle{
			font-size:18px;
			font-weight: bold;
		}
</style>
<script type="text/javascript">
$(function() {
	 selectList();
})

function selectList(currentPage){
	console.log(currentPage);
	currentPage = currentPage || 1;
	var param = {
		currentPage: currentPage,
		pageSize: 5
	}
	var callback = function(res) {
		console.log(res);
		$("#managehireList").html(res);
		var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "selectList");
		$("#pageArea").html(pageNavi);
	}
	callAjax("/manage-hire/managehireList.do", "post", "text", false,param, callback);
	
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
							<a href="/WEB-INF/view/notice/notice.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">채용관리</span> <span class="btn_nav bold">공고 관리(채용관리자)
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>공고 관리 </span> 
                  		</p>
                  		<div class="inputSelect">
                  			<a href="/manage-hire/managehireWritePage.do" class="btnType gray"><span>공고 등록</span></a>
                  		</div>
                  		 <div id="listTable">
                  		 <!--과정에 따른 테이블 갯수 추가  -->
                            <table class="col" style="width: 1000px; border: 1px solid;">
                                <colgroup>
									<col width="40%">
									<col width="10%">
									<col width="10%">
									<col width="30%">
									<col width="10%">
								</colgroup>
                                <thead>
                                	<tr >
	                                	<th class="Thead">공고제목
	                                	</th>
                                		<th class="Thead">경력여부
                                		</th>
                                		<th class="Thead">게시일
                                		</th>
                                		<th class="Thead">채용기간
                                		</th>
                                		<th class="Thead">승인여부
                                		</th>
                                	</tr>
                                </thead>
                                
                                <tbody id="managehireList">
                                   
                                </tbody>
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