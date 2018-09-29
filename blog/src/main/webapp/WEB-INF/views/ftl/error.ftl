<#import "spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>  <#--Templates here-->

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->



<!DOCTYPE html>
<html lang="en">

<#if title??>
    <#assign pTitle="${title}"/>
    <#else>
    <#assign pTitle="Error"/>
</#if>

<#--head-->
<@template.head title="${pTitle}">
    <style>

        .wrap{
            background-color: #353535;
            opacity: 0.6;
            margin: 200px 250px 0 590px;
        }


        h2{
            color : #dff1dd;
            font-size: 14pt;
            text-align: center;
        }

        #page-wrap{
            background-image: url("/assets/images/errors/error.jpg");

        }
        
        .code{
            color: red;
        }

        h1{
            text-align: center;
        }

    </style>
</@template.head>

<#--body-->
<@template.body>

    <@template.header/>

    <section style="margin: 150px 0  32% 0;">

        <div class="wrap">
            <#if code??>
                <#if code == 404>
                    <h1><span class="code">404 <@spring.message code="page.notfound.text"/></span></h1>
                    <h2>We are sorry but the page you ae looking for doesn't exist.</h2>
                    <h2>You could return to the homepage.</h2>
                    <h2>Don't worry =)</h2>
                <#elseif code == 400>
                    <h1><span class="code">400 <@spring.message code="page.badrequest"/></span></h1>
                    <h2>Your browser sent a request that our browser couldn't understand.</h2>
                    <h2>Check the URL and try again.</h2>
                <#elseif code == 403>
                    <h1><span class="code">403 <@spring.message code="page.accessdenied"/></span></h1>
                    <h2>You haven't got permissions.</h2>
                <#elseif code == 500>
                    <h1><span class="code">500 <@spring.message code="page.internalrserver"/></span></h1>
                    <h2>We are experiencing an internal server problem.</h2>
                <#else>
                    <h2>We are sorry but some unexpected error occurred!</h2>
                </#if>
                <#else>
                    <h2 style="font-size: 18pt;">We are sorry but some unexpected error occurred!</h2>
            </#if>
        </div>

    </section>

</@template.body>


</html>