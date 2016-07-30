</section>
</div>
<!-- /.content-wrapper -->
<footer class="main-footer">
    <div class="pull-right hidden-xs">
        <b>Version</b> 1.0.0
    </div>
    <strong>Copyright &copy; 2014-2016 <a href="mailto:lixin@foxdsp.com">FoxDsp.com</a>.</strong>Inc. All Rights Reserved
</footer>
<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs"></ul>
    <!-- Tab panes -->
    <div class="tab-content">
        <!-- Home tab content -->
        <div class="tab-pane" id="control-sidebar-home-tab">
        </div>
    </div>
</aside>
<!-- /.control-sidebar -->
<!-- Add the sidebar's background. This div must be placed
     immediately after the control sidebar -->
<div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<#--<script src="/static_v2/js/jquery.slimscroll.min.js"></script>-->
<#--<script src="/static_v2/js/fastclick.min.js"></script>-->
<script src="/static_v2/js/app.min.js"></script>
<#-- 这个是右边栏设置选择的样式-->
<#--<script src="/static_v2/js/demo.js"></script>-->
<script>
    // 退出
    $("#logoutBtn").click(function(){
        $.ajax({
            url:'/jf/libfun/user/loginOut',
            type:'GET',
            data:{

            },
            success:function(data){
                window.location.href = "/jf/libfun/user/login";
            },
            error: function (data) {
                alert("暂时无法显示，稍后再来！");
            }
        });
    });
</script>
</body>
</html>