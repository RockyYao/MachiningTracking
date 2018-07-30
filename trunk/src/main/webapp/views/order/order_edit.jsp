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
            <li class="breadcrumb-item active">订单修改</li>
        </ol>
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <strong style="font-size:17px;font-weight:700;vertical-align: -1px;margin-right:5px">☰</strong>订单修改
                </div>
                <div class="card-block">
                    <form id="mainForm" method="post" class="form-horizontal" action="${basePath}/order/editOrder.htm" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${order.id}">
                        <input type="hidden" name="currentPage" value="${currentPage}">
                        <input type="hidden" name="pageSize" value="${pageSize}">
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="jobNo">Job No</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="jobNo" name="jobNo" class="form-control"
                                       value="${order.jobNo}">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="dwgNo">Dwg No</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="dwgNo" name="dwgNo" class="form-control"
                                       value="${order.dwgNo}">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="rev">Rev</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="rev" name="rev" class="form-control"
                                       value="${order.rev}" maxlength="50">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="orderQty">OrderQty</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="orderQty" name="orderQty" class="form-control"
                                       value="${order.orderQty}" maxlength="50">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="plot">Plan</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="plot" name="plot" class="form-control"
                                       value="${order.plot}" maxlength="50">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="prodQty">ProdQty</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="prodQty" name="prodQty" class="form-control"
                                       value="${order.prodQty}" maxlength="50">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="saveOrder()"><i
                            class="fa fa-dot-circle-o"></i> 确认
                    </button>
                    <%--<button type="reset" class="btn btn-sm btn-danger"><i class="fa fa-ban"></i> 重置</button>--%>
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
<script src="${basePath}/resources/js/ajaxfileupload.js"></script>
<script src="${basePath}/resources/js/alert.js"></script>
<script>
    function saveOrder() {
        var jobNo = $("#jobNo").val();
        var dwgNo = $("#dwgNo").val();
        if(jobNo == ""){
            alertTip("请输入JobNo");
            return;
        }
        if(dwgNo == ""){
            alertTip("请输入DwgNo");
            return;
        }
        $("#mainForm").submit();
    }
</script>
</body>
</html>