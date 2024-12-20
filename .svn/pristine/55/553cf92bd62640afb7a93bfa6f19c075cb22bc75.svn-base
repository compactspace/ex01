<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<!-- 갯수가 0인 경우  -->
		<c:if test="${qnaCnt eq 0}">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${qnaCnt > 0}">
			<c:forEach items="${qna}" var="list" varStatus="num">
				<tr>
					    <td>${num.index + 1}</td>
						<td><a href="javascript:qnaDetailFileModal(${list.qnaIdx})">${list.title}</a>   <c:if test="${not empty list.ans_content}"><a href="#" class="btnTypeSmall" id="answerComplete" style="color:white; pointer-events: none;"><span>답변 완료</span></a></c:if></td>
						<td>${list.author}</td>
						<td>${list.createdDate.substring(0, 10)}</td>
				</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totcnt" name="totcnt" value="${qnaCnt}"/>

