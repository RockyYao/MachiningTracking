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
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<c:import url="/index/head.htm"/>
<div class="app-body">
    <c:import url="/index/leftNav.htm"/>
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">首页</li>
            <li class="breadcrumb-item">
                <a href="#">订单</a>
            </li>
            <li class="breadcrumb-item active">订单管理</li>
        </ol>
        <div class="container-fluid">
            <div class="goods_cate">
                <!--搜索  -->
                <form method="post" id="queryForm" name="queryForm" action="${basePath}/order/orderList.htm" enctype="multipart/form-data">
                    <a href="${basePath}/order/importOrder.htm" class="g_newAdd">导入</a>
                    <%--<a href="${basePath}/order/exportOrder.htm" class="g_newAdd">导出</a>--%>
                    <a href="${basePath}/order/downloadExcel.htm" class="g_newAdd" title="Download">下载模版</a>
                    <div class="lzf_qm_seach">
                        <table border="0">
                            <tbody>
                            <tr>
                                <td>
                                    <input name="jobNo" type="text" id="jobNo"
                                           value="${order.jobNo}" placeholder="这里输入JobNo">
                                </td>
                                <td>
                                    <input name="dwgNo" type="text" id="dwgNo"
                                           value="${order.dwgNo}" placeholder="这里输入DwgNo">
                                </td>
                                <td>状态：</td>
                                <td>
                                    <select name="status" id="status">
                                        <option value="">全部</option>
                                        <option value="1" <c:if test="${order.status eq 1}">selected</c:if>>未开始</option>
                                        <option value="2" <c:if test="${order.status eq 2}">selected</c:if>>进行中</option>
                                        <option value="3" <c:if test="${order.status eq 3}">selected</c:if>>已完成</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="submit" value="搜索" class="lzfs_but" style="cursor:pointer;">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div style="clear:both"></div>
                </form>
                <!-- ./搜索end -->
                <table border="0" width="100%" class="g_tab" id="j_checktab">
                    <thead>
                    <tr>
                        <th style="width:50px;"></th>
                        <th style="width: 50px" title="No">序号</th>
                        <th>Job No</th>
                        <th>Dwg No</th>
                        <th>Rev</th>
                        <th>OrderQty</th>
                        <th>Plan</th>
                        <th>ProdQty</th>
                        <th title="state">状态</th>
                        <th title="current process">当前工序</th>
                        <th title="expected time">预计工时</th>
                        <th title="actual hour">实际工时</th>
                        <th title="complete progress">完成进度</th>
                        <th title="bar code">条形码</th>
                        <th title="operation">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${orderPageResult.data.size() gt 0}">
                            <c:forEach items="${orderPageResult.data}" var="order" varStatus="vs">
                                <tr>
                                    <td>
                                        <input type="checkbox" class="check" name="ids" value="${order.id}">
                                    </td>
                                    <td>${vs.index+1}</td>
                                    <td>${order.jobNo}</td>
                                    <td>${order.dwgNo}</td>
                                    <td>${order.rev}</td>
                                    <td>${order.orderQty}</td>
                                    <td>${order.plot}</td>
                                    <td>${order.prodQty}</td>
                                    <c:if test="${order.status == 1}">
                                        <td style="background-color: #f3e108" title=" not start">
                                            未开始
                                        </td>

                                    </c:if>
                                    <c:if test="${order.status == 2}">
                                        <td style="background-color: #74cdf7" title="underway">
                                            进行中
                                        </td>
                                    </c:if>
                                    <c:if test="${order.status == 3}">
                                        <td style="background-color: #48f348" title="complete">
                                            已完成
                                        </td>
                                    </c:if>
                                    <td>${order.currentProcedure}</td>
                                    <td>${order.preCostTime}</td>
                                    <td>${order.formatRelCostTime}</td>
                                    <td>
                                        <c:if test="${order.status == 2}">
                                            ${order.completePercent}%
                                        </c:if>
                                        <c:if test="${order.status == 3}">
                                            100.00%
                                        </c:if>
                                    </td>
                                    <td>${order.barCode}</td>
                                    <td>
                                        <a href="${basePath}/orderProcedure/orderProcedureList.htm?orderId=${order.id}&orderPageSize=${orderPageResult.pageSize}&orderCurrentPage=${orderPageResult.pageIndex}" title="check">查看</a>
                                        <c:if test="${order.status ne 3}">
                                            <a href="${basePath}/order/editOrder.htm?id=${order.id}&pageSize=${orderPageResult.pageSize}&currentPage=${orderPageResult.pageIndex}" title="alter">修改</a>
                                            <a href="javascript:void(0)" title="print" onclick="printTag(${order.id})">打印</a>
                                        </c:if>
                                        <a href="javascript:void(0)" onclick="deleteOrder(${order.id})" title="del">删除</a>
                                    </td>
                                </tr>
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
                <p class="box_all">
                    <input type="checkbox" id="check-all" class="t_alldele">全选
                    <a href="#" class="j_alldele" onclick="batchDelete('${basePath}/order/batchDeleteOrder.htm')" title="delete in batches">批量删除</a>
                    <a href="#" class="j_alldele" onclick="batchPrint('${basePath}/order/batchPrint.htm')" title="delete in batches">批量打印</a>
                </p>
            </div>
            <div id="pageToolbar" <c:if test="${orderPageResult.data.size() eq 0}">class="hidden" </c:if>></div>
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
<script src="${basePath}/resources/js/views/checkAll.js"></script>
<script src="${basePath}/resources/js/date/laydate.js"></script><!--日期插件-->
<script src="${basePath}/resources/page/js/query.js"></script><!--page-->
<script src="${basePath}/resources/page/js/paging.js"></script><!--page-->
<script src="${basePath}/resources/js/dialog2.js"></script>
<script src="${basePath}/resources/js/alert.js"></script>
<script type="text/javascript">
    //
    <!--page-->
    $('#pageToolbar').Paging({
        pagesize: parseInt(${orderPageResult.pageSize}),
        count: parseInt(${orderPageResult.totalRows}),
        current: parseInt(${orderPageResult.pageIndex}),
        toolbar: true,//是否显示工具栏
        pageSizeList: [10, 20, 50, 100],//可设置每页条数，默认为[5,10,15,20]
        callback: function (page, size, count) {//page为当前页码,size为每页条数，count为总页数
            var url = '${basePath}/order/orderList.htm?currentPage=' + page + '&pageSize=' + size;
            if('${order.dwgNo}'){
                url += "&dogNo=${order.dwgNo}"
            }
            if('${order.jobNo}'){
                url += "&jobNo=${order.jobNo}"
            }
            window.location.href = url;
        },
        changePagesize: function (ps) {//修改每页的条数
            var url = '${basePath}/order/orderList.htm?currentPage=' + 1 + '&pageSize=' + ps;
            if('${order.dwgNo}'){
                url += "&dogNo=${order.dwgNo}"
            }
            if('${order.jobNo}'){
                url += "&jobNo=${order.jobNo}"
            }
            window.location.href = url;
        }
    });

    function printTag(orderId){
        $.ajax({
            url:'${basePath}/order/printTag.htm',
            type:'post',
            data:{orderId:orderId},
            dataType:'json',
            success:function (data) {
                if(data){
                    alertTip("打印成功");
                }else{
                    alertTip("打印失败")
                }
            }
        })
    }

    function batchPrint(url) {
        var ids = '';
        if($(".check").is(':checked')){
            kalert({
                title:"提示",
                content:'确定打印所选行吗？',
                ctext:"取消",
                stext:"确定",
                dCancel:'show',
                callback:function(ok){
                    if( ok ){
                        $("input[name=ids]").each(function () {
                            if ($(this).is(':checked')){
                                if (ids == '')
                                    ids += $(this).val();
                                else
                                    ids += ',' + $(this).val();
                            }
                        });
                        window.location.href = url+"?ids="+ids;
                    }
                }
            });
        }else{
            kalert({
                title:"提示",
                content:'请选择要打印的行！',
                ctext:"取消",
                stext:"确定",
                dCancel:'hidden',
                callback:function(ok){}
            });
        }
    }

    function deleteOrder(id){
        confirmAlert("确定删除该订单吗？",'${basePath}/order/deleteOrder.htm?id='+id+'&pageSize=${orderPageResult.pageSize}&currentPage=${orderPageResult.pageIndex}');
    }
</script>
</body>
</html>