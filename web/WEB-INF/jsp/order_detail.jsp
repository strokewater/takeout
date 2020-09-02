<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>订单详情</title>
</head>

<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp"></jsp:include>
    <div id="conter">
        <div style="width: 99%;">
            <div style="color:#3F4D6C;width: 99%;border:1px solid #E4E4E4;border-left:5px solid #3385FF;padding: 5px 10px 5px 25px;float:left;"><strong>订单信息</strong>
                <div style="color:#3F4D6C;width: 99%;padding: 5px 10px 5px 40px;color:#888888;line-height:20px;font-size:13px;float:left;">
                    订单编号:&nbsp;&nbsp;<span style="font-size:12px">${requestScope.order.id}</span> &nbsp;&nbsp;&nbsp;<span id="message" style="font-size:8px;color:black;padding:5px;border:1px solid #EFE0C1;border-radius:5px;background-color:#FDFBD6"></span>
                    <br/>
                    订单金额:&nbsp;&nbsp;<span style="font-size:12px;color:#F36227">￥${requestScope.order.totalPrice}</span>
                    <br/>
                    订单状态:&nbsp;&nbsp;<span style="font-size:12px;color:forestgreen">
                    <c:choose>
                        <c:when test="${requestScope.order.state == 0}">
                            准备中
                        </c:when>
                        <c:when test="${requestScope.order.state == 1}">
                            配送中
                        </c:when>
                        <c:when test="${requestScope.order.state == 2}">
                            已送达
                        </c:when>
                    </c:choose>
                </span>
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
                                <td  align="right" width="10%">
                                    <c:choose>
                                        <c:when test="${orderDetail.good.imgFileName != null}">
                                            <img src="img/${orderDetail.good.imgFileName}" style="width: 40px;height:40px;"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="img/aa.jpg" style="width: 40px;height:40px;"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding-left:50px;">${orderDetail.good.name}</td>
                                <td  align="center">${orderDetail.goodNum}</td>
                                <td  align="center" style="font-size:12px;">
                                    ￥${orderDetail.goodNum * orderDetail.good.price}
                                </td>
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

                        <tr>
                            <td colspan="4" align="right" style="padding-right:60px;">
                                <button style="padding:10px 20px 10px 20px;border:0;background-color:#3385FF;color:white" onclick="location.href='order'">&lt;返回</button>
                            </td>
                        </tr>
                    </table>
                    <script type="text/javascript">
                        $(function(){
                            var state = "${requestScope.order.state}";
                            var s = parseInt(state);
                            switch(s){
                                case 0:
                                    $("#message").html("说明:我们已收到您的订单，正在制作.");
                                    break;
                                case 1:
                                    $("#message").html("说明:正在派送中.");
                                    break;
                                case 2:
                                    $("#message").html("说明:食品已送达.");
                                    break;
                                default:
                                    $("#message").html("状态码错误");
                            }
                        })
                    </script>
                </div>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>
</body>
</html>
