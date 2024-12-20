<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 공고가 없는 경우 -->
<c:if test="${empty MList}">
	<tr class="row-separator">
		<td colspan="5">공고가 없습니다.</td>
	</tr>
</c:if>
<!-- 공고가 있는 경우 -->
<c:if test="${not empty MList}">
	<c:forEach var="list" items="${MList}">
		<tr>
			<td >
				<a href="managehireDetail.do/${list.postIdx}/${list.bizIdx}">${list.title}</a>
			</td>
			<td>
				${list.expRequired} 
			</td>
			<td>
				${list.postDate}
			</td>
			<td>
				${list.endDate}
			</td>
			<td>
            	${list.appStatus} 
        	</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totcnt" name="totcnt" value="${MCount}" />
<input type="hidden" id="postIdx" name="postIdx" value="${list.postIdx}">
<input type="hidden" id="bizIdx" name="bizIdx" value="${list.bizIdx}">