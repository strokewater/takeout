<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>详情</title>
    <link rel="stylesheet" href="js/bootstrap3.3.7/css/bootstrap.css">
    <link rel="stylesheet" href="js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.css">

    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/bootstrap3.3.7/js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
</head>

<style type="text/css">
    a{text-decoration: none;}
    a:link,a:visited,a:hover,a:active{
        color:white;
    }
</style>

<body>
<jsp:include page="../head/adminHead.jsp"/>

<div class="main-container" id="main-container">
    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text"></span>
        </a>

        <jsp:include page="../head/adminNavigationBar.jsp"/>

        <div class="main-content">
            <div class="breadcrumbs" id="breadcrumbs" style="height:40px">
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home home-icon"></i>
                        <a href="#">首页</a>
                    </li>
                    <li class="active">菜品详情</li>
                </ul><!-- .breadcrumb -->

            </div>
            <div class="page-content">
                <div class="page-header">
                    <h1>
                        菜品详情
                    </h1>
                    <a href="javascript:window.history.go(-1);" class="btn btn-primary btn-sm waves-effect waves-light m-b-5" style="float:right;position:relative;top:-30px;right:30px;">返回</a>
                </div><!-- /.page-header -->

                <!-- centent -->
                <div id="conter">
                    <table  style="margin-left:200px;">
                        <tr>
                            <td align="right" valign="top">
                                <c:choose>
                                    <c:when test="${requestScope.good.imgFileName != null}">
                                        <img class="img-thumbnail" style="width:300px;height: 360px;" src="img/${requestScope.good.imgFileName}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img class="img-thumbnail" style="width:300px;height: 360px;" src="img/aa.jpg"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td valign="top" style="font-size:15px;line-height: 25px;padding-left:40px;padding-top:50px;width:300px;height:360px;">
                                <span>菜名:</span>
                                <span>${requestScope.good.name}</span><br/>
                                <span>菜系:</span>
								            <span>${requestScope.good.category.name}</span><br/>
								            <span>价格:</span>
								            <span style="color:#F63E1C">￥${requestScope.good.price}</span><br/>
								            <span>简介:</span><br/>
								            &nbsp;&nbsp;&nbsp;&nbsp;<span style="padding-left:5px;font-size:13px;">${requestScope.good.description}</span><br/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div><!-- /.page-content -->
        </div><!-- /.main-content -->
    </div><!-- /.main-container-inner -->
</div><!-- /.main-container -->
</body>
</html>
