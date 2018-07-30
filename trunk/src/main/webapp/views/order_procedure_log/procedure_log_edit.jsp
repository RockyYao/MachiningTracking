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
    </style>
</head>
<body >

<div>
    <main class="main">
        <div class="card_f">
            <div class="card-block" style="padding: 3.25rem">
                <form id="mainForm" method="post" class="form-horizontal" action="${basePath}/orderProcedure/addOrderProcedure.htm" enctype="multipart/form-data">
                    <div class="form-group row">
                        <label class="col-sm-2-f form-control-label l_class_f" for="endTime">结束时间</label>
                        <div class="col-sm-6-f  goods_but ">
                            <input name="endTime" type="text" class="inline laydate-icon" id="endTime"
                                   value="<fmt:formatDate value='${orderProcedureLog.endTime}'
                                        pattern="yyyy-MM-dd HH:mm:ss"/>"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2-f form-control-label l_class_f" for="workNo">工号</label>
                        <div class="col-sm-6-f  goods_but ">
                            <input type="text" id="workNo" name="workNo" class="form-control"
                                   value="${orderProcedureLog.workNo}" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2-f form-control-label l_class_f" for="enName">姓名</label>
                        <div class="col-sm-6-f  goods_but ">
                            <input type="text" id="enName" name="enName" class="form-control"
                                   value="${orderProcedureLog.workName}" readonly>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-footer" style="text-align: center">
                <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="editOrderProcedureLog()"><i
                        class="fa fa-dot-circle-o"></i> 确认
                </button>
                <%--<button type="reset" class="btn btn-sm btn-danger"><i class="fa fa-ban"></i> 重置</button>--%>
            </div>
        </div>
    </main>
</div>
<script src="${basePath}/resources/assets/js/libs/jquery.min.js"></script>
<script src="${basePath}/resources/js/dialog2.js"></script>
<script src="${basePath}/resources/js/views/reset.js"></script><!--form重置-->
<script src="${basePath}/resources/js/date/laydate.js"></script><!--日期插件-->
<script src="${basePath}/resources/js/alert.js"></script>


<script>
    function editOrderProcedureLog(){
        var endTime = $("#endTime").val();
        if(endTime == ""){
            alertTip("请选择时间")
            return;
        }
        kalert({
            title:"提示",
            content:"确定提交吗？",
            ctext:"取消",
            stext:"确定",
            dCancel:'show',
            callback:function(ok){
                if(ok){
                    $.ajax({
                        url:'${basePath}/procedureLog/editProcedureLog.htm',
                        data:{id:'${orderProcedureLog.id}',endTime:endTime},
                        dataType:'json',
                        type:'post',
                        success:function (data) {
                            if(data.result){
                                window.parent.location.reload();
                                var index=parent.layer.getFrameIndex(window.name);
                                parent.layer.close(index);
                            }else{
                                alertTip("操作失败");
                            }
                        }
                    })
                }
            }
        });
    }

    //日期
    (function(){
        !function(){
            laydate.skin('danlan');//切换皮肤，请查看skins下面皮肤库
            // laydate({elem: '#demo'});//绑定元素
        }();

        //日期范围限制
        var start = {
            elem: '#endTime',
            format: 'YYYY-MM-DD hh:mm:ss',
//            min: laydate.now(), //设定最小日期为当前日期
            max: '2099-06-16 00:00:00', //最大日期
            istime: true,
            istoday: false,
            choose: function(datas){

            }
        };
        laydate(start);
    })();
</script>
</body>
</html>