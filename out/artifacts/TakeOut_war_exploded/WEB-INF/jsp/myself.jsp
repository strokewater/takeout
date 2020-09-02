<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>个人资料</title>
    <link rel="stylesheet" href="js/bootstrap3.3.7/css/bootstrap.css">
    <link rel="stylesheet" href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.css">
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/bootstrap3.3.7/js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
</head>

<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp"></jsp:include>
    <div id="conter">
        <form class="form-horizontal"  role="form" style="padding:30px 100px 10px;">
            <fieldset>
                <legend style="color:#3385FF">宜家用户资料</legend>
            </fieldset>
            <div class="form-group">
                <label class="col-sm-2 control-label">昵称:</label>

                <label class="col-sm-2 form-control-static">${sessionScope.customer.nickName}</label>

            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">账号:</label>

                <label class="col-sm-2 form-control-static">${sessionScope.customer.userName}</label>

            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">性别:</label>
                <label class="col-sm-2 form-control-static">${sessionScope.customer.gender}</label>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱:</label>
                <label class="col-sm-2 form-control-static">${sessionScope.customer.email}</label>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-4">
                    <button type="button" class="btn" style="width:140px;background-color:#3385FF;color:white" onclick="setPwd()">修改密码</button>
                </div>
            </div>

        </form>
        <script>
            function setPwd(){
                swal({
                    title: '修改密码',
                    allowOutsideClick:false,
                    showCancelButton: true,
                    confirmButtonText:'修改密码',
                    cancelButtonText:'返回',
                    html:
                        '<input id="swal-input1" placeholder="请输入旧密码"type="password" class="swal2-input"  autofocus>' +
                        '<input id="swal-input2" placeholder="请输入新密码" type="password" class="swal2-input">'+
                        '<input id="swal-input3" placeholder="请重复输入新密码" type="password" class="swal2-input">',
                    preConfirm:function(){
                        var input1 = $("#swal-input1").val();
                        var input2 = $("#swal-input2").val();
                        var input3 = $("#swal-input3").val();
                        if(input1==null||input1==""){
                            swal({
                                title: '温馨提示',
                                type: "warning",
                                text: "旧密码不能为空！",
                                confirmButtonText: '确认',
                                confirmButtonColor: '#3085D6',
                                timer: 3000
                            })
                            return;
                        }
                        if(input2==null||input2==""){
                            swal({
                                title: '温馨提示',
                                type: "warning",
                                text: "新密码不能为空！",
                                confirmButtonText: '确认',
                                confirmButtonColor: '#3085D6',
                                timer: 3000
                            })
                            return;
                        }
                        if(input3!=input2){
                            swal({
                                title: '温馨提示',
                                type: "warning",
                                text: "两次输入新密码不一致！",
                                confirmButtonText: '确认',
                                confirmButtonColor: '#3085D6',
                                timer: 3000
                            })
                            return;
                        }

                        var url = "customer/changePassword";
                        var data = {
                            "oldPassword":input1,
                            "newPassword":input2
                        };
                        $.post(url,data,function(msg){
                            if(msg.result == "false"){
                                swal({
                                    title: '温馨提示',
                                    type: "error",
                                    text: "未知错误,请刷新页面重试！",
                                    confirmButtonText: '确认',
                                    confirmButtonColor: '#3085D6',
                                    timer: 3000
                                })
                            }else if(msg.result == "error"){
                                swal({
                                    title: '温馨提示',
                                    type: "warning",
                                    text: "旧密码输入错误！",
                                    confirmButtonText: '确认',
                                    confirmButtonColor: '#3085D6',
                                    timer: 3000
                                })
                            }else{
                                swal({
                                    title: '温馨提示',
                                    type: "success",
                                    text: "修改成功",
                                    confirmButtonText: '确认',
                                    confirmButtonColor: '#3085D6',
                                    timer: 3000
                                });
                            }
                        });
                    }
                })
            }

        </script>
    </div>
</div>
</body>
</html>
