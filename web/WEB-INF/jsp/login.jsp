<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Login Page </title>

    <link rel="stylesheet" href="js/bootstrap/dist/css/bootstrap.css">
    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/bootstrap/dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
</head>

<body class="login" style="background: url(img/loginbg.png)">
<div style="margin: 0 auto; padding-bottom: 0%; padding-top: 7.5%; width: 380px;">
    <div class="panel panel-color panel-danger panel-pages panel-shadow">
        <div class="panel-default" >
            <div class="bg-overlay" style=""></div>
            <h3 class="text-center m-t-10" style="color:black;"> 登录页面</h3>
        </div>

        <div class="panel-body">
            <form class="form-horizontal m-t-20" method="post" id="loginForm" >

                <div class="form-group">
                    <div class="col-xs-12">
                        <input class=" input-lg input-border" id="account" name="account" type="text" required=""
                               placeholder="请输入账号 :)">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-12">
                        <input class=" input-lg input-border" id="password" name="password" type="password" required=""
                               placeholder="请输入密码">
                    </div>
                </div>

                <div class="form-group text-center m-t-40">
                    <div class="col-xs-12">
                        <button class="btn btn-danger btn-lg btn-rounded btn-block w-lg waves-effect waves-light"
                                style="background-color:#3385FF;box-shadow: 0px 0px 4px #3385FF;border:1px solid #3385FF;"
                                type="button" onclick="login()">登&nbsp;录
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <script type="text/javascript">
            function login(){
                var account = $("#account").val();
                var password = $("#password").val();
                if(account==null || account==""){
                    swal({
                        title: '温馨提示',
                        type: "warning",
                        text: "用户名不能为空！",
                        confirmButtonText: '确认',
                        confirmButtonColor: '#3085D6',
                        timer: 3000
                    })
                    return;
                }
                if(password==null||password==""){
                    swal({
                        title: '温馨提示',
                        type: "warning",
                        text: "密码不能为空！",
                        confirmButtonText: '确认',
                        confirmButtonColor: '#3085D6',
                        timer: 3000
                    })
                    return;
                }
                var url = "customer/doLogin";
                var data = {
                    "userName":account,
                    "password":password
                };
                $.post(
                    url,data,function(msg){
                    if(msg.result == "false"){
                        swal({
                            title: '温馨提示',
                            type: "error",
                            text: "用户名或密码错误！",
                            confirmButtonText: '确认',
                            confirmButtonColor: '#3085D6',
                            timer: 3000
                        }).then(function(){
                            $("#account").val("");
                            $("#password").val("");
                        });
                    }else{
                        if (msg.redirectURL == null)
                            location.href="<%=basePath%>";
                        else
                            location.href = msg.redirectURL;
                    }
                }, "json");
            }
        </script>
    </div>
</div>
</body>
</html>