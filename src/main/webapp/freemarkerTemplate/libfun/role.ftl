<#assign pageTitle= "角色管理" >
<#assign pageUrl="/jf/libfun/role">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName=pageUrl ></@bread.breadcrumb>
<div class="libfun-placeholder-h10"></div>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="queryForm" class="form-inline" method="GET">
            <div class="form-group">
                <label for="orderName">角色编号：</label>
                <input type="text" class="form-control" name="queryObj.no"/>
            </div>
            <div class="form-group">
                <label for="orderName">角色名称：</label>
                <input type="text" class="form-control" name="queryObj.name"/>
            </div>
            <button type="submit" class="btn btn-primary">查询</button>
            <span class="pull-right"></span>
        </form>
        <div class="libfun-placeholder-h10"></div>
        <div>
            <table id="dataTable"  class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>角色编号</th>
                    <th>角色名称</th>
                    <th>类型</th>
                    <th>备注</th>
                </tr>
                </thead>
            </table>
        </div>
        <div class="form-inline" style="width: 46%;float: left">
            <span class="label label-success">已有权限</span>
            <table   id="roleTable"  class="table table-striped table-bordered" cellspacing="0">
                <thead>
                    <tr>
                        <th style="width:15px"><input type="checkbox" value="" name="roleTableCheckAll" id='roleTableCheckAll'></th>
                        <th>类型</th>
                        <th>名称</th>
                        <th>值</th>
                    </tr>
                </thead>
            </table>
        </div>
        <div  style="width: 30px;float: left;margin-left: 40px;margin-top: 25px;">
            <span id="insertPrivilegeBtn" class="btn btn-primary glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
            <span style="margin-top: 10px;" id="deletePrivilegeBtn" class="btn btn-primary glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
        </div>
        <div class="form-inline" style="width: 46%;float: right;">
            <span class="label label-warning">其他权限</span>
            <table  id="privilegeTable" class="table table-striped table-bordered" cellspacing="0"  >
                <thead>
                <tr>
                    <th style="width:15px"><input type="checkbox" id='privilegeTableCheckAll' value="" name="privilegeTableCheckAll"></th>
                    <th>类型</th>
                    <th>名称</th>
                    <th>值</th>
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
        <label for="configno" class="col-sm-2 control-label">角色编号</label>
        <div class="col-sm-10"><input id="configno" name="editObj.no" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configname" class="col-sm-2 control-label">角色名称</label>
        <div class="col-sm-10"><input id="configname" name="editObj.name" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configvalue" class="col-sm-2 control-label">类型</label>
        <div class="col-sm-10"><input id="configvalue" name="editObj.type" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">备注</label>
        <div class="col-sm-10"><input id="remark" name="editObj.remark" type="text" class="form-control" /></div>
    </div>
