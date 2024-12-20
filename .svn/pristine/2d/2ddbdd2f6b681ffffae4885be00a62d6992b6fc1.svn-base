<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:choose>

    <c:when test="${fn:contains(url, '/manage-post/approval.do')}">
        <c:choose>
            <c:when test="${pendingPostCnt > 0}">
                <c:forEach items="${pendingList}" var="list">
                    <tr>
                      
                        <td>${list.postIdx}</td>
                       
                        <td style="display: none"><a>${list.bizIdx}</a></td>
       
                        <td>
                            <a href="/manage-post/${list.postIdx}/${list.bizIdx}">
                                ${list.title}
                            </a>
                        </td>
                        <td>${list.workLocation}</td>
                        <td>${list.expRequired}</td>
                        <td>${list.endDate}</td>
                        <td>${list.postDate}</td>
                         <c:if test="${userType eq 'M'}">
                        <td>${list.appStatus}</td> 
                        </c:if>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="8">데이터가 존재하지 않습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:otherwise>
        <c:choose>
            <c:when test="${approvalPostCnt > 0}">
                <c:forEach items="${approvalList}" var="list">
                    <tr>
                        <td>${list.postIdx}</td>
                        <td style="display: none"><a>${list.bizIdx}</a></td>
                  
                        <td>
                            <a href="/manage-post/${list.postIdx}/${list.bizIdx}">
                                ${list.title}
                            </a>
                        </td>
                        <td>${list.workLocation}</td>
                        <td>${list.expRequired}</td>
                        <td>${list.endDate}</td>
                        <td>${list.postDate}</td>
                         <c:if test="${userType eq 'M'}">
                        <td>${list.appStatus}</td> 
                        </c:if>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="8">데이터가 존재하지 않습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

<input type="hidden" id="totcnt" name="totcnt" 
       value="${fn:contains(url, '/manage-post/approval.do') ? pendingPostCnt : approvalPostCnt}" />
      
       
