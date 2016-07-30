<#assign pageTitle= "菜单管理" >
<#assign pageUrl="/jf/libfun/menu">
<#include "/freemarkerTemplate/common/header.ftl">
<#import  "/freemarkerTemplate/common/breadcrumb.ftl" as bread>
<@bread.breadcrumb listName=pageUrl ></@bread.breadcrumb>
<link rel="stylesheet" href="/static_v2/css/jqtree.css" />
<script src="/static_v2/js/tree.jquery.js"></script>
<div class="libfun-placeholder-h10"></div>
<div class="panel panel-default">
    <div class="panel-body">
        <form id="queryForm" class="form-inline" method="GET">
            <div class="form-group">
                <label for="privilegeValue">菜单编号：</label>
                <input type="text" class="form-control" name="queryObj.menuno"/>
            </div>
            <div class="form-group">
                <label for="privilegeValue">菜单名称：</label>
                <input type="text" class="form-control" name="queryObj.menuname"/>
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
                    <th>父编号</th>
                    <th>名称</th>
                    <th>url</th>
                    <th>顺序</th>
                    <th>生效</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<form id="editForm" class="hidden form-horizontal">
    <input name="editObj.seqid" value=""  class="addClearValue" type="hidden" id="seqid">
    <input name="editObj.displayorder" value="" type="hidden" id="displayorder">
    <input name="editObj.pmenuno" value="" type="hidden" id="pmenuno">
    <p class="libfun-editform-alert text-danger"></p>
    <div class="form-group">
        <label for="configname" class="col-sm-2 control-label">名称</label>
        <div class="col-sm-10"><input id="menuname" name="editObj.menuname" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="configvalue" class="col-sm-2 control-label">URL</label>
        <div class="col-sm-10"><input id="menuurl" name="editObj.menuurl" type="text" class="form-control" /></div>
    </div>
    <div class="form-group">
        <label for="inuse" class="col-sm-2 control-label">生效</label>
        <div class="col-sm-10" style="width: 30%">
            <select id="inuse"  name="editObj.inuse" class="form-control">
                <option value="1">是</option>
                <option value="0">否</option>
            </select>
        </div>
    </div>
</form>
<div style="color: #d9534f;" class="libfun-placeholder-h2"></div>
<div class="panel panel-primary">
    <div class="panel-heading">顺序调整</div>
    <div  class="panel-body">
        <div id="tree"></div>
    </div>
</div>

<script type="text/javascript">
$("#inUse").click(function(){
    if(this.checked) {
        $("#inUse").val(1);
    }
    else {
        $("#inUse").val(0);
    }
});
    $(function() {

        var rtn = eval('${menuName?j_string}');
        var  menuMap = {};
        for (i = 0; i < rtn.length; i++) {
            menuMap[rtn[i].menuno] = rtn[i];
            rtn[i].children = [];
            rtn[i].label = rtn[i].menuname;
        }
        for (i = 0; i < rtn.length; i++) {
            if (rtn[i].pmenuno !== "-1") {
                menuMap[rtn[i].pmenuno].children.push(rtn[i]);
            }
        }
      var tree =  $("#tree").tree({
            dragAndDrop: true
            , data:[menuMap[0]]
            , autoOpen: false
            , openedIcon: "-"
            , closedIcon: "+"
        })
                .on("tree.move", function (e) {
            //修改displayorder的方式是直接插入后 其余 兄弟节点自增或自减，所以频繁修改
            var move = e.move_info.moved_node, target = e.move_info.target_node, pos = e.move_info.position;
            console.log(target);
            if (pos === "before") {
                move.pmenuno = target.pmenuno;
                move.displayorder = target.displayorder;
                updateMenu(move);
                for (i = 0; i < target.parent.children.length; i++) {
                    var m = target.parent.children[i];
                    if (m.menuno != move.menuno && m.displayorder >= move.displayorder) {
                        m.displayorder++;
                        updateMenu(m);
                    }
                }
            } else if (pos === "after") {
                move.pmenuno = target.pmenuno;
                move.displayorder = target.displayorder;
                updateMenu(move);
                for (i = 0; i < target.parent.children.length; i++) {
                    var m = target.parent.children[i];
                    if (m.menuno != move.menuno && m.displayorder <= move.displayorder) {
                        m.displayorder--;
                        updateMenu(m);
                    }
                }
            } else if (pos === "inside") {
                move.pmenuno = target.menuno;
                if (target.children && target.children.length > 0) {
                    move.displayorder = target.children[0].displayorder - 1;
                } else {
                    move.displayorder = 0;
                }
                updateMenu(move);
            }
        });

        function updateMenu(move) {
            $.ajax({
                url:'/jf/libfun/menu/updateMenusTree',
                type:'GET',
                data:{
                    displayOrder:move.displayorder,
                    pmenuNo:move.pmenuno,
                    seqid:move.seqid
                },
                success:function(data){
                    if(data.code == 0) {
                        $(".libfun-placeholder-h2").html("已调整，重新登录之后生效！");
                    }else{
                        libfun.alert(data.message);
                    }
                },
                error: function (data) {
                    libfun.alert("暂时无法显示，稍后再来！");
                }
            });
        }
        $('#tree').bind(
                'tree.select',
                function(event) {
                    if (event.node) {
                        // node was selected
                        var selNode = tree.tree("getSelectedNode");
                        if (selNode) {
                            $("#pmenuno").val(selNode.menuno);
                            if (selNode.children && selNode.children.length > 0) {
                                $("#displayorder").val(selNode.children[selNode.children.length - 1].displayorder + 1);
                            } else
                                $("#displayorder").val(0);
                            }

                    }
                    else {

                    }
                }
        );
        $.extend($.fn.dataTable.defaults, {
            searching: false
        });
        libfun.initCrudDataTable({
            table: $("#dataTable"),
            editForm: $("#editForm"),
            queryForm: $("#queryForm"),
            columns: [
                {"data": "menuno"},
                {"data": "pmenuno"},
                {"data": "menuname"},
                {"data": "menuurl"},
                {"data": "displayorder"},
                {"data": "inuse",
                    "render": function (cellvalue, options, rowObject) {
                        var type = rowObject.inuse;
                        var typeName;
                        if (type == "1") {
                            typeName = "是";
                        } else if (type == "0") {
                            typeName = "否";
                        }
                        return typeName;
                    }
                }
            ],
            crudUrl: "${pageUrl}"
        });

    });
</script>
<#include "/freemarkerTemplate/common/footer.ftl">