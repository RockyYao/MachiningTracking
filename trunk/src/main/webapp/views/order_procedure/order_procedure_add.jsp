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
        .l_class_f{
            line-height: 35px;
        }
        .card_f{
            position: relative;
            display: flex;
            flex-direction: column;
            background-color: #fff;
            border: 1px solid #cfd8dc
        }
        .col-sm-2-f{
            position: relative;
            width: 30%;
            min-height: 1px;
            padding-right: 15px;
            padding-left: 15px;
            text-align: right;
        }
        .col-sm-6-f{
            position: relative;
            width: 70%;
            min-height: 1px;
            padding-right: 15px;
            padding-left: 15px;
        }
        .goods_icon {
            position: absolute;
            top: 10px;
            left: 0px;
            color: red;
        }
    </style>
</head>
<body >

<div>
    <main class="main">
        <div class="card_f">
            <div class="card-block">
                <form id="mainForm" method="post" class="form-horizontal" action="${basePath}/orderProcedure/addOrderProcedure.htm" enctype="multipart/form-data">
                    <div class="form-group row">
                        <label class="col-sm-2-f form-control-label l_class_f" for="enName">工序名称</label>
                        <div class="col-sm-6-f  goods_but ">
                            <input type="text" id="enName" name="enName" class="form-control" maxlength="50">
                            <span class="goods_icon">*</span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2-f form-control-label l_class_f" for="sort">排序</label>
                        <div class="col-sm-6-f  goods_but ">
                            <input type="text" id="sort" name="sort" class="form-control" maxlength="50"
                                   onkeyup="this.value=(this.value.match(/\d+(\.\d{0,1})?/)||[''])[0]"
                                   onafterpaste="this.value=(this.value.match(/\d+(\.\d{0,1})?/)||[''])[0]">
                            <span class="goods_icon">*</span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2-f form-control-label l_class_f" for="preCostTime">预估工时</label>
                        <div class="col-sm-6-f  goods_but ">
                            <input type="text" id="preCostTime" name="preCostTime" class="form-control" maxlength="50"
                                   onkeyup="this.value=(this.value.match(/\d+(\.\d{0,1})?/)||[''])[0]"
                                   onafterpaste="this.value=(this.value.match(/\d+(\.\d{0,1})?/)||[''])[0]">
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-footer" style="text-align: center">
                <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="saveOrderProcedure()"><i
                        class="fa fa-dot-circle-o"></i> 确认
                </button>
                <button type="reset" class="btn btn-sm btn-danger"><i class="fa fa-ban"></i> 重置</button>
            </div>
        </div>
    </main>
</div>
<script src="${basePath}/resources/assets/js/libs/jquery.min.js"></script>
<script src="${basePath}/resources/js/dialog2.js"></script>
<script src="${basePath}/resources/js/views/reset.js"></script><!--form重置-->

<script>
    function saveOrderProcedure(){
        if(check()){
            var sort = $("#sort").val();
            var flag = true;
            $.ajax({
                url:'${basePath}/orderProcedure/checkProcedureSort.htm',
                data:{'sort':sort,'orderId':'${orderId}'},
                type:'post',
                async:false,
                dataType:'json',
                success:function(data){
                    if(!data.result){
                        flag = false;
                        alert(data.message);
                    }
                }
            })
            if(flag){
                $.ajax({
                    url:'${basePath}/orderProcedure/addOrderProcedure.htm',
                    data:{"orderId":"${orderId}","sort":$("#sort").val(),
                        "enName":$("#enName").val(),"preCostTime":$("#preCostTime").val()},
                    dataType:'json',
                    type:'post',
                    async:false,
                    success:function (data) {
                        if(data.result){
                            kalert({
                                title:"提示",
                                content:"工序添加成功",
                                ctext:"取消",
                                stext:"确定",
                                dCancel:'hidden',
                                callback:function(ok){
                                    window.parent.location.reload();
                                    var index=parent.layer.getFrameIndex(window.name);
                                    parent.layer.close(index);
                                }
                            });
                        }
                    }
                })
            }
        }
    }

    function check(){
        var enName = $("#enName").val();
        if(enName == ""){
            alert("请输入工序名称");
            return false;
        }
        var sort = $("#sort").val();
        if(sort == ""){
            alert("请输入排序")
            return false;
        }
        return true;
    }

    function alert(msg) {
        kalert({
            title:"提示",
            content:msg,
            ctext:"取消",
            stext:"确定",
            dCancel:'hidden',
            callback:function(ok){

            }
        });
    }
</script>
</body>
</html>