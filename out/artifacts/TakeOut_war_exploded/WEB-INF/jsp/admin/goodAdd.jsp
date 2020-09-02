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
    <title>添加菜品</title>
    <link rel="stylesheet" href="css/ace.min.css">
    <link rel="stylesheet" href="js/bootstrap/dist/css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap/dist/js/bootstrap.min.js"></script>
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
                    <li class="active">添加菜品</li>
                </ul><!-- .breadcrumb -->

            </div>
            <div class="page-content">
                <div class="page-header">
                    <h1>
                        添加菜品
                    </h1>
                    <a href="javascript:window.history.go(-1);" class="btn btn-primary btn-sm waves-effect waves-light m-b-5" style="float:right;position:relative;top:-30px;right:30px;">返回</a>
                </div><!-- /.page-header -->

                <!-- centent -->
                <div >
                    <form id="defaultForm" class="form-horizontal" action="admin/good/doAdd" method="post" enctype="multipart/form-data" role="form" style="padding:30px 100px 10px;">
                        <div class="form-group" style="height:40px;">
                            <label class="col-sm-2 control-label">菜系:</label>
                            <div class="col-sm-4">
                                <select name="categoryID" class="form-control">
                                    <c:forEach items="${requestScope.categoryList}" var="category">
                                        <option value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group" style="height:40px;">
                            <label class="col-sm-2 control-label">菜名:</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="goodName" id="goodName"/>
                            </div>
                            <div style="display: inline">
                                <label id="fnameError" class="help-block" style="color:red"></label>
                            </div>
                        </div>
                        <!-- 防止文件上传框因为ace.css出现问题。 -->
                        <link rel="stylesheet" href="js/fileinput/css/fileinput.css">
                        <script src="js/fileinput/js/fileinput.js"></script>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">例图:</label>
                            <div class="col-sm-4">
                                <input name="file1" id="file1" type="file" class="file fileloading" autoReplace="true"  data-show-upload="false" data-allowed-file-extensions='["jpg","png","gif"]'>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">价格:</label>
                            <div class="col-sm-4">
                                <input type="number" class="form-control" name="goodPrice" id="goodPrice"/>
                            </div>
                            <div style="display: inline">
                                <label id="fpriceError" class="help-block" style="color:red"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">描述:</label>
                            <div class="col-sm-4">
                                <textarea name="goodDescription" id="goodDescritpion"></textarea>
                            </div>
                            <div style="display: inline">
                                <label id="fremarkError" class="help-block" style="color:red"></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-6">
                                <button type="button" class="btn col-sm-3" style="width:340px;background-color:#3385FF;color:white" onclick="addFood()">添加</button>
                            </div>
                        </div>
                    </form>
                </div>

                <script type="text/javascript">
                    /* var goodPrice = $("#goodPrice").val();
                    var goodRemark = $("#goodDescritpion").val();
                    alert(goodName+","+goodPrice+","+goodRemark); */
                    $(function(){
                        $("#goodName").blur(function(){
                            validatorFoodName();
                        });

                        $("#goodPrice").blur(function(){
                            validatorFoodPrice();
                        });

                        $("#goodDescritpion").blur(function(){
                            validatorFoodRemark();
                        });
                    });

                    //校验菜名
                    function validatorFoodName(){
                        var goodName = $("#goodName").val();
                        if(goodName==null||goodName==""||goodName==undefined){
                            $("#fnameError").html("*菜名不能为空!");
                            return false;
                        }else{
                            $("#fnameError").html("");
                        }
                        /*
                        var url = "goodAction_admin_ajaxValidatorName.action?goodName="+goodName;
                        $.post(url,{},function(msg){
                            if(msg=="true"){
                                $("#fnameError").html("");
                            }else if(msg=="false"){
                                $("#fnameError").html("*该菜名已存在!");
                                return false;
                            }else{
                                $("#fnameError").html("*未知错误,请刷新页面后重试!");
                                return false;
                            }
                        });

                         */
                        return true;
                    }

                    //校验价格
                    function validatorFoodPrice(){
                        var goodPrice = $("#goodPrice").val();
                        if(goodPrice==null||goodPrice==""||goodPrice==undefined){
                            $("#fpriceError").html("*价格不能为空!");
                            return false;
                        }else{
                            $("#fpriceError").html("");
                        }
                        if(goodPrice<1){
                            $("#fpriceError").html("*价格不能小于1!");
                            return false;
                        }else{
                            $("#fpriceError").html("");
                        }

                        return true;
                    }

                    //校验描述
                    function validatorFoodRemark(){
                        var goodDescritpion = $("#goodDescritpion").val();
                        if(goodDescritpion==null||goodDescritpion==""||goodDescritpion==undefined){
                            $("#fremarkError").html("*描述不能为空!");
                            return false;
                        }else{
                            $("#fremarkError").html("");
                        }
                        if(goodDescritpion.length>50){
                            $("#fremarkError").html("*字数只能在1-50位之间!");
                            return false;
                        }else{
                            $("#fremarkError").html("");
                        }
                        return true;
                    }


                    function addFood(){
                        var flag = true;
                        flag = flag && validatorFoodName();
                        flag = flag && validatorFoodPrice();
                        flag = flag && validatorFoodRemark();
                        if(flag){
                            $("#defaultForm").submit();
                        }
                    }
                </script>
            </div><!-- /.page-content -->
        </div><!-- /.main-content -->
    </div>
</div><!-- /.main-container -->

</body>
</html>