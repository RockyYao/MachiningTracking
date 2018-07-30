/**
 * Created with IntelliJ IDEA.
 * User: Qiu Le Qi
 * Date: 13-5-9
 * Time: 下午1:07
 * To change this template use File | Settings | File Templates.
 */
function ajaxRefresh(targetId, action, formId, data, callback, async){
    var isAsync = false;
    if(async!=undefined&&async!=null){
        isAsync = async;
    }
    var paramsData = $('#'+formId).serialize();
    if(data != null && data != undefined){
        var arr = data.split("&");
        for(var i = 0; i < arr.length; i++){
            var tmpArr = arr[i].split("=");
            paramsData += "&" + tmpArr[0] + "=" + encodeURIComponent(tmpArr[1]);

        }
    }
//    $('#'+targetId).empty();
//    $('#'+targetId).append("<div id='" + targetId + "Process' class='offset5 loading_medium'></div>");
    $.ajax({
        type:"POST",
        url:action,
        data:paramsData,
        async:isAsync,
        success:function(response){ //       alert(response);
            $('#'+targetId).html(response);
            if(callback!=undefined) callback(response);
        }
    });
}
function ajaxRefreshAsync(targetId, action, formId, data, callback){
    ajaxRefresh(targetId, action, formId, data, callback, true);
}

function sendAjaxRequest(action, formId, queryString, callback,async) {
    var isAsync = false;
    if(async!=undefined&&async!=null){
        isAsync = async;
    }
    //alert(action+(form).serialize());
    try{
    var data = $('#'+formId).serialize()+'&'+queryString;
    $.ajax({
        type:"POST",
        async:isAsync,
        url:action,
        data:data,
        success:function(response){
            if(callback!=undefined) callback(response);
        }
    });
    }catch (e){alert(e)}
}
function sendAjaxRequestAsync(action, formId, queryString, callback){
    sendAjaxRequest(action, formId, queryString, callback, true);
}

function sendSimpleAjaxRequest(action, queryString, callback, async) {
    var isAsync = false;
    if(async!=undefined&&async!=null){
        isAsync = async;
    }
    $.ajax({
        type:"POST",
        async:isAsync,
        url:action,
        data:queryString,
        success:function(response){
            if(callback!=undefined) callback(response);
        }
    });
}
function sendSimpleAjaxRequestAsync(action, queryString, callback){
    sendSimpleAjaxRequest(action, queryString, callback, true);
}

$(function(){

    $("#toggle_modal").on('click', function (e) {
        var destId = $(this).attr('modal_target');
        var modal = $(destId), modalBody = $(destId+' .modal-body');
		var href=$(this).attr('href');
        modal.on('show.bs.modal', function () {
	        	if(href!=''){
		    		modalBody.load(href);
		    	} 
            }).modal();
        modal.on("hidden.bs.modal", function() {
        	href='';
        	modal.removeData("bs.modal");
        });
        e.preventDefault();
	});
});

function toggleModal(btnId){
	var destId = $(btnId).attr('modal_target');
    var modal = $(destId), modalBody = $(destId+' .modal-body');
	var href=$(btnId).attr('href');
    modal.on('show.bs.modal', function () {
	    	if(href!=''){
	    		modalBody.load(href);
	    	}            
        }).modal();
    modal.on("hidden.bs.modal", function() {
    	href='';
    	modal.removeData("bs.modal");
    });
}


function Map() {
 var struct = function(key, value) {
  this.key = key;
  this.value = value;
 }
 
 var put = function(key, value){
  for (var i = 0; i < this.arr.length; i++) {
   if ( this.arr[i].key === key ) {
    this.arr[i].value = value;
    return;
   }
  }
   this.arr[this.arr.length] = new struct(key, value);
 }
 
 var get = function(key) {
  for (var i = 0; i < this.arr.length; i++) {
   if ( this.arr[i].key === key ) {
     return this.arr[i].value;
   }
  }
  return null;
 }
 
 var remove = function(key) {
  var v;
  for (var i = 0; i < this.arr.length; i++) {
   v = this.arr.pop();
   if ( v.key === key ) {
    continue;
   }
   this.arr.unshift(v);
  }
 }
 
 var size = function() {
  return this.arr.length;
 }
 
 var isEmpty = function() {
  return this.arr.length <= 0;
 }
 this.arr = new Array();
 this.get = get;
 this.put = put;
 this.remove = remove;
 this.size = size;
 this.isEmpty = isEmpty;
}