</form>
<script type="text/javascript">

    $(document).ready(function () {

        $.extend($.fn.dataTable.defaults, {
            searching: false
        });
       $('#roleTable').DataTable( {
            paging: false,
           "info": false,
            "bAutoWidth": false
        } );

        $('#privilegeTable').DataTable( {
            paging: false,
            "info": false,
            "bAutoWidth": false
        } );

        var  dataTable = libfun.initCrudDataTable({
            table: $("#dataTable"),
            editForm: $("#editForm"),
            queryForm: $("#queryForm"),
            columns: [
                {"data": "no"},
                {"data": "name"},
                {"data": "type"},
                {"data": "remark"}
            ],
            crudUrl: "${pageUrl}"
        });
        $('#dataTable').on( 'click', 'tr', function () {
            var data = dataTable.row({selected: true}).data();
            if(data == ""){
                return false;
            }
            var no = data["no"];
            var roleTable =   $('#roleTable').DataTable( {
                paging: false,
                "bAutoWidth": false,
                "info": false,
                "processing": true,
                "serverSide": true,
                "bDestroy":true,
                "aoColumnDefs": [ { "bSortable": false, "aTargets": [ 0 ] }],
                columns: [
                    {
                        "data": "seqid",
                        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                            $(nTd).html("<input type='checkbox' class='seqIdsDelete' name='roleTableList' value='" + sData + "'>");
                        }
                    },
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
                    {"data": "value"}
                ],
                "ajax": {
                    "url": "role/queryPrivilegeByRoleNo?roleNo="+no
                }

            } );

            var newPrivilegeTable = $('#privilegeTable').DataTable( {
                paging: false,
                "bAutoWidth": false,
                "processing": true,
                "serverSide": true,
                "bDestroy":true,
                "info": false,
                "aoColumnDefs": [ { "bSortable": false, "aTargets": [ 0 ] }],
                columns: [
                    {
                        "data": "seqid",
                        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                            $(nTd).html("<input type='checkbox' class='seqIdsInsert' name='privilegeList' value='" + sData + "'>");

                        }
                    },
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
                    {"data": "value"}
                ],
                "ajax": {
                    "url": "role/queryExcludedPrivilegeByRoleNo?roleNo="+no
                }

            } );

            $("#insertPrivilegeBtn").off("click").click(function(){

//                var data = newPrivilegeTable.rows( {selected:true} ).data();
//                var seqIds = [];
//                for(i=0;i<data.length;i++) {
//                    seqIds.push(data[i].seqid);
//                }
                var seqIdsInsert = [];
                $(".seqIdsInsert").each(function(){
                    if($(this).prop("checked")) {
                        seqIdsInsert.push($(this).val());
                    }
                });
                if(seqIdsInsert.length == 0) {
                    libfun.alert("请选择右边栏的权限");
                    return false;
                }
                insertPrivilege(no, seqIdsInsert, newPrivilegeTable, roleTable);
            });

            $("#deletePrivilegeBtn").off("click").click(function(){
                var seqIdsDelete = [];
                $(".seqIdsDelete").each(function(){
                    if($(this).prop("checked")) {
                        seqIdsDelete.push($(this).val());
                    }
                });
                if(seqIdsDelete.length == 0) {
                    libfun.alert("请选择左边栏的权限");
                    return false;
                }
                deletePrivilege(no, seqIdsDelete, newPrivilegeTable, roleTable);
            });

        } );
    });

    $("#roleTableCheckAll").click(function(){
        $("input[name='roleTableList']:checkbox").each(function(){
            if($(this).prop("checked")) {
                $(this).prop("checked",false);
            }else{
                $(this).prop("checked",true);
            }
        });
    });
    $("#privilegeTableCheckAll").click(function(){
        $("input[name='privilegeList']:checkbox").each(function(){
            if($(this).prop("checked")) {
                $(this).prop("checked",false);
            }else{
                $(this).prop("checked",true);
            }
        });
    });
    function insertPrivilege(roleNo,seqIds,newPrivilegeTable,roleTable) {
        $.ajax({
            url:'role/insertRolePrivilege',
            type:'GET',
            data:{
                roleNo:roleNo,
                privilegeIds:seqIds.toString()
            },
            success:function(data){
                if(data.code == 0) {
                    newPrivilegeTable.draw();
                    roleTable.draw();
                }
            },
            error: function (data) {
                alert("暂时无法显示，稍后再来！");
            }
        });
    }

    function deletePrivilege(roleNo,seqIds,newPrivilegeTable,roleTable){
        $.ajax({
            url:'role/deleteRolePrivilege',
            type:'GET',
            data:{
                roleNo:roleNo,
                privilegeIds:seqIds.toString()
            },
            success:function(data){
                if(data.code == 0) {
                    roleTable.draw();
                    newPrivilegeTable.draw();
                }
            },
            error: function (data) {
                alert("暂时无法显示，稍后再来！");
            }
        });
    }
</script>
<#include "/freemarkerTemplate/common/footer.ftl">