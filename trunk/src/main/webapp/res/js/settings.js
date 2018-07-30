/**
 * Created with IntelliJ IDEA.
 * User: Qiu Le Qi
 * Date: 13-6-18
 * Time: 下午1:15
 * To change this template use File | Settings | File Templates.
 */
function loadAccountList(){
    ajaxRefreshAsync("container", "/settings/searchAccount");
}
function removeAccount(id){
    if(confirm("是否删除账号？")){
        sendSimpleAjaxRequestAsync("/settings/removeAccount/"+id, '', function(){
            loadAccountList();
        });
    }
}
function showPasswordDialog(id){
    $('#account_dialog').modal({remote:"goUpdatePassword/"+id});
}
function changePassword(){
    sendAjaxRequestAsync("/settings/changePassword", "accountDialogForm", '', function(){
        alert("密码已修改成功!");
        $('#account_dialog').modal('hide');
        loadAccountList();
    });
}
function goToEdit(id){
    location.href="/settings/showAccount/"+id;
}
function viewAccount(id){
    location.href="/settings/viewAccount/"+id;
}
function saveOrUpdateAccount(){
    if(confirm("是否确定保存账号？")){
        sendAjaxRequestAsync('/settings/saveOrUpdateAccount', 'accountForm', '', function(){
            var checked = $('#continueCK').is(":checked");
            if(checked){
                goToEdit(0);
            }else{
                backToAccount();
            }
        });
    }
}
function backToAccount(){
    location.href="/settings/account";
}