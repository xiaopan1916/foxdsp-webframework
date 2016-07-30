<#assign pageTitle= "错误提示" >
<#assign pageUrl="/jf/orderInfo">
<#include "/freemarkerTemplate/common/header.ftl">
<script type="text/javascript">
    $(document).ready(function(){
        var msg = "${message.replaceAll("\n","").replaceAll("\t","")}";
        libfun.alert(msg);
        console && console.log && console.log(msg);
    });
</script>
