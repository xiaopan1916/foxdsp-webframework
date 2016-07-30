<#assign pageTitle="系统配置">
<#assign pageUrl="/jf/libfun/syslog">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName=pageUrl ></@bread.breadcrumb>

<div class="libfun-placeholder-h10"></div>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="queryForm" class="form-inline" method="GET">
            <div class="form-group">
                <label for="orderName">用户：</label>
                <input type="text" class="form-control" name="queryObj.userlogno"/>
            </div>
            <div class="form-group">
                <label for="orderName">url：</label>
                <input type="text" class="form-control" name="queryObj.url"/>
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
                    <th>访问时间</th>
                    <th>ip</th>
                    <th>url</th>
                    <th>方式</th>
                    <th>用户</th>
                    <th>时间(毫秒)</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>


<script>
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
                {"data": "seqid"},
                {"data": "visit_time"},
                {"data": "ip"},
                {"data": "url"},
                {"data": "method"},
                {"data": "userlogno"},
                {"data": "time"}
            ],
            crudUrl: "${pageUrl}"
        });
    });
</script>
<#include "/freemarkerTemplate/common/footer.ftl">