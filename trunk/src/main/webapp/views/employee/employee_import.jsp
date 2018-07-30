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
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<c:import url="/index/head.htm"/>

<div class="app-body">
    <c:import url="/index/leftNav.htm"/>
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">首页</li>
            <li class="breadcrumb-item">
                <a href="${basePath}/order/orderList.htm">员工管理</a>
            </li>
            <li class="breadcrumb-item active">导入员工Excel</li>
        </ol>
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <strong style="font-size:17px;font-weight:700;vertical-align: -1px;margin-right:5px">☰</strong>导入
                </div>
                <div class="card-block">
                    <form id="mainForm" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <div class="form-group row">
                            <input type="file" name="fileToUpload" id="fileToUpload" size="300"
                                   style="margin-left:15px;width:300px">
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="ajaxFileUpload()"><i
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
<script src="${basePath}/resources/js/views/main.js"></script>
<script src="${basePath}/resources/js/views/reset.js"></script><!--form重置-->
<script src="${basePath}/resources/js/dialog2.js"></script>
<script src="${basePath}/resources/js/alert.js"></script>
<script src="${basePath}/resources/js/ajaxfileupload.js"></script>
<script>

    //验证数据
    function isValidator() {
        var fileToUpload = $('#fileToUpload').val();
        if (fileToUpload == '') {
            kalert({
                title:"提示",
                content:"请选择文件",
                ctext:"取消",
                stext:"确定",
                dCancel:'hidden',
                callback:function(ok){

                }
            });
            return false;
        }
        return true;
    };

    function ajaxFileUpload(){
        if (!isValidator()) {
            return false;
        }
        $.ajaxFileUpload({
            url:'${basePath}/employee/importEmployee.htm',
            type:'post',
            secureuri:false,
            fileElementId:'fileToUpload', //文件选择框的id属性
            dataType: 'json',//服务器返回的格式，可以是json
            //相当于java中try语句块的用法
            success:function (data, status) {
                if(data.result){
                    kalert({
                        title:"提示",
                        content:data.message,
                        ctext:"取消",
                        stext:"确定",
                        dCancel:'hidden',
                        callback:function(ok){
                            window.location.href = ${basePath}data.url;
                        }
                    });
                }else{
                    alertTip("导入失败");
                }
            },
            error:function (data, status, e) {
                alert("导入出错："+data);
            }

        });
    }
</script>

</body>
</html>