function searchMenuCatg(){
    ajaxRefreshAsync('menuCatgList', 'searchMenuCatg', 'menuCatgCriteriaForm', '', function(){
        initPopover();
    });
}
function searchMenuItem(){
    ajaxRefreshAsync('menuItemList', 'searchMenuItem', 'menuItemCriteriaForm', '', function(){
//        $('input.radioImageSelect').radioImageSelect();
    });
}
function initPopover(){
    $('[rel="clickover"]').clickover({
        width: 532,
        placement: "bottom",
        onShown: function(){
            var action = this.options.poload;
            var target = $("div.clickover").find("div.popover-content");
            target.html("内容加载中...");
            $.ajax({
                type:"POST",
                url:action,
                data:"",
                async:true,
                success:function(response){
                    target.html(response);
                }
            });
        }
    });
}
function saveMenuCatg(){
    $('#menuCatgForm').attr("action","saveOrUpdateMenuCatg");
    $('#menuCatgForm').ajaxSubmit({
        success:function(){ //alert('success');
            $('#menuCatgDialog').modal('hide');
            searchMenuCatg();
        }
    });
}
function deleteMenuCatg(catgId){
    $("#confirmDiv").confirmModal({
        heading: '删除',
        body: '删除类型时属于该类下面的所有菜色信息也将被删除，确定要删除该类吗？',
        callback: function () {
            sendSimpleAjaxRequestAsync('deleteMenuCatg/'+catgId, '', function(){
                searchMenuCatg();
            });
        }
    });
}

function saveMenuItem(){
    $('#menuItemDialogForm').attr('action','saveOrUpdateMenuItem');
    $('#menuItemDialogForm').ajaxSubmit({
        success:function(){
            $('#menuItemDialog').modal('hide');
            searchMenuItem();
        }
    });
    return false;

}
function deleteMenuItem(itemId){
    $("#confirmDiv").confirmModal({
        heading: '删除',
        body: '确定要删除信息吗？',
        callback: function () {
            sendSimpleAjaxRequestAsync('deleteMenuItem/'+itemId, '', function(){
                searchMenuItem();
            });
        }
    });
}

function checkItemRecommend(obj, itemId){
    sendSimpleAjaxRequestAsync('checkItemRecommend', 'checked='+obj.checked+'&itemId='+itemId);
}

function setThumbnail(menuId, imageId){
    sendSimpleAjaxRequestAsync('setThumbnail', 'menuId='+menuId+'&imageId='+imageId, function(){

    });
}

function goToImageUpload(id){
    location.href = context+"/menuMtn/menuImageList/"+id;
}

/*



function loadAllMenuCatgs(){
    ajaxRefreshAsync('container', 'loadAllMenuCatgs', '', '', function(){});
    $('#newMenuCatgButton').show();
    $('#newMenuItemButton').hide();
}
function loadAllMenuItems(){
    ajaxRefreshAsync('container', 'loadAllMenuItems', '', '', function(){});
    $('#newMenuCatgButton').hide();
    $('#newMenuItemButton').show();
}

function saveMenuCatg(){
    $('#menuCatgForm').attr("action","saveMenuCatg");
    $('#menuCatgForm').ajaxSubmit({
        success:function(){
            loadAllMenuCatgs();
            $('#menuCatgDialog').modal('hide');
        }
    });
}

function deleteMenuCatg(catgId){
    $("#confirmDiv").confirmModal({
        heading: '删除',
        body: '确定要删除该类吗？',
        callback: function () {
            sendSimpleAjaxRequestAsync('deleteMenuCatg/'+catgId, '', function(){
                loadAllMenuCatgs();
            });
        }
    });
}

// ===============================================

function loadMenuItems(){
    var catgId = $('#menuCatgId').val();
    if(catgId==undefined||catgId=='')
        catgId = '';
    ajaxRefreshAsync('menuItemList', 'loadMenuItem/'+catgId, 'menuItemForm', '', function(){});
}

function loadMenuItemDialog(){
    ajaxRefreshAsync('menuItemDialogBody', 'loadMenuItemDialog', '', '', function(){
        $('#processing').hide();
        $('#menuItemForm').ajaxForm(function() {
            loadMenuItem();
            if(!$('#continue').attr("checked")){
                $('#menuItemDialog').modal('hide');
            }else{
                loadMenuItemDialog();
            }
        });
    });
}
function saveMenuItem(){
    $('#menuItemDialogForm').attr('action','saveMenuItem');
    $('#menuItemDialogForm').ajaxSubmit({
        success:function(){
            loadMenuItems();
            $('#menuItemDialog').modal('hide');
        }
    });
    return false;

}
function deleteMenuItem(itemId){
    $("#confirmDiv").confirmModal({
        heading: '删除',
        body: '确定要删除信息吗？',
        callback: function () {
            sendSimpleAjaxRequestAsync('deleteMenuItem', 'itemId='+itemId, function(){
                loadMenuItems();
            });
        }
    });
}*/
