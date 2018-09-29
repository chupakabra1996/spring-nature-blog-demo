<#import "/spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@template.head title="Post">

    <@s.csrfMetaTags/>

    <script>

        //csrf meta
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");


        //csrf allowing
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });

        $(document).ready(function() {

            //like
            $("#like").find('a').click(function (event) {

                event.preventDefault();

                var data = {};

                data["postId"] = parseInt($("#postId").val());

                console.log(data);

                $.ajax({
                    type : "POST",
                    contentType : "application/json",
                    url : " ${mvcUri('LC#performLike').build()}",
                    data : JSON.stringify(data),
                    dataType : 'json',
                    timeout : 100000,
                    success : function(data) {
                        //changing comments count

                        if (data.code != 200){
                            console.log(data.code);
                            return;
                        }

                        var value = parseInt($("#like_count").text()) + 1;
                        $("#like_count").text(value);
                    },
                    error : function(e) {
                        alert("Can't like post!");
                        console.log("ERROR");
                        console.log(data);
                    },
                    done : function(e) {
                        console.log(e);
                    }
                });
                
            });


            //comment
            $("#comment_form").submit(function(event) {

                enableButton(false);

                // Prevent the form from submitting via the browser.
                event.preventDefault();

                addCommentViaAjax();

            });
        });

        function addCommentViaAjax() {

            var data = {};

            data["comment"] = $("#comment").val();
            data["postId"] = $("#postId").val();

            $.ajax({
                type : "POST",
                contentType : "application/json",
                url : " ${mvcUri('CC#performComment').build()}",
                data : JSON.stringify(data),
                dataType : 'json',
                timeout : 100000,
                success : function(data) {
                    $("#comment").val("");

                    //changing comments count
                    var cc = parseInt($(".cc").text()) + 1;
                    $(".cc").text(cc);
                    $("#zero_none").show();
                    $(".cc2").text(cc);
                    $(".no_c_text").text(" Comments");

                    display(data);
                },
                error : function(e) {
                    console.log("ERROR");
                    alert("Can't add comment!");
                },
                done : function(e) {
                    console.log(e);
                }
            });


        }

        function enableButton(flag) {
            $("#submit_comment").prop("disabled", flag);
        }

        //display comment
        function display(data) {

            var html = "<li class='comment' style='display: none'>" +

                        "<div class='comment-box'>" +

                            "<div class='comment-author' style='margin-top: 5px'>" +
                                "<a href='" + data.result.userProfileLink  + "'>" +
                                    "<img src='" +  data.result.imageLink +"'>" +
                                "</a>" +
                            "</div>" +

                            "<div class='comment-body'>" +

                                "<cite class='fn'>" +
                                    "<a href='"+ data.result.userProfileLink + "'>" +
                                         data.result.userName +
                                    "</a>" +
                                "</cite>" +

                                "<p style='color: #c2c2c2;'> " +  data.result.comment +  " </p>" +

                                "<div class='comment-meta'>" +
                                    "<span class='date'>" + data.result.dateTime + "</span>" +
                                "</div>" +

                                "<div class='comment-abs'>" +
                                "<a class='comment-edit-link'>Edit</a>" +
                                 "</div>" +

                            "</div>" +

                        "</div>" +

                    "</li>";

            $(html).prependTo('#addContent').fadeIn(4000);
        }

    </script>

</@template.head>

