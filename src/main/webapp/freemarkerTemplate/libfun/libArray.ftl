<#assign pageTitle= "系统数组维护" >
<#assign pageUrl="/jf/libfun/array">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName=pageUrl ></@bread.breadcrumb>
<div class="libfun-placeholder-h10"></div>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="queryForm" class="form-inline" method="GET">
            <div class="form-group">
                <label for="orderName">数组编号：</label>
                <input type="text" class="form-control" name="queryObj.classno"/>
            </div>
            <div class="form-group">
                <label for="orderName">数组名称：</label>
                <input type="text" class="form-control" name="queryObj.classname"/>
            </div>
            <button type="submit" class="btn btn-primary">查询</button>
            <span class="pull-right"></span>
        </form>
        <div class="libfun-placeholder-h10"></div>
        <div>
            <table id="dataTable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>名称</th>
                    <th>备注</th>
                    <th>操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<form id="editForm" class="hidden form-horizontal">
    <p class="libfun-editform-alert text-danger"></p>
    <input type="hidden" class="addClearValue" name="editObj.seqid" value="">
    <div class="form-group">
        <label for="configno" class="col-sm-2 control-label">编号<span style="color:red;margin-left:5px;">*</span></label>
        <div class="col-sm-10"><input id="classno" name="editObj.classno" type="text" class="form-control readOnly" /></div>
    </div>
    <div class="form-group">
        <label for="configname" class="col-sm-2 control-label">名称<span style="color:red;margin-left:5px;">*</span></label>
        <div class="col-sm-10"><input id="classname" name="editObj.classname" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">备注</label>
        <div class="col-sm-10"><input id="remark" name="editObj.remark" type="text" class="form-control" /></div>
    </div>
</form>

<script>
    $(document).ready(function () {
        $.extend($.fn.dataTable.defaults, {
            searching: false
        });
       var table =  libfun.initCrudDataTable({
            table: $("#dataTable"),
            editForm: $("#editForm"),
            queryForm: $("#queryForm"),
            columns: [
                {"data": "classno"},
                {"data": "classname"},
                {"data": "remark"},
                {
                    "data": "classno", // 数据列名
                    "render": function(data, type, full) {
                        return "<a href='/jf/libfun/arrayItem?classNo=" + data + "'>设置</a>";
                    }
                }
            ],
            crudUrl: "${pageUrl}"
        });
    });
</script>
<#include "/freemarkerTemplate/common/footer.ftl">