<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.project.takeout.pojo.Customer" %>
<%
    String conTextPath = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+conTextPath+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>用户管理</title>
    <link rel="stylesheet" href="js/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="css/ace.min.css" />
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/ace.min.js"></script>
    <script src="js/bootstrap/dist/js/bootstrap.js"></script>
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
                        <a href="admin/index">首页</a>
                    </li>
                    <li class="active">用户管理</li>
                </ul><!-- .breadcrumb -->


            </div>

            <div class="page-content">
                <div class="page-header">
                    <h1>
                        用户管理
                    </h1>
                </div><!-- /.page-header -->

                <!-- centent -->
                <div class="right_col" role="main">
                    <div class="row"  style="width: 1500px;">
                        <div class="col-md-9" style="padding-left:20px;">
                            <table class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>账号</th>
                                    <th>密码</th>
                                    <th>昵称</th>
                                    <th>性别</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.customers}" var="customer">
                                    <tr cid="4" >
                                        <td>
                                            <a>${customer.userName}</a>
                                        </td>
                                        <td>${customer.password}</td>
                                        <td>${customer.nickName}</td>
                                        <td>${customer.gender}</td>
                                        <td>
                                            <a href="javascript:showDetail('${customer.id}')" class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
                                                    class="icon-rocket"></i> <span>详情</span></a>
                                            <a href="javascript:editMySelf('${customer.id}')" class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
                                                    class="icon-edit"></i> <span>编辑</span></a>
                                            <a href="javascript:deleteCustomer('${customer.id}')" class="btn btn-warning btn-sm waves-effect waves-light m-b-5">
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
                                            <a href="admin/customer/index?page=${requestScope.page - 1}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="admin/customer/index?page=1" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <li><span style="color:#6FAED9"><a>${requestScope.page}</a></span></li>

                                <li>
                                    <c:choose >
                                        <c:when test="${requestScope.page > 1 && requestScope.page < requestScope.totalPage}">
                                            <a href="admin/customer/index?page=${requestScope.page + 1}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
                                                <i class="icon-chevron-left"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="admin/customer/index?page=${requestScope.totalPage}" style="color:#6FAED9;padding-top:9px;padding-bottom:8px;">
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
                <script type="text/javascript">
                    function showDetail(id){
                        swal({
                            title: '用户详情',
                            confirmButtonText: '确认',
                            confirmButtonColor: '#3085D6',
                            html:"<iframe src='admin/customer/detail/"+id+"' style='width:100%;height:350px;border:0;' />"
                        });
                    }

                    function editMySelf(id){
                        swal({
                            showConfirmButton: false,
                            width:900,
                            title: '修改用户资料',
                            html:"<iframe src='admin/customer/changeDetail/"+id+"' style='width:900px;height:350px;border:0;' />"
                        });
                    }

                    function deleteCustomer(id) {
                        url = "admin/customer/delete";
                        data = {
                            "id": id
                        };

                        $.post(url, data, function (msg) {
                            if (msg.result == "true") {
                                swal('温馨提示','删除成功!','success').then(function(){location.reload(true)});
                            } else {
                                swal("温馨提示", "删除失败", "error");
                            }
                        });
                    }
                </script>
            </div><!-- /.page-content -->
        </div><!-- /.main-content -->


    </div><!-- /.main-container-inner -->


</div><!-- /.main-container -->
</body>
</html>
