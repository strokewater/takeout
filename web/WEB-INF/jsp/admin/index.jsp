<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.project.takeout.pojo.Customer" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <base href="<%=basePath%>">

    <title>仪表盘</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/ace.min.css" />
    <link rel="stylesheet" href="css/custom.min.css">
    <link rel="stylesheet" href="css/style.css">

    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/ace.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>


</head>

<body>
<jsp:include page="../head/adminHead.jsp"></jsp:include>
<div class="main-container" id="main-container" >
    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text"></span>
        </a>

        <jsp:include page="../head/adminNavigationBar.jsp"></jsp:include>

        <div class="main-content">
            <div class="breadcrumbs" id="breadcrumbs"  style="height:40px">
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home home-icon"></i>
                        <a href="#">首页</a>
                    </li>
                    <li class="active">仪表盘</li>
                </ul><!-- .breadcrumb -->


            </div>

            <div class="page-content">
                <div class="page-header">
                    <h1>
                        仪表盘
                    </h1>
                </div><!-- /.page-header -->

                <!-- centent -->
                <div>
                    <div class="row">
                        <div class="col-sm-4 col-lg-3">
                            <div class=" mini-stat clearfix bx-shadow bg-info">
										<span class="mini-stat-icon">
											<i class="icon-money"></i>
										</span>
                                <div class="mini-stat-info text-right">
                                    今日收入<span>￥${requestScope.thisDayMoney}</span>
                                    &nbsp;
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <div class="mini-stat clearfix bx-shadow bg-purple">
										<span class="mini-stat-icon">
											<i class="icon-money"></i>
										</span>
                                <div class="mini-stat-info text-right">
                                    今月收入<span>￥${requestScope.thisMonthMoney}</span>
                                    &nbsp;
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <div class="mini-stat clearfix bx-shadow bg-red">
										<span class="mini-stat-icon">
											<i class="icon-money"></i>
										</span>
                                <div class="mini-stat-info text-right">
                                    今年收入<span>￥${requestScope.thisYearMoney}</span>
                                    &nbsp;
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /.page-content -->
        </div><!-- /.main-content -->


    </div><!-- /.main-container-inner -->
</div>
</body>
</html>

