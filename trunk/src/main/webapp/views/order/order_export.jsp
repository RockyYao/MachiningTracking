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
                <a href="${basePath}/order/orderList.htm">订单管理</a>
            </li>
            <li class="breadcrumb-item active">导出订单条形码Excel</li>
        </ol>
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <strong style="font-size:17px;font-weight:700;vertical-align: -1px;margin-right:5px">☰</strong>导出
                </div>
                <div class="card-block">
                    <form id="mainForm" method="post" class="form-horizontal" enctype="multipart/form-data"
                          action="${basePath}/order/exportOrder.htm">
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="exportData">导出方式</label>
                            <div class="col-sm-6  goods_but ">
                                <select id="exportData" name="exportData" class="form-control">
                                    <option value="">请选择</option>
                                    <option value="jobNo">根据JobNo导出</option>
                                    <option value="dwgNo">根据DwgNo导出</option>
                                </select>
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="exportValue">值</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="exportValue" name="exportValue" class="form-control">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="exportOrder()"><i
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
<script>

    //验证数据
    function exportOrder() {
        var exportData = $("#exportData").val();
        if(exportData == ""){
            alertTip("请选择导出方式")
            return;
        }
        var exportValue = $('#exportValue').val();
        if(exportValue == ""){
            alertTip("请输入值")
            return;
        }
        $("#mainForm").submit();
    };

</script>

</body>
</html>