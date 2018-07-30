<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/views/common/taglibs.jsp" %>
<header class="app-header navbar">
    <button class="navbar-toggler mobile-sidebar-toggler hidden-lg-up" type="button">☰</button>
    <a class="navbar-brand" href="${basePath}/index/index.htm"></a>
    <ul class="nav navbar-nav hidden-md-down">
        <li class="nav-item">
            <a class="nav-link navbar-toggler sidebar-toggler" href="#">☰</a>
        </li>
    </ul>
    <ul class="nav navbar-nav ml-auto" style="margin-right: 30px">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                <c:set var="headImage" value="${basePath}/resources/img/u18523.png"/>
                <c:if test="${user.headPortrait ne null && user.headPortrait ne ''}">
                    <c:set var="headImage" value="${user.headPortrait}"/>
                </c:if>
                <img src="${headImage}" class="img-avatar">
                <span class="hidden-md-down">${user.userName}</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <!--<a target="_blank" href="http://sighttp.qq.com/authd?IDKEY=14038b6e7f88dad63ee5e02f9939de32c745037269dea201"><img border="0"  src="http://wpa.qq.com/imgd?IDKEY=14038b6e7f88dad63ee5e02f9939de32c745037269dea201&pic=51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>-->
                <a class="dropdown-item" href="${basePath}/login/logout.htm"><i class="fa fa-lock"></i>退出</a>
                <a class="dropdown-item" href="${basePath}/index/personalInfo.htm"><i class="fa fa-user"></i>个人资料</a>
                <a class="dropdown-item" href="${basePath}/index/editPassword.htm"><i class="fa fa-wrench"></i>修改密码</a>
            </div>
        </li>
    </ul>
</header>

<script>
    var head = document.getElementsByTagName('head')[0],
        cssURL = '${basePath}/resources/images/titleimg.png',
        linkTag = document.createElement('link');
    linkTag.href = cssURL;
    linkTag.setAttribute('rel','shortcut icon');
    head.appendChild(linkTag);
</script>