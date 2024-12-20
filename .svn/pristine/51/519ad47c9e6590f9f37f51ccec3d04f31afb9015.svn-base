<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${empty result}">
	<div class="contents">
		<p class="res-comment">경력사항을 추가할 수 있습니다.</p>
	</div>
</c:if>

<c:if test="${not empty result}">
	<div class="contents">
		<table class="col">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>기간</th>
					<th>회사명</th>
					<th>부서명</th>
					<th>직급/직책</th>
					<th>퇴사사유</th>
					<th>삭제</th>
				</tr>
			</thead>
			<c:forEach var="data" items="${result}">
			<tr>
				<td rowspan="2"><span>
					<fmt:formatDate value="${data.startDate}" pattern="yyyy.MM" />
					 ~ 
					 <fmt:formatDate value="${data.endDate}" pattern="yyyy.MM" />
				</span></td>
				<td><span>${data.company}</span></td>
				<td><span>${data.dept}</span></td>
				<td><span>${data.position}</span></td>
				<td><span>${data.reason}</span></td>
				<td rowspan="2"><button class="deleteBtn" id="career" data-num="${data.crrIdx}" onclick="deleteCareer(${data.crrIdx})">
						<svg xmlns="http://www.w3.org/2000/svg" height="20px"
							viewBox="0 -960 960 960" width="20px" fill="#5f6368">
																	<path
								d="M312-144q-29.7 0-50.85-21.15Q240-186.3 240-216v-480h-48v-72h192v-48h192v48h192v72h-48v479.57Q720-186 698.85-165T648-144H312Zm336-552H312v480h336v-480ZM384-288h72v-336h-72v336Zm120 0h72v-336h-72v336ZM312-696v480-480Z" /></svg>
					</button></td>
			</tr>
			<tr>
				<td colspan="4" style="white-space: pre-wrap; text-align: left">${data.crrDesc}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</c:if>