<#assign pageTitle= "系统数组维护详细" >
<#assign pageUrl="/jf/libfun/arrayItem">
<#include "/freemarkerTemplate/common/header.ftl">
<section class="content-header">
    <h1><small></small> </h1>
    <ol class="breadcrumb">
        <li><a href="/jf/libfun/user/dspIndex"><i class="glyphicon glyphicon-home"></i>Home</a></li>
       <li><a href="/jf/libfun/array">系统数组维护</a></li>
        <li class="active">${pageTitle}</li>
    </ol>
</section>
<!-- Main content -->
<section class="content">
<div class="libfun-placeholder-h10"></div>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="queryForm" class="form-inline" method="GET">
            <input type="hidden" name="queryObj.classno" value="${classNo!''}">
        </form>
        <div class="libfun-placeholder-h10"></div>
        <div>
            <table id="dataTable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>名称</th>
                    <th>值</th>
                    <th>顺序</th>
                    <th>备注</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<form id="editForm" class="hidden form-horizontal">
    <p class="libfun-editform-alert text-danger"></p>
    <input type="hidden" name="editObj.classno" value="${classNo!''}">
    <input type="hidden" class="addClearValue" name="editObj.seqid" value="">
    <div class="form-group">
        <label for="configno" class="col-sm-2 control-label">编号<span style="color:red;margin-left:5px;">*</span></label>
        <div class="col-sm-10"><input id="configno" name="editObj.itemno"  type="text" class="form-control readOnly" /></div>
    </div>
    <div class="form-group">
        <label for="configname" class="col-sm-2 control-label">名称<span style="color:red;margin-left:5px;">*</span></label>
        <div class="col-sm-10"><input id="configname" name="editObj.itemname" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configvalue" class="col-sm-2 control-label">值<span style="color:red;margin-left:5px;">*</span></label>
        <div class="col-sm-10"><input id="configvalue" name="editObj.itemvalue" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configvalue" class="col-sm-2 control-label">顺序<span style="color:red;margin-left:5px;">*</span></label>
        <div class="col-sm-10"><input id="configvalue" name="editObj.itemorder" type="text" class="form-control" /></div>
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
                {"data": "itemno"},
                {"data": "itemname"},
                {"data": "itemvalue"},
                {"data": "itemorder"},
                {"data": "remark"}

            ],
            crudUrl: "${pageUrl}"
        });
    });
</script>
<#include "/freemarkerTemplate/common/footer.ftl">