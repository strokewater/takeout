<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>购物车</title>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">

    <style>
        .iconfont{
        font-family: 'iconfont';
        font-style: normal;
        }
    </style>
</head>


<script>
    // 没有地址调用的方法，在list子窗口里调用
    function notAddress(){
        swal({
            title:'温馨提示',
            type:'warning',
            text:'暂无地址,请去添加!'
        }).then(function(){
            window.parent.location.reload(true)
        });
    }

    function buyButtonClickEvent() {
        var num = $("#total").html();
        if (num < 1) {
            swal(
                '温馨提示',
                '您还没有选择菜品!',
                'error'
            )
        } else {
            var addressID;
            var remark;


            function requestReturn(msg) {
                if (msg.result == "true") {
                    swal({
                        title: '温馨提示',
                        type: 'success',
                        text: '订单创建成功',
                        timer: 1000,
                        showConfirmButton: false
                    }).then(function(){
                        window.parent.location.reload(true)
                    });
                } else {
                    swal({
                        title: '温馨提示',
                        type: 'success',
                        text: '订单创建失败',
                        timer: 1000,
                        showConfirmButton: false
                    });
                }
            }

            function afterWriteNotice() {
                remark = $("#swal-remark").val();
                var ids = "";
                var nums = "";
                var goodid = "";
                $("#shoppingCarts tr").find(":checkbox:checked").each(function () {
                    goodid = $(this).val();
                    ids = ids + goodid + ',';
                    nums = nums + $("#" + goodid + "num").val() + ","
                });
                ids = ids.substr(0, ids.length - 1);
                nums = nums.substr(0, nums.length - 1);
                var url = "order/create";
                var data = {
                    "goodIDs": ids,
                    "goodNums": nums,
                    "notice": remark,
                    "addressID": addressID
                };

                $.post(url, data, requestReturn);
            }

            function afterSelectAddress() {
                addressID = $("#addressIFrame")[0].contentWindow.getSelectedId();
                swal({
                    allowOutsideClick: false,
                    type: "info",
                    showCancelButton: true,
                    confirmButtonText: '付款',
                    cancelButtonText: '取消',
                    title: '备注',
                    html: '<input id="swal-remark" placeholder="最多备注50字" maxlength="50" class="swal2-input">',
                    preConfirm: afterWriteNotice
                });
            }

            swal({
                width: 550,
                allowOutsideClick: false,
                showCancelButton: true,
                confirmButtonText: '下一步',
                cancelButtonText: '返回',
                title: '选择地址',
                html: "<iframe id='addressIFrame' src='address/frameIndex' style='width:100%;height:320px;border:0;' />",
                preConfirm: afterSelectAddress
            });
        }
    }

    $(function(){
        $(":checkbox").click(function(){
            setTotalPrice();
            setTotalNum();
        });

        $("#buyButton").click(buyButtonClickEvent);

        $("#allSelected").click(function(){
            if($("#shoppingCarts tr td").find(":checkbox:checked").length == $("#shoppingCarts tr").length){
                $("#shoppingCarts tr td").find(":checkbox:checked").each(function(){
                    this.checked = false;
                });
            }else{
                $("#shoppingCarts tr td").find(":checkbox").each(function(){
                    this.checked = true;
                });

            }
            setTotalPrice();
            setTotalNum();
        });


    });

    function setTotalNum(){
        $("#total").html($("#shoppingCarts tr td").find(":checkbox:checked").length);
    }

    function changeNumOfGood(id, changeNum) {
        var numStr = $("#" + id + "num").val();
        var singlePriceStr = $("#" + id + "singlePrice").html();

        var num = parseInt(numStr);
        var singlePrice = parseInt(singlePriceStr);
        if(num >= 0) {
            var newNum = num + changeNum;

            var url = "shoppingCart/setNum";
            var data = {
                "goodID":id,
                "goodNum": newNum
            };

            $.post( url, data, function (msg) {
                    if (msg.result == "true") {
                        $("#" + id + "num").val(newNum);
                        $("#" + id + "totalPrice").html(newNum * singlePrice);
                        setTotalPrice();
                        setTotalNum();
                    } else {
                        swal({
                            title:'温馨提示',
                            type:'error',
                            text:'修改数量失败!'
                        });
                    }
                }
            );
        }
    }

    function setTotalPrice(){
        var price = 0;
        $("#shoppingCarts tr td").find(":checkbox:checked").each(function(){
            var id = $(this).val();
            var money = $("#"+id+"totalPrice").html();
            price += parseInt(money);
        });
        $("#price").html(price);
    }

    function deleteShoppingCart(){
        var size = $("#shoppingCarts tr").find(":checkbox:checked").length;
        if(size<1){
            swal({
                title:'温馨提示',
                type:'warning',
                text:'请选择至少一项进行删除!'
            });
        }else{
            swal({
                title:'温馨提示',
                type:'warning',
                text:'确认删除所选菜品吗?',
                showCancelButton:true,
                confirmButtonColor:'#DD6B55',
                confirmButtonText:'删除',
                cancelButtonText:'取消',
                closeOnConfirm:false,
                preConfirm: function() {
                    var ids = "";
                    $("#shoppingCarts tr").find(":checkbox:checked").each(function(){
                        ids = ids+$(this).val()+",";
                    });

                    ids = ids.substr(0,ids.length-1);
                    var url = "shoppingCart/removeGoodList?goodIDs="+ids;

                    $.post(url,{},function(msg){
                        if(msg.result =="not_login"){
                            swal({
                                title:'温馨提示',
                                type:'error',
                                text:'暂未登录,无法加入购物车!'
                            });
                        }else if (msg.result == "false") {
                            swal({
                                title: '温馨提示',
                                type: 'error',
                                text: '删除异常'
                            });
                        } else
                            location.reload(true);

                        setTotalPrice();
                        setTotalNum();
                    });
                }
            });
        }

    }
