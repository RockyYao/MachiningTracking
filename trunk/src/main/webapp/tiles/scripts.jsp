<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="blueimp-gallery" class="blueimp-gallery">
    <!-- The container for the modal slides -->
    <div class="slides"></div>
    <!-- Controls for the borderless lightbox -->
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
    <!-- The modal dialog, which will be used to wrap the lightbox content -->
    <div class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body next"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left prev">
                        <i class="glyphicon glyphicon-chevron-left"></i>
                        上一张
                    </button>
                    <button type="button" class="btn btn-primary next">
                        下一张
                        <i class="glyphicon glyphicon-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${basePath}/res/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${basePath}/res/js/bootstrap-confirm.js"></script>
<script type="text/javascript" src="${basePath}/res/js/date.js"></script>
<script type="text/javascript" src="${basePath}/res/js/daterangepicker.js"></script>

<script type="text/javascript" src="${basePath}/res/js/moment.js"></script>
<script type="text/javascript" src="${basePath}/res/js/transition.js"></script>
<script type="text/javascript" src="${basePath}/res/js/collapse.js"></script>
<script type="text/javascript" src="${basePath}/res/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${basePath}/res/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script type="text/javascript" src="${basePath}/res/js/bootstrapx-clickover.js"></script>

<%--<script type="text/javascript" src="${basePath}/res/js/alertify.min.js"></script>--%>
<script type="text/javascript" src="${basePath}/res/js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.form.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.atmosphere.js"></script>

<%--<script type="text/javascript" src="${basePath}/res/js/iframe.xss.response-3.6.4.js"></script>--%>
<%--<script type="text/javascript" src="${basePath}/res/js/jquery.fineuploader-3.6.4.min.js"></script>--%>

<script type="text/javascript" src="${basePath}/res/js/jquery.radioImageSelect.min.js"></script>
<%--<script type="text/javascript" src="${basePath}/res/js/jquery.sticky-kit.min.js"></script>--%>
<script type="text/javascript" src="${basePath}/res/js/jquery.sticky-kit.js"></script>
<%--<script type="text/javascript" src="${basePath}/res/js/jquery.lockfixed.min.js"></script>--%>

<%--<script type="text/javascript" src="${basePath}/res/js/socket.io.js"></script>
<script type="text/javascript" src="${basePath}/res/js/application.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.stringifyjson.js"></script>--%>

<script type="text/javascript" src="${basePath}/res/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.dataTables.reloadAjax.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.dataTables-bootstrap.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.desknoty.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.pnotify.min.js"></script>
<%--<script type="text/javascript" src="${basePath}/res/js/jquery.websocket-0.0.1.js"></script>--%>
<script type="text/javascript" src="${basePath}/res/js/jquery.maskMoney.js"></script>
<%--<script type="text/javascript" src="${basePath}/res/js/jquery.matrixMultiFileUpload.js"></script>--%>
<%--<script type="text/javascript" src="${basePath}/res/js/jquery.filedrop.js"></script>--%>

<script type="text/javascript" src="${basePath}/res/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${basePath}/res/js/jquery.validate.message_cn.js"></script>
<%-- <script type="text/javascript" src="${basePath}/res/js/jquery.validate.bootstrap.js"></script> --%>
<%--<script type="text/javascript" src="${basePath}/res/js/jqBootstrapValidation-1.3.7.min.js"></script>--%>

<script type="text/javascript" src="${basePath}/res/js/jquery.blueimp-gallery.min.js"></script>
<script type="text/javascript" src="${basePath}/res/js/bootstrap-image-gallery.min.js"></script>
<script type="text/javascript" src="${basePath}/res/js/load-image.js"></script>

<script type="text/javascript" src="${basePath}/res/js/dropzone.js"></script>

<script type="text/javascript" src="${basePath}/res/js/bootstrap.autocomplete.js"></script>
<script type="text/javascript" src="${basePath}/res/js/common.js"></script>

<script type="text/javascript" src="${basePath}/res/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${basePath}/res/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

	function setSuccess(str){
		$('#success_content').html(str);
		$('#success_div').removeClass("hidden");
	}
	function setError(str){
		$('#error_content').html(str);
		$('#error_div').removeClass("hidden");
	}
	function clearAllMessage(){
		$('#success_div').addClass("hidden");
		$('#error_div').addClass("hidden");
	}
	$(function () {
   		//Add methods need to call while loading finished.
   		<c:if test="${not empty successMessage}">
   			setSuccess('${successMessage}');
   		</c:if>
   		<c:if test="${not empty errorMessage}">
   			setError('${errorMessage}');
		</c:if>
    });
</script>