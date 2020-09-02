<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>订单</title>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
</head>

<script>
    function addDiscuss(orderID){
        swal({
            allowOutsideClick:false,
            showCancelButton: true,
            confirmButtonText:'评论',
            cancelButtonText:'返回',
            title: '评论',
            html:
                '<input id="swal-input1" placeholder="最多评论50字" maxlength="50" class="swal2-input"  autofocus>',
            preConfirm:function(){
                var comment = $("#swal-input1").val();
                if(comment!=null && comment!=undefined && comment!=""){
                    var url = "order/comment";
                    var data = {
                        "id": orderID,
                        "comment":comment
                    };
                    $.post(url,data,function(msg){
                        if(msg.result == "true"){
                            location.reload(true);
                        }else{
                            swal('温馨提示','未知错误,请刷新页面重试!','error');
                        }
                    });
                }else{
                    swal('温馨提示','评论不能为空!','warning');
                }
            }
        })
    }
</script>
<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp"></jsp:include>
    <div id="conter">
        <table style="width:100%;border-collapse:collapse;font-size:13px;">
            <thead>
            <tr style="height:40px;border:1px solid #E4E4E4;color:#888888;">
                <td style="padding-left:100px;"><strong>订单编号</strong></td>
                <td width="14%" align="center"><strong>下单时间</strong></td>
                <td width="14%" align="center" style="font-size:12px;"><strong>总金额</strong></td>
                <td width="14%" align="center"><strong>状态</strong></td>
                <td width="20%" align="center" style="font-size:12px"><strong>操作</strong></td>
            </tr>
            </thead>
            <c:forEach items="${requestScope.orderList}" var="order">
                <tr style="height:60px;border:1px solid #E4E4E4;color:#888888;">
                    <td style="padding-left:50px;">${order.id}</td>
                    <td width="14%" align="center"><fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td width="14%" align="center" style="font-size:12px;">￥${order.totalPrice}</td>
                    <td width="14%" align="center"style=" color:#3385FF">
                            <c:choose>
                                <c:when test="${order.state == 0}">
                                    准备中
                                </c:when>
                                <c:when test="${order.state == 1}">
                                    配送中
                                </c:when>
                                <c:when test="${order.state == 2}">
                                    已送达
                                </c:when>
                            </c:choose>
                    </td>
                    <c:choose>
                        <c:when test="${order.state == 2}">
                            <td width="20%" align="center" style="font-size:12px;color:#3385FF">
                                <span onclick="location.href='order/detail/${order.id}'">详情</span>
                                &nbsp;&nbsp;
                                <span id="discuss" onclick="addDiscuss('${order.id}')">评论</span>
                            </td>
                        </c:when>
                        <c:otherwise>
                            <td width="20%" align="center" style="font-size:12px;color:#3385FF">
                                <span onclick="location.href='order/detail/${order.id}'">详情</span>
                            </td>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </c:forEach>

        </table>
    </div>
</div>
</body>
</html>
