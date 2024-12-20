<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	
		<c:if test="${scrapCnt eq 0 }">
    <tr>
        <td colspan="4">데이터가 존재하지 않습니다.</td>
    </tr>
</c:if>

<c:if test="${scrapCnt > 0 }">
    <c:forEach items="${scrapList}" var="list">
        <input type="hidden" id="scrapIdx" name="scrapIdx" class="scrapIdx" value="${list.scrapIdx}" />
        <input type="hidden" id="loginIdx" name="loginIdx" class="loginIdx" value="${loginId}" />
        <input type="hidden" id="postIdx" name="postIdx" class="postIdx" value="${list.postIdx}" />
        <input type="hidden" id="bizIdx" name="bizIdx" class="bizIdx" value="${list.postBizIdx}" />

        <tr>
            <td><input type="radio" name="scrapSelect" value="${list.scrapIdx}" /></td>
            
            <c:choose>
                <c:when test="${list.postIdx != null && list.postIdx != ''}">
                    <c:choose>
                        <c:when test="${list.postStatus == '승인'}">
                            <td>${list.postBizName}</td>
                            <td>
                                <a href="/manage-post/${list.postIdx}/${list.postBizIdx}">
                                    ${list.postTitle}
                                </a>
                            </td>
                            <td>${list.postExpRequired}</td>
                            <td>${list.postWorkLocation}</td>
                            <td>${list.postEndDate}</td>
                            <td><button type="button" class="btn btn-warning" onclick="applyDetailModal(${list.postIdx}, ${list.postBizIdx})">입사지원</button></td>
                        </c:when>
                        <c:otherwise>
                            <td colspan="6"><span>재승인이 필요한 공고입니다</span></td>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <td colspan="6"><span>삭제된 공고입니다</span></td>
                </c:otherwise>
            </c:choose>
        </tr>
        
        <c:set var="nRow" value="${nRow + 1}" /> 
    </c:forEach>
</c:if>

<input type="hidden" id="totcnt" name="totcnt" value="${scrapCnt}" />
