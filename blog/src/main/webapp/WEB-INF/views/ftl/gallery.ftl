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

    <!-- MASONRY -->
    <section class="masonry-section-demo">
        <div class="container">
            <div class="destination-grid-content">

                <div class="section-title">
                    <h5 class="text-uppercase">Gallery</h5>
                </div>

                <div class="row">
                    <div class="awe-masonry">
                        <!-- GALLERY ITEM -->
                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/1.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/2.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/3.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/4.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/5.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/6.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/7.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/8.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/9.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/10.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/11.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/12.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/13.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/14.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/15.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>

                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/16.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/17.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/18.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/19.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/20.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/21.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>



                        <div class="awe-masonry__item">
                            <a href="#">
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/gallery/22.jpg"/>" alt="">
                                </div>
                            </a>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- END / MASONRY -->

</@template.body>


</html>