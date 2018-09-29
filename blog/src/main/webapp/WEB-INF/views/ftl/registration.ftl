<#import "/spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as tempalte>

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@tempalte.head title="Registration">
    <style>
        #reg{
            spellcheck : false;
        }
    </style>
</@tempalte.head>

<@tempalte.body>

    <@tempalte.header selected=7/>

    <section class="awe-parallax register-page-demo">

        <div class="container">

            <div class="login-register-page__content">

                <div class="content-title">
                    <span style="color: whitesmoke;"><@spring.message code="register.stayathome"/></span>
                    <br>
                    <br>
                    <h2><@spring.message code="register.joinus"/></h2>
                </div>

                <@c.url value='${mvcUri("RC#registerUser").build()}' var="link"/>

                <@f.form modelAttribute="user" action="${link}" method="POST" acceptCharset="UTF-8" id="reg">

                    <div class="form-item">
                        <@f.label path="name" for="name">Name</@f.label>
                        <@f.input path="name" id="name"/>
                        <@f.errors path="name"/>
                    </div>

                    <div class="form-item">
                        <@f.label path="login" for="login">Login</@f.label>
                        <@f.input path="login" id="login"/>
                        <@f.errors path="login"/>
                    </div>

                    <div class="form-item">
                        <@f.label path="email" for="email">Email</@f.label>
                        <@f.input path="email" id="email"/>
                        <@f.errors path="email"/>
                    </div>


                    <div class="form-item">
                        <@f.label path="password" for="password">Password</@f.label>
                        <@f.password path="password"/>
                        <@f.errors path="password"/>
                    </div>

                    <div class="form-item">
                        <@f.label path="passwordRepeat" for="passwordRepeat">Confirm password</@f.label>
                        <@f.password path="passwordRepeat"/>
                        <@f.errors path="password"/>
                    </div>


                    <div class="form-item">
                        <@f.label path="sex" for="sex">Gender</@f.label>
                        <@f.select path="sex" cssStyle="width : 120px">
                            <@f.option value="Male"/>
                            <@f.option value="Female"/>
                        </@f.select>
                    </div>


                    <#--TODO accept conditions -->
                    <a href="#" class="terms-conditions"><@spring.message code="register.terms-conditions"/></a>


                    <div class="form-actions">
                        <input type="submit" value="Sign Up">
                    </div>

                    <@s.csrfInput/>

                </@f.form>

                <div class="login-register-link">
                    <@spring.message code="register.haveaccount"/> &nbsp;
                    <a href="<@c.url value="/login" />">
                        <@spring.message code="register.loginhere"/>
                    </a>
                </div>

            </div>

        </div>

    </section>

</@tempalte.body>


</html>