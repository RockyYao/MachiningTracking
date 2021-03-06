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
                <a href="#">权限</a>
            </li>
            <li class="breadcrumb-item active">角色管理</li>
        </ol>
        <div class="container-fluid">
            <div class="goods_cate">
                <!--搜索  -->
                <form method="post" id="queryForm" name="queryForm" action="${basePath}/role/roleList.htm">
                    <a href="${basePath}/role/addRole.htm" class="g_newAdd" title="Add User">添加角色</a>
                    <div class="lzf_qm_seach">
                        <table border="0">
                            <tbody>
                            <tr>
                                <td>
                                    <input name="name" type="text" id="name"
                                           value="${role.name}" placeholder="角色名称/role name">
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
                <table border="0" width="100%" class="g_tab" id="j_checktab">
                    <thead>
                    <tr>
                        <th style="width:50px;"></th>
                        <th style="width:50px; white-space:nowrap;">序号/No</th>
                        <th>名称/Name</th>
                        <th width="40%">操作/Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${rolePageResult.data.size() gt 0}">
                            <c:forEach items="${rolePageResult.data}" var="role" varStatus="vs">
                                <tr>
                                    <td>
                                        <c:if test="${role.name ne '管理员' && role.id ne userRole.id}">
                                            <input type="checkbox" class="check" name="ids" value="${role.id}">
                                        </c:if>
                                    </td>
                                    <td>${vs.index+1}</td>
                                    <td>${role.name}</td>
                                    <td>
                                        <c:if test="${role.name ne '管理员' && role.id ne userRole.id}">
                                            <a href="${basePath}/role/editRole.htm?id=${role.id}" title="alter">修改</a>
                                            <a href="${basePath}/permission/rolePermissionEdit.htm?roleId=${role.id}" title="user provisioning">权限分配</a>
                                            <a href="javascript:void(0)" onclick="deleteRole(${role.id})" title="del">删除</a>
                                        </c:if>
                                        <c:if test="${role.name eq '管理员' || role.id eq userRole.id}">
                                            <span style="font-weight: bold;color: red">无法操作</span>
                                        </c:if>
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
                    <a href="#" class="j_alldele" onclick="batchDelete('${basePath}/role/batchDeleteRole.htm')" title="delete in batches">批量删除</a>
                </p>
            </div>
            <div id="pageToolbar" <c:if test="${rolePageResult.data.size() eq 0}">class="hidden" </c:if>></div>
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
        pagesize: parseInt(${rolePageResult.pageSize}),
        count: parseInt(${rolePageResult.totalRows}),
        current: parseInt(${rolePageResult.pageIndex}),
        toolbar: true,//是否显示工具栏
        pageSizeList: [10, 20, 50, 100],//可设置每页条数，默认为[5,10,15,20]
        callback: function (page, size, count) {//page为当前页码,size为每页条数，count为总页数
            window.location.href = '${basePath}/role/roleList.htm?currentPage=' + page + '&pageSize=' + size;
        },
        changePagesize: function (ps) {//修改每页的条数
            window.location.href = '${basePath}/role/roleList.htm?currentPage=' + 1 + '&pageSize=' + ps;
        }
    });

    function deleteRole(id){
        confirmAlert("确定删除该角色吗？",'${basePath}/role/deleteRole.htm?id='+id);
    }
</script>
</body>
</html>