</script>
<form id="alipayment" name="alipayment" action="../../page_user_toBuy.action" method="post"
      target="_blank">
    <input type="hidden" id="WIDout_trade_no" name="WIDout_trade_no" />

    <input type="hidden" id="WIDsubject" name="WIDsubject" />

    <input type="hidden" id="WIDtotal_amount" name="WIDtotal_amount" />

    <input type="hidden" id="WIDbody" name="WIDbody" />
</form>
<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp"></jsp:include>
    <div id="conter">
        <table id="shoppingCarts" style="width:100%;border-collapse:collapse;font-size:12px;">
            <c:forEach items="${requestScope.shoppingCartList}" var="shoppingCart">
                <tr style="height:80px;border:1px solid #E4E4E4">
                    <td width="7%" align="center">
                        <input type="checkbox" name="id" value="${shoppingCart.good.id}"/></td>
                    <td align="center"width="7%">
                        <c:choose>
                            <c:when test="${shoppingCart.good.imgFileName != null}">
                                <img src="img/${shoppingCart.good.imgFileName}" style="width:60px;height:60px"/>
                            </c:when>
                            <c:otherwise>
                                <img src="img/aa.jpg" style="width:60px;height:60px"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="color:#7A7777">${shoppingCart.good.name}</td>
                    <td width="14%" align="center" style="font-size:16px;">
                        <i id="deleteSize" onclick="changeNumOfGood('${shoppingCart.good.id}', -1)" class="iconfont" style="margin-left:40px;border-radius: 5px 0 0 5px;float:left;padding:2px;border:1px solid #959494">&#xe729;</i>
                        <input id="${shoppingCart.good.id}num" type="text" style="float:left;width:45px;height:19px;text-align:center;color:#9E9D9C;border:0;border-top:1px solid #959494;border-bottom:1px solid #959494" maxlength="1" readonly="readonly" value="${shoppingCart.goodNum}"/>
                        <i id="addSize" onclick="changeNumOfGood('${shoppingCart.good.id}', 1)" class="iconfont"style="border-radius: 0 5px 5px 0;float:left;padding:2px;border:1px solid #959494">&#xe727;</i>
                    </td>
                    <td width="14%"  align="center" style="color:#F75C28;font-size:13px;">
                        单价：<span id="${shoppingCart.good.id}singlePrice">${shoppingCart.good.price}</span>&nbsp;元
                        &nbsp;&nbsp;
                        总价：<span id="${shoppingCart.good.id}totalPrice">${shoppingCart.good.price * shoppingCart.goodNum}</span>&nbsp;元
                    </td>
                </tr>
            </c:forEach>

        </table>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <div style="position:fixed;bottom:0px;background-color:white;border:1px solid #DADBDE;width:99%;height:80px">
            <button id="allSelected" style="background-color:#3385FF;color:white;border-radius:5px;margin-top:15px;margin-left:40px;padding:20px 30px 20px 30px;border:0;">全    选</button>
            <button id="deleteButton" onclick="deleteShoppingCart()" style="background-color:#3385FF;color:white;border-radius:5px;margin-top:15px;padding:20px 30px 20px 30px;border:0;">删    除</button>
            <button id="buyButton" style="float:right;background-color:#3385FF;margin-right:40px;color:white;border-radius:5px;margin-top:15px;margin-left:40px;padding:20px 30px 20px 30px;border:0;">下    单 (<span id="total">0</span>)</button>
            <span style="float:right;line-height:80px;margin-right:-20px">合计:&nbsp; <span style="color:#F75C28">￥<span id="price">00</span>.00</span></span>

        </div>
    </div>

</div>
</body>
</html>
