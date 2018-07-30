<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="sidebar">
    <nav class="sidebar-nav">
        <ul class="nav">
            <c:forEach items="${permissionList}" var="permission">
                <c:choose>
                    <c:when test="${permission.name eq '首页'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${basePath}${permission.pUrl}">
                                <i class="icon-speedometer"></i> ${permission.name}
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item nav-dropdown ">
                            <a class="nav-link nav-dropdown-toggle" href="#"><i class="${permission.pIcon}"></i> ${permission.name}</a>
                            <ul class="nav-dropdown-items">
                                <c:forEach items="${permission.childList}" var="child">
                                    <li class="nav-item">
                                        <a class="nav-link nav_pad" href="${basePath}${basePath}${child.pUrl}">
                                            ${child.name}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </nav>
</div>