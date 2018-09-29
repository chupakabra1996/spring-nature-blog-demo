<#import "/spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@template.head title="Contacts"/>

<@template.body isPreloader=1>

    <@template.header selected=4/>

    <section>

        <div class="container">

            <div class="row">

                <script src="http://maps.api.2gis.ru/2.0/loader.js?pkg=full"></script>


                <script type="text/javascript">
                    var map;

                    DG.then(function () {
                        map = DG.map('map', {
                            center: [55.41143, 49.08516],
                            zoom: 13
                        });

                        DG.marker([55.41143, 49.08516]).addTo(map);
                    });
                </script>

                <div class="col-md-6" style="margin: 9% 0 10% 0">
                    <div id="map" style="width:500px; height:400px"></div>
                </div>

                <div class="col-md-5 col-md-offset-1">

                    <div class="contact-page__form">

                        <div class="title">
                            <h2>CONTACT US</h2>
                        </div>

                        <div class="descriptions">
                            <p>If you have any problem with how to start or others do it!</p>
                        </div>

                        <#--TODO contact form-->

                        <form class="contact-form" action="#" method="post">

                            <div class="form-item">
                                <input type="text" placeholder="Your Name *" name="name">
                            </div>

                            <div class="form-item">
                                <input type="email" placeholder="Your Email *" name="email">
                            </div>


                            <div class="form-textarea-wrapper">
                                <textarea placeholder="Enter your message here ..."></textarea>
                            </div>

                            <div class="form-actions">
                                <input type="submit" value="Send" class="submit-contact">
                            </div>


                        </form>

                    </div>

                </div>

            </div>

        </div>

    </section>

    <#--<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3"></script>-->


    </@template.body>

</html>