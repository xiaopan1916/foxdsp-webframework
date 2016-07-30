<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FOXDSP--我们是最专业、最专注、最优秀的DSP服务提供商 !</title>
    <link rel="icon" href="/static_v2/images/favicon-16x16.png" type="image/x-icon"/>
    <link rel="stylesheet" href="/static_v2/bootstrap-3.3.5-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static_v2/bootstrap-3.3.5-dist/css/bootstrap-dialog.min.css">

    <script src="/static_v2/js/jquery.js"></script>
    <script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
    <script src="/static_v2/bootstrap-3.3.5-dist/js/bootstrap-dialog.min.js"></script>
    <script src="/static_v2/js/libfun/utils.js"></script>
    <style>
        body.login2 {
            padding: 200px 0 0;
            background: #eeeeee; }
        body.login2 .login-wrapper {
            max-width: 420px;
            margin: 0 auto;
            text-align: center; }
        body.login2 .login-wrapper img {
            margin: 40px auto; }
        body.login2 .login-wrapper .input-group-addon {
            padding: 8px 0;
            background: #f4f4f4;
            min-width: 48px;
            text-align: center; }
        body.login2 .login-wrapper input.form-control {
            height: 48px;
            font-size: 15px;
            box-shadow: none; }

        body.login2 .login-wrapper input[type="submit"] {
            padding: 10px 0 12px;
            margin: 20px 0 30px; }
        body.login2 .login-wrapper input[type="submit"]:hover {
            background: transparent; }

    </style>
</head>
<body class="login2">
<div class="login-wrapper">
<div class="panel panel-default">
    <div class="panel-body">
            <form class="form-signin">
                <h2 class="form-signin-heading">FOXDSP管理平台</h2>
                <div style="height: 25px">
                    <div id="loginErr"
                         style="font-weight: bold; color: red; text-align: center;"></div>
                </div>
                <div id="usernameDiv" class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span><input type="text" id="username" name="username"  class="form-control" placeholder="用户名" required autofocus>
                    </div>
                </div>

                <div id="flpwdDiv" class="form-group">
                    <div class="input-group">
                         <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span><input type="password" id="flpwd" name="password" value="" class="form-control" placeholder="密码" required>
                    </div>
                </div>
                <div id="verifycodeLiID" class="form-group " <#if verifyCode >  <#else> style="display: none" </#if> >
                    <div class="input-group">
                    <span class="input-group-addon"> <i class="glyphicon glyphicon-check"></i></span> <input type="text" id="vcode"  <#if verifyCode > value=""
                        <#else> value="1" </#if> class="form-control" placeholder="验证码"   />

                    </div>
                    <div style="margin-top: -20px;">
                        <img id="vcodeImg" title="看不清？点击刷新X" style="cursor: pointer;height:48px;"  alt="看不清？点击刷新" />
                        <a style="display:none;cursor: pointer;" id="vcodeBtn" title="看不清，换一张验证码">换一张</a>
                    </div>

                </div>
                <button class="btn btn-lg btn-primary btn-block" type="button" id="flLoginBtn">登录</button>
            </form>
        </div>
</div>
</div> <!-- /container -->
<script type="text/javascript">
    $(document).ready(function(){
        getCode();
    });

    function getCode() {
        var vi = $("#vcodeImg"), vb = $("#vcodeBtn");
        if (vb)
            vb.click(refresh);
        vi.click(refresh);
        function refresh() {
            vi.show();
            vb.show();
            vi.attr("src", "/libfun/vcode?" + new Date().getTime());
        }
        refresh();
    }

    $("#username").bind('keydown', keydown);
    $("#flpwd").focus(function() {
        $("#flpwdLab").hide();
    }).bind('keydown', keydown);
    $("#vcode").focus(function() {
        $("#vcodeLab").hide();
    }).bind('keydown', keydown);
    $("#flLoginBtn").click(
            function() {
                var username = $("#username").val();
                var flpwd = $("#flpwd").val();
                var vcode = $("#vcode").val();
                if(username == ""){
                    $("#usernameDiv").addClass("has-error");
                    $("#flpwdDiv").removeClass("has-error");
                    showError("请输入用户名");
                    getCode();
                    return false;
                }else if(flpwd == ""){
                    $("#flpwdDiv").addClass("has-error");
                    $("#usernameDiv").removeClass("has-error");
                    showError("请输入密码");
                    getCode();
                    return false;
                }else if (vcode == ""){
                    showError("请输入验证码");
                    $("#flpwdDiv").removeClass("has-error");
                    $("#usernameDiv").removeClass("has-error");
                    $("#verifycodeLiID").addClass("has-error");
                    getCode();
                    return false;
                }
                $.ajax({
                            url:'postLogin',
                            type:'POST',
                            data:{
                                userName:username,
                                password:flpwd,
                                verifyCode:vcode
                            },
                            success:function(data){
                              if(data.code == 0){
                                  var redirect = "dspIndex";
                                  var href = window.location.href;
                                  var index = href.indexOf("path=");
                                  if ( index != -1 ) {
                                      redirect  = href.substr(index+"path=".length);
                                  }
                                  if ( redirect.indexOf("?") == -1 ) {
                                      //替换第一个& 为 ？
                                      redirect = redirect.replace("&","?");
                                  }
                                  window.location.href = redirect;
                              }else{
                                  $("#flpwd").val("");
                                  $("#vcode").val();//目前不输入验证码
                                  $("#flpwd").focus();
                                  getCode();
                                  libfun.alert(data.message);

                              }
                            },
                            error: function (data) {
                                alert("服务器出现了问题，请联系管理员，谢谢！");
                            }
                        });
            });
    function keydown(event) {
        if (event.keyCode == "13") {
            $("#flLoginBtn").click();
            return false;
        }
    }
      function showError(msg) {
        $("#loginErrLi").show();
        $("#loginErr").show().text(msg).addClass("bg-danger");
    }
</script>
</body>
</html>