<@template.body class="single-post">

    <@template.header selected=1/>

    <!-- HEADING PAGE -->
    <section class="awe-parallax page-heading-demo" style="height: 500px">
        <div class="awe-overlay"></div>
        <div class="container">
            <div class="blog-heading-content text-uppercase">
                <h2>Post</h2>
            </div>
        </div>
    </section>

    <section class="blog-page">

        <div class="container">

            <div class="row">

                <div class="col-md-9">

                    <div class="blog-page__content blog-single">

                        <#if post??>

                            <#assign user_profile="${mvcUri('UC#showGuestProfile').arg(0, '${user.id}').build()}"/>

                            <!-- POST -->
                            <div class="post">

                                <div class="post-meta">

                                    <div class="date">${post.dateTime}</div>
                                    <div class="author">by
                                        <a href="${user_profile}">${user.login}</a>
                                    </div>
                                    <div class="comment">
                                        <a href="#comments">
                                        <span class="cc">${comments?size}</span> Comments &raquo;
                                        </a>
                                    </div>
                                </div>

                                <div class="post-title">
                                    <h1>${post.title}</h1>
                                </div>

                                <div class="post-media">
                                    <div class="image-wrap">
                                        <#assign img_link ="${mvcUri('ILC#loadPostImage').arg(0, post.id).build()}">
                                        <img src="<@c.url value="${img_link}"/>">
                                    </div>
                                </div>

                                <div class="post-body">

                                    <div class="post-content" style="font-size: 14pt">
                                        ${post.content}
                                    </div>

                                </div>


                                <div id="like" style="text-align: right; padding-right: 10%;">

                                    <#--<a href="#" style="font-size: 36pt; color: #ae0a1b">-->
                                        <#--<span style="font-size: 30pt;" class="glyphicon glyphicon-heart-empty"></span>-->
                                    <#--</a>-->
                                        <span>
                                            <a style="font-size: 36pt; color:#3aae3e;">
                                                <span style="font-size: 30pt;" class="glyphicon glyphicon-heart"></span>
                                            </a>
                                            <span id="like_count" style="font-size: 30pt">${post.postLikes?size}</span>
                                        </span>


                                </div>

                            </div>

                            <input id="postId" type="hidden" value="${post.id}">
                            <!-- END / POST -->

                        </#if>


                        <#if user??>
                            <!-- ABOUT AUTHOR -->
                            <div class="about-author">

                                <div class="image-thumb fl">

                                    <div class="image-cover">

                                        <#--TODO authors image here-->
                                        <a href="${user_profile}">
                                            <img src="<@c.url value='${user.image}'/>">
                                        </a>

                                    </div>

                                </div>

                                <div class="author-info">

                                    <div class="author-title">
                                        <h4>Author</h4>
                                    </div>

                                    <div class="author-name">
                                        <h3>
                                            <a href="${user_profile}">${user.login}</a>
                                        </h3>
                                    </div>

                                </div>

                            </div>
                            <!-- END / ABOUT AUTHOR -->
                        </#if>

                        <!-- RECENT POSTS -->
                        <div class="related-post">
                            <h4>Recent posts</h4>
                            <div class="related-slider">

                                <#if recentPosts??>
                                    <#list recentPosts as rp>

                                        <div class="post">

                                            <div class="post-media">
                                                <div class="image-wrap">
                                                    <a href="${mvcUri("PC#showPost").arg(0, '${rp.id}').build()}">
                                                        <img src="${mvcUri('ILC#loadPostImage').arg(0, rp.id).build()}" alt="">
                                                    </a>
                                                </div>
                                            </div>

                                            <div class="post-body">

                                                <div class="post-meta">

                                                    <div class="date">${rp.dateTime}</div>
                                                    <div class="author">by
                                                        <a href="${mvcUri('UC#showGuestProfile').arg(0, '${rp.user.id}').build()}">${rp.user.name}</a>
                                                    </div>


                                                </div>

                                                <div class="post-title">
                                                    <h2>
                                                        <a href="${mvcUri("PC#showPost").arg(0, '${rp.id}').build()}">
                                                            ${rp.title}
                                                        </a>
                                                    </h2>
                                                </div>

                                                <#--TODO in proccess-->
                                                <#--<div class="post-content">-->
                                                    <#--<#if rp.content?length gt 100>-->
                                                            <#--${rp.content?substring(0,100)}-->
                                                        <#--<#else>-->
                                                            <#--${rp.content}-->
                                                    <#--</#if>-->
                                                <#--</div>-->

                                                <div class="post-link">
                                                    <a href="${mvcUri("PC#showPost").arg(0, '${rp.id}').build()}" class="awe-btn awe-btn-style2">
                                                        Read more
                                                    </a>
                                                </div>

                                            </div>
                                        </div>

                                    </#list>
                                </#if>

                            </div>
                        </div>
                        <!-- END / RELATED POSTS -->




                            <!-- COMMENTS -->
                            <div id="comments">

                                <!-- LEAVE YOUR COMMENT -->
                                <div id="respond">

                                    <div class="reply-title">
                                        <#if comments??>
                                            <#if comments?size gt 0>
                                                <h4 >
                                                    <span class="cc2">${comments?size}</span> Comments
                                                </h4>
                                            <#else>
                                                <h4>
                                                    <span id="zero_none" class="cc2" style="display: none;">${comments?size}</span>
                                                    <span class="no_c_text">There is no comments ...</span>
                                                </h4>
                                            </#if>
                                        </#if>
                                    </div>


                                    <form spellcheck="false" id="comment_form">

                                        <div class="row">

                                            <div class="col-md-12">
                                                <div class="form-item form-textarea-wrapper">
                                                    <textarea id="comment" placeholder="Write down comment here ...">

                                                    </textarea>
                                                </div>

                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-actions">
                                                    <input id="submit_comment" type="submit" value="Post Comment">
                                                </div>
                                            </div>

                                        </div>

                                    </form>

                                </div>
                                <!-- END / LEAVE YOUR COMMENT -->


                                <#--Comments -->
                                <div class="commentlist-wrapper">

                                    <ul class="commentlist" id="addContent">

                                        <#if comments??>

                                            <#list comments as comment>

                                                <#assign comment_user="${mvcUri('UC#showGuestProfile').arg(0, '${comment.user.id}').build()}"/>

                                                <li class="comment">

                                                    <div class="comment-box">

                                                        <div class="comment-author" style="margin-top: 5px">
                                                            <a href="${comment_user}">
                                                                <img src="<@c.url value='${comment.user.image}'/>">
                                                            </a>
                                                        </div>

                                                        <div class="comment-body">

                                                            <cite class="fn">
                                                                <a href="${comment_user}">
                                                                    ${comment.user.name}
                                                                </a>
                                                            </cite>

                                                            <p style="color: #c2c2c2;"> ${comment.comment} </p>

                                                            <div class="comment-meta">
                                                                <span class="date">${comment.dateTime}</span>
                                                            </div>


                                                            <#if (currentUser?? && currentUser.id == comment.user.id) >
                                                                <div class="comment-abs">
                                                                    <a class="comment-edit-link">Edit</a>
                                                                </div>
                                                            </#if>

                                                        </div>

                                                    </div>

                                                </li>

                                            </#list>

                                        </#if>

                                    </ul>

                                </div>

                            </div>
                            <!-- END / COMMENTS -->
                    </div>

                </div>

                <#--SIDEBAR-->
                <div class="col-md-3">

                    <div class="page-sidebar">

                        <!-- WIDGET -->
                        <div class="widget widget_follow_us">
                            <h3>Follow us</h3>
                            <div class="awe-social">
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-pinterest"></i></a>
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                            </div>
                        </div>
                        <!-- END / WIDGET -->

                        <!-- WIDGET -->
                        <div class="widget widget_categories">
                            <ul>
                                <li>
                                    <a href="${mvcUri("PC#showAllPosts").arg(0, "all").arg(1, "1").arg(2, "desc").build()}">
                                        <@spring.message code="menu.blog.all"/>
                                    </a>
                                </li>
                                <li>
                                    <a href="${mvcUri("PC#showAllPosts").arg(0, "popular").arg(1, "1").arg(2, "desc").build()}">
                                        <@spring.message code="menu.blog.popular"/>
                                    </a>
                                </li>
                                <li>
                                    <a href="${mvcUri("PC#showAllPosts").arg(0, "recent").arg(1, "1").arg(2, "desc").build()}">
                                        <@spring.message code="menu.blog.recent"/>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <!-- END / WIDGET -->


                        <!-- WIDGET -->
                        <div class="widget widget_has_thumbnail">

                            <h3>Recent Posts</h3>


                            <ul>
                                <#if recentPosts??>
                                    <#list recentPosts as rp>
                                        <li>
                                            <div class="image-wrap image-cover">
                                                <a href="${mvcUri("PC#showPost").arg(0, '${rp.id}').build()}">
                                                    <#assign img_link ="${mvcUri('ILC#loadPostImage').arg(0, rp.id).build()}">
                                                    <img src="<@c.url value="${img_link}"/>" alt="">
                                                </a>
                                            </div>

                                            <div class="content">
                                                <a href="${mvcUri("PC#showPost").arg(0, '${rp.id}').build()}">
                                                    ${rp.title}
                                                </a>
                                            </div>

                                        </li>
                                    </#list>
                                </#if>
                            </ul>
                        </div>
                        <!-- END / WIDGET -->

                    </div>

                </div>

            </div>

        </div>

    </section>


</@template.body>

</html>