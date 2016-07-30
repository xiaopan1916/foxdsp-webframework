<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
    <title>${pageTitle}--FoxDsp</title>
    <link rel="icon" href="/static_v2/images/favicon-16x16.png" type="image/x-icon"/>
    <style type="text/css">
        .big-dialog .modal-dialog {
            width: 750px;
        }
    </style>
    <!-- Font Awesome  字体图标的样式-->
    <#--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">-->
    <!-- Theme style 页面布局的样式-->
    <link rel="stylesheet" href="/static_v2/css/AdminLTE.min.css">
    <!-- 所有皮肤的样式-->
    <link rel="stylesheet" href="/static_v2/css/_all-skins.min.css">

    <link rel="stylesheet" href="/static_v2/bootstrap-3.3.5-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static_v2/css/datatables.min.css"   id="datatables_css">
    <link rel="stylesheet" href="/static_v2/bootstrap-3.3.5-dist/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/static_v2/bootstrap-3.3.5-dist/css/bootstrap-dialog.min.css">
    <link rel="stylesheet" href="/static_v2/bootstrap-switch-master/dist/css/bootstrap3/bootstrap-switch.min.css">
    <link rel="stylesheet" href="/static_v2/css/libfun-common.css" />

    <script src="/static_v2/js/jquery.js"></script>
    <script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
    <script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap-datepicker.js"></script>
    <script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap-datepicker.zh-CN.min.js"></script>
    <script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap-dialog.min.js"></script>
    <script src="/static_v2/js/datatables.min.js"></script>
    <script src="/static_v2/bootstrap-treeview-1.2.0/public/js/bootstrap-treeview.js"></script>
    <script src="/static_v2/bootstrap-switch-master/dist/js/bootstrap-switch.min.js"></script>
    <script src="/static_v2/js/libfun/utils.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <header class="main-header">
        <!-- Logo -->
        <a href="/jf/libfun/user/dspIndex" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>Fox</b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>FoxDsp</b></span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" data-toggle="offcanvas" class="glyphicon glyphicon-align-justify" role="button" style=" color: #fff;float: left; padding: 15px;">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown messages-menu">
                        <a href="#" class="glyphicon glyphicon-envelope" data-toggle="dropdown">
                            <i style="font-style:normal" class="fa fa-envelope-o">消息中心</i>
                            <span style="color:red;" class="totalMessage"></span>
                        </a>
                        <ul class="dropdown-menu" style="width:700px;text-align:center;height:100%;">
                                <#include "/freemarkerTemplate/libfun/messagecenter.ftl">
                        </ul>
                    </li>

                    <!-- User Account: style can be found in dropdown.less -->
                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="hidden-xs">${userName!''}</span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="/jf/libfun/user/account" class="btn btn-default btn-flat">账户设置</a>
                                </div>
                                <div class="pull-right">
                                    <a href="#" id="logoutBtn" class="btn btn-default btn-flat">退出登录</a>
                                </div>
                            </li>
                        </ul>
                    </li>

                </ul>
            </div>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- Sidebar user panel -->
            <#--<div class="user-panel">-->
                <#--<div class="pull-left">-->
                <#--</div>-->
                <#--<div class="pull-left info">-->
                    <#--<p>${userName!''}</p>-->
                <#--</div>-->
            <#--</div>-->
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <#if menus?exists>
                <#list menus as menu>
                   <#if menu.pmenuno == "0" >
                       <li class="treeview
                       <#list menus as ms >
                           <#if ms.menuurl == pageUrl>
                               <#if ms.pmenuno == menu.menuno >
                                   active
                               </#if>
                           </#if>
                       </#list>
                       ">
                           <a href="#">
                               <i class="glyphicon glyphicon-hdd"></i> <span>${menu.menuname}</span>
                               <i class="pull-right"></i>
                           </a>
                           <ul class="treeview-menu">
                               <#list menus as mu>
                                   <#if menu.menuno == mu.pmenuno>
                                       <li <#if pageUrl == mu.menuurl > class="active"</#if> >
                                           <a href="${mu.menuurl}"><i class="glyphicon glyphicon-play-circle"></i>${mu.menuname}</a>
                                       </li>
                                   </#if>
                               </#list>
                           </ul>
                       </li>
                   </#if>
                </#list>
                </#if>
                <#--<li class="treeview <#if systemManageMeun?contains(pageUrl!'')>  active </#if>">-->
                    <#--<a href="#">-->
                        <#--<i class="glyphicon glyphicon-cog"></i> <span>系统配置</span>-->
                        <#--<i class="pull-right"></i>-->
                    <#--</a>-->
                    <#--<ul class="treeview-menu">-->
                        <#--<li <#if pageUrl == "/jf/libfun/user"> class="active"</#if> >-->
                            <#--<a href="/jf/libfun/user"><i class="glyphicon glyphicon-play-circle"></i>用户管理</a>-->
                        <#--</li>-->
                        <#--<li <#if pageUrl == "/jf/libfun/libconfig"> class="active"</#if> >-->
                            <#--<a target="_self" href="/jf/libfun/libconfig"><i class="glyphicon glyphicon-play-circle"></i>系统配置维护</a>-->
                        <#--</li>-->
                        <#--<li <#if pageUrl == "/jf/libfun/array"> class="active"</#if> >-->
                            <#--<a target="_self" href="/jf/libfun/array"><i class="glyphicon glyphicon-play-circle"></i>系统数组维护</a>-->
                        <#--</li>-->
                        <#--<li <#if pageUrl == "/jf/libfun/role"> class="active"</#if> >-->
                            <#--<a href="/jf/libfun/role"><i class="glyphicon glyphicon-play-circle"></i>角色管理</a>-->
                        <#--</li>-->
                        <#--<li <#if pageUrl == "/jf/libfun/privilege"> class="active"</#if> >-->
                            <#--<a href="/jf/libfun/privilege"><i class="glyphicon glyphicon-play-circle"></i>权限管理</a>-->
                        <#--</li>-->
                        <#--<li <#if pageUrl == "/jf/libfun/menu"> class="active"</#if> >-->
                            <#--<a href="/jf/libfun/menu"><i class="glyphicon glyphicon-play-circle"></i>菜单管理</a>-->
                        <#--</li>-->
                    <#--</ul>-->
                <#--</li>-->
            <#--<#assign platform = "/jf/platform,/jf/position" />-->
                <#--<li class="treeview <#if platform?contains(pageUrl!'')>  active </#if>">-->
                    <#--<a href="#" name="platform">-->
                        <#--<i class="glyphicon  glyphicon-hdd"></i>-->
                        <#--<span>基础管理</span>-->
                        <#--<i class="fa fa-angle-left pull-right"></i>-->
                    <#--</a>-->
                    <#--<ul class="treeview-menu">-->
                        <#--<li <#if pageUrl == "/jf/platform"> class="active"</#if> ><a href="/jf/platform"><i class="glyphicon glyphicon-play-circle"></i>广告平台</a></li>-->
                        <#--<li <#if pageUrl == "/jf/position"> class="active"</#if> ><a href="/jf/position"><i class="glyphicon glyphicon-play-circle"></i>广告位</a></li>-->
                    <#--</ul>-->
                <#--</li>-->
                <#--<#assign orderManageMeun = "/jf/orderInfo" />-->
                <#--<li class="treeview <#if orderManageMeun?contains(pageUrl!'')>  active </#if>">-->
                    <#--<a href="#" name="orderManage">-->
                        <#--<i class="glyphicon glyphicon-tasks"></i>-->
                        <#--<span>订单管理</span>-->
                        <#--<i class="fa fa-angle-left pull-right"></i>-->
                    <#--</a>-->
                    <#--<ul class="treeview-menu">-->
                        <#--<li <#if pageUrl == "/jf/orderInfo"> class="active"</#if> ><a href="/jf/orderInfo"><i class="glyphicon glyphicon-play-circle"></i>订单列表</a></li>-->
                    <#--</ul>-->
                <#--</li>-->
                <#--<#assign coutomerManageMeun = "/jf/customer,/jf/customerLogo" />-->
                <#--<li class="treeview <#if coutomerManageMeun?contains(pageUrl!'')>  active </#if> ">-->
                    <#--<a href="#">-->
                        <#--<i class="glyphicon glyphicon-th-large"></i>-->
                        <#--<span>客户管理</span>-->
                        <#--<i class="fa fa-angle-left pull-right"></i>-->
                    <#--</a>-->
                    <#--<ul class="treeview-menu">-->
                        <#--<li <#if pageUrl == "/jf/customer"> class="active"</#if>  ><a href="/jf/customer"><i class="glyphicon glyphicon-play-circle"></i>客户列表</a></li>-->
                    <#--</ul>-->
                <#--</li>-->
                <#--<#assign accountManageMeun = "/jf/libfun/user/account" />-->
                <#--<li class="treeview  <#if accountManageMeun?contains(pageUrl!'')>  active </#if>  ">-->
                    <#--<a href="#">-->
                        <#--<i class="glyphicon glyphicon-user"></i> <span>账户设置</span>-->
                        <#--<i class="fa fa-angle-left pull-right"></i>-->
                    <#--</a>-->
                    <#--<ul class="treeview-menu">-->
                        <#--<li <#if pageUrl == "/jf/libfun/user/account"> class="active"</#if> >-->
                            <#--<a href="/jf/libfun/user/account"><i class="glyphicon glyphicon-play-circle"></i>我的账号</a>-->
                        <#--</li>-->
                    <#--</ul>-->
                <#--</li>-->
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
