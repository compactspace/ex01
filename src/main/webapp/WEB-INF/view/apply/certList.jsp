<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${empty result}">
	<div class="contents">
		<p class="res-comment">취득한 자격증을 추가할 수 있습니다.</p>
	</div>
</c:if>

<c:if test="${not empty result}">
	<div class="contents">
		<table class="col">
			<colgroup>
				<col width="30%">
				<col width="20%">
				<col width="20%">
				<col width="20%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>자격증명</th>
					<th>등급</th>
					<th>발행처</th>
					<th>취득일자</th>
					<th>삭제</th>
				</tr>
			</thead>
			<c:forEach var="data" items="${result}">
				<tr>
					<td><span>${data.certName}</span></td>
					<td><span>${data.grade}</span></td>
					<td><span>${data.issuer}</span></td>
					<td><span>
						<fmt:formatDate value="${data.acqDate}" pattern="yyyy.MM" />
					</span></td>
					<td><button class="deleteBtn" id="certification" data-num="${data.certIdx}" onclick="deleteCert(${data.certIdx})">
							<svg xmlns="http://www.w3.org/2000/svg" height="20px"
								viewBox="0 -960 960 960" width="20px" fill="#5f6368">
																	<path
									d="M312-144q-29.7 0-50.85-21.15Q240-186.3 240-216v-480h-48v-72h192v-48h192v48h192v72h-48v479.57Q720-186 698.85-165T648-144H312Zm336-552H312v480h336v-480ZM384-288h72v-336h-72v336Zm120 0h72v-336h-72v336ZM312-696v480-480Z" /></svg>
						</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</c:if>