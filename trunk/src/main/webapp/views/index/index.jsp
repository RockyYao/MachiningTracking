<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/views/common/taglibs.jsp"%>
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
    <link href="${basePath}/resources/page/css/paging.css" rel="stylesheet"><!--page-->
</head>


<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<c:import url="/index/head.htm"/>
<div class="app-body">
    <c:import url="/index/leftNav.htm"/>
    <%--<main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">首页</li>
        </ol>
        <!--运营区管理员-->
        #if($!loginUser.factoryId==0)
        <div class="container-fluid">
            <div>
                <div class="row">
                    <div class="col-sm-6 col-md-3">
                        <div class="card card-inverse card-info">
                            <div class="card-block">
                                <div class="h1 text-muted text-right mb-2">
                                    <i class="icon-people"></i>
                                </div>
                                <div class="h4 mb-0">$!onlineUserList.size()</div>
                                <small class="text-muted text-uppercase font-weight-bold">用户在线人数</small>
                                <div class="progress progress-white progress-xs mt-1">
                                    <div class="progress-bar" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/.col-->
                    <div class="col-sm-6 col-md-3">
                        <div class="card card-inverse card-success">
                            <div class="card-block">
                                <div class="h1 text-muted text-right mb-2">
                                    <i class="icon-user-follow"></i>
                                </div>
                                <div class="h4 mb-0">$!totalUserList.size()</div>
                                <small class="text-muted text-uppercase font-weight-bold">用户总人数</small>
                                <div class="progress progress-white progress-xs mt-1">
                                    <div class="progress-bar" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/.col-->
                    <div class="col-sm-6 col-md-3">
                        <div class="card card-inverse card-warning">
                            <div class="card-block">
                                <div class="h1 text-muted text-right mb-2">
                                    <i class="icon-basket-loaded"></i>
                                </div>
                                <div class="h4 mb-0">$!customerList.size()</div>
                                <small class="text-muted text-uppercase font-weight-bold">客户总人数</small>
                                <div class="progress progress-white progress-xs mt-1">
                                    <div class="progress-bar" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/.col-->
                    <div class="col-sm-6 col-md-3">
                        <div class="card card-inverse card-primary">
                            <div class="card-block">
                                <div class="h1 text-muted text-right mb-2">
                                    <i class="icon-pie-chart"></i>
                                </div>
                                <div class="h4 mb-0">$!logisticsList.size()</div>
                                <small class="text-muted text-uppercase font-weight-bold">物流商总人数</small>
                                <div class="progress progress-white progress-xs mt-1">
                                    <div class="progress-bar" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/.col-->
                </div>
            </div>
            <div style="margin-bottom: 50px; position: relative;">
                <div style="width: 100%; display: inline-block;">
                    <div class="lzf_qm_seach" style="margin-bottom: 15px;">
                        <table border="0">
                            <tbody>
                            <tr>
                                <td>年份：</td>
                                <td>
                                    <select name="year" id="year">
                                        <option value="2017">2017年</option>
                                        <option value="2016">2016年</option>
                                        <option value="2015">2015年</option>
                                        <option value="2014">2014年</option>
                                        <option value="2013">2013年</option>
                                        <option value="2012">2012年</option>
                                        <option value="2011">2011年</option>
                                        <option value="2010">2010年</option>
                                        <option value="2009">2009年</option>
                                        <option value="2008">2008年</option>
                                        <option value="2007">2007年</option>
                                    </select>
                                </td>
                                <td>所属基地：</td>
                                <td>
                                    <select name="factoryId" id="factoryId">
                                        <option value="">所有基地</option>
                                        #foreach($factory in $!factoryList)
                                        <option value="$!factory.id">$!factory.name</option>
                                        #end
                                    </select>
                                </td>
                                <td>
                                    <input type="submit" value="搜索" class="lzfs_but" style="cursor:pointer;" id="orderQuery">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="card" style="width: 100%;">
                        <div class="card-header" style="position: relative;">
                            订单统计
                            <div class="bar-switch">
                                <span class="on">订单数量</span>
                                <span>订单金额</span>
                            </div>
                            <div class="card-actions">
                                <a href="">
                                    <small class="text-muted">docs</small>
                                </a>
                            </div>
                        </div>
                        <div class="card-block">
                            <div class="chart-wrapper" id="canCount">
                                <canvas id="orderCount"></canvas>
                            </div>
                        </div>
                        <div class="card-block hidden">
                            <div class="chart-wrapper" id="canAmount">
                                <canvas id="orderAmount"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        #else
        <!--基地管理员-->
        <div class="container-fluid">
            <div style="margin-bottom: 50px; position: relative;">
                <div style="width: 100%; display: inline-block;">
                    <div class="lzf_qm_seach" style="margin-bottom: 15px;">
                        <table border="0">
                            <tbody>
                            <tr>
                                <td>年份：</td>
                                <td>
                                    <select name="year" id="year">
                                        <option value="2017">2017年</option>
                                        <option value="2016">2016年</option>
                                        <option value="2015">2015年</option>
                                        <option value="2014">2014年</option>
                                        <option value="2013">2013年</option>
                                        <option value="2012">2012年</option>
                                        <option value="2011">2011年</option>
                                        <option value="2010">2010年</option>
                                        <option value="2009">2009年</option>
                                        <option value="2008">2008年</option>
                                        <option value="2007">2007年</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="submit" value="搜索" class="lzfs_but" style="cursor:pointer;" id="orderQuery">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="card" style="width: 100%;">
                        <div class="card-header" style="position: relative;">
                            订单统计
                            <div class="bar-switch">
                                <span class="on">订单数量</span>
                                <span>订单金额</span>
                            </div>
                            <div class="card-actions">
                                <a href="">
                                    <small class="text-muted">docs</small>
                                </a>
                            </div>
                        </div>
                        <div class="card-block">
                            <div class="chart-wrapper" id="canCount">
                                <canvas id="orderCount"></canvas>
                            </div>
                        </div>
                        <div class="card-block hidden">
                            <div class="chart-wrapper" id="canAmount">
                                <canvas id="orderAmount"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        #end
        <!---- cucc container start-->
        <!-- /.conainer-fluid -->
    </main>--%>
