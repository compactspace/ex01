<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>기업수정</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style>

#companyUpdatePreview {
    border: 1px dashed #ccc;
    padding: 10px;
    text-align: center;
    height: 100px; /* 미리보기 영역 높이 */
    line-height: 100px; /* 세로 중앙 정렬 */
    color: #aaa;
}
.font_red	{color:#fe1414;}
</style>
<script type="text/javascript">
    $(function() {
        registerBtnEvent(); // Register button events
        detailImgPreview(); // Initialize image preview
        
        $('#bizLogo').on('change', function() {
            const files = this.files;
            if (files.length > 0) {
                document.getElementById('currentFileName').textContent = '현재 파일: ' + files[0].name;
            }
        });
        
        
    });

    // Button click event function
    function registerBtnEvent() {
        $("a[name=btn]").click(function(e) {
            e.preventDefault(); // Prevent default anchor behavior
            var btnId = $(this).attr("id"); // Get clicked button's ID
            switch (btnId) {
                case "btnCompanyUpdate":
                    companyUpdate(); // Call update function
                   
                    break;
                case "btnCompanyDelete":
                    companyDelete(); // Call delete function
                   
                    break;
            }
        });
    }

 // 유효성검사 함수
	function validateForm() {

	    // 사업자 이름 검사
	    if ($("#bizName").val().trim() === "") {
	        swal("사업자 이름을 입력해주세요.").then(function() {
	            $("#bizName").focus();
	        });
	        return false;
	    }

	    // 사업자 대표 검사
	    else if ($("#bizCeoName").val().trim() === "") {
	        swal("사업자 대표를 입력해주세요.").then(function() {
	            $("#bizCeoName").focus();
	        });
	        return false;
	    }

	    // 주소 검사
	    else if ($("#bizAddr").val().trim() === "") {
	        swal("주소를 입력해주세요.").then(function() {
	            $("#bizAddr").focus();
	        });
	        return false;
	    }

	    // 설립일 검사
	    else if ($("#bizFoundDate").val().trim() === "") {
	        swal("설립일을 입력해주세요.").then(function() {
	            $("#bizFoundDate").focus();
	        });
	        return false;
	    } else {
	        // 설립일이 오늘보다 미래인 경우
	        var inputDate = new Date($("#bizFoundDate").val());
	        var today = new Date();
			console.log(inputDate +" 여긴 대나");
	        // 시간은 비교에서 제외하기 위해 00:00으로 설정
	        today.setHours(0, 0, 0, 0);

	        if (inputDate > today) {
	            swal("설립일은 오늘보다 이전이어야 합니다.").then(function() {
	                $("#bizFoundDate").focus();
	            });
	            return false;
	        }
	    }

	    // 홈페이지 URL 검사
	    if ($("#bizWebUrl").val().trim() === "") {
	        swal("홈페이지 주소를 입력해주세요.").then(function() {
	            $("#bizWebUrl").focus();
	        });
	        return false;
	    }

	    // 사원수 검사
	    else if ($("#bizEmpCount").val().trim() === "") {
	        swal("사원수를 입력해주세요.").then(function() {
	            $("#bizEmpCount").focus();
	        });
	        return false;
	    }

	    // 매출액 검사
	    else if ($("#bizRevenue").val().trim() === "") {
	        swal("매출액을 입력해주세요.").then(function() {
	            $("#bizRevenue").focus();
	        });
	        return false;
	    }

	    // 로고 검사
	    else if ($("#bizLogo").val().trim() === "") {
	        swal("로고를 등록해주세요.").then(function() {
	            $("#bizLogo").focus();
	        });
	        return false;
	    }

	    // 사업자 주소 형식 검사 (특수문자 제외)
	    const bizAddr = $("#bizAddr").val();
	    const addressPattern = /^[\w\s가-힣]+$/;
	    if (!addressPattern.test(bizAddr)) {
	        swal("주소는 특수 문자를 포함하지 않는 형식으로 입력해주세요.").then(function() {
	            $("#bizAddr").focus();
	        });
	        return false;
	    }

	    // 홈페이지 주소 형식 검사 (URL 형식 검증)
	    const bizWebUrl = $("#bizWebUrl").val();
	    const urlPattern = /^[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+([\/?%&=]*)?$/;
	    if (!urlPattern.test(bizWebUrl)) {
	        swal("홈페이지 주소는 올바른 URL 형식으로 입력해주세요.").then(function() {
	            $("#bizWebUrl").focus();
	        });
	        return false;
	    }

	    return true; // 모든 검사를 통과하면 true 반환
	}

    // Function to update the company details
    function companyUpdate() {
        var getForm = document.getElementById("companyUpdateForm");

        // Validation
        if (!validateForm()) {
            return; // Exit if validation fails
        }

        getForm.enctype = "multipart/form-data";
        var fileData = new FormData(getForm);

        var callback = function(res) {
            console.log("result는 " + res.result);
            if (res.result === "success") {
                alert("회사가 수정되었습니다.");
            } else {
                alert("수정 실패하였습니다.");
            }
        };

        callAjaxFileUpload("/company/companyUpdate.do", "post", "json", false,
            fileData, callback);
        window.location.href = "/mypage/update.do";
    }

    // Function to delete the company
    function companyDelete() {
    	 var getForm = document.getElementById("companyUpdateForm");
    	 getForm.enctype = "multipart/form-data"; 
    	 var fileData = new FormData(getForm);
        var callback = function(res) {
            if (res.result === "success") {
                alert("삭제되었습니다.");
                window.location.href = "/company/companyWritePage.do";
            } else {
                alert("삭제 실패하였습니다.");
            }
        };
        callAjaxFileUpload("/company/companyDelete.do", "post", "json", false, fileData, callback);
    	window.location.href = "/mypage/update.do";
    }
    

    // Image preview function
    function detailImgPreview() {
        $("#bizLogo").change(function(e) {
            e.preventDefault();
            var file = $(this)[0].files[0];
            if (file) {
                var fileInfo = $("#bizLogo").val();
                var fileInfoSplit = fileInfo.split(".");
                var fileLowerCase = fileInfoSplit[fileInfoSplit.length - 1].toLowerCase();
                var imgPath = ""; // Image path
                var previewHtml = ""; // HTML for preview

                if (fileLowerCase === "jpg" || fileLowerCase === "gif" || fileLowerCase === "png") {
                    imgPath = window.URL.createObjectURL(file);
                    previewHtml = "<img src='" + imgPath + "' id='imgFile' style='width:100px; height:100px'>";
                }
                $("#companyUpdatePreview").html(previewHtml);
                
            } 
        });
    }
    
    /** 휴대폰 번호 필터링 */
    function formatPhoneNumber() {
	    var bizContact = $("#bizContact");
	    console.log(bizContact + " 필터링중");
	    
	    // .val()을 사용하여 입력 필드의 값을 가져오기
	    var phoneNumber = bizContact.val().replace(/[^0-9]/g, "");
	    
	    // 처음 3자리가 허용된 번호인지 확인
	    if (phoneNumber.length >= 3) {
	        var prefix = phoneNumber.substring(0, 3);
	        if (["010", "019", "011", "016", "017"].indexOf(prefix) === -1) {
	            alert("정확한 전화번호를 입력해주세요.");
	            bizContact.val("").focus();
	            return; // 허용되지 않은 번호이면 함수를 종료
	        }
	    }
	    
	    // 휴대폰 번호 형식에 맞게 하이픈 추가
	    if (phoneNumber.length >= 3 && phoneNumber.length <= 7) {
	        phoneNumber = phoneNumber.replace(/(\d{3})(\d{1,4})/, "$1-$2");
	    } else if (phoneNumber.length >= 8) {
	        phoneNumber = phoneNumber.replace(/(\d{3})(\d{3,4})(\d{0,4})/, "$1-$2-$3");
	    }
	    
	    // 13자리까지만 입력받기 (한국 기준)
	    if (phoneNumber.length > 13) {
	        phoneNumber = phoneNumber.substring(0, 13);
	    }
	    
	    // 변경된 번호로 입력 필드 업데이트
	    bizContact.val(phoneNumber);
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
								class="btn_nav bold">회원정보수정</span> <span class="btn_nav bold">기업수정(채용관리자)
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>
					
						<p class="conTitle">
		                     <span>기업 수정및 삭제</span>
                  		</p>
						<form id="companyUpdateForm" name="companyUpdateForm" action="" method="post">
							<div id="companyUpdateSt" style="margin-top: 10px;">
                        <div id="writeTable">
                            <table class="col" style="width: 1000px; border: 1px solid;">
                                <colgroup>
                                    <col width="120px">
                                    <col width="*">
                                    <col width="120px">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">사업자명<span class="font_red">*</span></th>
                                        <td scope="col"><input type="text" class="inputTxt inputTable p100" name="bizName" id="bizName" value="${company.bizName}"/></td>
                                        <th scope="col">사업자 대표<span class="font_red">*</span></th>
                                        <td scope="col"><input type="text" class="inputTxt inputTable p100" name="bizCeoName" id="bizCeoName" value="${company.bizCeoName}"/></td>
                                    </tr>
                                    <tr>
                                        <th scope="col">연락처<span class="font_red">*</span></th>
                                        <td scope="col"><input type="text" class="inputTxt inputTable p100" name="bizContact" id="bizContact" placeholder="ex) 010-xxxx-xxxx" value="${company.bizContact}" oninput="javascript:formatPhoneNumber()"/></td>
                                        <th scope="col">사업자 주소<span class="font_red">*</span></th>
                                        <td scope="col"><input type="text" class="inputTxt inputTable p100" name="bizAddr" id="bizAddr" value="${company.bizAddr}"/></td>
                                    </tr>
                                    <tr>
                                        <th scope="col">사원수<span class="font_red">*</span></th>
                                        <td scope="col">
                                            <select id="bizEmpCount" name="bizEmpCount" class="inputTxt inputTable p100">
											    <option value="10명 이하" 
											        <c:if test="${company.bizEmpCount == '10명 이하'}">selected</c:if>>10명 이하</option>
											    <option value="50명 이하" 
											        <c:if test="${company.bizEmpCount == '50명 이하'}">selected</c:if>>50명 이하</option>
											    <option value="100명 이하" 
											        <c:if test="${company.bizEmpCount == '100명 이하'}">selected</c:if>>100명 이하</option>
											    <option value="1000명 이하" 
											        <c:if test="${company.bizEmpCount == '1000명 이하'}">selected</c:if>>1000명 이하</option>
											    <option value="1000명 이상" 
											        <c:if test="${company.bizEmpCount == '1000명 이상'}">selected</c:if>>1000명 이상</option>
											</select>
                                        </td>
                                        <th scope="col">홈페이지 주소<span class="font_red">*</span></th>
                                        <td scope="col"><input type="text" class="inputTxt inputTable p100" name="bizWebUrl" id="bizWebUrl" value="${company.bizWebUrl}"/></td>
                                    </tr>
                                    <tr>
                                        <th scope="col">설립일<span class="font_red">*</span></th>
                                        <td scope="col"><input type="date" class="inputTxt inputTable p100" name="bizFoundDate" id="bizFoundDate" value="${company.bizFoundDate}"/></td>
                                        <th scope="col">매출액<span class="font_red">*</span></th>
                                        <td scope="col">
                                          <select id="bizRevenue" name="bizRevenue" class="inputTxt inputTable p100">
										    <option value="10억 이하" 
										        <c:if test="${company.bizRevenue == '10억 이하'}">selected</c:if>>10억 이하</option>
										    <option value="100억 이하" 
										        <c:if test="${company.bizRevenue == '100억 이하'}">selected</c:if>>100억 이하</option>
										    <option value="1000억 이하" 
										        <c:if test="${company.bizRevenue == '1000억 이하'}">selected</c:if>>1000억 이하</option>
										    <option value="1000억 이상" 
										        <c:if test="${company.bizRevenue == '1000억 이상'}">selected</c:if>>1000억 이상</option>
										</select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">기업소개<span class="font_red">*</span></th>
                                        <td colspan="3"><textarea class="inputTxt p100" name="bizIntro" id="bizIntro" style="height: 200px;" placeholder="2000자 이내 입력해주세요">${company.bizIntro}</textarea></td>
                                    </tr>
                                    <tr>
                                        <th scope="col">기업로고<span class="font_red">*</span></th>
                                        <td colspan="3"><input type="file" class="inputTxt p100" name="bizLogo" id="bizLogo" /><span id="currentFileName">이전파일: ${company.bizLogo}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">미리보기</th>
                                        <td colspan="3">
                                            <div id="companyUpdatePreview">
                                            	<img src='${company.logicalPath}' id='imgFile' style='width:100px; height:100px'>
                                            </div>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                            <div class="btn_areaC mt30">
                                <a href="" class="btnType blue" id="btnCompanyUpdate" name="btn"><span>수정</span></a>
                                <a href="" class="btnType blue" id="btnCompanyDelete" name="btn"><span>삭제</span></a>
                                <a href="/mypage/update.do" class="btnType gray"><span>돌아가기</span></a>
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
