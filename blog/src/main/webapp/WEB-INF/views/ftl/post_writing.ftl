<#import "/spring.ftl" as spring>
<#import "templates/mainTmpl.ftl" as template>

<#assign t=JspTaglibs["http://www.springframework.org/tags"]>   <#--jsp tags-->
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>     <#--jsp core-->
<#assign f=JspTaglibs["http://www.springframework.org/tags/form"]>  <#--jsp form-->
<#assign s=JspTaglibs["http://www.springframework.org/security/tags"]>  <#--jsp spring security-->


<!DOCTYPE html>
<html lang="en">

<#--head-->
<@template.head title="Write down a great and cool post! ">

    <#--csrf-->
    <@s.csrfMetaTags/>

    <#--Text readactor-->
    <script src='<@c.url value="/assets/js/tinymce/tinymce.min.js"/>'></script>

    <script>

        var lang = $.cookie("lang");

        if (lang == "en_EN"){
            lang ="";
        }else if (lang == "ru_RUS"){
            lang = "ru";
        }else {
            lang = "";
        }

        <@c.url value="/assets/css/tiny_style.css" var="style"/>

        tinymce.init({
            selector: 'textarea#post',
            language : lang,
            height: 550,
            width : 1000,
            max_height : 900,
            min_height : 550,
            theme: 'modern',
            plugins: [
                'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                'searchreplace wordcount visualblocks visualchars code fullscreen',
                'insertdatetime media nonbreaking save table contextmenu directionality',
                'emoticons template paste textcolor colorpicker textpattern imagetools'
            ],
            toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
            toolbar2: 'print preview media | forecolor backcolor emoticons',
            image_advtab: true,
            templates: [
                { title: 'Test template 1', content: 'Test 1' },
                { title: 'Test template 2', content: 'Test 2' }
            ],
            content_css: [
                '//fast.fonts.net/cssapi/e6dc9b99-64fe-4292-ad98-6974f93cd2a2.css',
                '//www.tinymce.com/css/codepen.min.css',
            ],
            automatic_uploads: true

        });
    </script>

    <style>

        #page-wrap{
            background-image: url("/assets/images/write.jpg");
        }

        #title{

            font-size: 15pt;
            height: 100px;
            width: 800px;

            margin-bottom: 100px;
        }



        #write_content{

            margin-top: 80px;
        }

        #post{
            margin-left: 80px;
        }

        #submit_wrap{

            text-align: center;
            margin-bottom: 150px;
            margin-top: -50px;
        }

        .btn-file {
            position: relative;
            overflow: hidden;
        }
        .btn-file input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            min-width: 100%;
            min-height: 100%;
            font-size: 100px;
            text-align: right;
            filter: alpha(opacity=0);
            opacity: 0;
            outline: none;
            background: white;
            cursor: inherit;
            display: block;
        }

        #upload{
            text-align: center;
            padding-left: 200px;
            margin-top: 50px;
            margin-bottom: 200px;
        }


        #photoCover{
            text-align: center;
            width: 400px;
            color: #fff;
        }
    </style>


</@template.head>

<@template.body>

    <@template.header selected=1/>

    <section>

        <div class="container">

            <div class="container">
                <div class="blog-heading-content text-uppercase">
                    <h2><@spring.message code="post.write.heading.text"/></h2>
                </div>
            </div>


            <div class="container post_place">

                <h1 class="alert-warning" style="text-align: center"></h1>

                <@c.url value="${mvcUri('PC#savePost').build()}" var="saveUrl"/>

                <@f.form method="POST" modelAttribute="post" action="${saveUrl}" enctype="multipart/form-data">

                    <div id="write_content">

                        <div class="container">
                            <div class="blog-heading-content text-uppercase">
                                <h2>Title</h2>
                            </div>
                        </div>


                        <span class="alert-warning" style="text-align: center; font-size: 24pt"><@f.errors path="title"/></span>
                        <br>
                        <br>
                        <@f.textarea id="title" path="title"/>

                        <br>
                        <br>

                        <span class="alert-warning" style="text-align: center;font-size: 24pt"><@f.errors path="content"/></span>
                        <br>
                        <br>
                        <@f.textarea path="content" id="post"></@f.textarea>


                    </div>

                    <br>
                    <br>
                    <span class="alert-warning"style="font-size: 20pt"><@f.errors path="image"/></span>
                    <div id="upload" style="margin-top: 50px; margin-bottom: 100px">

                        <input id="file" type="file" name="image" style="display:none">

                        <div class="input-append">

                            <@spring.bind path="post.image">
                                <input disabled id="photoCover" name="${status.expression}" class="input-large" type="text">
                            </@spring.bind>

                            <input disabled id="photoCover" class="input-large" type="text">

                            <a style="font-size: 15pt" class="btn" onclick="$('input[id=file]').click();">
                                Choose Featured Image
                            </a>
                        </div>


                        <script type="text/javascript">
                            $('input[id=file]').change(function() {
                                $('#photoCover').val($(this).val());
                            });
                        </script>

                    </div>

                    <div id="submit_wrap">
                        <button type="submit" class="btn btn-success btn-lg">Save and post!</button>
                    </div>

                </@f.form>

            </div>


        </div>

    </section>

</@template.body>

</html>