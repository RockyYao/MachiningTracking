<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html class="not-ie" lang="en">
<!--<![endif]-->
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Qiu Le Qi">
    <title>OECHSLER</title>
    <link rel="${basePath}/resources/img/otc_logo.jpg">
    <%@include file="/tiles/styles.jsp" %>
</head>
<body>
<header class="bs-docs-nav hidden-xs" role="banner">
    <div class="container">
        <div class="navbar-header">
        </div>
    </div>
</header>
<h3 class="visible-xs text-center">OECHSLER<BR>订单追踪系统</h3>
<div class="container" style="padding-top: 20px;">
    <div class="col-xs-12 col-md-8 row hidden-xs">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div id="myCarousel" class="carousel slide" style="margin-bottom:10px;">
                <div class="carousel-inner">
                    <div class="active item center"><img src="${basePath}/res/img/pic1.png"></div>
                </div>
            </div>
        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="col-xs-12 col-md-4">
        <div id="errorMsg">
            <%
                String error = request.getParameter("error");
                if ("true".equals(error)) {
            %>
            <div class="alert alert-danger">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <strong>登录失败!</strong> 用户名或者密码输入有误，请重新输入。
            </div>
            <%}%>
        </div>
        <div class="panel panel-default center-text">
            <div class="panel-heading">
                <h3 class="panel-title">登录/Login</h3>
            </div>
            <div class="panel-body">
                <form id="loginForm" class="form-signin" action="${basePath}/login/doLogin.htm"
                      method="post">
                    <div class="form-group">
                        <label>账号/ID</label>
                        <input type="text" name="userName" class="form-control" placeholder="用户名" autofocus="">
                    </div>
                    <div class="form-group">
                        <label>密码/Password</label>
                        <input type="password" name="password" class="form-control" placeholder="密码" onkeypress="return pressKey()">
                    </div>
                    <%--<div class="checkbox">--%>
                    <%--<label>--%>
                    <%--<input name="rememberMe" type="checkbox" value="true"/>一周内自动登录--%>
                    <%--</label>--%>
                    <%--</div>--%>
                    <button id="btn_login" class="btn btn btn-primary" style="width: 100%" type="button" onclick="submitLogin()">登录/Login
                    </button>

                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/tiles/footer.jsp" %>
</body>
</html>
<%@include file="/tiles/scripts.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
        $('#loginForm').validate();
        /*$('#loginForm').ajaxForm(function(data){
         if(!data.status){
         $.pnotify({
         title: '登录失败',
         text: data.error,
         type: 'error',
         history: false
         });
         }
         });*/
    });

    function submitLogin() {
        $('.alert').val('');
        $('#loginForm').submit();
    };

   /* 回车登录*/
    function pressKey(){

        if((event.keyCode == 13)){
            submitLogin();
        }

    }
</script>