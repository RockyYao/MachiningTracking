(function(){
    selectAll('check-all','check');
    selectItem('check-all','check');
    function selectAll(id,className){//全选
        var seletAllBtnDom = document.getElementById(id);
        var checkItem = document.getElementsByClassName(className)
        seletAllBtnDom.onclick = function(){
            var isChecked = this.checked;
            for(var i in checkItem){
                isChecked?checkItem[i].checked = true:checkItem[i].checked=false;
            }
        }
        //seletAllBtnDom.checked = true;
        seletAllBtnDom.onclick();
    }
    function selectItem(id,className){
        var checkItem = document.getElementsByClassName(className);
        var seletAllBtnDom = document.getElementById(id);
        for(var i=0;i<checkItem.length;i++){
            checkItem[i].onclick = function(){
                var k = 0;
                for(var j=0;j<checkItem.length;j++){
                    if(checkItem[j].checked){
                        k++;
                    }
                    if(k == checkItem.length){
                        seletAllBtnDom.checked = true;
                    }else{
                        seletAllBtnDom.checked = false;
                    }
                }

            }
        }
    }
    //单个删除
    function dialog(txt,url){
        kalert({
            title:"提示",
            content:txt,
            ctext:"取消",
            stext:"确定",
            dCancel:'show',
            callback:function(ok){
                if( ok ){
                    window.location.href = url;
                }
            }
        });
    };
})();

function batchDelete(url) {
    var ids = '';
    if($(".check").is(':checked')){
        kalert({
            title:"提示",
            content:'确定删除所选行吗？',
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
            content:'请选择要删除的行！',
            ctext:"取消",
            stext:"确定",
            dCancel:'hidden',
            callback:function(ok){}
        });
    }
}

