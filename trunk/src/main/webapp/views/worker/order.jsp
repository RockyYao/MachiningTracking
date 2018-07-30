<%@ taglib prefix="javascript" uri="http://www.springframework.org/tags/form" %>
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
    <title>订单加工</title>
    <link rel="shortcut icon" href="${basePath}/resources/img/otc_logo.jpg">
    <!-- Icons -->
    <link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
    <!-- Main styles for this application -->
    <link href="${basePath}/resources/css/style.css" rel="stylesheet">
    <link href="${basePath}/resources/css/goods.css" rel="stylesheet">
    <!--cucc main-->
    <link href="${basePath}/resources/css/public.css" rel="stylesheet">
    <link href="${basePath}/resources/page/css/paging.css" rel="stylesheet"><!--page-->
    <!---- cucc container start-->
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<header class="app-header navbar">
    <a class="navbar-brand" href="#"></a>
    <ul class="nav navbar-nav ml-auto" style="margin-right: 30px">
        <li class="nav-item dropdown">
            <a class="dropdown-item" href="${basePath}/login/toLoginView.htm"><i class="fa fa-lock"></i>登录/Log In</a>
        </li>
    </ul>
</header>
<div class="app-body">
    <main class="main" style="margin-left: 0px">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">订单加工/Order Processing</li>
        </ol>
        <div class="container-fluid">
            <div class="goods_cate">
                <!--搜索  -->
                <form method="post" id="queryForm" name="queryForm" action="${basePath}/worker/order.htm">
                    <div class="lzf_qm_seach">
                        <table border="0">
                            <tbody>
                            <tr>
                                <td>
                                    <input name="barCode" type="text" id="barCode" placeholder="扫描条形码/scan the barcode">
                                </td>
                                <td>
                                    <input type="submit" value="搜索/Seek" class="lzfs_but" style="cursor:pointer;">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div style="clear:both"></div>
                </form>
                <!-- ./搜索end -->
                <table border="0" width="100%" class="g_tab" id="j_checktab2">
                    <thead>
                    <tr>
                        <th>Job No</th>
                        <th>Dwg No</th>
                        <th>Rev</th>
                        <th>OrderQty</th>
                        <th>Plan</th>
                        <th>ProdQty</th>
                        <th>状态/status</th>
                        <th>当前工序/the current process</th>
                        <th>预计工时/expected time</th>
                        <th>实际工时/working hours</th>
                        <th>条形码/bar code</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>${order.jobNo}</td>
                        <td>${order.dwgNo}</td>
                        <td>${order.rev}</td>
                        <td>${order.orderQty}</td>
                        <td>${order.plot}</td>
                        <td>${order.prodQty}</td>
                        <td style="white-space:nowrap;">
                            <c:if test="${order.status == 1}">
                                未开始/have not started
                            </c:if>
                            <c:if test="${order.status == 2}">
                                进行中/under way
                            </c:if>
                            <c:if test="${order.status == 3}">
                                已完成/off the stocks
                            </c:if>
                        </td>
                        <td>${order.currentProcedure}</td>
                        <td>${order.preCostTime}</td>
                        <td>${order.formatRelCostTime}</td>
                        <td>${order.barCode}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <table border="0" width="100%" class="g_tab" id="j_checktab">
                <thead>
                <tr>
                    <th width="10%" style="white-space:nowrap;">工序名称/process name</th>
                    <th width="10%">排序/sort</th>
                    <th width="10%" style="white-space:nowrap;">预计工时/expected time</th>
                    <th width="10%" style="white-space:nowrap;">已耗工时/working hours</th>
                    <th width="10%">状态/status</th>
                    <th>操作/operation</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${orderProcedureList.size() gt 0}">
                        <c:forEach items="${orderProcedureList}" var="orderProcedure">
                            <tr>
                                <td>${orderProcedure.enName}</td>
                                <td>${orderProcedure.sort}</td>
                                <td>${orderProcedure.preCostTime}</td>
                                <td>${orderProcedure.formatRelCostTime}</td>
                                <td style="white-space:nowrap;">
                                    <c:if test="${orderProcedure.status == 1}">
                                        未接收/Did not receive
                                    </c:if>
                                    <c:if test="${orderProcedure.status == 2}">
                                        已接收/already received
                                    </c:if>
                                    <c:if test="${orderProcedure.status == 3}">
                                        进行中/under way
                                    </c:if>
                                    <c:if test="${orderProcedure.status == 4}">
                                        暂停中/pause
                                    </c:if>
                                    <c:if test="${orderProcedure.status == 5}">
                                        已完成/complete
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${orderProcedure.status ne 5}">
                                        <c:if test="${orderProcedure.sort eq currentSort}">
                                            请扫描或输入工号/work number<input type="text" name="workNo" id="workNo_${orderProcedure.id}">
                                            <a href="javascript:void(0)"
                                               onclick="accept('${orderProcedure.id}')">接受</a>
                                        </c:if>
                                        <c:if test="${order.currentSort eq orderProcedure.sort}">
                                            <c:if test="${orderProcedure.status eq 2 || orderProcedure.status eq 4}">
                                                请扫描或输入工号/work number<input type="text" name="workNo" id="workNo_${orderProcedure.id}">
                                                <a href="javascript:void(0)"
                                                   onclick="start('${orderProcedure.id}')" title="start">开始</a>
                                            </c:if>
                                            <c:if test="${orderProcedure.status eq 3}">
                                                <a href="javascript:void(0)"
                                                   onclick="pause('${orderProcedure.id}')" title="push">暂停</a>
                                                <a href="javascript:void(0)"
                                                   onclick="complete('${orderProcedure.id}')" title="complete">完成</a>
                                            </c:if>
                                        </c:if>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                </c:choose>
                </tbody>
            </table>
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
<%--<script src="${basePath}/resources/js/views/checkAll.js"></script>--%>
<script src="${basePath}/resources/js/date/laydate.js"></script><!--日期插件-->
<script src="${basePath}/resources/page/js/query.js"></script><!--page-->
<script src="${basePath}/resources/page/js/paging.js"></script><!--page-->
<script src="${basePath}/resources/js/dialog2.js"></script>
<script src="${basePath}/resources/js/alert.js"></script>

