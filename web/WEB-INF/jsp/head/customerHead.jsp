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

    <title>My JSP 'userHead.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <link rel="stylesheet" href="js/bootstrap3.3.7/css/bootstrap.css">
    <script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap3.3.7/js/bootstrap.js"></script>
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
    <link rel="icon" href="data:;base64,=">
    <style type="text/css">
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

        #title li{
            padding-left:30px;
            padding-right:30px;
        }

        #category li{
            color:#7B7E81;
            font-size:13px;
            padding-left:50px;
            padding-top:3px;
            padding-bottom:3px;
        }
        @font-face {
            font-family: 'iconfont';  /* project id 600992 */
            src: url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.eot');
            src: url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.eot?#iefix') format('embedded-opentype'),
            url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.woff') format('woff'),
            url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.ttf') format('truetype'),
            url('//at.alicdn.com/t/font_600992_tzvum5ijr0vbo6r.svg#iconfont') format('svg');
        }

        @font-face {
            font-family: 'iconfont1';  /* project id 602091 */
            src: url('http://at.alicdn.com/t/font_602091_4i2mxdvsfcu9pb9.eot');
            src: url('//at.alicdn.com/t/font_602091_4i2mxdvsfcu9pb9.eot?#iefix') format('embedded-opentype'),
            url('//at.alicdn.com/t/font_602091_4i2mxdvsfcu9pb9.woff') format('woff'),
            url('//at.alicdn.com/t/font_602091_4i2mxdvsfcu9pb9.ttf') format('truetype'),
            url('//at.alicdn.com/t/font_602091_4i2mxdvsfcu9pb9.svg#iconfont') format('svg');
        }
    </style>
</head>

<body>
<div id="top1">
    <%
        Customer customer = (Customer)session.getAttribute("customer");
        if (customer == null) {
    %>
            <div style="float:right;">
                <span id="login" onclick="location.href='login'">登录</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span onclick="location.href='register'">注册</span>
            </div>
     <%
         } else {
     %>
            <div style="float:right;">
                欢迎您,<span style="color:#2A3AFF">${sessionScope.customer.nickName}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span onclick="location.href='customer/doLogout'">退出</span>
            </div>
     <%
         }
     %>
</div>
<div id="top2">
    <span style="float:left;padding-left:15px;margin-right:35px;color:white"><span style="font-size:50px;">YI</span>宜家餐厅</span>
    <ul id="title" style="list-style: none;padding: 0;margin: 0;color:white;font-size:18px;">
        <li style="float:left;"><a href="index">首页</a></li>
        <li style="float:left;"><a href="shoppingCart">购物车</a></li>
        <li style="float:left;"><a href="order">订单</a></li>
        <li style="float:left;"><a href="address">收货地址</a></li>
        <li style="float:left;"><a href="myself">个人资料</a></li>
    </ul>
</div>


</body>
</html>
