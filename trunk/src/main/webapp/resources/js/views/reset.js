/**
 * Created by Administrator on 2017/5/26.
 */
//重置
$(function () {
    var cc;
    $('button:reset').click(function () {
        var inputs = $("input[class*='form']");
        // var inputs = $("input[class*='fir_input']");
        var len = inputs.length;
        for (var i = 0; i < len; i++) {
            var vvv = inputs[i].value;
            if (vvv == "") {
                cc = true;
            } else {
                cc = false;
                break;
            }
        }
        if (cc) {
            kalert({
                title: "提示",
                content: "请输入内容",
                ctext: "取消",
                stext: "确定",
                dCancel: 'show',
                callback: function (ok) {
                }
            });
        } else {
            kalert({
                title: "提示",
                content: "确定要重置吗",
                ctext: "取消",
                stext: "确定",
                dCancel: 'show',
                callback: function (ok) {
                    if (ok) {
                        $("form").find($("input")).val("");
                        $("form").find($("input")).attr("value", "")
                    } else {

                    }
                }
            });
        }
        $("input:first").focus();
    });
})