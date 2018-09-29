<#import "spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>  <#--Templates here-->

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">


<#--head-->
<@template.head title="Travelling">
    <#-- REVOLUTION DEMO -->
    <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/revslider-demo/css/settings.css"/>">
</@template.head>



<#--body-->
<@template.body>

    <#--header-->
    <@template.header selected=0/>

    <#-- HERO SECTION -->
    <section class="hero-section">
        <div id="slider-revolution">
            <ul>
                <li data-slotamount="7" data-masterspeed="500" data-title="Slide title 1">
                    <img src="<@c.url value="/assets/images/img/3.jpg"/>" data-bgposition="left center" data-duration="14000"
                         data-bgpositionend="right center" alt="">

                    <div class="tp-caption sfb fadeout slider-caption-sub slider-caption-sub-1" data-x="150" data-y="230"
                         data-speed="700" data-start="1500" data-easing="easeOutBack">
                        Travelling all around the world
                    </div>

                    <div class="tp-caption sfb fadeout slider-caption slider-caption-1" data-x="center" data-y="280"
                         data-speed="700" data-easing="easeOutBack" data-start="2000">Amazing stories
                    </div>

                    <a href="${mvcUri("PC#showAllPosts").arg(0, "all").arg(1, "1").arg(2, "desc").build()}" class="tp-caption sfb fadeout awe-btn awe-btn-style3 awe-btn-slider" data-x="center"
                       data-y="380" data-easing="easeOutBack" data-speed="700" data-start="2200">READ now</a>
                </li>

            </ul>
        </div>
    </section>

    <#-- MASONRY -->
    <@template.masonry/>

</@template.body>


</html>