<script type="text/javascript">
    $(function() {
        $("input[name='barCode']").focus();
    });
    //接收订单
    function accept(id) {
        var workNo = $("#workNo_" + id).val();
        if(workNo == ""){
            alertTip("请扫描工号");
            return;
        }
        if(!checkWorkNo(workNo,id)){
            alertTip("您输入的工号信息错误");
            return;
        }
        kalert({
            title:"提示",
            content:"确认接收吗?",
            ctext:"取消",
            stext:"确定",
            dCancel:'show',
            callback:function(ok){
                if(ok){
                    $.ajax({
                        url:'${basePath}/worker/accept.htm',
                        type:'post',
                        data:{id:id,workNo:workNo,barCode:'${barCode}'},
                        success:function (data) {
                            if(data == "success"){
                                window.location.reload();
                            }else{
                                alertTip("操作失败");
                            }
                        }
                    })
                }
            }
        });
    }

    function start(id) {
        var workNo = $("#workNo_" + id).val();
        if(workNo == ""){
            alertTip("请扫描工号");
            return;
        }
        if(!checkWorkNo(workNo,id)){
            alertTip("您输入的工号信息错误");
            return;
        }
        kalert({
            title:"提示",
            content:"确认开始吗?",
            ctext:"取消",
            stext:"确定",
            dCancel:'show',
            callback:function(ok){
                if(ok){
                    $.ajax({
                        url:'${basePath}/worker/start.htm',
                        type:'post',
                        data:{id:id,workNo:workNo,barCode:'${barCode}'},
                        success:function (data) {
                            if(data == "success"){
                                window.location.reload();
                            }else{
                                alertTip("操作失败");
                            }
                        }
                    })
                }
            }
        });
    }

    function pause(id) {
        kalert({
            title:"提示",
            content:"确认暂停吗?",
            ctext:"取消",
            stext:"确定",
            dCancel:'show',
            callback:function(ok){
                if(ok){
                    $.ajax({
                        url:'${basePath}/worker/pause.htm',
                        type:'post',
                        data:{id:id,barCode:'${barCode}'},
                        success:function (data) {
                            if(data == "success"){
                                window.location.reload();
                            }else{
                                alertTip("操作失败");
                            }
                        }
                    })
                }
            }
        });
    }


    function complete(id) {
        kalert({
            title:"提示",
            content:"确认结束吗?",
            ctext:"取消",
            stext:"确定",
            dCancel:'show',
            callback:function(ok){
                if(ok){
                    $.ajax({
                        url:'${basePath}/worker/complete.htm',
                        type:'post',
                        data:{id:id,barCode:'${barCode}'},
                        success:function (data) {
                            if(data == "success"){
                                window.location.reload();
                            }else{
                                alertTip("操作失败");
                            }
                        }
                    })
                }
            }
        });
    }

    function checkWorkNo(workNo,id) {
        var flag = true;
        $.ajax({
            url:'${basePath}/worker/checkEmployee.htm',
            type:'post',
            data:{workNo:workNo,id:id},
            async:false,
            dataType:'json',
            success:function (data) {
                if(!data){
                    flag = false;
                }
            }
        })
        return flag;
    }
</script>
</body>
</html>