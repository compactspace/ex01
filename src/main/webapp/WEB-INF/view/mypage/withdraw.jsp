<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>회원탈퇴</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	

/* 비밀번호 확인모달 */
function pwConfirmModal(){
	$("#passwd").val("");
	gfModalPop("#pwConfirmModal");
}

/* 최종탈퇴 */
function compleWithdraw(){
	
	var param = { password: $("#passwd").val() }
	var pwvalidate = $("#passwd").val();
	
	if(pwvalidate.length < 1){
		swal("비밀번호를 입력하세요.").then(function(){
			$('#passwd').focus();
		})} else {
			var callback = function(res){
				if(res.result === "success") {
					alert("탈퇴되었습니다.\n그동안 서비스를 이용해주셔서 감사합니다.");
					fLogOut();		
					} else { 
						swal("비밀번호가 일치하지 않습니다.");
					}
				}
			callAjax("/mypage/deleteUser.do", "post", "json", true, param, callback);
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
							<a href="/WEB-INF/view/mypage/mypage.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">마이페이지</span> <span class="btn_nav bold">회원탈퇴
								</span> <a href="/mypage/withdraw.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>회원탈퇴</span> <span class="fr">
		                 
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							사용하고 계신 아이디(세션ID)를 탈퇴할 경우 재사용 및 복구가 불가능합니다.<br>
							탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.<br>
							안내 사항을 모두 확인하였으며, 이에 동의합니다.<br>
							<a class="btnType blue" href="javascript:pwConfirmModal();" ><span>확인</span></a>
						</div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 비밀번호 입력모달 -->
	<div id="pwConfirmModal" class="layerPop layerType2" style="width: 500px;">
		<dl>
			<dt>
				<strong>비밀번호 확인</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
									<td colspan=3><input type="password" class="inputTxt p100" name="passwd" id="passwd" /></td>
							</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="javascript:compleWithdraw();" class="btnType blue" ><span>수정</span></a> 
					<a href="" class="btnType gray" ><span>취소</span></a>
				</div>
				</dl>
		</div>
	 
	
	
</body>
</html>