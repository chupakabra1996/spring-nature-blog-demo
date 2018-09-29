<#import "/spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>


<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@template.head title="Log in">
    <style>
        #loginForm{
            spellcheck : false;
        }
    </style>
</@template.head>

<@template.body>

    <@template.header selected=5/>


    <section class="awe-parallax login-page-demo">

        <div class="awe-overlay"></div>

        <div class="container">

            <div class="login-register-page__content">

                <div class="content-title">
                    <span>
                        <#if message??>
                            ${message}
                            <#elseif logout??>
                            ${logout}
                            <#else>
                            <@spring.message code="login.welomeback"/>
                        </#if>
                    </span>
                    <br>
                    <br>
                    <#if !(message?? || logout??)>
                        <h2><@spring.message code="login.explorer"/></h2>
                    </#if>

                </div>

                <@c.url value="/login" var="action"></@c.url>

                <form method='POST' action="${action}" name="loginForm" id="loginForm">

                    <#if error??>
                        <div class="alert alert-danger">
                            ${error}
                        </div>
                    </#if>

                    <div class="form-item">
                        <label for="login">Login<label>
                        <input spellcheck="false" type="text" name="login" id="login"/>
                    </div>

                    <div class="form-item">
                        <label for="password">Password<label>
                        <input type="password" name="password" id="password"/>
                    </div>

                    <br>

                    <div class="form-item">

                        <label for="remember-me"><@spring.message code="login.rememberme"/></label>
                        <input id="remember-me" type="checkbox" name="remember-me">
                    </div>

                    <a href="#" class="forgot-password"><@spring.message code="login.forgotpassword"/></a>

                    <div class="form-actions">
                        <input type="submit" value="Log In">
                    </div>

                    <@s.csrfInput/>

                </form>

                <div class="login-register-link">
                    <@spring.message code="login.account"/>
                    <a href="${mvcUri("RC#registration").build()}">
                        <@spring.message code="login.registerhere"/>
                    </a>
                </div>

            </div>

        </div>

    </section>


</@template.body>

</html>