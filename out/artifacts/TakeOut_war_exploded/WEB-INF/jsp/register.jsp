<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>注册页面</title>
    <link rel="stylesheet" href="js/bootstrap3.3.7/css/bootstrap.css">
    <link rel="stylesheet" href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.css">

    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/bootstrap3.3.7/js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
</head>
<style>

    @font-face {
        font-family: 'iconfont';  /* project id 600992 */
        src: url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.eot');
        src: url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.eot?#iefix') format('embedded-opentype'),
        url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.woff') format('woff'),
        url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.ttf') format('truetype'),
        url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.svg#iconfont') format('svg');
    }
    .iconfont{
        font-family: 'iconfont';
        font-style: normal;
    }

</style>
<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp"/>
    <div id="conter">
        <div class="form-horizontal" style="padding:30px 100px 10px;">
            <fieldset>
                <legend style="color:#3385FF">宜家用户注册</legend>
            </fieldset>
            <div class="form-group">
                <label class="col-sm-2 control-label">昵称:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="name"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">账号:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="account"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码:</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="password"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">确认密码:</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="rePwd"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">性别:</label>
                <div class="col-sm-4">
                    <select id="gender">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="email"/>
                </div>
                <div style="display: inline">
                    <label class="help-block">一旦选择不可更改</label>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-4">
                    <button class="btn" style="width:340px;background-color:#3385FF;color:white" onclick="register()">立即注册</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $("#form_datetime").datetimepicker({
        format: 'yyyy-mm-dd',//显示格式
        todayHighlight: 1,//今天高亮
        minView: "month",//设置只显示到月份
        startView:2,
        forceParse: 0,
        showMeridian: 1,
        autoclose: 1//选择后自动关闭
    });

    function register() {
        var userName = $("#account").val();
        var password = $("#password").val();
        var rePassword = $("#rePwd").val();
        var nickName = $("#name").val();
        var gender = $("#gender").val();
        var email = $("#email").val();

        if (userName == null || userName.length == 0)
        {
            swal('温馨提示','用户名不能为空!','warning')
            return;
        }

        if (password == null || password.length == 0)
        {
            swal('温馨提示','密码不能为空!','warning')
            return;
        }

        if (rePassword == null || rePassword.length == 0)
        {
            swal('温馨提示','请再次输入密码','warning')
            return;
        }

        if (nickName == null || nickName.length == 0)
        {
            swal('温馨提示','请输入昵称!','warning')
            return;
        }

        if (gender == null || gender.length == 0)
        {
            swal('温馨提示','请选择性别!','warning')
            return;
        }

        if (email == null || email.length == 0)
        {
            swal('温馨提示','邮箱不能为空!','warning')
            return;
        }

        if (password != rePassword)
        {
            swal({
                title: '温馨提示',
                type: "warning",
                text: "密码不一致",
                confirmButtonText: '确认',
                confirmButtonColor: '#3085D6',
                timer: 10000
            });
        }

        var url = "customer/doRegister";
        var data = {
            "userName": userName,
            "password": password,
            "nickName": nickName,
            "gender": gender,
            "email": email
        }
        $.post(url, data, function (msg) {
                if (msg.result == "true") {
                    swal({
                        title: '温馨提示',
                        type: "info",
                        text: "注册成功",
                        confirmButtonText: '确认',
                        confirmButtonColor: '#3085D6',
                        timer: 10000
                    }).then(function () {
                        window.location = "<%=basePath%>login"
                    });
                } else {
                    swal({
                        title: '温馨提示',
                        type: "error",
                        text: "注册失败",
                        confirmButtonText: '确认',
                        confirmButtonColor: '#3085D6',
                        timer: 10000
                    }).then(function () {
                        $("#account").val("");
                        $("#password").val("");
                        $("#rePwd").val("");
                        $("#gender").val("男");
                        $("#email").val("");
                    });
                }
            }
        );
    }
</script>
</body>
</html>