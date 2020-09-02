<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>菜系管理</title>
    <link rel="stylesheet" href="js/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="css/ace.min.css" />
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/ace.min.js"></script>
    <script src="js/bootstrap/dist/js/bootstrap.js"></script>
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.css">
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
                    <li class="active">菜系管理</li>
                </ul><!-- .breadcrumb -->

            </div>

            <div class="page-content">
                <div class="page-header">
                    <h1>
                        菜系管理
                    </h1>
                </div><!-- /.page-header -->


                <div class="right_col" role="main">
                    <div class="row"  style="width: 1500px;">

                        <div class="col-md-5" style="border:0">
                            <div class="panel panel  panel-pink">
                                <div class="panel-heading" style="background-color:#6E8CD7;height:50px">
                                    <h1 class="panel-title" style="color:#FFFFFF;">菜系列表</h1>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${requestScope.categoryList}" var="category"> <!-- btn-inverse dropdown-toggle waves-effect waves-light -->
                                        <div class="btn-group m-b-10" style="margin-top:5px;margin-bottom:5px;">
                                            <button type="button" class="btn"
                                                    data-toggle="dropdown" aria-expanded="false">${category.name}&nbsp;<i class="icon-caret-down"></i></button>
                                            <ul class="dropdown-menu" role="menu">
                                                <li onclick="updateCategory('${category.id}')"><a href="javascript:void(0)" mid="5" cname="aaa" class="edit-category">修改</a>
                                                </li>
                                                <li  onclick="deleteCategory('${category.id}')"><a href="javascript:void(0)" mid="5" class="del-category">删除</a></li>
                                            </ul>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <form id="cform" class="form-inline" role="form">
                                        <input type="hidden" id="mid"/>
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="cname" placeholder="请输入菜系名称">
                                        </div>
                                        <button id="save-category-btn" type="button" onclick="saveCategory()"
                                                class="btn btn-success waves-effect waves-light m-l-10">保存菜系
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        function deleteCategory(id){
                            var url = "admin/category/delete?id="+id;
                            $.post(url,{},function(){
                                location.reload();
                            });
                        }

                        function updateCategory(id){
                            swal({
                                title: '修改菜系',
                                allowOutsideClick:false,
                                showCancelButton: true,
                                confirmButtonText:'修改菜系',
                                cancelButtonText:'返回',
                                html:
                                    '<input id="swal-input1" placeholder="请输入新菜系名称" type="text" class="swal2-input"  autofocus>',
                                preConfirm:function(){
                                    var input1 = $("#swal-input1").val();
                                    if(input1!=null&&input1!=""&&input1!=undefined){
                                        var url = "admin/category/edit";
                                        var data = {
                                            "id":id,
                                            "name":input1
                                        };
                                        $.post(url,data,function(msg){
                                            if(msg.result == "true"){
                                                swal({
                                                    title: '温馨提示',
                                                    type: "success",
                                                    text: "修改成功！",
                                                    confirmButtonText: '确认',
                                                    confirmButtonColor: '#3085D6'
                                                }).then(function(){
                                                    location.reload();
                                                });
                                            }else if(msg.result == "warning"){
                                                swal({
                                                    title: '温馨提示',
                                                    type: "warning",
                                                    text: "该菜系已存在!"
                                                });
                                            }else if(msg.result == "error"){
                                                swal({
                                                    title: '温馨提示',
                                                    type: "error",
                                                    text: "发生未知错误,请稍后再试!",
                                                    confirmButtonText: '确认',
                                                    confirmButtonColor: '#3085D6'
                                                });
                                            }
                                        });

                                    }
                                }
                            })
                        }
                        function saveCategory(){
                            var cname = $("#cname").val();
                            if(cname==null||cname==""||cname==undefined){
                                swal({
                                    title: '温馨提示',
                                    type: "warning",
                                    text: "菜系名称不能为空！",
                                    confirmButtonText: '确认',
                                    confirmButtonColor: '#3085D6'
                                });
                                return;
                            }
                            var url = "admin/category/add";
                            var data = {"name":cname};
                            $.post(url,data,function(msg){
                                if(msg.result == "true"){
                                    swal({
                                        title: '温馨提示',
                                        type: "success",
                                        text: "保存成功！",
                                        confirmButtonText: '确认',
                                        confirmButtonColor: '#3085D6'
                                    }).then(function(){
                                        location.reload();
                                    });
                                }else if(msg.result == "warning"){
                                    swal({
                                        title: '温馨提示',
                                        type: "warning",
                                        text: "该菜系已存在!",
                                        confirmButtonText: '确认',
                                        confirmButtonColor: '#3085D6'
                                    });
                                }else if(msg.result == "error"){
                                    swal({
                                        title: '温馨提示',
                                        type: "error",
                                        text: "发生未知错误,请稍后再试!",
                                        confirmButtonText: '确认',
                                        confirmButtonColor: '#3085D6'
                                    });
                                }
                            });

                        }

                        $(function(){
                            $(".btn-group").find("button").each(function(){
                                var get = getRandomColor();
                                $(this).css("background-color",get);
                            });
                        });
                        //随机颜色
                        var getRandomColor = function(){
                            return  '#' +
                                (function(color){
                                    return (color +=  '0123456789abcdef'[Math.floor(Math.random()*16)])
                                    && (color.length == 6) ?  color : arguments.callee(color);
                                })('');
                        }
                    </script>
                </div>

            </div><!-- /.page-content -->
        </div><!-- /.main-content -->


    </div><!-- /.main-container-inner -->


</div><!-- /.main-container -->
</body>
</html>
