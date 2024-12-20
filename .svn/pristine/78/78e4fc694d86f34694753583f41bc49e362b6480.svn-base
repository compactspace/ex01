<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<!-- 갯수가 0인 경우  -->
					<c:if test="${faqCnt eq 0 }">
						<tr>
							<c:if test="${userType ne 'M'}">
								<td colspan="4">데이터가 존재하지 않습니다.</td>
							</c:if>
							<c:if test="${userType eq 'M'}">
								<td colspan="5">데이터가 존재하지 않습니다.</td>
							</c:if>
						</tr>
					</c:if>
				<!-- 갯수가 있는 경우  -->
					<c:if test="${faqCnt > 0 }">
						<c:forEach items="${faq}" var="list" varStatus="num">
							<tr>
					    		<td>${num.index + 1}</td>
								<td><a href="javascript:showContent(${list.faq_idx});">${list.title}</a></td>
								<td>${list.author}</td>
								<td>${list.created_date.substring(0, 10)}</td>
								<c:if test="${userType eq 'M'}">
									<td><a href="javascript:faqDetailModal(${list.faq_idx})" class="btnType gray"><span>관리</span></a></td>
					    		</c:if>
							</tr>
							<tr>
								<c:if test="${userType ne 'M'}">
					    			<td colspan="4" id="faqcontent_${list.faq_idx}" style="display:none; height: 5em; max-height: 25em;">${list.content}</td>
					    		</c:if>
								<c:if test="${userType eq 'M'}">
					    			<td colspan="5" id="faqcontent_${list.faq_idx}" style="display:none; height: 5em; max-height: 25em;">${list.content}</td>
					    		</c:if>
							</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
					</c:forEach>
				</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->
        <input type="hidden" id="totcnt" name="totcnt" value="${faqCnt}"/>