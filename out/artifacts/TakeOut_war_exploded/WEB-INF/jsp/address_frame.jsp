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
    <title></title>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
</head>
<script>
    $(function(){
        if($("#addressList li").length < 1){
            window.parent.notAddress();

        }

        $(":checkbox").click(function(){
            $(":checkbox[checked='checked']").removeAttr("checked");
            $(this).attr("checked","checked");
        });
    });

    function getSelectedId(){
        return $(":checkbox:checked").val();
    }
</script>
<body>
<div style='width:480px;height:300px;font-size:10px;overflow: auto;overflow-x: hidden;'>
    <div style='width:500px;height:300px;overflow: auto;overflow-x: hidden;'>
        <ul id="addressList" style='margin:0;padding:0;list-style: none;'>
            <c:forEach items="${requestScope.addressList}" var="address" varStatus="status">
                <li style='height:60px;padding-top:12px;padding-left:40px;line-height: 20px;border-bottom:1px solid #E4E4E4;'>
                    <div>
                        <c:choose>
                            <c:when test="${status.count == 1}">
                                <input type="checkbox" checked="checked" style="position: relative;left:-65px;top:10px" value="${address.id}"/>
                            </c:when>
                            <c:otherwise>
                                <input type="checkbox" style="position: relative;left:-65px;top:10px" value="${address.id}"/>
                            </c:otherwise>
                        </c:choose>

                        <span style='font-size:13px;float:left;'>${address.name}</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <span style='font-size:12px'>${address.phone}</span><br/>
                            ${address.address}
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
</body>
</html>
