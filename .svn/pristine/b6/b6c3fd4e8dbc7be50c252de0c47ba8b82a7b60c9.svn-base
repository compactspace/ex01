<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공고등록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style>
  /   table {
        width: 100%;
        border-collapse: collapse; /* 테두리 중복 제거 */
        margin-top: 10px;
    }

    /* 테두리와 셀 간격 조정 */
    th, td {
        border: 1px solid #ddd; /* 테두리 */
        padding: 12px; /* 여유 공간 */
        text-align: left;
        vertical-align: middle; /* 세로 중앙 정렬 */
    }

    /* 테이블 헤더 스타일 */
    th {
        background-color: #f5f5f5; /* 밝은 배경 */
        font-weight: bold;
        text-align: center; /* 중앙 정렬 */
    }

   /* 인풋과 텍스트 에리어 기본 스타일 */
input[type="text"],
input[type="number"],
input[type="file"],
textarea{
    width: calc(100% - 24px);
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

/* 추가된 select 스타일 */
select {
    height: 40px; /* Adjust the height to match input fields */
    line-height: 20px; /* Set line height for text alignment */
    border: 1px solid #ccc;
    border-radius: 4px;
}
    #hirProcess{
        width: calc(60% - 24px);
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
     input[type="datetime-local"]{
     	 width: calc(30% - 24px);
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
     }
		
		/* select 박스가 비활성화되었을 때 색상 */
		select:disabled {
		    background-color: #f0f0f0; /* 비활성화 시 배경색 */
		}
		
		/* 체크박스와 라디오 버튼 스타일 */
		input[type="checkbox"], 
		input[type="radio"] {
		    transform: scale(1.3); /* 크기 조정 */
		    margin-right: 8px; /* 오른쪽 여백 */
		}
		
		/* 체크박스 및 라디오 버튼 레이블 스타일 */
		label {
		    display: inline-flex; /* 인라인 플렉스 박스 설정 */
		    align-items: center; /* 수직 중앙 정렬 */
		    margin-right: 15px; /* 여유 공간 */
		}
		
		/* 채용공고 출력 css  */
		#hiringProcText {
    margin-top: 10px; /* Add some space above the text */
    padding: 10px; /* Add padding for better spacing */
    font-size: 16px; /* Make the font a bit larger */
    font-weight: bold; /* Make the text bold */
	}
	/* 채용공고 버튼 css  */
	#btnHirProcess,#btnHirInit {
	    background-color: #808080; /* Green background */
	    color: white; /* White text */
	    border: none; /* No border */
	    padding: 6px 10px; /* Padding for button */
	    text-align: center; /* Centered text */
	    text-decoration: none; /* No underline */
	    display: inline-block; /* Allow height and width to be set */
	    font-size: 16px; /* Font size */
	    margin: 4px 2px; /* Spacing around button */
	    transition-duration: 0.4s; /* Smooth transition */
	    cursor: pointer; /* Pointer cursor on hover */
	    border-radius: 5px; /* Rounded corners */
	}
	
	#btnHirProcess:hover {
	    background-color: white; /* Background color on hover */
	    color: black; /* Text color on hover */
	    border: 2px solid  #808080;; /* Border on hover */
	}
	.font_red	{color:#fe1414;}

        
</style>
<script type="text/javascript">
	$(function() {
		registerBtnEvent(); // 함수 호출을 추가해야 이벤트가 등록됩니다.
		$('input[name="expRequired"]').change(toggleExpYearsSelect);// '경력여부' '경력' 체크 select 활성화함수
		
		//채용절차 절차추가버튼을 눌렀을때 text를 html 화면에 보여줌
		  $('#btnHirProcess').click(function(event) {
		        event.preventDefault(); // 페이지 새로고침 방지

		        const hirProcessInput = $('#hirProcess').val(); // 입력 필드의 값 가져오기
		        const hiringProcText = $('#hiringProcText'); // 출력할 위치

		        const newProc = hirProcessInput.trim(); // 입력된 값에서 공백 제거
		        
		        if (!newProc) return; // 입력 값이 없으면 종료

		        // hiringProcText에 내용을 추가
		        if (hiringProcText.text()) {
		            hiringProcText.text(hiringProcText.text() + ' - ' + newProc); // 기존 내용 뒤에 추가
		        } else {
		            hiringProcText.text(newProc); // 처음 입력하는 경우
		        } 
		        //초기화
		        $('#hirProcess').val('');
		    });
		//채용절차 절차초기화버튼을 눌렀을때 text를 초기화
		  $("#btnHirInit").click(function(event) {
		        $("#hiringProcText").text(''); 
		    });
		
		
	});
	// 버튼을 클릭하면 동작하는 함수
	function registerBtnEvent() {
		$("a[name=btn]").click(function(e) {
			e.preventDefault(); // 앵커 태그 기본 동작 방지

			var btnId = $(this).attr("id"); // 클릭된 버튼의 ID 가져오기

			switch (btnId) {
			case "btnManagehireUpdate":
				managehireUpdate(); // 수정 함수 호출
				break;
			}
		});
	}
	

	
	// 유효성검사 함수
	function validateForm() {
		const expCheckboxes = document.querySelectorAll(".expCheckbox");
		const isExpChecked = Array.from(expCheckboxes).some(function(checkbox) {
			return checkbox.checked; // 전통적인 함수 표현 사용
		});

		if (!isExpChecked) {
			alert("경력 여부를 하나 이상 선택해주세요.");
			return false; // 유효성 검사 실패 시 false 반환
		}

		const startDate = document.getElementById("startDate").value; // jQuery 대신 기본 DOM 접근
		const endDate = document.getElementById("endDate").value;

		if (!startDate || !endDate) {
			alert("시작일과 종료일을 모두 입력해주세요.");
			return false;
		}

		if (new Date(startDate) > new Date(endDate)) {
			alert("종료일은 시작일 이후여야 합니다.");
			return false;
		}

		const hiringProcText = document.getElementById("hiringProcText").innerText
				.trim();

		if (!hiringProcText) {
			alert("채용 절차 내용을 입력해주세요.");
			return false;
		}

		// jQuery를 사용하여 각 입력 필드의 값을 검사
		if ($("#title").val().trim() === "") {
			swal("공고 제목을 입력해주세요.").then(function() {
				$("#title").focus(); // title로 포커스 변경
			});
			return false; // 유효성 실패 시 false 반환
		} else if ($("#salary").val().trim() === "") {
			swal("급여를 입력해주세요.").then(function() {
				$("#salary").focus();
			});
			return false;
		} else if (!/^\d+$/.test($("#salary").val().trim())) {
			alert("급여는 숫자만 입력 가능합니다.");
			this.value = ""; // 입력값 초기화
			this.focus(); // 입력 필드 포커스
			return false;
		} else if ($("#openings").val().trim() === "") {
			swal("모집 인원을 입력해주세요.").then(function() {
				$("#openings").focus();
			});
			return false;
		} else if (!/^\d+$/.test($("#openings").val().trim())) {
			alert("모집인원은 숫자만 입력 가능합니다.");
			this.value = ""; // 입력값 초기화
			this.focus(); // 입력 필드 포커스
			return false;
		} else if ($("#workLocation").val().trim() === "") {
			swal("근무 지역을 입력해주세요.").then(function() {
				$("#workLocation").focus();
			});
			return false;
		} else if ($("#reqQualifications").val().trim() === "") {
			swal("자격 조건을 입력해주세요.").then(function() {
				$("#reqQualifications").focus();
			});
			return false;
		}

		return true; // 모든 검사를 통과하면 true 반환
	}
	
	//업데이트 함수
	function managehireUpdate() {
		var getForm = document.getElementById("managehireUpdateForm");
		// 유효성검사
		if (!validateForm()) {
			return; // 유효성 검사 실패 시 함수 종료
		}

		// FormData 생성: 폼 내 모든 데이터를 자동으로 포함
		var fileData = new FormData(getForm);

		// 추가 또는 덮어쓰기 해야 하는 데이터 처리
		var StringDate = changeString();
		const
		hiringProcText = $("#hiringProcText").text();
		console.log("hiringProcText......." + hiringProcText);
		var fileName = $("#fileName").val();
		if (fileName == null || fileName == "") {
			console.log("fileName : " + fileName)
			fileData.set('fileName', "");
		}

		fileData.set('hirProcess', hiringProcText);
		fileData.set('expRequired', StringDate.expRequired);
		fileData.set('endDate', StringDate.endDate);
		// 콜백 함수 설정
		var callback = function(res) {
			console.log("result는 " + res.result);
			if (res.result === "success") {
				alert("공고가 수정되었습니다.");
				window.location.href = "/manage-hire/post.do";
			} else if (res.result === "fail") {
				alert("회사를 등록하고 공고를 등록해주세요.");
			} else if (res.result === "no") {
				alert("이미 공고를 등록했습니다.");
			}
		};

		// Ajax 요청
		callAjaxFileUpload("/manage-hire/managehireUpdate.do", "post", "json",
				false, fileData, callback);
	}

	////db에 저장하기위해 여러값이 있는것들을 string 한줄로 만들어주기 위한 함수
	function changeString() {

		//////날짜 //////////////////////////////
		// startDate와 endDate가 유효한지 확인
		let
		startDate = $("#startDate").val();
		let
		endDate = $("#endDate").val(); // 예시 종료 날짜

		// startDate와 endDate를 Date 객체로 변환
		let
		start = new Date(startDate);
		let
		end = new Date(endDate); // end 변수가 여기서 정의됨

		// 유효성 체크
		if (isNaN(start.getTime()) || isNaN(end.getTime())) {
			console.error("Invalid Date:", startDate, endDate);
			return; // 날짜가 유효하지 않으면 종료
		}

		// 년, 월, 일, 시 추출
		let
		startYear = start.getFullYear();
		let
		startMonth = String(start.getMonth() + 1).padStart(2, '0');
		let
		startDay = String(start.getDate()).padStart(2, '0');
		let
		startHours = String(start.getHours()).padStart(2, '0');

		let
		endYear = end.getFullYear();
		let
		endMonth = String(end.getMonth() + 1).padStart(2, '0');
		let
		endDay = String(end.getDate()).padStart(2, '0');
		let
		endHours = String(end.getHours()).padStart(2, '0');

		// 포맷팅된 날짜를 다시 저장
		startDate = startYear + "." + startMonth + "." + startDay + " "
				+ startHours;
		endDate = endYear + "." + endMonth + "." + endDay + " " + endHours;

		console.log("Formatted Start Date:", startDate);
		console.log("Formatted End Date:", endDate);
		//save 함수로 보냄
		endDate = startDate + " ~ " + endDate;

		//////////////////////////
		////경력여부////
		// 체크된 체크박스의 값을 배열로 가져옴
		const
		checkedValues = $('input[name="expRequired"]:checked').map(function() {
			return this.value; // 체크된 체크박스의 value 값을 가져옴
		}).get(); // jQuery 객체를 배열로 변환

		// 배열을 콤마(,)로 연결된 문자열로 변환 save 함수로 보냄
		const
		expRequired = checkedValues.join(', ');
		console.log("expRequired...." + expRequired);

		return {
			expRequired : expRequired,
			endDate : endDate
		}
	}

	// '경력여부'에서 '경력' 체크박스의 선택 여부를 확인	
	function toggleExpYearsSelect() {
		// '경력' 체크박스의 선택 여부를 확인
		const
		isChecked = $('input[name="expRequired"][value="경력"]').is(':checked');

		// '경력' 체크박스가 선택된 경우 select 활성화 
		$('#expYears').prop('disabled', !isChecked);
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
								class="btn_nav bold">채용관리</span> <span class="btn_nav bold">공고수정(채용관리자)
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>공고수정</span>
                  		</p>
						<form id="managehireUpdateForm" name="managehireUpdateForm" action="" method="post">
							<input type="hidden" name="postIdx" id="postingId" value="${detail.postIdx}">
							<div id="companyWriteSt" style="margin-top: 10px;">
                        <div id="writeTable">
                            <table class="col" id="jobTable">
							    <colgroup>
							        <col width="120px">
							        <col width="*">
							        <col width="120px">
							        <col width="*">
							    </colgroup>
							    <tr>
							        <th>채용제목<span class="font_red">*</span></th>
							        <td colspan="3"><input type="text" id="title" name="title" value="${detail.title }"></td>
							    </tr>
							    <tr>
							        <th>경력 여부<span class="font_red">*</span></th>
							        <td>
							       <label>
									    <input type="checkbox" name="expRequired" value="신입" class="expCheckbox"
									           <c:if test="${detail.expRequired.contains('신입')}">checked</c:if>> 신입
									</label>
									<label>
									    <input type="checkbox" name="expRequired" value="경력" class="expCheckbox"
									           <c:if test="${detail.expRequired.contains('경력')}">checked</c:if>> 경력
									</label>
									<label>
									    <input type="checkbox" name="expRequired" value="경력무관" class="expCheckbox"
									           <c:if test="${detail.expRequired.contains('경력무관')}">checked</c:if>> 경력무관
									</label>
							        <th>경력</th>
							        <td>
							        <select id="expYears" name="expYears">
									    <option value="1년이상" >1년이상</option>
									    <option value="2년이상" >2년이상</option>
									    <option value="3년이상" >3년이상</option>
									    <option value="4년이상" >4년이상</option>
									</select>
							        </td>
							    </tr>
							    <tr>
							        <th>급여<span class="font_red">*</span></th>
							        <td><input type="text" id="salary" name="salary" value="${detail.salary }"></td>
							        <th>모집인원<span class="font_red">*</span></th>
							        <td><input type="text" id="openings" name="openings" value="${detail.openings }"></td>
							    </tr>
							    <tr>
							        <th>근무지역<span class="font_red">*</span></th>
							        <td><input type="text" id="workLocation" name="workLocation" value="${detail.workLocation }"></td>
							        <th>포지션 설명<span class="font_red">*</span></th>
							        <td><input type="text" id="posDescription" name="posDescription" value="${detail.posDescription }"></td>
							    </tr>
							    <tr>
							        <th>채용기간<span class="font_red">*</span></th>
							        <td colspan="3">
							            시작 <input type="datetime-local" id="startDate" name="startDate" value="${startDate }">
							            ~ 종료 <input type="datetime-local" id="endDate" name="endDate" value="${endDate }">
							        </td>
							    </tr>
							    <tr>
							        <th>채용절차<span class="font_red">*</span></th>
							        <td colspan="3">
							            <input type="text" id="hirProcess" name="hirProcess" placeholder="과정을 하나씩 적은후 절차등록버튼을 눌러주세요">
							            <button type="button" id="btnHirProcess" class="btnType gray"><span>절차등록</span></button>
							            <button type="button" id="btnHirInit" class="btnType gray"><span>절차초기화</span></button>
							            <div id="hiringProcText" name="hiringProcText">${detail.hirProcess}</div>
							        </td>
							    </tr>
							    <tr>
							        <th>자격조건</th>
							        <td colspan="3"><textarea id="reqQualifications" name="reqQualifications">${detail.reqQualifications}</textarea></td>
							    </tr>
							    <tr>
							        <th>우대사항</th>
							        <td colspan="3"><textarea id="prefQualifications" name="prefQualifications">${detail.prefQualifications}</textarea></td>
							    </tr>
							    <tr>
							        <th>업무</th>
							        <td colspan="3"><textarea id="duties" name="duties">${detail.duties}</textarea></td>
							    </tr>
							    <tr>
							        <th>혜택 & 복지</th>
							        <td colspan="3"><textarea id="benefits" name="benefits">${detail.benefits}</textarea></td>
							    </tr>
							    <tr>
							        <th>첨부파일</th>
							        <td colspan="3"><input type="file" id="fileName" name="fileName"></td>
							    </tr>
							</table>
                            <div class="btn_areaC mt30">
                                 <a href="" class="btnType blue" id="btnManagehireUpdate" name="btn"><span>수정</span></a>
                                <a href="/manage-hire/managehireDetail.do/${postIdx}/${bizIdx}" class="btnType gray"><span>돌아가기</span></a>
                            </div>
                        </div>
						</div>
					</form>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>