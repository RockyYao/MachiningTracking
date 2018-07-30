<%@page import="com.oechsler.common.utils.BrowseTool"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="st"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<c:set var="basePath" scope="request" value="${pageContext.request.contextPath}" />

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Qiu Le Qi">
<link rel="shortcut icon" href="${basePath}/resources/img/otc_logo.jpg">
<link rel="stylesheet" href="${basePath}/res/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${basePath}/res/bootstrap/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${basePath}/res/css/font-awesome.min.css">
<!--[if IE 7]>
<link rel="stylesheet" href="${basePath}/res/css/font-awesome-ie7.min.css">
<![endif]-->
<%--<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">--%>
<%--<link href="//netdna.bootstrapcdn.com/font-awesome/3.1.1/css/font-awesome.css" rel="stylesheet">--%>
<link rel="stylesheet" href="${basePath}/res/css/bootstrap-responsive.min.css">
<link rel="stylesheet" href="${basePath}/res/css/bootstrap-fileupload.css">
<link rel="stylesheet" href="${basePath}/res/css/bootstrap_datatables.css">
<link rel="stylesheet" href="${basePath}/res/css/daterangepicker-bs3.css">
<link rel="stylesheet" href="${basePath}/res/css/bootstrap-datetimepicker.min.css">

<link rel="stylesheet" href="${basePath}/res/css/alertify.core.css">
<link rel="stylesheet" href="${basePath}/res/css/alertify.default.css">
<link rel="stylesheet" href="${basePath}/res/css/jquery.pnotify.default.css">
<link rel="stylesheet" href="${basePath}/res/css/fineuploader-3.6.4.css">
<%--<link rel="stylesheet" href="${basePath}/res/css/alertify.bootstrap.css">--%>
<link rel="stylesheet" href="${basePath}/res/css/blueimp-gallery.min.css">
<link rel="stylesheet" href="${basePath}/res/css/bootstrap-image-gallery.min.css">

<link rel="stylesheet" href="${basePath}/res/css/dropzone.css">


 <%
 	String userAgent = request.getHeader("User-Agent");
 	boolean isIE6 = BrowseTool.IE6.equals(BrowseTool.checkBrowse(userAgent));
 	boolean isIE7 = BrowseTool.IE7.equals(BrowseTool.checkBrowse(userAgent));
 	boolean isIE = BrowseTool.checkBrowse(userAgent).startsWith("MSIE");
 %>
 <script type="text/javascript">
<!--
var isIE6 = <%=isIE6%>;
var isIE7 = <%=isIE7%>;
var isIE = <%=isIE%>;
//-->
</script>
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
<script src="${basePath}/res/assets/js/html5shiv.js"></script>
<script src="${basePath}/res/assets/js/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="${basePath}/res/js/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" href="${basePath}/res/css/style.css">
<link rel="stylesheet" href="${basePath}/res/css/paper_style.css">
<link rel="stylesheet" href="${basePath}/res/css/sb-admin.css">



<link rel="stylesheet" type="text/css" media="print" href="${basePath}/res/css/print.css" />
    <style>
        html,body {
            padding-top: 0px;
            background-color: #FFFFFF;
        }
        .bs-docs-nav {
            background-image: url("${basePath}/res/img/logo_bg.png");
            height:167px;
            background-repeat:  no-repeat;         
        }
        .menu-group .btn{
        	width: 100%;
        	margin:1px;
        }
        .nav-pills>li>a {
            background-color: RGB(68,68,68);
            color: #FFFFFF;
		}
        .center {
            text-align: center;
        }
        
        .footer_information {
            text-align: center;
            color:#A9A9A9;
        }
        
        .no-radius{
        	margin:0; 
        	border:0px none; 
        	border-bottom-left-radius: 0px; 
        	border-bottom-right-radius: 0px;
        	border-top-left-radius: 0px; 
        	border-top-right-radius: 0px;
        }
        .breadcrumb>li+li:before {
			padding: 0 5px;
			color: #ccc;
			content: "";
		}
		
		 label.error {
			/* remove the next line when you have trouble in IE6 with labels in list */
			color: red;
			font-style: italic
		}
		
		.radio-div{
			padding-top: 7px;
		}
    </style>
    