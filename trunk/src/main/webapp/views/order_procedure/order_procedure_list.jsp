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
    <link href="${basePath}/resources/css/goods.css" rel="stylesheet">
    <!--cucc main-->
    <link href="${basePath}/resources/css/public.css" rel="stylesheet">
    <link href="${basePath}/resources/page/css/paging.css" rel="stylesheet"><!--page-->
    <!---- cucc container start-->
    <link href="${basePath}/resources/layer/theme/default/layer.css" rel="stylesheet">
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
            <li class="breadcrumb-item active">订单工序</li>
        </ol>
        <div class="container-fluid">
            <div class="goods_cate">
                <!--搜索  -->
                <form method="post" id="queryForm" name="queryForm" enctype="multipart/form-data">
                    <a href="javascript:void(0);" class="g_newAdd" onclick="window.location.href='${basePath}/order/orderList.htm?pageSize=${orderPageSize}&currentPage=${orderCurrentPage}'">返回</a>
                    <a href="javascript:void(0);" class="g_newAdd" onclick="showAdd('${orderId}')">添加工序</a>
                    <div style="clear:both"></div>
                </form>
                <!-- ./搜索end -->
                <table border="0" width="100%" class="g_tab" id="j_checktab">
                    <thead>
                    <tr>
                        <th width="10%" colspan="2">工序名称</th>
                        <th width="10%" colspan="2">排序</th>
                        <th width="10%">预计工时</th>
                        <th width="10%">已耗工时</th>
                        <th width="10%">状态</th>
                        <th width="10%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${orderProcedurePageResult.data.size() gt 0}">
                            <c:forEach items="${orderProcedurePageResult.data}" var="orderProcedure">
                                <tr>
                                    <td colspan="2">${orderProcedure.enName}</td>
                                    <td colspan="2">${orderProcedure.sort}</td>
                                    <td>${orderProcedure.preCostTime}</td>
                                    <td>${orderProcedure.formatRelCostTime}</td>
                                    <td>
                                        <c:if test="${orderProcedure.status == 1}">
                                            未接收
                                        </c:if>
                                        <c:if test="${orderProcedure.status == 2}">
                                            已接收
                                        </c:if>
                                        <c:if test="${orderProcedure.status == 3}">
                                            进行中
                                        </c:if>
                                        <c:if test="${orderProcedure.status == 4}">
                                            暂停中
                                        </c:if>
                                        <c:if test="${orderProcedure.status == 5}">
                                            已完成
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${orderProcedure.status eq 1 || orderProcedure.status eq 2}">
                                            <a href="javascript:void(0);"
                                               onclick="showEdit(${orderProcedure.id})">修改</a>
                                            <a href="javascript:void(0);"
                                               onclick="confirmAlert('确定删除工序吗？','${basePath}/orderProcedure/deleteOrderProcedure.htm?id=${orderProcedure.id}&orderId=${orderId}')">删除</a>
                                        </c:if>
                                        <a href="javascript:void(0);" onclick="showProcedureLog(${orderProcedure.id})">加工记录</a>
                                    </td>
                                </tr>
                                <tr style="font-size: 12px;height: 30px;background-color: aliceblue;" hidden
                                    class="procedure_log_${orderProcedure.id}">
                                    <td width="5%"><strong>工号</strong></td>
                                    <td width="5%"><strong>姓名</strong></td>
                                    <td width="5%"><strong>类型</strong></td>
                                    <td width="5%"><strong>接收时间</strong></td>
                                    <td><strong>开始时间</strong></td>
                                    <td><strong>结束时间</strong></td>
                                    <td><strong>耗时</strong></td>
                                    <td><strong>操作</strong></td>
                                </tr>
                                <c:forEach items="${orderProcedure.procedureLogList}" var="log">
                                    <tr style="font-size: 12px;height: 30px;background-color: aliceblue;" hidden
                                        class="procedure_log_${orderProcedure.id}">
                                        <td>${log.workNo}</td>
                                        <td>${log.workName}</td>
                                        <td>
                                            <c:if test="${log.logType eq 1}">
                                                接收订单
                                            </c:if>
                                            <c:if test="${log.logType eq 2}">
                                                加工订单
                                            </c:if>
                                        </td>
                                        <td><fmt:formatDate value="${log.receiveTime}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td><fmt:formatDate value="${log.startTime}"
                                                                        pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td><fmt:formatDate value="${log.endTime}"
                                                                        pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>${log.formatRelCostTime}</td>
                                        <td>
                                            <c:if test="${log.logType eq 2 && log.endTime ne null}">
                                                <a href="javascript:void(0);"
                                                   onclick="showLogEdit(${log.id})" style="background-color: #48a7c7">修改记录</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!--判断若无数据 这个tr显示 否则下面的数据tr显示 由class hidden控制-->
                            <tr class="noData">
                                <td colspan="100">暂无数据！</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
            <div id="pageToolbar"
                 <c:if test="${orderProcedurePageResult.data.size() eq 0}">class="hidden" </c:if>></div>
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
<script src="${basePath}/resources/layer/layer.js"></script>
<script type="text/javascript">
    //
    <!--page-->
    $('#pageToolbar').Paging({
        pagesize: parseInt(${orderProcedurePageResult.pageSize}),
        count: parseInt(${orderProcedurePageResult.totalRows}),
        current: parseInt(${orderProcedurePageResult.pageIndex}),
        toolbar: true,//是否显示工具栏
        pageSizeList: [10, 20, 50, 100],//可设置每页条数，默认为[5,10,15,20]
        callback: function (page, size, count) {//page为当前页码,size为每页条数，count为总页数
            window.location.href = '${basePath}/orderProcedure/orderProcedureList.htm?currentPage='
                + page + '&pageSize=' + size + '&orderId=' + ${orderId};
        },
        changePagesize: function (ps) {//修改每页的条数
            window.location.href = '${basePath}/orderProcedure/orderProcedureList.htm?currentPage='
                + 1 + '&pageSize=' + ps + '&orderId=' + ${orderId};
        }
    });

    function showProcedureLog(procedureId) {
        var display = $(".procedure_log_" + procedureId).attr("hidden");
        if (display == "hidden") {
            $(".procedure_log_" + procedureId).removeAttr("hidden");
        } else {
            $(".procedure_log_" + procedureId).attr("hidden", "hidden");
        }
    }

    function showAdd(orderId) {
        layer.open({
            type: 2,
            title: "添加工序",
            area: ['430px', '314px'],
            maxmin: false,
            closeBtn: 1,
            content: '${basePath}/orderProcedure/addOrderProcedure.htm?orderId=' + orderId
        });
    }

    function showEdit(id) {
        layer.open({
            type: 2,
            title: "修改工序",
            area: ['430px', '314px'],
            maxmin: false,
            closeBtn: 1,
            content: '${basePath}/orderProcedure/editOrderProcedure.htm?id=' + id + "&orderId=${orderId}"
        });
    }

    function showLogEdit(id) {
        layer.open({
            type: 2,
            title: "修改加工记录",
            area: ['450px',"378px"],
            maxmin: false,
            closeBtn: 1,
            content: '${basePath}/procedureLog/editProcedureLog.htm?id=' + id + "&orderId=${orderId}"
        });
    }
</script>
</body>
</html>