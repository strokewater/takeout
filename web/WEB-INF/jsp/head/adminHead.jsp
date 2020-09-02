<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.project.takeout.pojo.Customer" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>head</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="js/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/ace.min.css">
    <link rel="stylesheet" href="css/custom.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="js/ace.min.js"></script>
</head>

<body>
<div class="navbar navbar-default" id="navbar" style="height:53px;background-color:#438eb9;">
    <div class="navbar-container" id="navbar-container">
        <div class="navbar-header pull-left" style="background-color:#438eb9;">
            <a href="admin/index" class="navbar-brand">
                <small>
                    <i class="icon-leaf"></i>
                    宜家后台管理系统
                </small>
            </a><!-- /.brand -->
        </div><!-- /.navbar-header -->

        <div class="navbar-header pull-right" role="navigation" style="background-color:#438eb9;">
            <ul class="nav ace-nav" >
                <li class="light-blue" >
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <img style="position: relative;top:-10px;" class="nav-user-photo" src="img/aa.jpg" alt="keben's Photo" />
                        <span class="user-info">
                            ${sessionScope.admin.userName}
                        </span>
                        <i class="icon-caret-down"></i>
                    </a>
                    <script type="text/javascript">
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

                                    var url = "admin/changePassword";
                                    var data = {
                                        "oldPassword":input1,
                                        "newPassword":input2
                                    };
                                    $.post(url,data,function(msg){
                                        if(msg.result == "false"){
                                            swal({
                                                title: '温馨提示',
                                                type: "error",
                                                text: "密码修改错误！",
                                                confirmButtonText: '确认',
                                                confirmButtonColor: '#3085D6',
                                                timer: 3000
                                            })
                                        }else if(msg.result =="true"){
                                            swal({
                                                title: '温馨提示',
                                                type: "success",
                                                text: "修改成功！",
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
                    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li>
                            <a href="javascript:setPwd();">
                                <i class="icon-cog"></i>
                                修改密码
                            </a>
                        </li>
                        <li class="divider"></li>

                        <li>
                            <a href="admin/doLogout">
                                <i class="icon-off"></i>
                                退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul><!-- /.ace-nav -->
        </div><!-- /.navbar-header -->
    </div><!-- /.container -->
</div>
</body>
</html>
