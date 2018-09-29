<#import "/spring.ftl" as spring>

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<#macro head title="Title" includeJs=true>

    <head>
        <#--<meta charset="utf-8">-->
        <#--<meta content="text/html" charset="utf-8">-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- TITLE -->
        <title>${title}</title>

        <link rel="shortcut icon" href="<@c.url value="/assets/favicon.ico"/>" type="image/icon">
        <link rel="icon" href="<@c.url value="/assets/favicon.ico"/>" type="image/icon">

        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes">

        <!-- GOOGLE FONT -->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:700,600,400,300' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Oswald:400' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>

        <!-- CSS LIBRARY -->
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/lib/bootstrap.min.css"/>">
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/lib/font-awesome.min.css"/>">
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/lib/awe-booking-font.css"/>">
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/lib/owl.carousel.css"/>">
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/lib/jquery-ui.css"/>">
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/bootstrap-formhelpers.css"/>">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

        <script type="text/javascript" src="<@c.url value="/assets/js/lib/jquery-2.2.3.min.js"/>"></script>
        <script type="text/javascript" src="<@c.url value="/assets/js/jquery.cookie.js"/>"></script>
        <script type="text/javascript" src="<@c.url value="/assets/js/bootstrap-formhelpers.js"/>"></script>

        <script type="text/javascript" src="<@c.url value="/assets/js/lib/masonry.pkgd.min.js"/>"></script>
        <script type="text/javascript" src="<@c.url value="/assets/js/lib/jquery.owl.carousel.js"/>"></script>
        <script type='text/javascript' src="<@c.url value="/assets/js/lib/jquery-ui.js"/>"></script>
        <script type="text/javascript" src="<@c.url value="/assets/js/lib/theia-sticky-sidebar.js"/>"></script>

        <!-- MAIN STYLE -->
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/style.css"/>">
        <link rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/demo.css"/>">

        <!-- CSS COLOR -->
        <link id="colorreplace" rel="stylesheet" type="text/css" href="<@c.url value="/assets/css/colors/green.css"/>">

        <#--spellcheck false-->
        <script>
            $(document).ready( function() {
                $("input[type='text'], textarea").attr('spellcheck',false);
            });
        </script>


    <#--Locale trigger-->
        <script type="text/javascript">
            $(document).ready(function () {

                $('#language a').click(function (e) {

                    e.preventDefault();

                    var lang = $(this).find('span').attr('data-language');

                    if (lang == "en_US"){
                        lang = "en_EN"
                    }

                    if (lang == "ru_RU"){
                        lang = "ru_RUS"
                    }

                    $.cookie('lang', lang , { expires: 365, path: '/' });

                    window.location.reload();
                });

            })
        </script>

        <style>
            #header-page .logo{
                left : -20px;
            }
        </style>

        <#--Nested for writing additional js/css/meta-->
        <#nested />

    </head>

</#macro>


<#macro sripts>
    <!-- LOAD JQUERY -->
    <script type="text/javascript" src="<@c.url value="/assets/js/lib/jquery.parallax-1.1.3.js"/>"></script>
    <script type="text/javascript" src="<@c.url value="/assets/js/min/scripts.min.js"/>"></script>

    <#-- REVOLUTION DEMO -->
    <script type="text/javascript"
            src="<@c.url value="/assets/revslider-demo/js/jquery.themepunch.revolution.min.js"/>"></script>
    <script type="text/javascript"
            src="<@c.url value="/assets/revslider-demo/js/jquery.themepunch.tools.min.js"/>"></script>
    <script type="text/javascript">
        var slider = $('#slider-revolution');
        if (slider.length) {
            slider.show().revolution({
                ottedOverlay: "none",
                delay: 10000,
                startwidth: 1600,
                startheight: 650,
                hideThumbs: 200,

                thumbWidth: 100,
                thumbHeight: 50,
                thumbAmount: 5,


                simplifyAll: "off",

                navigationType: "none",
                navigationArrows: "solo",
                navigationStyle: "preview4",

                touchenabled: "on",
                onHoverStop: "on",
                nextSlideOnWindowFocus: "off",

                swipe_threshold: 0.7,
                swipe_min_touches: 1,
                drag_block_vertical: false,

                parallax: "mouse",
                parallaxBgFreeze: "on",
                parallaxLevels: [7, 4, 3, 2, 5, 4, 3, 2, 1, 0],


                keyboardNavigation: "off",

                navigationHAlign: "center",
                navigationVAlign: "bottom",
                navigationHOffset: 0,
                navigationVOffset: 20,

                soloArrowLeftHalign: "left",
                soloArrowLeftValign: "center",
                soloArrowLeftHOffset: 20,
                soloArrowLeftVOffset: 0,

                soloArrowRightHalign: "right",
                soloArrowRightValign: "center",
                soloArrowRightHOffset: 20,
                soloArrowRightVOffset: 0,

                shadow: 0,
                fullWidth: "on",
                fullScreen: "off",

                spinner: "spinner2",

                stopLoop: "off",
                stopAfterLoops: -1,
                stopAtSlide: -1,

                shuffle: "off",

                autoHeight: "off",
                forceFullWidth: "off",


                hideThumbsOnMobile: "off",
                hideNavDelayOnMobile: 1500,
                hideBulletsOnMobile: "off",
                hideArrowsOnMobile: "off",
                hideThumbsUnderResolution: 0,

                hideSliderAtLimit: 0,
                hideCaptionAtLimit: 0,
                hideAllCaptionAtLilmit: 0,
                startWithSlide: 0
            });
        }
    </script>
    <#nested />
