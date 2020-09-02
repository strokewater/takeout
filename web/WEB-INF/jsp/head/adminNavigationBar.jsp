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

    <title>adminNavigationBar</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="css/ace.min.css" />
    <link rel="stylesheet" href="js/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/custom.min.css">
    <link rel="stylesheet" href="css/style.css">

    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/ace.min.js"></script>
    <script type="text/javascript" src="js/bootstrap/dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>

</head>

<body>
<script type="text/javascript">
    $(function(){
        var title = $("title").html();
        if(title=="仪表盘"){
            $("#index").addClass("active");
        }else if(title=="用户管理"){
            $("#userManager").addClass("active");
        }else if(title=="菜系管理"){
            $("#categoryManager").addClass("active");
        }else if(title=="菜品管理"){
            $("#foodManager").addClass("active");
        }else if(title=="添加菜品"){
            $("#foodManager").addClass("active");
        }else if(title=="评论管理"){
            $("#discussManager").addClass("active");
        }else if(title=="订单管理"){
            $("#orderManager").addClass("active");
        }else if(title=="系统设置"){
            $("#settingManager").addClass("active");
        }
    });
</script>
<div class="sidebar" id="sidebar">
    <ul class="nav nav-list">
        <li id="index">
            <a  href="admin/index" style="padding-top:0px;">
                <i class="icon-dashboard"></i>
                <span class="menu-text"> 仪表盘 </span>
            </a>
        </li>

        <li id="userManager">
            <a href="admin/customer" style="padding-top:0px;">
                <i class="icon-user"></i>
                <span class="menu-text"> 用户管理 </span>
            </a>
        </li>

        <li id="categoryManager">
            <a href="admin/category" style="padding-top:0px;">
                <i class="icon-tag"></i>
                <span class="menu-text"> 菜系管理 </span>
            </a>
        </li>

        <li id="foodManager">
            <a href="admin/good" style="padding-top:0px;">
                <i class="icon-food"></i>
                <span class="menu-text">
									菜品管理
								</span>
            </a>
        </li>

        <li id="orderManager">
            <a href="admin/order/index" style="padding-top:0px;">
                <i class="icon-money"></i>
                <span class="menu-text"> 订单管理 </span>
            </a>
        </li>
    </ul><!-- /.nav-list -->

</div>
</body>
</html>
