<#import "spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>  <#--Templates here-->

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@template.head title="Profile"/>

<#--body-->
<@template.body>

    <@template.header selected=8/>

    <div class="container" style="margin: 70px 0 200px 0">

        <div class="row">

            <div style="text-align : center" class="col-md-4">
                <h1>Text left</h1>
            </div>

            <div style="text-align : center" class="col-md-8">
                <img src="${user.image}">
            </div>

        </div>


    </div>


</@template.body>


</html>