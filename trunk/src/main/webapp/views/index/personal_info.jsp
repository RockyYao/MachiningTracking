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
</head>
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
<c:import url="/index/head.htm"/>

<div class="app-body">
    <c:import url="/index/leftNav.htm"/>
    <main class="main">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">首页</li>
            <li class="breadcrumb-item active">个人资料</li>
        </ol>
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <strong style="font-size:17px;font-weight:700;vertical-align: -1px;margin-right:5px">☰</strong>个人资料
                </div>
                <div class="card-block">
                    <form id="mainForm" method="post" class="form-horizontal" action="${basePath}/user/editUser.htm"
                          enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${user.id}">
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="workNo">工号/Work No</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="workNo" name="workNo" class="form-control"
                                       value="${user.workNo}">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="userName">用户名/Name</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="userName" name="userName" class="form-control"
                                       value="${user.userName}" readonly>
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class">头像/Favicon</label>
                            <div class="col-sm-6  goods_but ">
                                <div class="ncsc-upload-thumb store-logo">
                                    <p>
                                        <c:set var="headImage" value="${basePath}/resources/img/u18523.png"/>
                                        <c:if test="${user.headPortrait ne null && user.headPortrait ne ''}">
                                            <c:set var="headImage" value="${user.headPortrait}"/>
                                        </c:if>
                                        <img id="preview" style="width: 150px;height: 150px" src="${headImage}"/>
                                    </p>
                                </div>
                                <div class="ncsc-upload-btn">
                                    <a href="javascript:void(0);">
                                        <span>
                                            <input hidefocus="true" size="1" class="input-file"
                                                   name="headImg" id="headImg" nc_type="change_store_banner" type="file">
                                        </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="enName">英文名/EN Name</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="enName" name="enName" class="form-control"
                                       value="${user.enName}">
                                <span class="goods_icon">*</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="chName">中文名/CN Name</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="text" id="chName" name="chName" class="form-control"
                                       value="${user.chName}">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class" for="birthdayPram">生日/Birthday</label>
                            <div class="col-sm-6  goods_but ">
                                <input name="birthdayPram" type="text" class="inline laydate-icon" id="birthdayPram"
                                       value="<fmt:formatDate value='${user.birthday}' pattern="yyyy-MM-dd"/>"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label l_class">性别/Sex</label>
                            <div class="col-sm-6  goods_but ">
                                <input type="radio" name="gender" value="1" style="margin-top: 15px"
                                       <c:if test="${user.gender eq 1}">checked="checked"</c:if> >男/male
                                <input type="radio" name="gender" value="2" style="margin-left: 10%"
                                       <c:if test="${user.gender eq 2}">checked="checked"</c:if>>女/famale
                            </div>
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <button id="submitBtn" type="submit" class="btn btn-sm btn-primary" onclick="saveUser()"><i
                            class="fa fa-dot-circle-o"></i> 确认/Confirm
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
<script src="${basePath}/resources/js/date/laydate.js"></script><!--日期插件-->
<script src="${basePath}/resources/js/views/main.js"></script>
<script src="${basePath}/resources/js/views/reset.js"></script><!--form重置-->
<script src="${basePath}/resources/js/dialog2.js"></script>
<script src="${basePath}/resources/js/alert.js"></script>
<script>
    function saveUser() {
        if (check()) {
            $.ajax({
                url: '${basePath}/user/checkUserInfo.htm',
                type: 'post',
                data: {"userName": $("#userName").val(), "workNo": $("#workNo").val(),"id":${user.id}},
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        $("#mainForm").submit();
                    } else {
                        alertTip("用户名或工号已存在");
                    }
                }
            })
        }
    }

    function check() {
        var workNo = $("#workNo").val();
        if (workNo == "") {
            alertTip("请输入工号");
            return false;
        }
        var enName = $("#enName").val();
        if (enName == "") {
            alertTip("请输入英文名");
            return false;
        }
        return true;
    }

    //日期
    (function () {
        !function () {
            laydate.skin('danlan');//切换皮肤，请查看skins下面皮肤库
            // laydate({elem: '#demo'});//绑定元素
        }();

        //日期范围限制
        var start = {
            elem: '#birthdayPram',
            format: 'YYYY-MM-DD',
//            min: laydate.now(), //设定最小日期为当前日期
            max: '2099-06-16', //最大日期
            istime: true,
            istoday: false,
            choose: function (datas) {

            }
        };
        laydate(start);
    })();

    document.getElementById('headImg').onchange = function (evt) {
        // 如果浏览器不支持FileReader，则不处理
        if (!window.FileReader) return;
        var files = evt.target.files;
        for (var i = 0, f; f = files[i]; i++) {
            if (!f.type.match('image.*')) {
                continue;
            }
            var reader = new FileReader();
            reader.onload = (function (theFile) {
                return function (e) {
                    // img 元素
                    document.getElementById('preview').src = e.target.result;
                };
            })(f);
            reader.readAsDataURL(f);
        }
    }
</script>
</body>
</html>