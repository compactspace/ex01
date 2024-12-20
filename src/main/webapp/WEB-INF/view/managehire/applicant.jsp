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
            border: 0px solid; /* 기본 테두리 0px 설정 */
            border-top: 0.5px solid #ddd; /* 상단 테두리 0.5px 설정 */
            text-align: left;
        }
        #listTable td {
            padding: 8px;
            border: 0px solid; /* 기본 테두리 0px 설정 */
            vertical-align: top;
            font-family: Arial, sans-serif; /* 폰트 설정 */
            font-size: 14px; /* 폰트 크기 설정 */
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
        /* 행 구분 스타일 */
        .row-separator {
            border-top: 1px solid #b0b0b0; /* 구분선 추가 */
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
	var postText = $("#postTitle option:selected").text();
	selectText(postText); // 첫 text 입력
	selectList();
	// div 안에 selectvalue 출력
	$("#postTitle").change(function changeText(){
		var selectText = $("#selectText");   //value값을 출력할 div
		var postText = $("#postTitle option:selected").text();  //select의 value값
		selectText.text(postText);
		selectList()
	})
	// div 안에 selectvalue 출력
	$("#selectValue").change(function changeText(){
		selectList()
	})
	
	 // 합격 버튼 클릭 이벤트
    $(document).on('click', '.btn-resume', function() {
        const userId = $(this).data('user-id');
        const currentStatus = $(this).data('current-status'); // 현재 상태
        let nextStatus;
        // 이력서 열람 유무? 함수
        viewChange(userId);
		
        // 현재 상태에 따른 다음 상태 결정
        if (currentStatus === '서류심사중') {
            nextStatus = '면접진행중'; // 서류심사 후 면접 진행
            statusUpdate(userId,nextStatus)
            selectList();
        } else if (currentStatus === '면접진행중') {
            nextStatus = '최종합격'; // 면접 진행 후 최종 합격
            statusUpdate(userId,nextStatus)
            selectList();
        } else if (currentStatus.includes('탈락')){
        	nextStatus = '서류심사중'; // 면접 진행 후 최종 합격
            statusUpdate(userId,nextStatus)
            selectList();
        } else {
            alert('더 이상 진행할 수 없는 상태입니다.');
            return;
        }
        
    });

    // 불합격 버튼 클릭 이벤트
    $(document).on('click','.btn-danger', function() {
        const userId = $(this).data('user-id');
        
        const currentStatus = $(this).data('current-status'); // 현재 상태
        let nextStatus;
     	// 이력서 열람 유무? 함수
        viewChange(userId);
        // 현재 상태에 따른 다음 상태 결정
        if (currentStatus === '서류심사중') {
            nextStatus = '서류탈락'; // 서류심사 후 면접 진행
            statusUpdate(userId,nextStatus)
            selectList();
            return
        } else if (currentStatus === '면접진행중') {
            nextStatus = '면접탈락'; // 면접 진행 후 최종 합격
            statusUpdate(userId,nextStatus)
            selectList();
            return
        } else {
            alert('더 이상 진행할 수 없는 상태입니다.');
            return;
        }
    });
    
    //이력서 클릭이벤트
	$(document).on('click','.res',function(e){
		console.log("이력서가 클릭되었습니다.");
		previewResume($(this));
		selectList();
	})
	
})



function selectList(currentPage){
	var postTitle = $("#postTitle").val(); //postIdx
	var selectValue = $("#selectValue").val(); //keyword
	currentPage = currentPage || 1;
	var param = {
		postIdx : postTitle,
		keyword : selectValue,
		currentPage: currentPage,
		pageSize: 5
	}
	var callback = function(res) {
		$("#resultList").html(res);
		
		var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "selectList");
		$("#pageArea").html(pageNavi);
	}
	callAjax("/manage-hire/applicantList.do", "post", "text", false,param, callback);
	
}
//div 안에 selectvalue 출력
function selectText(postText){
	var selectText = $("#selectText");
	
	selectText.text(postText);
}


function hiringProcSerch(){
	var hiringProcSerch = $("#hiringProcSerch").val();
}

//업데이트 함수
function statusUpdate(userId, status) {
	var postTitle = $("#postTitle").val(); //postIdx
    var fileData = {
        loginId: userId,
        postIdx: postTitle,
        keyword: status
    };

    // 콜백 함수 설정
    var callback = function(res) {
    	if(res.result === "success"){
    		console.log("수정되었습니다");
    	}else{
    		console.log("실패");
    	}
    };

    // Ajax 요청
    callAjax("/manage-hire/statusUpdate.do", "POST", "json", false, fileData, callback);
}
/* 이력서 프리뷰 */
function previewResume(element) {
	const userId = element.data('user-id');
    const resIdx = element.data('residx');
	 
	viewChange(userId);
		gfModalPopTop("#previewModal");
		var param = {
			resIdx : resIdx
		}
		var callback = function(res) {
			$("#previewResumeContent").html(res);
		}
		callAjax("/apply/previewResume.do", "post", "text", false, param,
				callback)
		
	}
//이력서 열람 유무? 함수
  function viewChange(userId){
        var postTitle = $("#postTitle").val();
        
        var param = { 
        		loginId: userId,
        		postIdx:postTitle
        		};
        // 간단한 콜백으로 처리
        var callback = function(res) {
            if (res.result === "success") {
                console.log("뷰가 1로 업데이트 됐습니다.");
            }
        };
        
        callAjax("/manage-hire/viewUpdate.do", "post", "text", false, param, callback)
    }
    //select 결과에 따른 버튼 활성화
  function toggleButtons() {
      var selectValue = $("#selectValue").val();
      var btnPass = $("#btnPass");
      var btnFail = $("#btnFail");
	  console.log("selectValue : " + selectValue);
      if (selectValue === "최종합격" || selectValue === "탈락") {
          btnPass.style.display = "none";
          btnFail.style.display = "none";
      } else {
          btnPass.style.display = "inline-block";
          btnFail.style.display = "inline-block";
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
							<a href="/WEB-INF/view/notice/notice.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">채용관리</span> <span class="btn_nav bold">지원자 관리(채용관리자)
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>지원자 관리 </span> 
                  		</p>
                  		<div class="inputSelect">
                  			<span id="selectText" name="title"></span>
                  			<select id="postTitle">
                  				<c:forEach var="MDetail" items="${MDetail}">
                  				<option value="${MDetail.postIdx}">${MDetail.title}</option>
                  				</c:forEach>
                  				
                  			</select>
                  			<select id="selectValue">
							    <option value="서류심사중" ${keyword == '서류심사중' ? 'selected' : ''}>서류심사</option>
							    <option value="면접진행중" ${keyword == '면접진행중' ? 'selected' : ''}>면접진행</option>
							    <option value="최종합격" ${keyword == '최종합격' ? 'selected' : ''}>최종합격</option>
							    <option value="탈락" ${keyword == '탈락' ? 'selected' : ''}>불합격</option>
							</select>
                  		</div>
                  		
                  		 <div id="listTable">
                  		 <!--과정에 따른 테이블 갯수 추가  -->
                            <table class="col" style="width: 1000px; border: 1px solid;">
                                <thead id="resultList">
                                   
                                </thead>
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
	<!--  이력서 모달창 -->
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

</body>
</html>