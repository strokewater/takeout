<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.project.takeout.pojo.Customer" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>

    <title>菜品管理</title>

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
<jsp:include page="../head/adminHead.jsp"></jsp:include>


<div class="main-container" id="main-container">
    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text"></span>
        </a>

        <jsp:include page="../head/adminNavigationBar.jsp"></jsp:include>

        <div class="main-content">
            <div class="breadcrumbs" id="breadcrumbs" style="height:40px">
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home home-icon"></i>
                        <a href="#">首页</a>
                    </li>
                    <li class="active">菜品管理</li>
                </ul><!-- .breadcrumb -->


            </div>

            <div class="page-content">
                <div class="page-header">
                    <h1 style="">
                        菜品管理
                    </h1>
                    <a href="admin/good/add" class="btn btn-primary btn-sm waves-effect waves-light m-b-5" style="float:right;position:relative;top:-30px;right:30px;"><span>添加菜品 </span></a>
                </div><!-- /.page-header -->

                <!-- centent -->
                <div class="right_col" role="main">
                    <div class="row" style="width:1110px;">
                        <div  style="padding-left:20px;">
                            <ul id="goodList" style="list-style: none;border:1px solid #DDDDDD;padding:10px;">

                                <c:forEach items="${requestScope.goods}" var="good">
                                    <li style="width:240px;height:270px;border:1px solid #DDDDDD;padding:10px;float:left;margin:10px;">
                                        <c:choose>
                                            <c:when test="${good.imgFileName != null}">
                                                <img src="img/${good.imgFileName}" style="width:220px;height:180px;margin-bottom: 5px"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="img/aa.jpg" style="width:220px;height:180px;margin-bottom: 5px"/>
                                            </c:otherwise>
                                        </c:choose>

                                        <center><span style="font-size:16px;margin-bottom:10px;"><strong>${good.name}</strong></span></center>
                                        <center>
                                            <a href="admin/good/detail?id=${good.id}" class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><span>预 览</span></a>
                                            <a href="admin/good/edit?id=${good.id}" class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><span>编 辑</span></a>
                                            <a href="javascript:deleteGood('${good.id}')" class="btn btn-warning btn-sm waves-effect waves-light m-b-5">
                                                <span>删 除</span></a>
                                        </center>
                                    </li>
                                </c:forEach>

                                <div class="clearfix"></div>
                            </ul>
                            <div class="clearfix"></div>
                            <ul class="pagination m-b-5 pull-right">

                                <li>
                                    <c:choose >
                                        <c:when test="${requestScope.page > 1}">
                                            <a href="admin/good/index?page=${requestScope.page - 1}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="admin/good/index?page=1" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <li><span style="color:#6FAED9"><a>${requestScope.page}</a></span></li>

                                <li>
                                    <c:choose >
                                        <c:when test="${requestScope.page > 1 && requestScope.page < requestScope.totalPage}">
                                            <a href="admin/good/index?page=${requestScope.page + 1}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="admin/good/index?page=${requestScope.totalPage}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
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
    function deleteGood(goodID) {
        url = "admin/good/doDelete";
        data = {
            "id": goodID
        };

        $.post(url, data, function (msg) {
            if (msg.result == "true") {
                swal('温馨提示','删除成功!','success').then(function(){
                    location.reload(true);
                });
            } else {
                swal("温馨提示", "删除失败", "error");
            }
        });
    }
</script>

</body>
</html>
