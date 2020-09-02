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
    <title>个人资料</title>
    <link rel="stylesheet" href="js/bootstrap3.3.7/css/bootstrap.css">
    <link rel="stylesheet" href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.css">
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/bootstrap3.3.7/js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
</head>
<style>
    a{text-decoration: none;}
    a:link,a:visited,a:hover,a:active{
        color:white;
    }
    #top1{
        background-color:white;
        font-size:12px;
        color:#828282;
        padding-left:10px;
        padding-right:10px;
        height:35px;
        line-height: 35px;
    }

    #top2{
        background-color:#3385FF;
        padding-left:20px;
        height:60px;
        line-height:60px;
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

</style>
<body>
<div id="all" style="width:100%">
    <div id="conter">
        <form class="form-horizontal"  role="form" style="padding:30px 100px 10px;">

            <div class="form-group">
                <label class="col-sm-2 control-label">昵称:</label>

                <label class="col-sm-2 form-control-static">${requestScope.customer.nickName}</label>

            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">账号:</label>

                <label class="col-sm-2 form-control-static">${requestScope.customer.userName}</label>

            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码:</label>

                <label class="col-sm-2 form-control-static">${requestScope.customer.password}</label>

            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">性别:</label>
                <label class="col-sm-2 form-control-static">${requestScope.customer.gender}</label>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱:</label>

                <label class="col-sm-2 form-control-static">${requestScope.customer.email}</label>
            </div>

        </form>
    </div>

</div>
</body>
</html>
