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
    <title>cuccRole</title>
    <link rel="shortcut icon" href="${basePath}/resources/img/otc_logo.jpg">
    <!-- Icons -->
    <link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
    <!-- Main styles for this application -->
    <link href="${basePath}/resources/css/style.css" rel="stylesheet">
    <link href="${basePath}/resources/css/public.css" rel="stylesheet">
    <link href="${basePath}/resources/css/zTreeStyle.css" rel="stylesheet">
    <style>
        .goods_but {
            position: relative;
        }
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
    <!-- Main content -->
    <main class="main">
        <!-- Breadcrumb -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item">首页</li>
            <li class="breadcrumb-item">
                <a href="${basePath}/role/roleList.htm">角色管理</a>
            </li>
            <li class="breadcrumb-item active">权限分配</li>
            <!-- Breadcrumb Menu-->

        </ol>
        <!---- cucc container start-->
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <strong style="font-size:17px;font-weight:700;vertical-align: -1px;margin-right:5px">☰</strong>分配权限
                </div>
                <div class="card-block">
                    <form id="mainForm" action="${basePath}/permission/rolePermissionEdit.htm" role="form" name="myForm" method="post" class="form-horizontal" >
                        <!--<input type="hidden" name="treesJson" id="treesJson" value="$!treesJson">-->
                        <input type="hidden" name="permissionIds" id="permissionIds">
                        <input type="hidden" name="roleId" id="roleId" value="${roleId}">
                        <div class="form-group row treesauto">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                    </form>
                 </div>
                <div class="card-footer">
                    <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="saveRolePermission()"><i class="fa fa-dot-circle-o"></i> 确认
                    </button>
                    <!--<button type="reset" class="btn btn-sm btn-danger"><i class="fa fa-ban"></i> 重置</button>-->
                </div>
             </div>
        </div>
<!---- cucc container start-->
<!-- /.conainer-fluid -->
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
<!--下拉复选菜单-->
<script src="${basePath}/resources/js/jquery.ztree.core.js"></script>
<script src="${basePath}/resources/js/jquery.ztree.excheck.js"></script>
<script>
    var zNodes = ${treesJson};
    //    树形菜单
    var setting = {
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true,
                pIdKey:'parentId'
            }
        },
        treeNode:{
            open : false
        }
    };
    $(document).ready(function(){
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    });

    function saveRolePermission() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            node = zTree.getCheckedNodes(true),//获取选中
            idArr = [],//选中ID list
            id;//id拼接的字符串
        for(var i=0;i<node.length;i++){
            idArr.push(node[i].id); //获取每个节点的id
        }
        id = idArr.join(',');
        $("#permissionIds").val(id);
        $("#mainForm").submit();
    }
</script>

</body>
</html>