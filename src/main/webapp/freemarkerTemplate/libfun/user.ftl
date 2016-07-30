<#assign pageTitle= "用户管理" >
<#assign pageUrl="/jf/libfun/user">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName=pageUrl ></@bread.breadcrumb>
<div class="libfun-placeholder-h10"></div>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="queryForm" class="form-inline" method="GET">
            <div class="form-group">
                <label for="orderName">用户名：</label>
                <input type="text" class="form-control" name="queryObj.userLogNo"/>
            </div>
            <div class="form-group">
                <label for="orderName">姓名：</label>
                <input type="text" class="form-control" name="queryObj.trueName"/>
            </div>
            <button type="submit" class="btn btn-primary">查询</button>
            <span class="pull-right"></span>
        </form>
        <div class="libfun-placeholder-h10"></div>
        <div>
            <table id="dataTable"  class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th>用户名</th>
                    <th>姓名</th>
                    <th>管理员</th>
                    <th>生效</th>
                    <th>绑定IP</th>
                    <th>电话</th>
                    <th>邮箱</th>
                </tr>
                </thead>
            </table>
        </div>
        <div class="form-inline" style="width: 46%;float: left">
            <span class="label label-success">已有角色</span>
            <table   id="roleTable"  class="table table-striped table-bordered" cellspacing="0">
                <thead>
                <tr>
                    <th style="width:15px"><input type="checkbox" value="" name="roleTableCheckAll" id='roleTableCheckAll'></th>
                    <th>角色编号</th>
                    <th>角色名称</th>
                </tr>
                </thead>
            </table>
        </div>
        <div  style="width: 30px;float: left;margin-left: 40px;margin-top: 25px;">
            <span id="insertPrivilegeBtn" class="btn btn-primary glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
            <span style="margin-top: 10px;" id="deletePrivilegeBtn" class="btn btn-primary glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
        </div>
        <div class="form-inline" style="width: 46%;float: right;">
            <span class="label label-warning">其他角色</span>
            <table  id="privilegeTable" class="table table-striped table-bordered" cellspacing="0"  >
                <thead>
                <tr>
                    <th style="width:15px"><input type="checkbox" id='privilegeTableCheckAll' value="" name="privilegeTableCheckAll"></th>
                    <th>角色编号</th>
                    <th>角色名称</th>
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
        <label for="configno" class="col-sm-2 control-label">用户名</label>
        <div class="col-sm-10"><input id="configno" name="editObj.userlogno" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configno" class="col-sm-2 control-label">密码</label>
        <div class="col-sm-10"><input id="configno" name="editObj.userpassword" type="password" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configname" class="col-sm-2 control-label">姓名</label>
        <div class="col-sm-10"><input id="configname" name="editObj.truename" type="text" class="form-control" /></div>
    </div>

    <div class="form-group">
        <label for="configvalue" class="col-sm-2 control-label">管理员</label>
        <div class="col-sm-10">
            <input id="configvalue" name="editObj.superman" type="checkbox"  />
        </div>
    </div>
    <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">生效</label>
        <div class="col-sm-10">
            <input id="remark" name="editObj.inuse" type="checkbox" />
        </div>
    </div>
    <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">绑定IP</label>
        <div class="col-sm-10"><input id="remark" name="editObj.bindip" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">电话</label>
        <div class="col-sm-10"><input id="remark" name="editObj.tel" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="remark" class="col-sm-2 control-label">邮箱</label>
        <div class="col-sm-10"><input id="remark" name="editObj.email" type="text" class="form-control" /></div>
    </div>
    <div class="form-group" >
        <label for="platform" class="col-md-2 control-label">员工</label>
        <div class="col-md-10">
        <select id="platform" class="form-control" name="editObj.copartnerno">
            <option value=""></option>
            <#if copartnersList?exists>
                <#list copartnersList as key>
                    <option value="${key.copartnerNo}">${key.copartnerName}</option>
                </#list>
            </#if>
        </select>
            </div>
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
                {"data": "userlogno"},
                {"data": "truename"},
                {"data": "superman"
                    ,"render": function (cellvalue, options, rowObject) {
                    var type = rowObject.superman;
                    var typeName;
                    if (type == "1") {
                        typeName = "是";
                    } else if (type == "0") {
                        typeName = "否";
                    }
                    return typeName;
                }
                },
                {"data": "inuse","render": function (cellvalue, options, rowObject) {
                    var type = rowObject.inuse;
                    var typeName;
                    if (type == "1") {
                        typeName = "是";
                    } else if (type == "0") {
                        typeName = "否";
                    }
                    return typeName;
                }},
                {"data": "bindip"},
                {"data": "tel"},
                {"data": "email"}
            ],
            crudUrl: "${pageUrl}"
        });
        $('#dataTable').on( 'click', 'tr', function () {
            var data = dataTable.row({selected: true}).data();
            if(data == ""){
                return false;
            }
            var no = data["userlogno"];
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
                        "data": "no",
                        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                            $(nTd).html("<input type='checkbox' class='seqIdsDelete' name='roleTableList' value='" + sData + "'>");
                        }
                    },
                    {"data": "no"},
                    {"data": "name"}
                ],
                "ajax": {
                    "url": "/jf/libfun/user/queryRoleByUserName?username="+no
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
                        "data": "no",
                        "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                            $(nTd).html("<input type='checkbox' class='seqIdsInsert' name='privilegeList' value='" + sData + "'>");
                        }
                    },
                    {"data": "no"},
                    {"data": "name"}
                ],
                "ajax": {
                    "url": "/jf/libfun/user/queryExcludedRoleByUsername?username="+no
                }

            } );

            //事件重复绑定
            $("#insertPrivilegeBtn").off("click").click(function(){
                var seqIdsInsert = [];
                $(".seqIdsInsert").each(function(){
                    if($(this).prop("checked")) {
                        seqIdsInsert.push($(this).val());
                    }
                });
                if(seqIdsInsert.length == 0) {
                    libfun.alert("请选择右边栏的角色");
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
                    libfun.alert("请选择左边栏的角色");
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
    function insertPrivilege(username,userRole,newPrivilegeTable,roleTable) {
        $.ajax({
            url:'/jf/libfun/user/insertUserRole',
            type:'GET',
            data:{
                username:username,
                userRole:userRole.toString()
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

    function deletePrivilege(username,userRole,newPrivilegeTable,roleTable){
        $.ajax({
            url:'/jf/libfun/user/deleteUserRoleByUsername',
            type:'GET',
            data:{
                username:username,
                userRole:userRole.toString()
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