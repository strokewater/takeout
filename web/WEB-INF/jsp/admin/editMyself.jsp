<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.project.takeout.pojo.Customer" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>s

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <link rel="stylesheet" href="js/bootstrap3.3.7/css/bootstrap.css">
    <link rel="stylesheet" href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.css">

    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/bootstrap3.3.7/js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
</head>
<style>
    a{text-decoration: none;}
    a:link,a:visited,a:hover,a:active{
        color:white;
    }

    #conter{
        margin:0;
        padding:0;
        width:100%;
    }

    #bottom{background-color:black;}

    #title li{
        padding-left:30px;
        padding-right:30px;
    }
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

<div id="conter">
    <div class="form-horizontal"role="form" style="padding:30px 100px 10px;">
        <input type="hidden" id="customerID" value="${requestScope.customer.id}">
        <div class="form-group">
            <label class="col-sm-2 control-label">昵称:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="nickName" value="${requestScope.customer.nickName}"/>
            </div>
            <div style="display: inline">
                <label class="help-block">3-8位字母,数字,符号,汉字</label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">账号:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" readonly="readonly" id="userName" value="${requestScope.customer.userName}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">密码:</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="password"  value="${requestScope.customer.password}"/>
            </div>
            <div style="display: inline">
                <label class="help-block">6-16位字母,数字,符号,区分大小写</label>
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
            <select id="gender">
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">邮箱:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="customerEmail" id="email" value="${requestScope.customer.email}"/>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-4">
                <button type="button" class="btn" style="width:340px;background-color:#3385FF;color:white" onclick="onSubmitUser()">修改资料</button>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function onSubmitUser() {
            var customerID = $("#customerID").val();
            var userName = $("#userName").val();
            var nickName = $("#nickName").val();
            var password = $("#password").val();
            var rePwd = $("#rePwd").val();
            var gender = $("#gender").val();
            var email = $("#email").val();

            if (nickName == null || nickName == "" || nickName == undefined) {
                swal({
                    title: '温馨提示',
                    type: 'warning',
                    confirmButtonText: '确认',
                    confirmButtonColor: '#3085D6',
                    text: "昵称不能为空!"
                });
                return;
            }

            if (password == null || password == "" || password == undefined) {
                swal({
                    title: '温馨提示',
                    type: 'warning',
                    confirmButtonText: '确认',
                    confirmButtonColor: '#3085D6',
                    text: "密码不能为空!"
                });
                return;
            }

            if (rePwd != password) {
                swal({
                    title: '温馨提示',
                    type: 'warning',
                    confirmButtonText: '确认',
                    confirmButtonColor: '#3085D6',
                    text: "两次密码输入不一致!"
                });
                return;
            }

            var url = "admin/customer/doChangeDetail";
            var data = {
                "id": customerID,
                "userName": userName,
                "nickName": nickName,
                "password": password,
                "gender": gender,
                "email": email
            };

            $.post(url, data, function (msg) {
                    if (msg.result == "true") {
                        swal({
                            title: '温馨提示',
                            type: "info",
                            text: "修改成功",
                            confirmButtonText: '确认',
                            confirmButtonColor: '#3085D6',
                            timer: 10000
                        });
                    } else {
                        swal({
                            title: '温馨提示',
                            type: "error",
                            text: "修改失败",
                            confirmButtonText: '确认',
                            confirmButtonColor: '#3085D6',
                            timer: 10000
                        });
                    }
                }
            );

        }
    </script>
</div>

</div>
</body>
</html>