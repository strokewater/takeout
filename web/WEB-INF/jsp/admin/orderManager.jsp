<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="org.project.takeout.pojo.Customer" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>订单管理</title>

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/ace.min.css" />

    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/ace.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
</head>

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
                    <li class="active">订单管理</li>
                </ul><!-- .breadcrumb -->
            </div>

            <div class="page-content">
                <div class="page-header">
                    <h1>
                        订单管理
                    </h1>
                </div>
                <div class="right_col" role="main">
                    <div class="row"  style="width: 1500px;">
                        <div class="col-md-9" style="padding-left:20px;">
                            <table class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>订单编号</th>
                                    <th>下单人</th>
                                    <th>下单时间</th>
                                    <th>总金额</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:forEach items="${requestScope.orders}" var="order">
                                    <tr cid="4" >
                                        <td>
                                            <a>${order.id}</a>
                                        </td>
                                        <td>${order.customer.userName}</td>
                                        <td><fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>￥${order.totalPrice}</td>
                                        <td><span class="label label-warning">${requestScope.ORDER_STATE[order.state]}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.state == 2}"/>
                                                <c:otherwise>
                                                    <a href="admin/order/nextState?id=${order.id}" class="btn btn-danger btn-sm waves-effect waves-light m-b-5">
                                                        <i class="icon-edit"></i> <span>${requestScope.ORDER_STATE[order.state + 1]}</span>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="admin/order/detail?id=${order.id}" class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
                                                    class="icon-rocket"></i> <span>详情</span></a>
                                            <a href="admin/order/doDelete?id=${order.id}" class="btn btn-warning btn-sm waves-effect waves-light m-b-5">
                                                <i class="icon-trash"></i> <span>删除</span></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="clearfix"></div>
                            <ul class="pagination m-b-5 pull-right">

                                <li>
                                    <c:choose >
                                        <c:when test="${requestScope.page > 1}">
                                            <a href="admin/order/index?page=${requestScope.page - 1}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="admin/order/index?page=1" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <li><span style="color:#6FAED9"><a>${requestScope.page}</a></span></li>

                                <li>
                                    <c:choose >
                                        <c:when test="${requestScope.page > 1 && requestScope.page < requestScope.totalPage}">
                                            <a href="admin/order/index?page=${requestScope.page + 1}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="admin/order/index?page=${requestScope.totalPage}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <li><span>共${requestScope.totalPage}页</span></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div><!-- /.page-content -->
        </div><!-- /.main-content -->
    </div><!-- /.main-container-inner -->
</div><!-- /.main-container -->
<script>
    $(function(){
        $(".label-warning").each(function(){
            var v = $(this).html();
            if(v=="订单已完成"){
                $(this).removeClass("label-warning").addClass("label-success");
            }
        });
    });
</script>
</body>
</html>
