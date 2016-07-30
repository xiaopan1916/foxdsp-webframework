<style>
    .circle {
             width: 8px;
             height: 8px;
             background: red;
             -moz-border-radius: 5px;
             -webkit-border-radius: 5px;
             border-radius: 5px;
         }
</style>
<div id="messagebox">
    <h4 class="pull-left">我的消息</h4>
    <br>
    <div class="panel panel-default libfun-panel">
            <div class="btn-group" role="group" aria-label="...">
                <button type="button" class="tab1 btn btn-default active">系统消息<label id="circletab1" class="circle"></label></button>
                <button type="button" class="tab2 btn btn-default">审核消息<label id="circletab2" class="circle"></label></button>
                <button type="button" class="tab3 btn btn-default">账户消息<label id="circletab3" class="circle"></label></button>
                <input type="hidden" id="pageNo" name="pageNo" value="">
                <input type="hidden" id="type" name="type" value="0">
            </div>
        <div class="panel-body" style="overflow: scroll;max-height: 550px;">
            <button id="delMessage" type="button" class="btn btn-default pull-right">删除</button>
            <p class="libfun-editform-alert text-danger pull-left"></p>
            <table id="messageTable" class="table table-striped" cellspacing="0" width="100%">
                <thead>
                </thead>
            </table>
            <div id="page" class="pull-right">
            </div>
        </div>
    </div>
</div>
<script>
    $('.tab1').click(function () {
        $(this).addClass("active");
        $('.tab2').removeClass("active");
        $('.tab3').removeClass("active");
        updateMessageReadStatus(0);
        $('#type').val(0);
    });
    $('.tab2').click(function () {
        $(this).addClass("active");
        $('.tab1').removeClass("active");
        $('.tab3').removeClass("active");
        updateMessageReadStatus(1);
        $('#type').val(1);
    });
    $('.tab3').click(function () {
        $(this).addClass("active");
        $('.tab1').removeClass("active");
        $('.tab2').removeClass("active");
        updateMessageReadStatus(2);
        $('#type').val(2);
    });

    // 删除
    $("#delMessage").click(function () {
        var messageIds = [];
        $("._checkMessage").each(function () {
            if ($(this).prop("checked")) {
                messageIds.push($(this).val());
            }
        });
        if (messageIds.length == 0) {
            $(".libfun-editform-alert").text("请选择需要删除的消息!").show();
            return false;
        }
        $.ajax({
            url: '/jf/messageList/updateMessageDeleteStatus',
            type: 'GET',
            data: {
                messageIds: messageIds.toString()
            },
            success: function (data) {
                var type = $('#type').val();
                if (data.code == 0) {
                    $(".libfun-editform-alert").text("删除成功").show();
                    searchMessage(1, type);
                } else {
                    $(".libfun-editform-alert").text(data.message).show();
                }

            },
            error: function (data) {
                alert("暂时无法显示，稍后再来！");

            }
        });
    });

    $(document).ready(function(){
        searchMessage(1, 0);
        $("#messagebox").click(function(event) {
            event.stopPropagation();
        });
    });
    function updateMessageReadStatus(type) {
        $.ajax({
            url:'/jf/messageList/updateMessageReadStatus',
            type:'GET',
            cache:false,
            data:{
                type:type

            },
            success:function(data){
                searchMessage(1, type);
            },
            error: function (data) {
                libfun.alert("暂时无法显示，稍后再来！");
            }
        });
    }
    function  searchMessage(pageNumber,type) {

        $.ajax({
            url:'/jf/messageList/queryMessages',
            type:'GET',
            cache:false,
            data:{
                pageNumber:pageNumber,
                type:type

            },
            success:function(data){
                var result =  data.paging.list;
                var messageCount =  data.messageCount;
                var $dataTable = $("#messageTable");
                if(result.length > 0){
                    var htmlData ="";
                    for(i = 0 ; i < result.length ; i++) {
                        var item = result[i];
                        var top = "";
                        if(item.is_top){
                            top = '<span class="label label-warning">置顶</span>';
                        }
                        var className = "";
                        if(item.status == "0") {
                            className = '<label  class=" circle"></label>';
                        }
                        htmlData +=  "<tr> <td><div class='checkbox'>" +
                                " <label> <input type='checkbox' class='_checkMessage' name='selectMessageSeqid' value='"+item.seqid+"'> </label> </div>" +
                                " </td> <td style='text-align: left;width: 450px;'> <h5>"+className+item.title+top +"</h5>"+item.message_content+"</td>" +
                                "<td>"+item.created_time+"</td>";
                    }
                    $dataTable.html("");
                    $dataTable.append(htmlData);
                    $("#page").html("");
                    var pageHtml = foxdsp.pagination(data.paging);
                    $("#page").append(pageHtml);
                }else {
                    $("#page").html("");
                    $dataTable.html("");
                    $dataTable.append("<tr class='text-danger' style='text-align: center'><td>没有可展示的数据</td></tr>");
                }

                var systemMessageCount = messageCount["systemMessageCount"];
                 $("#circletab1").hide();

                var checkMessageCount = messageCount["checkMessageCount"];
                if(checkMessageCount > 0){
                    $("#circletab2").show()
                }else {
                    $("#circletab2").hide();
                }
                var accountMessageCount =messageCount["accountMessageCount"];
                if(accountMessageCount > 0){
                    $("#circletab3").show()
                }else {
                    $("#circletab3").hide();
                }
                var totalCount =  messageCount["totalCount"];
                if(totalCount > 0 && totalCount < 100){
                    $(".totalMessage").html("("+totalCount+")");
                }else if(totalCount > 99){
                    $(".totalMessage").html("(99+)");
                }else {
                    $(".totalMessage").html("");
                }

            },
            error: function (data) {
                libfun.alert("暂时无法显示，稍后再来！");
            }
        });
    }

    function gotopage(pageNo){
        if(pageNo > 0){
            var type = $('#type').val();
            $('#pageNo').val(pageNo);
            searchMessage(pageNo,type);
        }
    }
</script>