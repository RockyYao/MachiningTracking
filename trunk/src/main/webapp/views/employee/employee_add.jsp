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
        .count-up{
            display: inline-block;
            width: 30px;
            background-color: #f0f0f0;
            text-align: center;
            font-size: 22px;
            border: 1px solid #cccccc;
            box-sizing: border-box;
            cursor: pointer;
            user-select: none;
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
                <a href="${basePath}/employee/employeeList.htm">员工管理</a>
            </li>
            <li class="breadcrumb-item active">员工添加</li>
        </ol>
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <strong style="font-size:17px;font-weight:700;vertical-align: -1px;margin-right:5px">☰</strong>员工添加
                </div>
                <div class="card-block">
                    <form id="mainForm" method="post" class="form-horizontal" action="${basePath}/employee/addEmployee.htm"
                    enctype="multipart/form-data">
                        <input type="hidden" name="nameStr" id="nameStr">
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="workNo">工号</label>
                            <div class="col-sm-6  goods_but " style="margin-left: 35px">
                                <input type="text" id="workNo" name="workNo" class="form-control" maxlength="50">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="workName">姓名</label>
                            <div class="col-sm-6  goods_but " style="margin-left: 35px">
                                <input type="text" id="workName" name="name" class="form-control" maxlength="50">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class">工序名称</label>
                            <div>
                                <span class="count-up" onclick="addInput()">+</span>
                            </div>
                            <div class="col-sm-6  goods_but " style="margin-left: 5px">
                                <input type="text" name="pName" class="form-control" maxlength="50">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="card-footer">
                    <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="saveEmployee()"><i
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
    function addInput() {
        var html = "";
        html += '<div class="form-group row">';
        html += '<label class="col-sm-2 form-control-label l_class"></label>';
        html += '<div>';
        html += '<span class="count-up" onclick="reduceInput(this)">-</span>';
        html += '</div>';
        html += '<div class="col-sm-6  goods_but " style="margin-left: 5px">';
        html += '<input type="text" name="pName" class="form-control" maxlength="50">';
        html += '</div>';
        html += '</div>';
        $("#mainForm").append(html)
    }

    function reduceInput(el) {
        $(el).parent().parent().remove();
    }

    function saveEmployee() {
        var workNo = $("#workNo").val();
        if(workNo == ''){
            alertTip("请输入工号");
            return;
        }
        var flag = true;
        $.ajax({
            url:'${basePath}/employee/checkEmployee.htm',
            type:'post',
            data:{workNo:workNo},
            async:false,
            dataType:'json',
            success:function (data) {
                flag = data;
            }
        })
        if(!flag){
            alertTip("工号已存在");
            return;
        }
        var workName = $("#workName").val();
        if(workName == ''){
            alertTip("请输入姓名");
            return;
        }
        var names = $("input[name=pName]").map(function(){
            return this.value
        }).get();
        var nameStr="";
        for(var i = 0; i<names.length;i++){
            if(names[i]!=""){
                nameStr += names[i];
                nameStr += ",";
            }
        }
        if(nameStr == ""){
            alertTip("请输入工序名称");
            return;
        }
        $("#nameStr").val(nameStr);
        $("#mainForm").submit();
    }

</script>
</body>
</html>