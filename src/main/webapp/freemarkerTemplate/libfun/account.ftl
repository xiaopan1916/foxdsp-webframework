<#assign pageTitle= "账号设置" >
<#assign pageUrl="/jf/libfun/user/account">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName=pageUrl ></@bread.breadcrumb>
<div class="panel panel-default">
    <div class="panel-body">
            <form>
                <div class="form-group" style="width: 30%">
                    <label for="userlogno">账号：</label>
                    <input type="hidden" class="form-control" value="${users.seqid}" id="seqid" readonly="readonly">
                    <input type="text" value="${users.userlogno}" class="form-control" id="userlogno" readonly="readonly">
                </div>
                <div class="form-group" style="width: 30%">
                    <label for="newpassword1">新密码：</label>
                    <input type="password" class="form-control" id="newpassword1" name="" placeholder="新密码">
                </div>
                <div class="form-group" style="width: 30%">
                    <label for="newpassword2">确认密码：</label>
                    <input type="password" class="form-control" id="newpassword2" name="" placeholder="确认密码">
                </div>
                <div class="form-group" id="emailList" style="width: 30%">
                    <label for="addEmail">邮箱：</label>
                    <#--<button type="button" id="addEmail" class="btn btn-default">添加邮箱</button>-->
                </div>

                <div class="form-group" id="emailTemplate" style="display: none;">
                    <input type="text" class="form-control" name="email[]"  placeholder="请输入新的邮箱账号">
                    <#--<button type="button" name="deleteEmail" onclick="$(this).parent().remove();" class="btn btn-default">删除邮箱</button>-->
                </div>
                <button type="button" id = "saveButton" class="btn btn-primary">确认修改</button>
            </form>
            <br>
            <br>
            <br>
            <#--<form>-->
                <#--<input type="hidden" class="form-control" value="${usersExt.seqid}" id="pinciSeqid" readonly="readonly">-->
                <#--<label for="addEmail">监控报告发送频次：</label><br>-->
                <#--<label class="checkbox-inline">-->
                    <#--<input <#if (usersExt.daily)!'' > checked="checked" </#if> type="checkbox" id="daily"> 每天-->
                <#--</label>-->
                <#--<label class="checkbox-inline">-->
                    <#--<input type="checkbox"  <#if (usersExt.weekly)!'' > checked="checked" </#if>  id="weekly"> 每周-->
                <#--</label>-->
                <#--<label class="checkbox-inline">-->
                    <#--<input type="checkbox"  <#if (usersExt.activityOver)!'' > checked="checked" </#if>  id="activityOver"> 活动结束-->
                <#--</label><br><br>-->
                <#--<button type="button" id = "savePinCiButton" class="btn btn-primary">提交</button>-->
            <#--</form>-->
        </div>
</div> <!-- /container -->

<script>
    $(document).ready(function(){
        var emailArray =${emailArray};
        $.each(emailArray, function(index, value) {
            var newEmailNode = $('#emailTemplate').clone();
            newEmailNode.attr("id","");
            newEmailNode.css("display","block");
            newEmailNode.children("input").val(value);
            newEmailNode.children("input").attr("name","email[]");
            newEmailNode.appendTo('#emailList');
        });
    });
    // 点击添加邮箱按钮
    $("#addEmail").click(function () {
        var newEmailNode = $('#emailTemplate').clone();
        newEmailNode.attr("id","");
        newEmailNode.css("display","block");
        newEmailNode.children("input").attr("name","email[]");
        newEmailNode.appendTo('#emailList');
    });
    // 修改用户信息
    $("#saveButton").button().click(function (){
        // 如果输入了旧密码和新密码，则判断输入的新密码是否相同，旧密码是否正确
        if( ! verifyNewPassword()){
            return;
        }
        var seqid = $("#seqid").val();
        var userlogno = $("#userlogno").val();
        // 获取邮箱的值
        var emailArr = new Array();
        $("input[name='email[]']").each(function(i){
            if($(this).val() != ""){
                emailArr[i] = $(this).val();
            }
        });
        var email ;
        if(emailArr.length > 1){
            email = emailArr.join();
        }else if(emailArr.length == 1){
            email = emailArr[0];
        }

        if(email == null || email == ""){
            alert("邮箱不能为空。");
            return false;
        }
        var newpassword1 = $("#newpassword1").val();

        $.ajax({
                    url:'updateCustomerInfo',
                    type:'POST',
                    data:{
                        seqid: seqid,
                        userlogno: userlogno,
                        email: email,
                        userpassword: newpassword1
                    },
                    success:function(data){
                        if (data.code == '0') {
                            libfun.alert("修改成功");
                            // 如果修改了密码，则自动注销用户
                            if(newpassword1 != ""){
                                $("#logoutBtn").trigger("click");
                            }
                        } else {
                            libfun.alert(data.message);
                        }
                    },
                    error: function (data) {
                        libfun.alert("暂时无法显示，稍后再来！");
                    }
                });
    });
    // 修改用户扩展信息
    $("#savePinCiButton").button().click(function (){
        $.ajax({
                    url:'updateUserExt',
                    type:'POST',
                    data:{
                        seqid: $("#pinciSeqid").val(),
                        usersId: $("#seqid").val(),
                        daily: $("#daily").prop("checked"),
                        weekly:$("#weekly").prop("checked"),
                        activityOver: $("#activityOver").prop("checked")
                    },
                    success:function(data){
                        if (data.code == '0') {
                            libfun.alert("修改成功");
                        } else {
                            libfun.alert(data.message);
                        }

                    },
                    error: function (data) {
                        libfun.alert("暂时无法显示，稍后再来！");

                    }
                });
    });

    /**
     * 验证输入的原密码是否正确。
     * @returns {boolean}
     */
    function verifyNewPassword(){
        var v1 = $('#newpassword1').val();
        var v2 = $('#newpassword2').val();
        if(v1 == null || v1 == ""){
            // 不修改密码
            return true;
        }

        if(v1 != v2) {
            alert('两次输入的密码不一样.');
            return false;
        }
        if(v1.length < 4) {
            alert('密码长度不能小于4位.');
            return false;
        }
//        var oldPassword = $('#oldpassword').val();
//        if( oldPassword == null || oldPassword == "") {
//            alert('旧密码不能为空.');
//            return false;
//        }
        return true;
    }
</script>
<#include "/freemarkerTemplate/common/footer.ftl">