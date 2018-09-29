<#import "/spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@template.head title="Blog">

    <style>
        .format_text h1{
            font-size: 14pt;
        }
    </style>
</@template.head>

<@template.body>

    <@template.header selected=1/>

    <!-- HEADING PAGE -->
    <section class="awe-parallax category-heading-section-demo">

        <div class="awe-overlay"></div>

        <div class="container">

            <div class="container">
                <div class="blog-heading-content text-uppercase">
                    <h2>TRAVEL BLOG</h2>
                </div>
            </div>

            <div class="category-heading-content category-heading-content__2 text-uppercase">

                <!-- BREADCRUMB -->
                <div class="find">

                    <h2 class="text-center">Find An Interesting Post</h2>

                </div>

            </div>

        </div>

    </section>
    <!-- END / HEADING PAGE -->

    <#--POSTS-->
    <section class="blog-page">

        <div class="container">

            <div class="row">

                <#if page??>
                    <div class="col-md-9">
                        <div class="blog-page__content">

                            <br><br><br>

                            <@c.url var="firstUrl" value='${mvcUri("PC#showAllPosts").arg(0,"${type}").build()}'/>
                            <@c.url var="lastUrl" value='${mvcUri("PC#showAllPosts").arg(0,"${type}").arg(1,"${page.totalPages}").build()}'/>
                            <@c.url var="prevUrl" value='${mvcUri("PC#showAllPosts").arg(0,"${type}").arg(1,"${current - 1}").build()}'/>
                            <@c.url var="nextUrl" value='${mvcUri("PC#showAllPosts").arg(0,"${type}").arg(1,"${current + 1}").build()}'/>

                            <!-- POST -->
                            <#assign posts = page.getContent()/>

                            <#list posts as p>

                                <#assign link_post='${mvcUri("PC#showPost").arg(0,p.id).build()}'/>

                                <div class="post">

                                    <!-- Image post -->
                                    <div class="post-media">

                                        <div class="image-wrap">
                                            <a href="${link_post}">
                                                <#assign img_link ="${mvcUri('ILC#loadPostImage').arg(0, p.id).build()}">
                                                <img src='${img_link}'>
                                            </a>
                                        </div>

                                    </div>

                                    <div class="post-body">

                                        <div class="post-meta">
                                            <div class="date"> ${p.dateTime} </div>
                                            <#assign link_user='${mvcUri("UC#showGuestProfile").arg(0, p.getUser().id).build()}'/>
                                            <div class="author">by <a href="${link_user}"> ${p.user.login} </a></div>
                                        </div>

                                        <div class="post-title">
                                            <h2>
                                                <a href='${link_post}'> ${p.title} </a>
                                            </h2>
                                        </div>

                                        <div class="post-content">
                                            <#assign length = p.content?length>

                                            <#--TODO in proccess-->
                                            <#--<#if (length <= 250)>-->
                                                <#--<span class="format_text">-->
                                                    <#--${p.content}-->
                                                <#--</span>-->
                                                <#--<#else>-->
                                                <#--<span class="format_text">-->
                                                    <#--${p.content?substring(0, 200)} [...]-->
                                                <#--</span>-->
                                            <#--</#if>-->
                                        </div>

                                        <p> Likes : ${p.postLikes?size}</p>

                                        <div class="post-link">
                                            <a href="${link_post}" class="awe-btn awe-btn-style2">Read more</a>
                                        </div>

                                    </div>

                                </div>
                            </#list>
                            <!-- END / POST -->


                        <#--left side-->
                            <ul class="page__pagination pagination">
                                <#if (current == 1)>
                                    <li class="disabled"><a href="#">&lt;&lt;</a></li>
                                    <li class="disabled"><a href="#">&lt;</a></li>
                                <#else>
                                    <li><a href="${firstUrl}">&lt;&lt;</a></li>
                                    <li><a href="${prevUrl}">&lt;</a></li>
                                </#if>

                                <#list begin..end as i>

                                    <@c.url var="pageUrl" value='${mvcUri("PC#showAllPosts").arg(0,"${type}").arg(1,"${i}").arg(2, "desc").build()}'/>

                                    <#if (i == current)>
                                        <li class="active"><a href="${pageUrl}">${i}</a></li>
                                    <#else>
                                        <li><a href="${pageUrl}">${i}</a></li>
                                    </#if>
                                </#list>

                                <#if (current == page.totalPages)>
                                    <li class="disabled"><a href="#">&gt;</a></li>
                                    <li class="disabled"><a href="#">&gt;&gt;</a></li>
                                <#else>
                                    <li><a href="${nextUrl}">&gt;</a></li>
                                    <li><a href="${lastUrl}">&gt;&gt;</a></li>
                                </#if>
                            </ul>

                        </div>
                    </div>
                    <div class="col-md-3">

                        <div class="page-sidebar">

                            <!-- WIDGET -->
                            <div class="widget widget_follow_us">
                                <h3><@spring.message code="sidebar.followus"/></h3>
                                <div class="awe-social">
                                    <a href="https://vk.com/itis11403"><i class="fa fa-twitter"></i></a>
                                    <a href="https://vk.com/itis11403"><i class="fa fa-pinterest"></i></a>
                                    <a href="https://vk.com/itis11403"><i class="fa fa-facebook"></i></a>
                                    <a href="https://vk.com/itis11403"><i class="fa fa-youtube-play"></i></a>
                                </div>
                            </div>
                            <!-- END / WIDGET -->

                            <!-- WIDGET -->
                            <div class="widget widget_categories">
                                <h3><@spring.message code="sidebar.categories"/></h3>
                                <ul>
                                    <li><a href='${mvcUri("PC#showAllPosts").arg(0,"all").arg(1, "1").arg(2, "desc").build()}'>
                                        <@spring.message code="menu.blog.all"/>
                                    </a></li>
                                    <li><a href='${mvcUri("PC#showAllPosts").arg(0,"popular").arg(1, "1").arg(2, "desc").build()}'>
                                        <@spring.message code="menu.blog.popular"/>
                                    </a></li>
                                    <li><a href='${mvcUri("PC#showAllPosts").arg(0,"recent").arg(1, "1").arg(2, "desc").build()}'>
                                        <@spring.message code="menu.blog.recent"/>
                                    </a></li>
                                </ul>
                            </div>

                        </div>

                    </div>
                    <#else>

                    <div class="col-md-12" style="margin-top: 100px; margin-bottom: 400px; text-align: center">
                        <h2 style="color : #72BF4E">There is no posts yet</h2>
                    </div>

                </#if>
            </div>

        </div>

    </section>

</@template.body>

</html>