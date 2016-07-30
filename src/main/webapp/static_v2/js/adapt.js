;(function(factory){
    if (typeof define === "function" && define.amd) {
        define("jquery.adapt", ["jquery"], function () {
            factory(window.jQuery);
        });
    } else {

        factory(window.jQuery);
    }
}(function($){
    'use strict';
    // cehcobox for sdsp
    // =========================
    var cusCheckbox = function(ele){
        this.element = $(ele);
    }
    cusCheckbox.prototype = {
        init:function(){
        },
        check:function(){

            var _ele = this.element;
            _ele.toggleClass("checked");
            var isChecked = _ele.hasClass("checked");
            _ele.attr("checked",isChecked);
            if(_ele.find("input[type=checkbox]")[0])
                _ele.find("input[type=checkbox]")[0].checked=true;
            _ele.find("input[type=checkbox]").attr("checked",isChecked);
            if(isChecked){
                var _checked = $.Event('check.bs.checkbox');
                _ele.trigger(_checked);
            }else{
                var _cancel = $.Event('cancel.bs.checkbox');
                _ele.trigger(_cancel);
            }
            var e = $.Event('change.bs.checkbox');
            _ele.trigger(e);
        }
    }
    function Plugin(e){
        if($(this).hasClass("disable") || $(this).hasClass("disabled") || $(this).attr("data-disable") == "true"){
            return false;
        }
        return new cusCheckbox($(this)).check();
    }
    var old = $.fn.cusCheckbox
    $.fn.tab             = Plugin;
    $.fn.tab.Constructor = cusCheckbox;
    $.fn.tab.noConflict = function () {
        $.fn.cusCheckbox = old
        return this
    }
    $(document).on("click.bs.cusCheckbox.data-api",'[data-toggle="checkbox"]',Plugin);
    $(document).on("ready",function(){
        $(".cus-checkbox").each(function(){
            var _ele = $(this);
            var isChecked = _ele.hasClass("checked");
            _ele.attr("checked",isChecked);
            _ele.find("input[type=checkbox]").attr("checked",isChecked);
        });
    });
}))
;(function(factory){
    if (typeof define === "function" && define.amd) {
        define("jquery.adapt", ["jquery"], function () {
            factory(window.jQuery);
        });
    } else {

        factory(window.jQuery);
    }
}(function($){
    'use strict';
    // select for sdsp
    // =========================
    var cusRadio = function(ele){
        this.element = $(ele);
    }

    cusRadio.prototype = {
        init:function(){
        },
        toggle:function(){

            var _ele = this.element;
            var name = _ele.attr("data-name");
            var input;

            if(_ele.hasClass("checked")){
                return;
            }

            /*if($("input[name="+name+"]").length>0){
             input = $("input[name="+name+"]");
             }else{
             input = $('<input type="hidden" name="'+name+'" />');
             }*/
            $("[data-name='"+name+"']").removeClass("checked");
            _ele.addClass("checked");
            //input.attr("value",_ele.attr("data-value"));

            //_ele.parent().append(input);
            var e = $.Event('change.bs.radiobox');
            _ele.trigger(e);
        }
    }
    function Plugin(e){
        if($(this).hasClass("disable") || $(this).attr("data-disable") == "true"){
            return false;
        }
        return new cusRadio($(this)).toggle();
    }
    var old = $.fn.cusRadio
    $.fn.cusRadio             = Plugin;
    $.fn.cusRadio.Constructor = cusRadio;
    $.fn.cusRadio.noConflict = function () {
        $.fn.cusRadio = old
        return this
    }

    $(document).on("click.bs.cusRadio.data-api",'[data-toggle="radiobox"]',Plugin);
    $(document).on("ready",function(){
        /*$(".cus-radiobox.checked").each(function(){
         var _ele = $(this);
         var name = _ele.attr("data-name");
         var input = $('<input type="hidden" name="'+name+'" />');
         input.attr("value",_ele.attr("data-value"));
         _ele.parent().append(input);
         }); */
    });
}))
;(function(factory){
    if (typeof define === "function" && define.amd) {
        define("jquery.adapt", ["jquery"], function () {
            factory(window.jQuery);
        });
    } else {

        factory(window.jQuery);
    }
}(function($){
    'use strict';
    // select for sdsp
    // =========================
    var cusSelect = function(ele){
        this.element = $(ele);
        this.eleOffset = {};
        this.list = "";
        this.init();
        this._id = "";
    }
    cusSelect.prototype = {
        init:function(){

            var _ele = this.element;
            var isActive = _ele.hasClass("active");
            var _input = _ele.find("input").eq(0);
            var $this = this;
            this.eleOffset = {
                top:_ele.offset().top,
                left:_ele.offset().left,
                width:_ele.width(),
                height:_ele.height()
            }
            _ele.find("ul").click(function(event){
                event.stopPropagation();
            });
        },
        closeSelect:function(e){
            var _ele = this.element;
            _ele.removeClass("open");
            _ele.find(".arrowUp").removeClass("arrowUp");
            var list = $(".cusSelectBox").find("ul");
            _ele.append(list);
            $(".cusSelectBox").remove();
            $(document).off("click.bs.closeSelect.data-api");
        },
        createBox:function(){
            var _box = $("<div></div>");
            var pos = this.eleOffset;
            _box.attr("class","cusSelectBox cus-select-list");

            this.list = this.element.find("ul");
            this.list.show();
            _box.append(this.list);
            var _ele = this.element;
            var $this = this;
            this.list.find("li").one("click.li.closeSelect.data-api",function(event){
                $this.closeSelect();
                $this.list.find("li").off("click.li.closeSelect.data-api");
                //使用符合目前py.select组件的处理
                if($(_ele).hasClass("custom-select")){
                    if(_ele.find("input.select-show").val() != $(this).text().trim()){
                        _ele.find("li").removeClass("selected");
                        $(this).addClass("selected");
                        var e = $.Event('change.bs.selectbox');
                        _ele.trigger(e);
                    }
                }else{
                    if(_ele.find("input").val() != $(this).text()){
                        _ele.find("li").removeClass("selected");
                        $(this).addClass("selected");
                        _ele.find("input").val($(this).text());
                        var e = $.Event('change.bs.selectbox');
                        var id = $this.element.attr("data-name");
                        if($("#"+id).length>0){
                            $("#"+id).val($(this).attr("data-value"));
                        }else{
                            if( document.getElementById(id)){
                                document.getElementById(id).value = $(this).attr("data-value");
                            }
                        }
                        _ele.trigger(e);
                    }
                }

            });
            $("body").append(_box);
            _box.css({
                width:pos.width,
                position:"absolute",
                top:pos.top+pos.height,
                left:_ele.offset().left,
                'z-index':'10000'
            });
            _ele.addClass("open");
            $(document).one("click.bs.closeSelect.data-api",function(e){
                $this.closeSelect();
            });
        },
        toggle:function(){
//            if(this.element.hasClass("open")){
//                this.closeSelect();
//                return false;
//            }
            if($('.open').length>0){
                this.closeAllSelect();
                return false;
            }

            if(this.element.attr('data-uptoggle')=="up"){
                this.createBoxUpSelect();
            }else{
                this.createBox();
            }

        },
//        上拉菜单开始
        createBoxUpSelect:function(){
            var _box = $("<div></div>");
            var pos = this.eleOffset;
            _box.attr("class","cusSelectBox cus-select-list");

            this.list = this.element.find("ul");
            this.list.show();
            _box.append(this.list);
            var _ele = this.element;
            var $this = this;
            this.list.find("li").one("click.li.closeSelect.data-api",function(event){

                $this.closeSelect();
                $this.list.find("li").off("click.li.closeSelect.data-api");
                if(_ele.find("input").val() != $(this).text()){
                    _ele.find("li").removeClass("selected");
                    $(this).addClass("selected");
                    _ele.find("input").val($(this).text());

                    var e = $.Event('change.bs.selectbox');
                    var id = $this.element.attr("data-name");
                    if($("#"+id).length>0){
                        $("#"+id).val($(this).attr("data-value"));
                    }else{
                        if( document.getElementById(id)){
                            document.getElementById(id).value = $(this).attr("data-value");
                        }
                    }
                    _ele.trigger(e);
                }

            });

            $("body").append(_box);
            var cusSelectBoxHeight=$(".cusSelectBox").css("height").replace("px","");

            _box.css({
                width:pos.width,
                position:"absolute",
                top:$(this)[0].eleOffset.top-cusSelectBoxHeight-1,
                left:$(this)[0].eleOffset.left,
                "border-top": "1px solid #e1e1d9",//上拉框上边框
                'z-index':'10000'
            });
            _ele.addClass("open");
            $(document).one("click.bs.closeSelect.data-api",function(e){
                $this.closeSelect();
            });
        },
        closeAllSelect:function(){
//            var _ele = $('.open');
//            _ele.removeClass("open");
//            _ele.find(".arrowUp").removeClass("arrowUp");
//            var list = $(".cusSelectBox").find("ul");
//            _ele.append(list);
//            $(".cusSelectBox").remove();
//            $(document).off("click.bs.closeSelect.data-api");
//
            $('.open').each(function(){
                $(this).removeClass("open");
                $(this).find(".arrowUp").removeClass("arrowUp");
                var list = $(".cusSelectBox").find("ul");
                $(this).append(list);
            });
            $(".cusSelectBox").remove();
            $(document).off("click.bs.closeSelect.data-api");
        }
    }
    function Plugin(e){
        if($(this).hasClass("disable") || $(this).attr("data-disable") == "true"){
            return false;
        }
        return new cusSelect($(this)).toggle();
    }
    var old = $.fn.cusSelect
    $.fn.cusSelect             = Plugin;
    $.fn.cusSelect.Constructor = cusSelect;
    $.fn.cusSelect.noConflict = function () {
        $.fn.cusSelect = old
        return this
    }

    $(document).on("click.bs.cusSelect.data-api",'[data-toggle="select"]',Plugin);
    //$('[data-toggle="select"]').bind("click.bs.cusSelect.data-api",Plugin);

}))