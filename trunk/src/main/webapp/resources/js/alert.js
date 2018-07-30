function alertTip(message) {
    kalert({
        title:"提示",
        content:message,
        ctext:"取消",
        stext:"确定",
        dCancel:'hidden',
        callback:function(ok){

        }
    });
}

function confirmAlert(message,url) {
    kalert({
        title:"提示",
        content:message,
        ctext:"取消",
        stext:"确定",
        dCancel:'show',
        callback:function(ok){
            if(ok){
                window.location.href = url;
            }
        }
    });
}

function alertReload(message) {
    kalert({
        title:"提示",
        content:message,
        ctext:"取消",
        stext:"确定",
        dCancel:'hidden',
        callback:function(ok){
            window.location.reload();
        }
    });
}