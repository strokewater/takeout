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
    <title>订单详情</title>
</head>
<style>
    a{text-decoration: none;}
    a:link,a:visited,a:hover,a:active{
        color:white;
    }

    #conter{
        margin:0;
        padding:10px;
        width:100%;
    }

    #bottom{background-color:black;}

    #title li{
        padding-left:30px;
        padding-right:30px;
    }

</style>
<body>
<div id="all" style="width:100%">
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
                        <li class="active">订单详情</li>
                    </ul><!-- .breadcrumb -->

                </div>
                <div class="page-content">
                    <div class="page-header">
                        <h1>
                            订单详情
                        </h1>
                        <a href="javascript:window.history.go(-1);" class="btn btn-primary btn-sm waves-effect waves-light m-b-5" style="float:right;position:relative;top:-30px;right:30px;">返回</a>
                    </div><!-- /.page-header -->

                    <!-- centent -->
                    <div id="conter">
                        <div style="width: 99%;">
                            <div style="color:#3F4D6C;width: 99%;border:1px solid #E4E4E4;border-left:5px solid #3385FF;padding: 5px 10px 5px 25px;float:left;"><strong>订单信息</strong></div>
                            <div style="color:#3F4D6C;width: 99%;padding: 5px 10px 5px 40px;color:#888888;line-height:20px;font-size:13px;float:left;">
                                订单编号:&nbsp;&nbsp;<span style="font-size:12px">${requestScope.order.id}</span> &nbsp;&nbsp;&nbsp;

                                <span id="message" style="font-size:8px;color:black;padding:5px;border:1px solid #EFE0C1;border-radius:5px;background-color:#FDFBD6">
                                    ${requestScope.ORDER_STATE_LONG_EXPLAIN[requestScope.order.state]}
                                </span>

                                <br/>
                                订单金额:&nbsp;&nbsp;<span style="font-size:12px;color:#F36227">￥${requestScope.order.totalPrice}.00</span>
                                <br/>
                                订单状态:&nbsp;&nbsp;<span style="font-size:12px;color:forestgreen">${requestScope.ORDER_STATE[requestScope.order.state]}</span>
                            </div>
                            <div style="color:#3F4D6C;width: 99%;padding: 5px 10px 5px 40px;margin-left:20px;margin-top:10px;color:#888888;line-height:20px;font-size:13px;float:left;">
                                <table  style="width: 100%;border-collapse:collapse;font-size:13px">
                                    <tr style="border:1px solid #E4E4E4;background-color:#F0F0F0;">
                                        <td colspan="2" align="center">食品</td>
                                        <td  align="center">数量</td>
                                        <td  align="center">金额小计</td>
                                    </tr>

                                    <c:forEach items="${requestScope.order.goodList}" var="orderDetail">
                                        <tr style="border-bottom:1px solid #E4E4E4;border-left:1px solid #E4E4E4;border-right:1px solid #E4E4E4;">
                                            <td  align="right" width="10%"><img src="img/${orderDetail.good.imgFileName}" style="width: 40px;height:40px;"/></td>
                                            <td style="padding-left:50px;">${orderDetail.good.name}</td>
                                            <td  align="center">${orderDetail.goodNum}</td>
                                            <td  align="center" style="font-size:12px;">￥${orderDetail.goodNum * orderDetail.good.price}</td>
                                        </tr>
                                    </c:forEach>

                                    <!-- 收货信息-->
                                    <tr style="border:1px solid #E4E4E4;background-color:#F0F0F0;">
                                        <td  colspan="4">
                                            <span style="color:#4C698A;font-size:12px;padding-left:5px"><strong>收货信息</strong></span>
                                        </td>
                                    </tr>
                                    <tr style="border:1px solid #E4E4E4;font-size:12px;color:#7B7E81">
                                        <td colspan="4" style="padding-left:60px;line-height: 25px;">
                                            <table>
                                                <tr>
                                                    <td align="right">收货地址:</td>
                                                    <td style="padding-left:10px;font-size:10px;color:black">${requestScope.order.receiveAddress}</td>
                                                </tr>
                                                <tr>
                                                    <td align="right">收货人:</td>
                                                    <td style="padding-left:10px;font-size:10px;color:black">${requestScope.order.receiverName}</td>
                                                </tr>
                                                <tr>
                                                    <td align="right">联系电话:</td>
                                                    <td style="padding-left:10px;font-size:10px;color:black">${requestScope.order.receiverPhone}</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                        <div style="clear: both;"></div>
                    </div>
                    <script type="text/javascript">
                        $(function(){
                            var s = parseInt("${requestScope.order.state}");
                            $("#message").html("说明:" + requestScope.ORDER_STATE_LONG_EXPLAIN[s]);
                        })
                    </script>
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->
        </div><!-- /.main-container-inner -->
    </div><!-- /.main-container -->

</div>
</body>
</html>
