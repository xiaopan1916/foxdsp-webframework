//jquery plugin
$.fn.serializeObject = function (transfer) {
    var o = {};
    var a = this.serializeArray();
    var $this = this;
    var transfer = transfer || false ;//checkbox默认的value是on,off,transfer参数将其改变为1,0

    $.each(a, function () {
        var $check = $("input[name='" + this.name + "'][type='checkbox']", $this);
        if ( $check.length && transfer ) {
            this.value = $check.prop("checked") ? "1" : "0" ;
        }
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};


//此段代码用来解决多个modal窗口弹出的问题
$(document).on('show.bs.modal', '.modal', function (event) {
    var zIndex = 1040 + (10 * $('.modal:visible').length);
    $(this).css('z-index', zIndex);
    setTimeout(function() {
        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
    }, 0);
});

var libfun = {
    //modal 模块，主要作用是补强bootstrap
    modal: {
        /**
         * modal 远程加载
         * @param url
         * @param title
         * @param callback
         */
        showRemote: function(url, title,callback){
            BootstrapDialog.show({
                        title: title,
                        draggable: true,
                        size: "big-dialog",
                        closeByBackdrop: false,
                        closeByKeyboard: false,
                        closable: true,
                        message: $('<div></div>').load(url),
                        buttons: [{
                            id: 'ok',
                            label: '确定',
                            cssClass: 'btn-primary js-loading-btn2',
                            autospin: false,
                            action: function(dialogRef){
                             if(callback) {
                                 callback(true);
                             }else{
                                 dialogRef.close();
                             }
                            }
                        },{
                            label: '返回',
                            action: function(dialogRef) {
                                dialogRef.close();
                            }}
                        ]
                   });
        },
        getInstance: function(){
            return $('<div class="modal fade"> <div class="modal-dialog"><div class="modal-content"><div class="modal-header">' +
            '<button type="button" class="close" data-dismiss="modal" aria-label="Close">' +
            '<span aria-hidden="true">&times;</span></button> <h4 class="modal-title"></h4></div>' +
            '<div class="modal-body"></div> <div class="modal-footer"> </div></div></div></div>').clone();
        },
        getCancalBtn: function(){
            return $('<button type="button"  class="btn btn-default" data-dismiss="modal">取消</button>').clone();
        },
        getOkBtn: function(){
            return $('<button type="button"  class="btn btn-primary ">确认</button>').clone();
        }
    },

    alert: function (message) {
        BootstrapDialog.show({
            title: "温馨提示",
            draggable: true,
            message: message,
            buttons: [{
                id: 'ok',
                label: '确定',
                cssClass: 'btn-primary',
                action: function(dialogRef){
                     dialogRef.close();
                }
            },{
                label: '取消',
                action: function(dialogRef) {
                    dialogRef.close();
                }}
            ]
        });
    },

    /**
     * 返回URL带的参数
     * @param n 参数名称
     * @returns
     */
    P: function (n) {
        var hrefstr, pos, parastr, para, tempstr;
        hrefstr = window.location.href;
        if (hrefstr.indexOf("#") > -1)hrefstr = hrefstr.substring(0, hrefstr.indexOf("#"));
        pos = hrefstr.indexOf("?");
        parastr = hrefstr.substring(pos + 1);
        para = parastr.split("&");
        tempstr = "";
        for (var i = 0; i < para.length; i++) {
            tempstr = para[i];
            pos = tempstr.indexOf("=");
            if (tempstr.substring(0, pos).toLowerCase() == n.toLowerCase()) {
                return tempstr.substring(pos + 1);
            }
        }
        return null;
    },

    /**
     *
     * @param message
     * @param callback
     * @param title
     * @param preventAutoClose ==true 的时候，把一个关闭函数传给处理 ok 事件的callback,让callback决定何时关
     */
    confirm: function (message, callback, title, preventAutoClose) {
        var modal = libfun.modal.getInstance(), okBtn = libfun.modal.getOkBtn(), cancalBtn = libfun.modal.getCancalBtn();
        modal.find(".modal-header").text(title ? title : "警告").end()
            .find(".modal-footer").empty().append(cancalBtn).append(okBtn).end();
        if (typeof message === "string") {
            $(".modal-body", modal).empty().append("<p>" + message + "</p>");
        } else {
            $(".modal-body", modal).empty().append(message);
        }
        cancalBtn.off().click(function () {
            if (callback) callback(false);
            modal.modal("hide");
        });
        okBtn.off().click(function () {
            if (callback){
                if(preventAutoClose){
                    callback(true, function(){modal.modal("hide")});
                }else{
                    callback(true);
                    modal.modal("hide");
                }
            }else{
                modal.modal("hide");
            }
        });
        modal.modal();
    },


    /**
     *增删改成的基础框
     * @param p
     */
    initCrudDataTable: function (p) {
        //libfun.initCrudDataTable({
        //    table: "#dataTable",
        //    editForm: "#editContainer"
        //    queryForm:
        //    columns: [
        //        {"data": "configno"},
        //        {"data": "configname"},
        //        {"data": "configvalue"},
        //        {"data": "remark"}
        //    ],
        //    crudUrl: "${pageUrl}"
        //});

        var table = p.table.DataTable({
            serverSide: true,
            processing: true,
            dom: 'Bfrtip',
            "paging":  typeof p.paging !== 'undefined' ? p.paging : true,
            treetable: p.treetable,
            select: {
                style: "single"//multi
            },
            "oLanguage": {
                "sUrl": "/static_v2/DataTables-1.10.9/chinese.json"
            },
            buttons: [
                {
                    text: "新增",
                    className: 'btn-primary',
                    action: function () {
                        p.editForm.removeClass("hidden");
                        p.editForm[0].reset();
                        $(".readOnly").attr("readOnly", false);
                        $(".addClearValue").val("");
                        $(".libfun-editform-alert", p.editForm).hide();
                        libfun.confirm(p.editForm, function (isSubmit, closeFunc) {
                            if (isSubmit) {
                                $.post(p.crudUrl + "/insert", p.editForm.serializeObject(true), function (data) {
                                    if (data && data["code"] === 0) {
                                        table.draw();
                                        closeFunc();
                                    } else {
                                        $(".libfun-editform-alert", p.editForm).text(data.message).show();
                                    }
                                });
                            }
                        }, "新增", true);
                    }
                }, {
                    text: "编辑",
                    className: 'btn-info',
                    action: function () {
                        p.editForm.removeClass("hidden");
                        $(".readOnly").attr("readOnly", true);
                        var editData = table.row({selected: true}).data();
                        $(".libfun-editform-alert", p.editForm).hide();
                        if (editData) {
                            //给目标赋值
                            for (var name in editData) {
                                if (editData.hasOwnProperty(name)) {
                                    $("input[name='editObj." + name + "']", p.editForm).val(editData[name]);
                                    $("textarea[name='editObj." + name + "']", p.editForm).val(editData[name]);
                                    $("select[name='editObj." + name + "']", p.editForm).val(editData[name]);
                                    //TODO editData[name]==1 优化
                                    $("input[name='editObj." + name + "'][type='checkbox']", p.editForm).prop("checked",editData[name]==1);
                                }
                            }
                            libfun.confirm(p.editForm, function (isSubmit, closeFunc) {
                                if (isSubmit) {
                                    var editAfterData = p.editForm.serializeObject();
                                    var editBeforeData = $.extend(true, {}, editData);
                                    for (var name in editBeforeData) {
                                        //把editData 转化成 jfinal getModel可以理解的形式
                                        if (editBeforeData.hasOwnProperty(name)) {
                                            var s = $("input[name='editObj." + name + "'][type='checkbox']", p.editForm);
                                            if ( s.length ) {
                                                editAfterData["editObj." + name] = s.prop("checked") ? "1" : "0" ;
                                            }
                                            if (typeof editAfterData["editObj." + name] !== "undefined") {
                                                editBeforeData["editObj." + name] = editAfterData["editObj." + name];
                                            } else {
                                                editBeforeData["editObj." + name] = editBeforeData[name];
                                            }
                                        }
                                    }
                                    $.post(p.crudUrl + "/update", editBeforeData, function (data) {
                                        if (data && data["code"] === 0) {
                                            table.draw();
                                            closeFunc();
                                        } else {
                                            $(".libfun-editform-alert", p.editForm).text(data.message).show();
                                        }
                                    });
                                }
                            }, "编辑", true);
                        } else {
                            libfun.alert("请选择一行数据");
                        }
                    }
                }, {
                    text: "删除",
                    className: 'btn-danger',
                    action: function () {
                        var editData = table.row({selected: true}).data();
                        if (editData) {
                            libfun.confirm("确认删除？", function (isOk) {
                                if (isOk) {
                                    $.post(p.crudUrl + "/delete", editData, function (data) {
                                        if (data && data["code"] === 0) {
                                            table.draw();
                                        } else {
                                            libfun.alert(data.message);
                                        }
                                    });
                                }
                            });
                        } else {
                            libfun.alert("请选择一行数据");
                        }
                    }
                }
            ],
            ajax: {
                url: p.crudUrl + "/query",
                data: function (d) {
                    var arr = p.queryForm.serializeArray();
                    for (var i = 0; i < arr.length; i++) {
                        d[arr[i].name] = arr[i].value;
                    }
                }
            },
            columns: p.columns,
            drawCallback: p.drawCallback || function() {}
        });

        p.queryForm.submit(function (e) {
            e.preventDefault();
            table.ajax.reload();
        });
        return table;
    },


    /**
     *增删改成的基础框
     * 编辑  时   动态生成指定列
     * @param p
     */
    initCrudDataDynTable: function (p) {

        $("#statno , #acturl").blur(function(){
            getCuurl();
        });



        var getCuurl=function() {
            var escapeacturl = encodeURIComponent($('#acturl').val());
            var data = $('#countUrl').val() + $('#statno').val() + "&location=" + escapeacturl;
            $("#staturl").val(data);
        };

        var table = p.table.DataTable({
            serverSide: true,
            processing: true,
            dom: 'Bfrtip',
            select: {
                style: "single"//multi
            },
            "oLanguage": {
                "sUrl": "/static_v2/DataTables-1.10.9/chinese.json"
            },
            buttons: [
                {
                    text: "新增",
                    className: 'btn-primary',
                    action: function () {
                        p.editForm.removeClass("hidden");
                        p.editForm[0].reset();
                        $(".readOnly").attr("readOnly", false);
                        $(".addClearValue").val("");
                        $(".libfun-editform-alert", p.editForm).hide();
                        libfun.confirm(p.editForm, function (isSubmit, closeFunc) {
                            if (isSubmit) {
                                $.post(p.crudUrl + "/insert", p.editForm.serializeObject(), function (data) {
                                    if (data && data["code"] === 0) {
                                        table.draw();
                                        closeFunc();
                                    } else {
                                        $(".libfun-editform-alert", p.editForm).text(data.message).show();
                                    }
                                });
                            }
                        }, "新增", true);
                    }
                }, {
                    text: "编辑",
                    className: 'btn-info',
                    action: function () {
                        p.editForm.removeClass("hidden");
                        $(".readOnly").attr("readOnly", true);
                        var editData = table.row({selected: true}).data();
                        $(".libfun-editform-alert", p.editForm).hide();
                        if (editData) {
                            //给目标赋值

                            for (var name in editData) {
                                if (editData.hasOwnProperty(name)) {
                                    $("input[name='editObj." + name + "']", p.editForm).val(editData[name]);
                                    $("textarea[name='editObj." + name + "']", p.editForm).val(editData[name]);
                                    $("select[name='editObj." + name + "']", p.editForm).val(editData[name]);
                                    //TODO editData[name]==1 优化
                                    $("input[name='editObj." + name + "'][type='checkbox']", p.editForm).prop("checked",editData[name]==1);
                                }
                            }
                            getCuurl();
                            libfun.confirm(p.editForm, function (isSubmit, closeFunc) {
                                if (isSubmit) {
                                    var editAfterData = p.editForm.serializeObject();
                                    var editBeforeData = $.extend(true, {}, editData);

                                    for (var name in editBeforeData) {
                                        //把editData 转化成 jfinal getModel可以理解的形式
                                        if (editBeforeData.hasOwnProperty(name)) {
                                            var s = $("input[name='editObj." + name + "'][type='checkbox']", p.editForm);
                                            if ( s.length ) {
                                                editAfterData["editObj." + name] = s.prop("checked") ? "1" : "0" ;
                                            }
                                            if (typeof editAfterData["editObj." + name] !== "undefined") {
                                                editBeforeData["editObj." + name] = editAfterData["editObj." + name];
                                            } else {
                                                editBeforeData["editObj." + name] = editBeforeData[name];
                                            }
                                        }
                                    }

                                    $.post(p.crudUrl + "/update", editBeforeData, function (data) {
                                        if (data && data["code"] === 0) {
                                            table.draw();
                                            closeFunc();
                                        } else {
                                            $(".libfun-editform-alert", p.editForm).text(data.message).show();
                                        }
                                    });
                                }
                            }, "编辑", true);

                        } else {
                            libfun.alert("请选择一行数据");
                        }
                    }
                }, {
                    text: "删除",
                    className: 'btn-danger',
                    action: function () {
                        var editData = table.row({selected: true}).data();
                        if (editData) {
                            libfun.confirm("确认删除？", function (isOk) {
                                if (isOk) {
                                    $.post(p.crudUrl + "/delete", editData, function (data) {
                                        if (data && data["code"] === 0) {
                                            table.draw();
                                        } else {
                                            libfun.alert(data.message);
                                        }
                                    });
                                }
                            });
                        } else {
                            libfun.alert("请选择一行数据");
                        }
                    }
                }
            ],
            ajax: {
                url: p.crudUrl + "/query",
                data: function (d) {
                    var arr = p.queryForm.serializeArray();
                    for (var i = 0; i < arr.length; i++) {
                        d[arr[i].name] = arr[i].value;
                    }
                }
            },
            columns: p.columns,
            drawCallback: p.drawCallback || function() {}
        });

        p.queryForm.submit(function (e) {
            e.preventDefault();
            table.ajax.reload();
        });
        return table;
    },


    /**
     * 查询和增加的table
     * @param p
     */
    initOnlyQueryAndAddTable:function(p){
        var addOnlyTable = p.table.DataTable({
            serverSide: true,
            processing: true,
            bAutoWidth: true,
            dom: 'Bfrtip',
            select: {
                style: "single"//multi
            },
            "oLanguage": {
                "sUrl": "/static_v2/DataTables-1.10.9/chinese.json"
            },
            buttons: [
                {
                    text: "新增",
                    className: 'btn-primary',
                    action: function () {
                        p.editForm.removeClass("hidden");
                        p.editForm[0].reset();
                        $(".libfun-editform-alert", p.editForm).hide();
                        libfun.confirm(p.editForm, function (isSubmit, closeFunc) {
                            if (isSubmit) {
                                $.post(p.crudUrl + "/insert", p.editForm.serializeObject(), function (data) {
                                    if (data && data["code"] === 0) {
                                        addOnlyTable.draw();
                                        closeFunc();
                                    } else {
                                        $(".libfun-editform-alert", p.editForm).text(data.message).show();
                                    }
                                });
                            }
                        }, "新增", true);
                    }
                }
            ],
            ajax: {
                url: p.crudUrl + "/query",
                data: function (d) {
                    var arr = p.queryForm.serializeArray();
                    for (var i = 0; i < arr.length; i++) {
                        d[arr[i].name] = arr[i].value;
                    }
                }
            },
            columns: p.columns,
            drawCallback: p.drawCallback || function() {}
        });

        p.queryForm.submit(function (e) {
            e.preventDefault();
            addOnlyTable.ajax.reload();

        });
    },
    /**
     * 查询的table
     * @param p
     */
    initOnlyQueryTable:function(p){
        var queryTable = p.table.DataTable({
            serverSide: true,
            processing: true,
            bAutoWidth: true,
            aoColumnDefs: p.bSortable,  // 这个可以定义哪一列不用排序
            dom: 'Bfrtip',
            select: {
                style: "single"//multi
            },
            "oLanguage": {
                "sUrl": "/static_v2/DataTables-1.10.9/chinese.json"
            },
            buttons: [],
            ajax: {
                url: p.crudUrl + "/query",
                data: function (d) {
                    var arr = p.queryForm.serializeArray();
                    for (var i = 0; i < arr.length; i++) {
                        d[arr[i].name] = arr[i].value;
                    }
                }
            },
            columns: p.columns,
            drawCallback: p.drawCallback || function() {}
        });

        p.queryForm.submit(function (e) {
            e.preventDefault();
            queryTable.ajax.reload();

        });
        return queryTable;
    },
    /**
     *
     * @param p
     * {
                    option: option,
                    data: data,
                    legendName: "positionname",
                    startDate: "",
                    endDate: "",
                    dateName: "balancedate",
                    seriesName: "pvsum"
                }
     */
    initEchartsDateLine: function (p) {
        var dateArr = dateutils.getDateArr(p.startDate, p.endDate);
        var map = [];

        for (var i = 0; i < p.data.length; i++) {
            var obj = p.data[i], seriesObj = map[obj[p.legendName]];
            if (seriesObj === undefined) {
                //初始化一个全是0完整的数列，用于补全数据中没有的日期
                seriesObj = [];
                for (var j = 0; j < dateArr.length; j++) {
                    seriesObj.push(0);
                }
                map[obj[p.legendName]] = seriesObj;
            }
            seriesObj[dateArr.indexOf(obj[p.dateName])] = obj[p.seriesName];
        }

        p.option.xAxis[0].data = dateArr;
        p.option.legend.data = [];
        p.option.series = [];
        for (var key in map) {
            p.option.legend.data.push(key);
            p.option.series.push({"name": key, "type": "line", "data": map[key]});
        }
    },

    /**
     *
     * @param p {containerId, dataArr, dateName,legendArr, legendTitleArr}
     */
    initDayPvEchart: function (p) {
        var chartDayList = [], series = [], echarts = p.echarts;
        for (var i = 0; i < p.dataArr.length; i++) {
            chartDayList.push(p.dataArr[i][p.dateName]);
            for (var j = 0; j < p.legendArr.length; j++) {
                if (i === 0) {
                    series.push({name: p.legendTitleArr[j], type: "line", data: []});
                }
                series[j].data.push(p.dataArr[i][p.legendArr[j]]);
            }
        }
        var contentDiv = echarts.init(document.getElementById(p.containerId));
        contentDiv.setOption({
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: p.legendTitleArr
            },
            xAxis: [
                {
                    type: 'category',
                    data: chartDayList
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: series
        });
    }
};

var dateutils = {
    DAY: 86400000,
    getDateArr: function (startDate, endDate) {
        if (endDate.getTime() < startDate.getTime()) {
            return [];
        } else {
            var arr = [];
            for (var i = 0; startDate.getTime() < endDate.getTime(); i++) {
                arr.push(dateutils.formatYYYYMMDD(startDate));
                startDate.setTime(startDate.getTime() + dateutils.DAY);
            }
            if ((startDate.getTime() - endDate.getTime()) < dateutils.DAY) {
                //差值小于1天，说明还要增加最后一天
                arr.push(dateutils.formatYYYYMMDD(endDate));
            }
            return arr;
        }
    },
    getDateByDay: function (date, dayNum) {
        //var newDate = new Date();
        //newDate.setTime(date.getTime() + dayNum * dateutils.DAY);
        //return newDate;
        return new Date(date.getTime() + dayNum * dateutils.DAY);
    },
    formatYYYYMMDD: function (date) {
        return date.toISOString().slice(0, 10);
    }
}

var foxdsp = {
    /**
     * 媒介计划表
     * @param p {table:,salesPlan:,adcpmsetting:}
     */
    initSalesPlan: function (p) {
        var table = $(p.table);
        var dataMap = {};
        //thead
        table.append("<thead><tr><td>媒体点位</td><td>总量</td><td>月份</td></tr></thead>");
        for (var i = 1; i <= 31; i++) {
            $("tr", table).append("<td>" + i + "</td>");
        }
        //使用 positionid-turnseq-YYYY-MM作为主键,把数据整理成可绘制的形式,数据排序方式见bo  positionid asc, turnseq asc, playdate asc
        var tbody = $("<tbody></tbody>"), tr, cpmtotal=0;
        for (var m = 0; m < p.salesPlan.length; m++) {
            var plan = p.salesPlan[m], planDate = new Date(plan.playdate);
            if (dataMap[[plan.positionid, plan.turnseq, plan.playdate.slice(0, 7)]] === undefined) {
                dataMap[[plan.positionid, plan.turnseq, plan.playdate.slice(0, 7)]] = {};
                tr = $("<tr><td>" + plan.positionname + "-" + plan.turnseq + "</td><td>" + 0 + "</td><td>" + plan.playdate.slice(0, 7) + "</td></tr>");
                for (var n = 0; n < 31; n++) {
                    tr.append("<td>" + 0 + "</td>");
                }
                tbody.append(tr);
            }
            for (var k in p.adcpmsetting) {
                var ads = p.adcpmsetting[k];
                if (ads.positionid === plan.positionid && ads.turnseq === plan.turnseq && ads.playdate === plan.playdate) {
                    cpmtotal = ads.cpmtotal;
                    break;
                } else {
                    cpmtotal = 0;
                }
            }
            //2表示td偏移
            $("td", tr).eq(2 + planDate.getDate()).addClass("info").text(cpmtotal / 1000);
            $("td", tr).eq(1).text(parseInt($("td", tr).eq(1).text()) + cpmtotal / 1000);
        }
        table.append(tbody);
    },
    /**
     * 排期项选择
     * @param data  排期的数据（日期、轮数、广告位等等）
     * @param orderSchedule 排期项的页面元素
     */
    renderOrderPanData: function (data, orderSchedule,isHis) {
        var formatterFunc = function (cellvalue, rowObject, day) {
            if (cellvalue) {
                var playdate = rowObject.month + "-" + day;
                var month = rowObject.month.split('-')[1];
                var curRowClass = rowObject.positionid + "_" + rowObject.turnseq + "_" + month + "_" + playdate;
                var id = "scheduletable_" + rowObject.positionid + "_" + rowObject.turnseq + "_" + month + "_" + playdate;
                var resultList = $.parseJSON(cellvalue);
                if ( isHis && resultList.isoverplan) { //修改状态下
                    return "<div class='" + getPlanColorStyle(resultList.playsaletype) + "'><strong>" + resultList.plancount + "</strong></div>";
                }
                var html = "<div class='" + getPlanColorStyle(resultList.playsaletype) + "'><input type='checkbox' title='下单量：" + resultList.plancount + "' class='level3 scheduleitem " + curRowClass + "' value='" + resultList.planid + "'";
                html += " id='" + id + "' ";
                html += "/></div>";
                return html;
            } else {
                return "";
            }
        };
        orderSchedule.init('scheduletable', formatterFunc);
        orderSchedule.render(data);
    },

    /**
     * js 分页
     * @param paging 对应于jfinal 返回的page类对象
     * @returns {string} 返回是HTML 分页标签
     */
    pagination: function (paging) {

        var pageHtml;
        var pagingFunctionName = 'gotopage';
        //前后多少页
        var pageInterval = 2;
        if (paging.totalRow > 0) {
            var pageTemp = (paging.totalRow / paging.pageSize);
            var pageTemp2 = (paging.totalRow / paging.pageSize) + 1;
            var lastPageNo;
            if (paging.totalRow % paging.pageSize == 0) {
                lastPageNo = parseInt(pageTemp);
            } else {
                lastPageNo = parseInt(pageTemp2);
            }
            var hasNextPage = lastPageNo > paging.pageNumber;
            var hasPreviousPage = paging.pageNumber > 1;
            var previousPageNo = paging.pageNumber - 1;
            var nextPageNo = paging.pageNumber + 1;
            pageHtml = "<form class='form-inline'>";
            if (lastPageNo > 1) {
                pageHtml += "<div class='form-group'>";
                pageHtml += "<ul class='pagination pagination-sm'>";
                //上一页
                if (hasPreviousPage) {
                    pageHtml += "<li><a class='a_first' href='#'";
                    pageHtml += "onclick='" + pagingFunctionName + "(" + previousPageNo + ")" + "'> < </a>";
                    pageHtml += "</li>";
                }

                //前pageInterval页及第一页
                var paging_previous_begin = (paging.pageNumber - pageInterval);
                if (paging_previous_begin < 1) {
                    paging_previous_begin = 1;
                }
                if (paging_previous_begin > 1) {
                    pageHtml += "<li><a href='#' onclick='" + pagingFunctionName + "(" + 1 + ")" + "'>1</a></li>";
                    if (paging_previous_begin > 2) {
                        pageHtml += "<li><a style='border-top: none;border-bottom: none'>...</a></li>";
                    }
                }
                if (paging_previous_begin <= previousPageNo) {
                    for (i = paging_previous_begin; i < previousPageNo; i++) {
                        pageHtml += "<li><a href='#' onclick='" + pagingFunctionName + "(" + i + ")" + "'>" + i + "</a></li>";
                    }
                }

                //当前页
                pageHtml += " <li class='active'><a >" + paging.pageNumber + "</a></li>";
                //后pageInterval页及最后一页
                var paging_next_begin = paging.pageNumber + 1;
                if (paging_next_begin < (lastPageNo)) {
                    paging_next_end = paging_next_begin + pageInterval - 1;
                    if (paging_next_end > (lastPageNo)) {
                        var paging_next_end = lastPageNo;
                    }
                    for (i = paging_next_begin; i < paging_next_end; i++) {
                        pageHtml += "<li><a href='#' onclick='" + pagingFunctionName + "(" + i + ")" + "'>" + i + "</a></li>";
                    }

                    if (paging_next_end < lastPageNo) {
                        if (paging_next_end < lastPageNo - 1) {
                            pageHtml += " <li><a style='border-top: none;border-bottom: none'> ...</a></li>";
                        }
                        pageHtml += "<li><a href='#' onclick='" + pagingFunctionName + "(" + lastPageNo + ")" + "'>" + lastPageNo + "</a></li>";
                    }

                } else if (paging_next_begin == lastPageNo) {
                    pageHtml += "<li><a href='#' onclick='" + pagingFunctionName + "(" + lastPageNo + ")" + "'>" + lastPageNo + "</a></li>";
                }
                //下一页
                if (hasNextPage) {
                    pageHtml += "<li><a class='a_last' href='#' ";
                    pageHtml += " onclick=' " + pagingFunctionName + "(" + nextPageNo + ")" + " '>" + " > </a>";
                    pageHtml += "</li>";
                }

                pageHtml += "</ul>";
                pageHtml += "</div>";
            } else if (lastPageNo == 1) {
                pageHtml += "<div class='form-group'>";
                pageHtml += "<ul  class='pagination pagination-sm'>";
                pageHtml += "<li class='active'><a>" + paging.pageNumber + "</a></li>";
                pageHtml += "</ul>";
                pageHtml += "</div>";
            }
            pageHtml += "<div class='form-group'>";
            var currentPage = (paging.pageNumber) + 1;
            var firstPage = 1;
            pageHtml += "<label for='exampleInput' style='font-weight:normal'>共<em>" + lastPageNo + "</em>页</label>";
            if (lastPageNo > 1) {
                pageHtml += "<label for='exampleInput'style='font-weight:normal'>到第</label>";
                if (lastPageNo >= currentPage) {
                    pageHtml += "<input type='text' class='form-control' style='width: 50px;height: 30px;' value='" + currentPage + "' id='exampleInput' >";
                } else {
                    pageHtml += "<input type='text' class='form-control' style='width: 50px;height: 30px;' value='" + firstPage + "' id='exampleInput' >";
                }
                pageHtml += "<label for='exampleInput' style='font-weight:normal'>页</label> &nbsp;";
                    var fun ='javascript:gotopage($("#exampleInput").val().trim())';
                pageHtml += "<button type='button' onclick='"+fun+"' class='btn btn-default'>确定</button>";
            }
            pageHtml += "</div>";
            pageHtml += "</form>";
            return pageHtml;
        }

    }
};
/**
 * 排期类型样式
 * @param playsaletype 广告类型
 * @returns {*}
 */
function getPlanColorStyle(playsaletype) {
    var color;
    switch (playsaletype) {
        case "A":
            color = "t_zs";
            break;
        case "B":
            color = "t_ls";
            break;
        case "C":
            color = "t_fs";
            break;
        case "D":
            color = "t_ns";
            break;
        case "E":
            color = "t_blue";
            break;
        case "F":
            color = "t_green";
            break;
        case "G":
            color = "t_hs";
            break;
        case "J":
            color = "t_bc";
            break;
        case "I":
            color = "t_bl";
            break;
        case "K":
            color = "t_ls_flex";
            break;
        case "L":
            color = "t_fs_flex";
            break;
        case "M":
            color = "t_ns_flex";
            break;
        case "N":
            color = "t_js";
            break;
        case "O":
            color = "t_auto_bl";
            break;
        case "P":
            color = "t_third_bl";
            break;
    }
    return color;
}