</#macro>


<#macro header selected = 0>

    <!-- HEADER PAGE -->
    <header id="header-page">

        <div class="header-page__inner">

            <div class="container">

                <#--LOGO-->
                <div class="logo">
                    <a href="#"><img src="<@c.url value="/assets/images/logo-dark.png"/>"></a>
                </div>

                <!-- NAVIGATION -->
                <nav class="navigation awe-navigation" data-responsive="1200">

                    <ul class="menu-list">


                        <#--Langauge-->
                        <li class="menu-item-has-children">
                            <a>
                                <span class="glyphicon glyphicon-globe"></span>&nbsp;<@spring.message code="menu.language"/>
                            </a>
                            <ul class="sub-menu" id="language">
                                <li><a> <span class="bfh-languages" data-language="en_US" data-flags="true"></span> </a></li>
                                <li><a> <span class="bfh-languages" data-language="ru_RU" data-flags="true"></span> </a></li>
                            </ul>
                        </li>


                        <#--Home-->
                        <li class="menu-item <#if (selected == 0)>current-menu-item</#if>">
                            <a href="<@c.url value="/"/>">
                                <span class="glyphicon glyphicon-home"></span>
                                <@spring.message code="menu.home"/>
                            </a>
                        </li>


                        <#--Blog-->
                        <li class="menu-item-has-children <#if (selected == 1)>current-menu-item</#if>">
                            <a href="${mvcUri("PC#showAllPosts").arg(0, "all").arg(1, "1").arg(2, "desc").build()}">
                                <span class="glyphicon glyphicon-book"></span>
                                <@spring.message code="menu.blog"/>
                            </a>
                            <ul class="sub-menu">

                                <li><a href='${mvcUri("PC#showAllPosts").arg(0,"all").arg(1, "1").arg(2, "desc").build()}'>
                                    <@spring.message code="menu.blog.all"/>
                                </a></li>

                                <li><a href='${mvcUri("PC#showAllPosts").arg(0,"popular").arg(1, "1").arg(2, "desc").build()}'>
                                    <@spring.message code="menu.blog.popular"/>
                                </a></li>

                                <li><a href='${mvcUri("PC#showAllPosts").arg(0,"recent").arg(1, "1").arg(2, "desc").build()}'>
                                    <@spring.message code="menu.blog.recent"/>
                                </a></li>

                                <@s.authorize access="isAuthenticated()">
                                    <li><a href='${mvcUri("PC#showWritePost").build()}'>
                                        <span class="glyphicon glyphicon-pencil"></span>
                                        <@spring.message code="menu.blog.writepost"/>
                                    </a></li>
                                </@s.authorize>
                            </ul>
                        </li>


                        <#--Gallery-->
                        <li class="menu-item <#if (selected == 2)>current-menu-item</#if>">
                            <a href="<@c.url value="/gallery"/>">
                                <span class="glyphicon glyphicon-picture"></span>
                                <@spring.message code="menu.sights"/>
                            </a>
                        </li>


                        <#--Info-->
                        <li class="menu-item-has-children <#if (selected == 3)>current-menu-item</#if>">
                           <a>
                               <span class="glyphicon glyphicon-info-sign"></span>
                               Info
                           </a>

                            <ul class="sub-menu">
                                <li class="menu-item">
                                    <a href="<@c.url value="/about"/>">
                                        <@spring.message code="menu.about"/>
                                    </a>
                                </li>

                                 <#--Contacts-->
                                <li class="menu-item">
                                    <a href="<@c.url value="/contacts"/>">
                                        <span class="glyphicon glyphicon-envelope"></span>
                                        <@spring.message code="menu.contacts"/>
                                    </a>
                                </li>
                            </ul>

                        </li>




                        <#--Log in-->
                        <@s.authorize access="isAnonymous()">
                            <li class="menu-item <#if (selected == 5)>current-menu-item</#if>">
                                <a href="<@c.url value="/login"/>">
                                    <span class="glyphicon glyphicon-log-in"></span>
                                    <@spring.message code="menu.login"/>
                                </a>
                            </li>
                        </@s.authorize>


                        <#--Logout-->
                        <@s.authorize access="isAuthenticated()">

                            <li class="menu-item <#if (selected == 6)>current-menu-item</#if>">
                                <a href="<@c.url value="/logout"/>">
                                    <span class="glyphicon glyphicon-log-out"></span>
                                    <@spring.message code="menu.logout"/>
                                </a>
                            </li>

                        </@s.authorize>


                        <#--Registration-->
                        <@s.authorize access="isAnonymous()">

                            <li class="menu-item <#if (selected == 7)>current-menu-item</#if>">
                                <a href="${mvcUri("RC#registration").build()}">
                                    <span class="glyphicon glyphicon-heart"></span>
                                    <@spring.message code="menu.register"/>
                                </a>
                            </li>

                        </@s.authorize>


                        <#--Profile-->
                        <@s.authorize access="isAuthenticated()">
                            <@s.authentication property="principal" var="p"/>
                            <li class="menu-item <#if (selected == 8)>current-menu-item</#if>">

                                <a href="<@c.url value="${mvcUri('UC#showProfile').build()}"/>">
                                    <span class="glyphicon glyphicon-user"></span>
                                    <#if p.login?length lt 26>
                                        ${p.login}
                                        <#else>
                                        ${p.login?substring(0, 25)}...
                                    </#if>

                                </a>

                            </li>
                        </@s.authorize>

                    </ul>

                </nav>
                <!-- END / NAVIGATION -->

            </div>

        </div>

    </header>
    <!-- END / HEADER PAGE -->
