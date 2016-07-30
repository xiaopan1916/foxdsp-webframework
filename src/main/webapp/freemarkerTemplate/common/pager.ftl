<#--## 基于Page类的分页组件-->
<#--调用方法如下-->
<#--<#import "page.ftl" as pager >-->
<#--<@pager.pagination paging = paging > </@pager.pagination>-->
<#macro pagination paging queryUrl>
    <#assign pagingFunctionName = "gotopage" >
<#--## 前后多少页-->
    <#assign pageInterval = 2 >
    <#if (paging.totalRow > 0)  >
        <#assign  pageTemp = (paging.totalRow / paging.pageSize) >
        <#assign  pageTemp2 = (paging.totalRow / paging.pageSize) + 1 >
        <#if (paging.totalRow % paging.pageSize == 0) >
            <#assign  lastPageNo = pageTemp?int >
        <#else>
            <#assign  lastPageNo = pageTemp2?int >
        </#if>

        <#assign hasNextPage =  lastPageNo gt paging.pageNumber >
        <#assign hasPreviousPage =   paging.pageNumber gt 1 >
        <#assign previousPageNo =   paging.pageNumber - 1 >
        <#assign nextPageNo =   paging.pageNumber + 1 >

        <div class="form-inline">
        <#if (lastPageNo > 1) >
            <div class="form-group">
                <ul class="pagination pagination-sm">
                <#--## 上一页-->
                    <#if (hasPreviousPage) >
                        <li><a class="a_first" href="${queryUrl}?_querypageNumber=${previousPageNo}"> < </a></li>
                    </#if>

                <#--## 前pageInterval页及第一页-->
                    <#assign paging_previous_begin = (paging.pageNumber - pageInterval) >
                    <#if (paging_previous_begin < 1)>
                        <#assign paging_previous_begin = 1 >
                    </#if>
                    <#if (paging_previous_begin > 1)>
                        <li><a href="${queryUrl}?_querypageNumber=1">1</a></li>
                        <#if (paging_previous_begin > 2) >
                            <li><a style="border-top: none;border-bottom: none">...</a></li>
                        </#if>
                    </#if>

                    <#if (paging_previous_begin <= previousPageNo) >
                        <#list paging_previous_begin..previousPageNo as i >
                            <li><a href="${queryUrl}?_querypageNumber=${i}" >${i}</a></li>
                        </#list>
                    </#if>
                <#--## 当前页-->
                    <li class="active"><a >${paging.pageNumber}</a></li>
                <#--## 后pageInterval页及最后一页-->
                    <#assign paging_next_begin = paging.pageNumber + 1 >
                    <#if (paging_next_begin < (lastPageNo)) >
                        <#assign paging_next_end = paging_next_begin + pageInterval - 1>
                        <#if (paging_next_end > (lastPageNo)) >
                            <#assign paging_next_end = lastPageNo >
                        </#if>
                        <#list paging_next_begin..paging_next_end as i>
                            <li><a href="${queryUrl}?_querypageNumber=${i}" >${i}</a></li>
                        </#list>
                        <#if (paging_next_end < lastPageNo) >
                            <#if (paging_next_end < lastPageNo - 1) >
                                <li><a style="border-top: none;border-bottom: none"> ...</a></li>
                            </#if>
                            <li><a href="${queryUrl}?_querypageNumber=${lastPageNo}" >${lastPageNo}</a></li>
                        </#if>
                    <#elseif (paging_next_begin == lastPageNo) >
                        <li><a href="${queryUrl}?_querypageNumber=${lastPageNo}" >${lastPageNo}</a></li>
                    </#if>

                <#--## 下一页-->
                    <#if (hasNextPage) >
                        <li><a class="a_last" href="${queryUrl}?_querypageNumber=${nextPageNo}" style="font-family:'宋体';font-weight:bold;vertical-align:top;"> > </a></li>
                    </#if>
                </ul>
            </div>
        <#elseif (lastPageNo == 1) >
            <div class="form-group">
                <ul  class="pagination pagination-sm">
                    <li class="active"><a>${paging.pageNumber}</a></li>
                </ul>
            </div>
        </#if>
        <div class="form-group">
            <#assign currentPage = (paging.pageNumber) + 1 >
            <#assign firstPage=1  >
            <label for="exampleInput" style="font-weight:normal">共<em>${lastPageNo}</em>页</label>
            <#if (lastPageNo > 1) >
                <label for="exampleInput" style="font-weight:normal">到第</label>
                <input type="text" class="form-control" style="width: 50px;height: 30px;" value="${paging.pageNumber}" name="_querypageNumber" >
                <label for="exampleInput" style="font-weight:normal">页</label>
                &nbsp;
                <button type="submit" class="btn btn-default">确定</button>
            </#if>
        </div>
        </div>
    </#if>
</#macro>