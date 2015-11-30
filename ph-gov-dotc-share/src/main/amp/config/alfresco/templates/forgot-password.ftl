<!DOCTYPE html>
<html class="grey lighten-2">

<head>
    <title>Alfresco Forgot Password</title>

    <link rel="icon" href="${url.context}/res/favicon.ico" type="image/png">

    <link rel="stylesheet" type="text/css" href="${url.context}/css/materialize.min.css" >
    <link rel="stylesheet" type="text/css" href="${url.context}/css/main.css" >
    <link rel='stylesheet' type='text/css' href="//fonts.googleapis.com/css?family=Raleway:200,600" />

</head>

<body>

<header>
    <div class="navbar-fixed">
        <nav class="transparent">
            <div class="container">
                <div class="nav-wrapper">
                    <a href="${url.context}" class="company-logo"><img src="${url.context}/res/themes/default/images/logo.png"></a>
                    <#--<a class="right hide-on-med-and-down grey-text text-darken-4" href="${url.context}"> Alfresco ${srv.data.edition} - Version ${srv.data.version}</a>-->
                </div>
            </div>
        </nav>
    </div>
</header>

    <main>
        <div class="container">

            <div class="row">
                <div class="col s12 m12 l12 text-center">
                    <div class="row">
                    </div>
                    <div class="row">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col l6 offset-l3 s12 m12">
                    <div class="card z-depth-1">
                        <div class="card-content">
                            <span class="card-title grey-text text-darken-4">Forgot your password?</span>
                            <div class="divider blue"></div>
                            <br>
                            <p>We can send you details on how to reset it. Please enter your email address or the username you use to log into your account.</p>
                            <br>
                            <form id="form-forgot">
                                <div class="row">
                                    <div id="form-label" class="input-field col s12">
                                        <input id="email" type="text" name="email" required>
                                        <label for="email">Email or Username</label>
                                    </div>
                                </div>
                                <button id="form-btn" class="btn waves-effect waves-light green" type="submit" name="action">Send Instructions</button>
                                <div class="row"></div>
                            </form>
                            <div id="loading" class="progress blue lighten-1" style="display:none;">
                                <div class="indeterminate blue lighten-4"></div>
                            </div>
                            <p class="flow-text" id="form-result"></p>
                            <p id="error" class="orange-text text-darken-4"></p>
                        </div>
                        <#--<div class="card-action">
                            <a href="${url.context}" class="waves-effect btn grey lighten-5 grey-text text-darken-4" type="submit" name="action">Cancel</a>
                        </div>-->
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col s12 m12 l12 text-center">
                    <div class="row">
                    </div>
                    <div class="row">
                    </div>
                </div>
            </div>

        </div>
    </main>

    <#--<footer class="page-footer grey lighten-3">-->
        <#--<div class="container">-->
            <#--<div class="row">-->
                <#--<div class="col l6 s12">-->
                    <#--<div class="row valign-wrapper">-->
                        <#--<div class="col s4 m2">-->
                            <#--<img class="responsive-img valign" src="${url.context}/res/themes/${theme}/images/app-logo-48.png">-->
                        <#--</div>-->
                        <#--<div class="col s8 m10">-->
                            <#--<p class="grey-text text-darken-4">© 2005-2014 <a href="http://www.alfresco.com" title="Alfresco" target="_blank">Alfresco Software Inc.</a> | All Rights Reserved.</p>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->
                <#--<div class="col l4 offset-l2 s12 grey-text text-darken-4">-->
                    <#--<h5>Links</h5>-->
                    <#--<li><a class="blue-text" href="http://docs.alfresco.com/" target="_blank">Online Documentation</a></li>-->
                    <#--<li><a class="blue-text" href="/alfresco/webdav" target="_blank">Alfresco WebDav</a></li>-->
                    <#--<li><a class="blue-text" href="/alfresco/s/index" target="_blank">Alfresco WebScripts Home (admins only)</a></li>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
        <#--<div class="footer-copyright grey lighten-2">-->
            <#--<div class="container">-->
                <#--<div class="clearfix"></div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</footer>-->

    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="${url.context}/js/materialize.min.js"></script>
    <script>
        $(document).ready(function(){

            $('#form-forgot').submit(function( event ) {
                event.preventDefault();
                emptyDiv('#form-result');
                emptyDiv('#error');
                $('#loading').show();
                $('#form-btn').attr('disabled','disabled');
                $('#form-btn').removeClass('blue');
                $('#form-btn').addClass('disabled');
                var emailValue = $('#email').val();
                $.ajax({
                   type: "POST",
                   url: "/share/proxy/alfresco-noauth/androgogic/login/forgot-password",
                   data: JSON.stringify({ email: emailValue }),
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function(result) {
                        $('#loading').hide();
                        $('#form-btn').removeAttr('disabled');
                        $('#form-btn').addClass('blue');
                        $('#form-btn').removeClass('disabled');
                        $('#form-result').text('Please check your email.');
                   },
                   error: function(xhr, status, error) {
                        $('#loading').hide();
                        $('#form-btn').removeAttr('disabled');
                        $('#form-btn').addClass('blue');
                        $('#form-btn').removeClass('disabled');
                        var err = eval("(" + xhr.responseText + ")");
                        $('#error').text(err.message);
                    }
                });
            });

            function emptyDiv(divElement){
                $( divElement ).empty();
            }

        });
    </script>

</body>

</html>