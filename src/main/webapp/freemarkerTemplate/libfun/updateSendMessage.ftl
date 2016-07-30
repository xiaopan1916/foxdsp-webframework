
<script src="/static_v2/wysihtml/wysihtml-toolbar.min.js"></script>
<script src="/static_v2/wysihtml/advanced_unwrap.js"></script>
<form class="form-horizontal" id="editForm">
    <p class="libfun-editform-alert text-danger"></p>
    <input type="hidden" name="editObj.seqid" value="${notifySend.seqid}">
    <div class="form-group">
        <label for="media" class="control-label col-md-3"><span style="color:red;margin-left:5px;">*</span>接收账号</label>
        <input type="hidden" name="editObj.receiver_userlogno" id="hiddenUserLogNo" value="${(notifySend.receiver_userlogno)!''}"/>
        <div class="col-md-9">
            <select id="userlognoselect" class="selectpicker" multiple data-live-search="true"
                    data-live-search-placeholder="Search" data-actions-box="true">
            <#--<#if userLogNos?exists>-->
                <#list userses as user>
                    <#assign hasUserLog = "false" >
                    <#list userLogNos as key>
                        <#if user.userlogno == key> <#assign hasUserLog = "true" > </#if>
                    </#list>
                     <#if hasUserLog == "true">
                            <option selected value="${user.userlogno}">${user.userlogno}</option>
                        <#else>
                            <option  value="${user.userlogno}">${user.userlogno}
                     </#if>

                </#list>
            <#--</#if>-->
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="playdatestart" class="col-md-3 control-label"><span style="color:red;margin-left:5px;">*</span>消息标题</label>

        <div class="col-md-9">
            <input type="text" class="form-control" id="title"
                   name="editObj.title" value="${notifySend.title}">
        </div>
    </div>
    <div class="form-group">
        <label for="playdatestart" class="col-md-3 control-label">
            <span style="color:red;margin-left:5px;">*</span>消息内容</label>
        <div class="col-md-9">
            <div class="toolbar" id="toolbar" style="display: none;">
                <a data-wysihtml5-command="createLink">link</a> |
                <a data-wysihtml5-command="removeLink"><s>link</s></a>
                <div data-wysihtml5-dialog="createLink" style="display: none;">
                    <label>
                        Link:
                        <input data-wysihtml5-dialog-field="href" value="http://">
                    </label>
                    <a data-wysihtml5-dialog-action="save">OK</a>&nbsp;<a data-wysihtml5-dialog-action="cancel">Cancel</a>
                </div>
                </div>
            <textarea class="textarea" class="form-control" name="editObj.send_content" id="editor1">${notifySend.send_content}</textarea>

        </div>
    </div>

    <div class="form-group">
        <label for="" class="col-md-3 control-label">置顶显示</label>
        <div class="col-md-9">
            <input type="checkbox" name="top" id="istop" <#if notifySend.is_top> checked <#else ></#if>
                   value="">
            <input type="hidden" name="editObj.is_top" id="topValue"  <#if notifySend.is_top> value="1" <#else > value="0" </#if> >
        </div>
    </div>
    <div class="form-group">
        <label for="" class="col-md-3 control-label">定点发送</label>
        <div class="col-md-1">
            <input type="checkbox" name="isSendTime" id="isSendTime"
            <#if (notifySend.send_time)??> checked value="1" <#else > value="0" </#if> >
            <input type="hidden" name="sendSentinel" id="sendSentinel"  <#if (notifySend.send_time)??> checked value="1" <#else > value="0" </#if> >
        </div>
        <div class=" input-group date" id="playdateend"  <#if (notifySend.send_time)??>  <#else > style="display: none;"  </#if> >

            <input type="text"  class="form-control"
                   name="editObj.send_time"  id="sendTime" value="${(notifySend.send_time)!''}">
                             <span  class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>

        </div>


</form>
<script>
    $('#istop').click(function () {
        var check = $("input[name='top']:checkbox");
        if(!check.prop("checked")) {
            $('#topValue').val("0");
        }else{
            $('#topValue').val("1");
        }
    });
    $('#isSendTime').click(function () {
        var check = $("input[name='isSendTime']:checkbox");
        if(!check.prop("checked")) {
            $('#playdateend').hide();
            $('#sendSentinel').val("0");
            $('#sendTime').val("");
        }else{
            $('#playdateend').show();
            $('#sendSentinel').val("1");
        }
    });
    $('.selectpicker').selectpicker();
    $('#userlognoselect').on('hidden.bs.select', function (e) {
        var val = $('#userlognoselect').val();
        if(val) {
            $('#hiddenUserLogNo').val(val.join(","));
        }else {
            $('#hiddenUserLogNo').val("");
        }
    });

    var editor = new wysihtml5.Editor("editor1", { // id of textarea element
        toolbar:      "toolbar", // id of toolbar element
        parserRules:  wysihtml5ParserRules // defined in parser rules set
    });

    $('#playdateend').datetimepicker({
        format: "yyyy-mm-dd hh:ii:00",
        todayBtn: true,
        clearBtn: true,
        language: "zh-CN",
        autoclose: true,
        todayHighlight: true
    });
</script>