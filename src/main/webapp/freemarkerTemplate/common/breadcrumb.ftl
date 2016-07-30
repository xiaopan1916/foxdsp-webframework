<#macro breadcrumb  listName>
<section class="content-header">
    <h1><small></small> </h1>
    <ol class="breadcrumb">
        <li><a href="/jf/libfun/user/dspIndex"><i class="glyphicon glyphicon-home"></i>Home</a></li>
        <#assign pmenuno = "">
        <#assign lastName = "">
        <#list menus as ms>
            <#if ms.menuurl == listName>
                <#assign pmenuno = ms.pmenuno>
                <#assign lastName = ms.menuname>
                <#break>
            </#if>
        </#list>
        <#list menus as ms>
            <#if ms.menuno == pmenuno>
                <li><a href="${ms.menuurl}">${ms.menuname}</a></li>
                <#break>
            </#if>
        </#list>
        <li class="active">${lastName}</li>
        <#--<#assign keys=listName?keys>-->
        <#--<#list keys as key >-->
            <#--<#if (keys?size == key_index+1) >-->
                <#--<li class="active">${listName[key]}</li>-->
             <#--<#else>-->
                 <#--<li><a href="${key}">${listName[key]}</a></li>-->
            <#--</#if>-->
        <#--</#list>-->
    </ol>
</section>
<!-- Main content -->
<section class="content">
</#macro>