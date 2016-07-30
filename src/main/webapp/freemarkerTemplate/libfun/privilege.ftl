<#assign pageTitle="权限管理">
<#assign pageUrl="/jf/libfun/privilege">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName=pageUrl ></@bread.breadcrumb>

<div class="libfun-placeholder-h10"></div>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="queryForm" class="form-inline" method="GET">
            <div class="form-group">
                <label for="type">类型：</label>
                <select id="type" class="form-control" name="queryObj.type">
                    <option value="0">自定义</option>
                    <option value="1" selected="selected">菜单</option>
                    <option value="2">接口</option>
                </select>
            </div>
            <div class="form-group">
                <label for="privilegeValue">值：</label>
                <input type="text" class="form-control" name="queryObj.value"/>
            </div>
            <button type="submit" class="btn btn-primary">查询</button>
            <span class="pull-right"></span>
        </form>
        <div class="libfun-placeholder-h10"></div>
        <div>
            <table id="dataTable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>类型</th>
                    <th>名称</th>
                    <th>值</th>
                    <th>备注</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<form id="editForm" class="hidden form-horizontal">
    <input name="editObj.seqid" value="" class="addClearValue" type="hidden" id="seqid">
    <p class="libfun-editform-alert text-danger"></p>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="type">类型</label>
        <div class="col-sm-10" style="width: 30%">
            <select id="type" class="control-label" name="editObj.type">
                <option value="0">自定义</option>
                <option value="1">菜单</option>
                <option value="2">接口</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="configname" class="col-sm-2 control-label">名称</label>
        <div class="col-sm-10"><input id="configname" name="editObj.name" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configvalue" class="col-sm-2 control-label">值</label>
        <div class="col-sm-10"><input id="configvalue" name="editObj.value" type="text" class="form-control" /></div>
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
        libfun.initCrudDataTable({
            table: $("#dataTable"),
            editForm: $("#editForm"),
            queryForm: $("#queryForm"),
            columns: [
                {"data": "type"
                    ,"render": function (cellvalue, options, rowObject) {
                    var type = rowObject.type;
                    var typeName;
                    if (type == "1") {
                        typeName = "菜单";
                    } else if (type == "2") {
                        typeName = "接口";
                    } else if (type == "0") {
                        typeName = "自定义";
                    }
                    return typeName;
                }
                },
                {"data": "name"},
                {"data": "value"},
                {"data": "remark"}
            ],
            crudUrl: "${pageUrl}"
        });
    });
</script>

<#include "/freemarkerTemplate/common/footer.ftl">