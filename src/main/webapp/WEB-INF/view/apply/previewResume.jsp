<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div style="font-family: pretendard; color: #333; padding: 20px;">
	<div style="margin-bottom: 20px;">
		<p style="white-space: pre-line; font-size: 25px; font-weight: 900;">${resumeInfo.resTitle}</p>
	</div>
	<div style="margin-bottom: 5px;">
		<p style="white-space: pre-line; font-size: 15px; font-weight: 500;">
			이름 : ${resumeInfo.userNm}</p>
	</div>
	<div style="margin-bottom: 5px;">
		<p style="white-space: pre-line; font-size: 15px; font-weight: 500;">
			이메일 : ${resumeInfo.email}</p>
	</div>
	<div style="margin-bottom: 10px;">
		<p style="white-space: pre-line; font-size: 15px; font-weight: 500;">
			연락처 : ${resumeInfo.phone}</p>
	</div>

	<div
		style="margin-top: 20px; padding: 15px; border-top: 1px solid #ccc;">
		<c:if test="${not empty resumeInfo.shortIntro}">
			<div>
				<p style="white-space: pre-line;">${resumeInfo.shortIntro}</p>
			</div>
		</c:if>
		<c:if test="${not empty resumeInfo.proLink}">
			<div style="">
				<p style="white-space: pre-line;">
					링크 : <a style="color: #36f;" href="${resumeInfo.proLink}">${resumeInfo.proLink}</a>
				</p>
			</div>
		</c:if>
		<c:if test="${not empty resumeInfo.fileName}">
			<div>
				<p style="white-space: pre-line;">
					첨부파일 : <a style="color: #36f;"
						href="attachment-download?resumeNum=${resumeInfo.resIdx}">${resumeInfo.fileName}</a>
				</p>
			</div>
		</c:if>
	</div>

	<c:if test="${not empty careerInfo}">
		<div style="padding: 15px;">
			<div
				style="font-size: 1.2em; font-weight: bold; color: #333; padding: 10px; border-top: 1px solid #000; border-bottom: 1px solid #ccc;">
				경력</div>
			<div>
				<ul style="list-style: none; padding: 0;">
					<c:forEach var="data" items="${careerInfo}">
						<li
							style="padding: 15px; border-bottom: 1px solid #f1f1f1; display: flex;">
							<div style="width: 20%; text-align: left; font-weight: 900">
								<span> <fmt:formatDate value="${data.startDate}"
										pattern="yyyy.MM" /> ~ <fmt:formatDate
										value="${data.endDate}" pattern="yyyy.MM" />
								</span>
							</div>
							<div style="width: 80%; padding-left: 10px;">
								<span style="font-weight: 900; font-size: 15px;">${data.company}</span><span
									style="font-weight: 900;"> &nbsp;&nbsp; | ${data.dept} |
									${data.position}</span>
								<p
									style="margin-top: 20px; margin-left: 20px; white-space: pre-line;">${data.crrDesc}</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>

	<c:if test="${not empty eduInfo}">
		<div style="margin-top: 20px; padding: 15px;">
			<div
				style="font-size: 1.2em; font-weight: bold; color: #333; padding: 10px; border-top: 1px solid #000; border-bottom: 1px solid #ccc;">
				학력</div>
			<div>
				<ul style="list-style: none; padding: 0;">
					<c:forEach var="data" items="${eduInfo}">
						<li style="padding: 15px; display: flex;">
							<div style="width: 20%; text-align: left; font-weight: 900">
								<span>${data.grdStatus}</span>
							</div>
							<div style="width: 60%; padding-left: 10px;">
								<span style="font-weight: 900; font-size: 15px;">${data.schoolName}</span>
								<c:if test="${not empty data.major}">
									<span style="font-weight: 900;"> &nbsp;&nbsp; |
										&nbsp;&nbsp;${data.major} </span>
								</c:if>
							</div>
							<div style="width: 20%; padding-left: 10px;">
								<span style="font-weight: 900;"> <span> <fmt:formatDate
											value="${data.admDate}" pattern="yyyy.MM" /> ~ <fmt:formatDate
											value="${data.grdDate}" pattern="yyyy.MM" />
								</span>
								</span>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>

	<c:if test="${not empty skillInfo}">
		<div style="margin-top: 20px; padding: 15px;">
			<div
				style="font-size: 1.2em; font-weight: bold; color: #333; padding: 10px; border-top: 1px solid #000; border-bottom: 1px solid #ccc;">
				스킬</div>
			<ul style="list-style: none; padding: 0;">
				<c:forEach var="data" items="${skillInfo}">
					<li
						style="padding: 15px; border-bottom: 1px solid #f1f1f1; display: flex;">
						<div style="width: 20%; text-align: left; font-weight: 900">
							<span> ${data.skillName} </span>
						</div>
						<div style="width: 80%; padding-left: 10px;">
							<p style="white-space: pre-line;">${data.skillDetail}</p>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>

	<c:if test="${not empty certInfo}">
		<div style="margin-top: 20px; padding: 15px;">
			<div
				style="font-size: 1.2em; font-weight: bold; color: #333; padding: 10px; border-top: 1px solid #000; border-bottom: 1px solid #ccc;">
				자격증 및 외국어</div>
			<c:forEach var="data" items="${certInfo}">
				<li
					style="padding: 15px; display: flex;">
					<div style="width: 20%; text-align: left; font-weight: 900">
						<span><fmt:formatDate value="${data.acqDate}"
								pattern="yyyy.MM" /></span>
					</div>
					<div style="width: 60%; padding-left: 10px;">
						<span style="font-weight: 900; font-size: 15px;">${data.certName}</span>
						<span style="font-weight: 900; font-size: 15px;">&nbsp;&nbsp;&nbsp;${data.grade}</span>
						<span style="font-weight: 900;">&nbsp;&nbsp;&nbsp;${data.issuer}</span>
					</div>
					<div style="width: 20%; padding-left: 10px;">
						<span style="font-weight: 900;"> <span> <fmt:formatDate
									value="${data.acqDate}" pattern="yyyy.MM" /></span>
					</div>
				</li>
			</c:forEach>
		</div>
	</c:if>

	<c:if test="${not empty resumeInfo.perStatement}">
		<div style="margin-top: 20px; padding: 15px;">
			<div
				style="font-size: 1.2em; font-weight: bold; color: #333; padding: 10px; border-top: 1px solid #000; border-bottom: 1px solid #ccc;">
				자기소개서</div>
			<div style="border-bottom: 1px solid #ccc;">
				<p style="padding: 20px; white-space: pre-line;">${resumeInfo.perStatement}</p>
			</div>
		</div>
	</c:if>
</div>