</div>

<%--<footer class="app-footer">
    Copyright &copy;V4.1.2 2017.Company name All rights reserved.
    </span>
</footer>--%>

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
<script src="${basePath}/resources/page/js/query.js"></script><!--page-->
<script src="${basePath}/resources/page/js/paging.js"></script><!--page-->
<script type="text/javascript">
    //<!--page-->分页
    $('#pageToolbar').Paging({
        pagesize:parseInt('$!cuccGoodsSku.pageSize'),
        count:parseInt('$!cuccGoodsSku.totalRows'),
        current:parseInt('$!cuccGoodsSku.pageIndex'),
        toolbar:true,//是否显示工具栏
        pageSizeList:[5],//可设置每页条数，默认为[5,10,15,20]
        callback:function(page,size,count){//page为当前页码,size为每页条数，count为总页数
            window.location.href = '${basePath}/system/CuccGoodsSku/CuccGoodsSkuList.html?factoryid=xxx&currentPage='+page+'&pageSize='+size;
        },
        changePagesize:function(ps){//修改每页的条数
            window.location.href = '${basePath}/system/CuccGoodsSku/CuccGoodsSkuList.html?factoryid=xxx&currentPage='+1+'&pageSize='+ps;
        }
    });

    $('#pageToolbar1').Paging({
        pagesize:parseInt('$!cuccGoodsSku.pageSize'),
        count:parseInt('$!cuccGoodsSku.totalRows'),
        current:parseInt('$!cuccGoodsSku.pageIndex'),
        toolbar:true,//是否显示工具栏
        pageSizeList:[5],//可设置每页条数，默认为[5,10,15,20]
        callback:function(page,size,count){//page为当前页码,size为每页条数，count为总页数
            window.location.href = '${basePath}/system/CuccGoodsSku/CuccGoodsSkuList.html?factoryid=xxx&currentPage='+page+'&pageSize='+size;
        },
        changePagesize:function(ps){//修改每页的条数
            window.location.href = '${basePath}/system/CuccGoodsSku/CuccGoodsSkuList.html?factoryid=xxx&currentPage='+1+'&pageSize='+ps;
        }
    });

    //var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
    var dataCount = {
            labels : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
            datasets : [
                {
                    label: '订单数量',
                    backgroundColor : 'rgba(33,150,243,0.8)',
                    borderColor : 'rgba(220,220,220,0.8)',
                    highlightFill: 'rgba(220,220,220,0.75)',
                    highlightStroke: 'rgba(220,220,220,1)',
                    data : ["$!orderNum[0]","$!orderNum[1]","$!orderNum[2]","$!orderNum[3]","$!orderNum[4]","$!orderNum[5]","$!orderNum[6]",
                        "$!orderNum[7]","$!orderNum[8]","$!orderNum[9]","$!orderNum[10]","$!orderNum[11]"]
                }
            ]
        },
        dataAmount = {
            labels : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
            datasets : [
                {
                    label: '金额（元）',
                    backgroundColor : 'rgba(220,220,220,0.8)',
                    borderColor : 'rgba(220,220,220,0.8)',
                    highlightFill: 'rgba(220,220,220,0.75)',
                    highlightStroke: 'rgba(220,220,220,1)',
                    data : ["$!orderAmount[0]","$!orderAmount[1]","$!orderAmount[2]","$!orderAmount[3]","$!orderAmount[4]","$!orderAmount[5]","$!orderAmount[6]", "$!orderAmount[7]","$!orderAmount[8]","$!orderAmount[9]","$!orderAmount[10]","$!orderAmount[11]"]
                }
            ]
        }
    var ctx = document.getElementById('orderCount'),
        ctx1 = document.getElementById('orderAmount');
    var chart = new Chart(ctx, {
        type: 'bar',
        data: dataCount,
        options: {
            responsive: true,
        }
    });
    var chart1 = new Chart(ctx1, {
        type: 'bar',
        data: dataAmount,
        options: {
            responsive: true,
        }
    });

    $('.bar-switch span').click(function () {
        var index=$(this).index();
        if( !$(this).hasClass('on') ){
            if( index == 0 ){
                $('#orderCount').parents('.card-block').removeClass('hidden');
                $('#orderAmount').parents('.card-block').addClass('hidden');
            }else if( index == 1 ){
                $('#orderCount').parents('.card-block').addClass('hidden');
                $('#orderAmount').parents('.card-block').removeClass('hidden');
            }
            $('.bar-switch span').removeClass('on');
            $(this).addClass('on');
        }
    })
    $("#orderQuery").click(function (){
        var year = $("#year").val();
        var factoryId = $("#factoryId").val();
        $.ajax({
            type:"POST",
            url:"${basePath}/system/CuccAdmin/orderQuery.html",
            data:{year:year,factoryId:factoryId},
            success: function(data){
                var json = JSON.parse(data);
                dataCount = {
                    labels : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
                    datasets : [
                        {
                            label: '订单数量',
                            backgroundColor : 'rgba(33,150,243,0.8)',
                            borderColor : 'rgba(220,220,220,0.8)',
                            highlightFill: 'rgba(220,220,220,0.75)',
                            highlightStroke: 'rgba(220,220,220,1)',
                            data : [json.orderNum[0],json.orderNum[1],json.orderNum[2],json.orderNum[3],json.orderNum[4],json.orderNum[5],json.orderNum[6],
                                json.orderNum[7],json.orderNum[8],json.orderNum[9],json.orderNum[10],json.orderNum[11]]
                        }
                    ]
                }
                dataAmount = {
                    labels : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
                    datasets : [
                        {
                            label: '金额（元）',
                            backgroundColor : 'rgba(220,220,220,0.8)',
                            borderColor : 'rgba(220,220,220,0.8)',
                            highlightFill: 'rgba(220,220,220,0.75)',
                            highlightStroke: 'rgba(220,220,220,1)',
                            data : [json.orderAmount[0],json.orderAmount[1],json.orderAmount[2],json.orderAmount[3],json.orderAmount[4],json.orderAmount[5],json.orderAmount[6],json.orderAmount[7],json.orderAmount[8],json.orderAmount[9],json.orderAmount[10],json.orderAmount[11]]
                        }
                    ]
                }
                var canvasCount = $('<canvas>').attr('id','orderCount'),
                    canvasAmount = $('<canvas>').attr('id','orderAmount');
                $('#orderCount').remove();
                $('#orderAmount').remove();
                $('#canCount').append(canvasCount);
                $('#canAmount').append(canvasAmount);
                var ctxCount = document.getElementById('orderCount'),
                    ctxAmount = document.getElementById('orderAmount');

                var chartCount = new Chart(ctxCount, {
                    type: 'bar',
                    data: dataCount,
                    options: {
                        responsive: true
                    }
                });
                var chartAmount = new Chart(ctxAmount, {
                    type: 'bar',
                    data: dataAmount,
                    options: {
                        responsive: true
                    }
                });
            }
        });
    });
</script>

</body>
</html>