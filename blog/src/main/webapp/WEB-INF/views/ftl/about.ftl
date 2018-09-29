<#import "spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>  <#--Templates here-->

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@template.head title="About">

    <style>
        h1,h2,h3,h4,h5,h6,p {
            color: #aea7a8;
        }

        p {
            font-size: 16pt;
            color: #fff;
        }
    </style>

</@template.head>

<#--body-->
<@template.body>

    <@template.header selected=3/>

    <section style="margin: 50px 0 200px 0; text-align: center">

        <div style="color: #fff; padding: 0 20% 0 20%; text-align: left">

            <h1>ABOUT Ramil Safin</h1>

            <p>
                Hi! I am Ramil - ITIS student and programmer. I started this project to inspire others to travel all around the world
                and join with experiences and skills.
            </p>

            <p>I’ve been traveling the world since 2006 and created this website to help others travel more while spending less. Growing up in Boston, I was never a big traveler. I didn’t take my first trip overseas until I was 23. Outside a cruise and college trip to Montreal, I had no travel experience. After college, I got a job and the standard American two weeks a year vacation. I wanted to use that time to travel. After all, it was vacation time, right? So for my first trip overseas, I went on a tour to Costa Rica. That trip changed my life. It opened me up to the possibilities of the world. I was just a sheltered middle class suburban kid before that trip. In Costa Rica, I experienced other cultures, got lost in a jungle, saw real poverty, conservation projects in action, and met people from around the world. From that moment on, I was hooked in travel. All I wanted to do was travel, see more of the world, and learn more about the people in it. But like most Americans I only had two weeks of vacation per year and I didn’t know any of the genius ways to save money and travel longer.</p>

            <img src="/assets/images/author.jpg">
            <p>I am beautiful, strong and very modest!!! Here  I am! </p>
        </div>

    </section>

</@template.body>


</html>