</#macro>


<#macro masonry>

    <#-- MASONRY -->
    <section class="masonry-section-demo">

        <div class="container">

            <div class="destination-grid-content" style="margin-bottom: 100px">

                <div class="section-title">
                    <h3>Beauty</h3>
                </div>

                <div class="row">

                    <div class="awe-masonry">

                        <!-- GALLERY ITEM -->
                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/beach_usa.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>Beach</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>USA</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>



                        <!-- GALLERY ITEM -->
                        <div class="awe-masonry__item">
                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/mountains_rus.jpeg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>Mountains</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Russia</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>

                        <!-- GALLERY ITEM -->
                        <div class="awe-masonry__item">
                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/turkey_capital.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>Capital</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Turkey</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>


                        <!-- GALLERY ITEM -->
                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/moscow_rus.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>Capital</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Moscow</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>


                        <!-- GALLERY ITEM -->
                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/spain_grenada.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Spain</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>


                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/kazan_city.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Kazan</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>


                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/rio_city.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Rio</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>



                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/italy_city.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Italy</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>



                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/monaco_city.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Monaco</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>



                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/japan_city.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Japan</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>


                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/rome_city.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Rome</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>


                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/italy_city2.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Italy</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>


                        <div class="awe-masonry__item">

                            <a>
                                <div class="image-wrap image-cover">
                                    <img src="<@c.url value="/assets/images/czech_rep_city.jpg"/>">
                                </div>
                            </a>


                            <div class="item-title">
                                <h2>City</h2>
                                <div class="item-cat">
                                    <ul>
                                        <li><a>Czech Republic</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>

                        <#nested />

                        <!-- END / GALLERY ITEM -->

                    </div>

                </div>

            </div>

        </div>

    </section>
    <#-- END / MASONRY -->

</#macro>


<#macro footer>

    <!-- FOOTER PAGE -->
    <footer id="footer-page">

        <div class="container">

            <div class="row">

                <!-- WIDGET -->
                <div class="col-md-3">
                    <div class="widget widget_contact_info">
                        <div class="widget_background">
                            <div class="widget_background__half">
                                <div class="bg"></div>
                            </div>
                            <div class="widget_background__half">
                                <div class="bg"></div>
                            </div>
                        </div>
                        <div class="logo">
                            <img src="<@c.url value="/assets/images/logo-footer-dark.png"/>" alt="">
                        </div>
                        <div class="widget_content">
                            <p>14 Novoselskaya st. , Kazan, Tatarstan, Russia</p>
                            <p>+8 (917) - 888 - 37 - 39</p>
                            <a href="#">RamilSafNab1996@gmail.com</a>
                        </div>
                    </div>
                </div>
                <!-- END / WIDGET -->

                <!-- WIDGET -->
                <div class="col-md-2">
                    <div class="widget widget_about_us">
                        <h3>About</h3>
                        <div class="widget_content">
                            <p>Useful blog who wants to know about the world</p>
                        </div>
                    </div>
                </div>
                <!-- END / WIDGET -->

                <!-- WIDGET -->
                <div class="col-md-3">
                    <div class="widget widget_follow_us">
                        <div class="widget_content">
                            <p>For Special booking request, please call</p>
                            <span class="phone">112</span>
                            <div class="awe-social">
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-pinterest"></i></a>
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END / WIDGET -->
            </div>
            <div class="copyright">
                <p>©2016 Safin travel™ All rights reserved.</p>
            </div>
        </div>
    </footer>
    <!-- END / FOOTER PAGE -->
</#macro>


<#macro body isPreloader=1 class="">
    <body class="${class}">

        <#-- PAGE WRAP -->
        <div id="page-wrap" class="dark">

            <#if (isPreloader == 1)>
                <#-- PRELOADER -->
                <div class="preloader"></div>
                <#-- END / PRELOADER -->
            </#if>

            <#nested />

            <@footer/>

        </div>
        <#-- END / PAGE WRAP -->

        <@sripts/>

    </body>
</#macro>





