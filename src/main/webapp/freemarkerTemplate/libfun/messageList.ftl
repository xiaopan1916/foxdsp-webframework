<#assign pageTitle= "${pageTitle}" >
<#assign pageUrl="${pageUrl}">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName="${pageUrl}" ></@bread.breadcrumb>
<link rel="stylesheet" href="/static_v2/bootstrap-3.3.5-dist/css/bootstrap-datetimepicker.css">
<link rel="stylesheet" href="/static_v2/bootstrap-select-1.10.0/dist/css/bootstrap-select.min.css">
<script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap-datetimepicker.js"></script>
<script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="/static_v2/bootstrap-select-1.10.0/dist/js/bootstrap-select.min.js"></script>
<script src="/static_v2/bootstrap-select-1.10.0/js/i18n/defaults-zh_CN.js"></script>

<div class="panel panel-default libfun-panel">
    <div class="panel-body">
    <form id="queryForm" class="form-inline libfun-form  pull-right">

        <div class="form-group">
            <label for="datestart">日期</label>
            <input type="text" class="form-control" value="${startTime}" id="datestart" name="startDate"
                   placeholder="开始日期">
            --
            <input type="text" class="form-control" value="${endTime}" id="dateend" name="endDate" placeholder="结束日期">
        </div>
        <div class="form-group">
            <input id="titleContent" type="text" name="titleContent" placeholder="标题/内容" class="form-control"/>
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
    </form>
    <div class="libfun-placeholder-h10">

    </div>
        <button id="addSendMessage" type="button" class="btn btn-primary">添加系统消息</button>
        <div class="tips"></div>
        <table id="dataTable" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <thead>
            <tr>
                <td>日期</td>
                <td>接收者</td>
                <td>消息标题</td>
                <td>消息内容</td>
                <td>发送者</td>
                <td>置顶显示</td>
                <td>定点发送时间</td>
            </tr>
            </thead>
        </table>
    </div>
</div>

<script type="text/javascript">

    $("#addSendMessage").click(function () {
        libfun.modal.showRemote('/jf/messageList/addSendMessage', "添加系统消息", function () {
            $.post("/jf/messageList/insert", $("#editForm").serialize(), function (data) {
                if (data && data["code"] === 0) {
                    window.location.reload();
                } else {
                    $(".libfun-editform-alert", $("#editForm")).text(data.message).show();
                }
            });
        });

    });
    $('#datestart').datepicker({
        format: "yyyy-mm-dd",
        todayBtn: true,
        clearBtn: true,
        language: "zh-CN",
        autoclose: true,
        todayHighlight: true
    });
    $('#dateend').datepicker({
        format: "yyyy-mm-dd",
        todayBtn: true,
        clearBtn: true,
        language: "zh-CN",
        autoclose: true,
        todayHighlight: true
    });


    $(document).ready(function () {

        $.extend($.fn.dataTable.defaults, {
            searching: false,
            "order": [[0, "desc"]]
        });
        libfun.initOnlyQueryTable({
            table: $("#dataTable"),
            editForm: $("#editForm"),
            queryForm: $("#queryForm"),
            columns: [
                {
                    "data": "created_time",
                    "render": function (data, type, full) {
                        if (full.status == 0) {

                            return data + '<button name="editlinkButton" class="btn btn-primary btn-sm" data-seqid="' + full.seqid + '"> <span class="glyphicon glyphicon-pencil"></span></button>';
                        } else {
                            return data;
                        }
                    }
                },
                {
                    "data": "receiver_userlogno",
                    "render": function (cellvalue, options, rowObject) {
                        return cellvalue;
                    }
                },
                {
                    "data": "title",
                    "render": function (cellvalue, options, rowObject) {
                        return "<span class='limitText'>" + cellvalue + "</span>";
                    }
                },
                {
                    "data": "send_content"
                    , "render": function (cellvalue, options, rowObject) {
                    return "<span class='limitText'>" + cellvalue + "</span>"+"<input type='hidden' class='sendContent' value='"+cellvalue+"'>";
                }
                },
                {"data": "sender_userlogno"},
                {
                    "data": "is_top"
                    ,
                    "render": function (cellvalue, options, rowObject) {
                        var check = cellvalue == "1" ? "checked data-seqid=" + rowObject.seqid : " data-seqid=" + rowObject.seqid;
                        return '<input type="checkbox" name="switch-checkbox" ' + check + '>';
                    }
                },
                {"data": "send_time" ,
                    "render": function (cellvalue, options, rowObject) {
                        var result= "";
                        if(cellvalue){
                            result = cellvalue;
                        }else {
                            result = "即时发送";
                        }
                        return result;
                    }}
            ],
            crudUrl: "/jf/messageList",
            drawCallback: function (settings) {
                initSwitch();
            }
        });

        function initSwitch() { //初始化on off开关
            $("input[name='switch-checkbox']").bootstrapSwitch();
            $('input[name="switch-checkbox"]').on('switchChange.bootstrapSwitch', function (event, state) {
                var seqid = $(this).data('seqid');
                var top = state ? "1" : "0";
                $.post("/jf/messageList/updateTopStatus", {
                    seqid: seqid,
                    top: top
                }, function (data) {
                    if (data && data["code"] === 0) {
                    } else {
                        libfun.confirm(data.message, function (isOk) {
                            window.location.reload();
                        });
                    }
                });
            });
            $("button[name='editlinkButton']").on('click', function () {
                var seqid = $(this).data("seqid");

                libfun.modal.showRemote('/jf/messageList/updateSendMessage?seqid=' + seqid, "修改系统消息", function () {
                    $.post("/jf/messageList/update", $("#editForm").serialize(), function (data) {
                        if (data && data["code"] === 0) {
                            window.location.reload();
                        } else {
                            $(".libfun-editform-alert", $("#editForm")).text(data.message).show();
                        }
                    });
                });
            });
            //限制字符个数
            $(".limitText").each(function () {
                var maxwidth = 50;
                if ($(this).text().length > maxwidth) {
                    $(this).text($(this).text().substring(0, maxwidth));
                    $(this).html($(this).html() + '…');
                }
            });
        }

        var tip = $(".tips");
        $('#dataTable').on('mouseenter', 'td', function (e) {
            var content = $(this).find('.sendContent').val();
            if (typeof(content) == "undefined"){
                return ;
            }
            if (e.pageX < 600) {
                tip.css("top", (e.pageY) + "px").css("left", (e.pageX + 10) + "px")
            } else {
                tip.css("top", (e.pageY + 10) + "px").css("left", (e.pageX - 450) + "px")
            }
            tip.html(content).show();
        });
        $('#dataTable').on('mouseleave', 'td', function () {
            tip.hide();
        });

    });

</script>
<#include "/freemarkerTemplate/common/footer.ftl">