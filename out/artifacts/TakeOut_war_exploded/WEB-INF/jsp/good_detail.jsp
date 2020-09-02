<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
</head>
<script>
    function addShoppingCart(id){
        var url = "shoppingCart/changeNum";
        var data={
            "goodID": id,
            "goodNumVariation": 1
        };

        $.post(url,data,function(msg){
            if(msg.result == "true"){
                swal({
                    title:'温馨提示',
                    type:'success',
                    text:'已加入购物车!',
                    timer:1000,
                    showConfirmButton:false
                });
            }else{
                swal({
                    title:'温馨提示',
                    type:'error',
                    text:'暂未登录,无法加入购物车!'
                });
            }
        });
    }
</script>
<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp"></jsp:include>
    <div id="conter">
        <div style="margin:10px;">
            <fieldset>
                <legend style="color:#3385FF">宜家菜品详情</legend>
            </fieldset>
        </div>
        <table  style="margin-left:200px;">
            <tr>
                <td align="right" valign="top">
                    <c:choose>
                        <c:when test="${requestScope.good.imgFileName == null}">
                            <img class="img-thumbnail" style="width:300px;height: 360px;" src="img/aa.jpg"/>
                        </c:when>
                        <c:otherwise>
                            <img class="img-thumbnail" style="width:300px;height: 360px;" src="img/${requestScope.good.imgFileName}"/>
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
                                </form>
                </td>
            </tr>
        </table>
        <div style="float:left;margin-left:600px;">
            <button type="button" class="btn" style="width:140px;background-color:#3385FF;color:white" onclick="window.history.back(-1);">&lt;返回</button>
            <button type="button" class="btn" style="width:140px;background-color:#3385FF;color:white" onclick="addShoppingCart('${requestScope.good.id}')">加入购物车</button>
        </div>
    </div>
</body>
</html>
