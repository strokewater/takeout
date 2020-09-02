<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>收货地址</title>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
</head>
<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp"></jsp:include>
    <div id="conter">
        <table style="width:100%;border-collapse:collapse;font-size:13px;">
            <thead>
            <tr style="height:40px;border:1px solid #E4E4E4;color:#888888;">
                <td width="14%"style="padding-left:100px;"><strong>收货人</strong></td>
                <td align="center"><strong>收货地址</strong></td>
                <td width="14%" align="center" style="font-size:12px;"><strong>手机电话</strong></td>
                <td width="20%" align="center" style="font-size:12px"><strong>操作</strong></td>
            </tr>
            </thead>

            <c:forEach items="${requestScope.addressList}" var="address">
                <tr style="height:60px;border:1px solid #E4E4E4;color:#888888;">
                    <td id="add${address.id}1" width="14%"style="padding-left:100px;">${address.name}</td>
                    <td align="center">
                        <input type="hidden" id="add${address.id}2" value="${address.address}" />
                        ${address.address}
                    </td>
                    <td id="add${address.id}3" width="14%" align="center" style="font-size:12px;">${address.phone}</td>
                    <td width="20%" align="center" style="font-size:12px;color:#3385FF">
                        <span onclick="deleteAddress('${address.id}')">删除</span>
                            &nbsp;&nbsp;
                        <span onclick="updateAddress('${address.id}')">修改</span>
                    </td>
                </tr>
            </c:forEach>
            <script>
                function deleteAddress(addID) {
                    var url = "address/delete"
                    var data = {
                        "id": addID
                    };

                    $.post(url,data,function(msg){
                        if(msg.result == "true"){
                            swal('温馨提示','删除成功!','success').then(function(){location.reload(true)});
                        }else{
                            swal('温馨提示','删除失败,请刷新页面重试!','error');
                        }
                    });
                }

                function updateAddress(addId){
                    var person = $("#add"+addId+"1").html();
                    var address = $("#add"+addId+"2").val();
                    var mobile = $("#add"+addId+"3").html();
                    swal({
                        title: '修改地址',
                        allowOutsideClick:false,
                        showCancelButton: true,
                        confirmButtonText:'修改',
                        cancelButtonText:'返回',
                        html:
                            '<input id="swal-input1" placeholder="收件人" class="swal2-input" value="'+person+'"  autofocus>' +
                            '<input id="swal-input2" placeholder="电话号码" type="text" value="'+mobile+'" class="swal2-input">'+
                            '<input id="swal-input3" placeholder="地址" type="text" maxLength="50" value="'+address+'" class="swal2-input">',
                        preConfirm:function(){
                            var reg = /^1[0-9]{10}$/;
                            var input1 = $("#swal-input1").val();
                            var input2 = $("#swal-input2").val();
                            var input3 = $("#swal-input3").val();
                            var v = true;
                            if(input1==null||input1==undefined||input1==""){
                                v = false;
                                swal('温馨提示','收件人不能为空','warning').then(function(){updateAddress(addId);});
                            }
                            if(input2==null||input2==undefined||input2==""){
                                v = false;
                                swal('温馨提示','手机号不能为空!','warning').then(function(){updateAddress(addId);});
                            }
                            if(input3==null||input3==undefined||input3==""){
                                v = false;
                                swal('温馨提示','地址不能为空!','warning').then(function(){updateAddress(addId);});
                            }
                            if(!reg.test(input2)){
                                v = false;
                                swal('温馨提示','手机号码格式错误!','warning').then(function(){updateAddress(addId);});
                            }
                            if(v){
                                var url = "address/edit";
                                var data = {
                                    "id":addId,
                                    "name":input1,
                                    "phone":input2,
                                    "address":input3
                                };
                                $.post(url,data,function(msg){
                                    if(msg.result == "true"){
                                        swal('温馨提示','修改成功!','success').then(function(){location.reload(true)});
                                    }else{
                                        swal('温馨提示','修改失败,请刷新页面重试!','error');
                                    }
                                });
                            }

                        }

                    })
                    //
                }

                function addAddress(){
                    swal({
                        title: '添加地址',
                        allowOutsideClick:false,
                        showCancelButton: true,
                        confirmButtonText:'添加',
                        cancelButtonText:'返回',
                        html:
                            '<input id="swal-input1" placeholder="收件人" class="swal2-input"  autofocus>' +
                            '<input id="swal-input2" placeholder="电话号码" type="text" class="swal2-input">'+
                            '<input id="swal-input3" placeholder="地址" type="text" maxLength="50" class="swal2-input">',
                        preConfirm:function(){
                            var reg = /^1[0-9]{10}$/;
                            var input1 = $("#swal-input1").val();
                            var input2 = $("#swal-input2").val();
                            var input3 = $("#swal-input3").val();
                            var v = true;
                            if(input1==null||input1==undefined||input1==""){
                                v = false;
                                swal('温馨提示','收件人不能为空','warning').then(function(){addAddress();});
                            }
                            if(input2==null||input2==undefined||input2==""){
                                v = false;
                                swal('温馨提示','手机号不能为空!','warning').then(function(){addAddress();});
                            }
                            if(input3==null||input3==undefined||input3==""){
                                v = false;
                                swal('温馨提示','地址不能为空!','warning').then(function(){addAddress();});
                            }
                            if(!reg.test(input2)){
                                v = false;
                                swal('温馨提示','手机号码格式错误!','warning').then(function(){addAddress();});
                            }
                            if(v){
                                var url = "address/add";
                                var data = {
                                    "name":input1,
                                    "phone":input2,
                                    "address":input3
                                };
                                $.post(url,data,function(msg){
                                    if(msg.result == "true"){
                                        swal('温馨提示','添加成功!','success').then(function(){location.reload(true)});
                                    }else{
                                        swal('温馨提示','添加失败,请刷新页面重试!','error');
                                    }
                                });
                            }

                        }

                    })
                    //
                }
            </script>
            <tr style="height:60px;color:#888888;">
                <td colspan="4" align="right" style="padding-right:30px">
                    <button style="padding:10px 20px 10px 20px;border:0;background-color:#3385FF;color:white" onclick="addAddress()">新增地址</button>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
