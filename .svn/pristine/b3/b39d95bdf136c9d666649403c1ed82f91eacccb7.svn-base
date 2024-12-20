<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<tr>
	<th colspan="3" class="header" style="text-align: left;">지원자 <span>${count}</span>
		명
	</th>
</tr>
<!-- 서류심사과정  -->
<!-- 지원자가 없는 경우 -->
<c:if test="${empty list}">
	<tr class="row-separator">
		<td>지원자가 없습니다.</td>
	</tr>
</c:if>
<!-- 지원자가 있는 경우 -->
<c:if test="${not empty list}">
	<c:forEach var="list" items="${list}">
		<tr class="row-separator">
			<!-- 구분선 클래스 추가 -->
			<td rowspan="4">
				<span class="highlight">${list.name}</span><br>
				<span class="resTitle">${list.resTitle}</span><br> 
				<span>${list.applyDate.substring(0, 10)}</span>
			</td>
			<!-- 회사가 없을경우 테이블 배치 달라짐 -->
			<c:if test="${!empty list.company}">
			<td><span class="highlight">학력: </span>
				${list.schoolName}
				(${list.grdStatus})
			</td>
			</c:if>
			<c:if test="${empty list.company}">
			<td rowspan="2" style="vertical-align: middle;"><span class="highlight">학력: </span>
				${list.schoolName}
				(${list.grdStatus})
			</td>
			</c:if>
			<td rowspan="2"><a href="#" class="btn btn-primary res" data-resIdx="${list.resIdx}" data-user-id="${list.loginId}">지원자 이력서
					보기</a></td>
		</tr>
		<tr>
				<c:if test="${!empty list.company}">
			<td>
					 <span class="highlight">경력:</span>${list.company}
			</td>
				</c:if>
		</tr>
		<tr>
			<td> <span class="highlight">전화번호:</span>${list.phone}</td>
			<td rowspan="2">
			<c:if test="${list.viewed == 1 && list.status == '서류심사중' || list.status == '면접진행중'}">
			    <button id="btnPass" class="btn btn-resume" data-user-id="${list.loginId}" data-current-status="${list.status}">합격</button>
			    <button id="btnFail" class="btn btn-danger" data-user-id="${list.loginId}" data-current-status="${list.status}">불합격</button>
			</c:if>
			
			<c:if test="${list.viewed == 1 && list.status == '서류탈락' || list.status == '면접탈락'}">
			    <button id="btnPass" class="btn btn-resume" data-user-id="${list.loginId}" data-current-status="${list.status}">추가합격</button>
			</c:if>
			
			<c:if test="${list.viewed == 0 || list.status == '최종합격'}">
			</c:if>	
			</td>
		</tr>
		<tr>
			<td> <span class="highlight">이메일:</span>${list.email}</td>
			
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totcnt" name="totcnt" value="${count}" />
<input type="hidden" id="postIdx" name="postIdx" value="${postIdx}" />
<input type="hidden" id="hiringProcSerch" name="hiringProcSerch"
	value="${hiringProcSerch}" />
