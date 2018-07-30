<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/views/common/taglibs.jsp" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keyword" content="">
    <title>OECHSLER</title>
    <link rel="shortcut icon" href="${basePath}/resources/img/otc_logo.jpg">
    <!-- Icons -->
    <link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
    <!-- Main styles for this application -->
    <link href="${basePath}/resources/css/style.css" rel="stylesheet">
    <link href="${basePath}/resources/css/public.css" rel="stylesheet">

    <style>
        .goods_icon {
            position: absolute;
            top: 10px;
            left: 0px;
            color: red;
        }
    </style>
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<c:import url="/index/head.htm"/>

<div class="app-body">
    <c:import url="/index/leftNav.htm"/>
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">首页</li>
            <li class="breadcrumb-item">
                <a href="${basePath}/role/roleList.htm">角色管理</a>
            </li>
            <li class="breadcrumb-item active">角色添加</li>
        </ol>
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <strong style="font-size:17px;font-weight:700;vertical-align: -1px;margin-right:5px">☰</strong>角色添加
                </div>
                <div class="card-block">
                    <form id="mainForm" method="post" class="form-horizontal" action="${basePath}/role/addRole.htm">
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="name">角色名称</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="name" name="name" class="form-control" maxlength="50">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="saveRole()"><i
                            class="fa fa-dot-circle-o"></i> 确认
                    </button>
                    <button type="reset" class="btn btn-sm btn-danger"><i class="fa fa-ban"></i> 重置</button>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Bootstrap and necessary plugins -->
<script src="${basePath}/resources/assets/js/libs/jquery.min.js"></script>
<script src="${basePath}/resources/assets/js/libs/tether.min.js"></script>
<script src="${basePath}/resources/assets/js/libs/bootstrap.min.js"></script>
<script src="${basePath}/resources/assets/js/libs/pace.min.js"></script>
<!-- Plugins and scripts required by all views -->
<script src="${basePath}/resources/assets/js/libs/Chart.min.js"></script>

<!-- GenesisUI main scripts -->
<script src="${basePath}/resources/js/app.js"></script>
<!-- Plugins and scripts required by this views -->
<!-- Custom scripts required by this view -->
<script src="${basePath}/resources/js/date/laydate.js"></script><!--日期插件-->
<script src="${basePath}/resources/js/views/main.js"></script>
<script src="${basePath}/resources/js/views/reset.js"></script><!--form重置-->
<script src="${basePath}/resources/js/dialog2.js"></script>
<script src="${basePath}/resources/js/alert.js"></script>
<script>
    function saveRole() {
        if (check()) {
            $.ajax({
                url:'${basePath}/role/checkRoleInfo.htm',
                type:'post',
                data:{"name":$("#name").val()},
                dataType:'json',
                success:function(data){
                    if(data){
                        $("#mainForm").submit();
                    }else{
                        alertTip("该角色已经存在");
                    }
                }
            })
        }
    }

    function check() {
        var name = $("#name").val();
        if (name == "") {
            alertTip("请输入角色名称");
            return false;
        }
        return true;
    }

</script>
</body>
</html>