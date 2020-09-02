<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <base href="<%=basePath%>">

    <title>首页</title>
    <link rel="stylesheet" href="js/bootstrap3.3.7/css/bootstrap.css">
    <script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap3.3.7/js/bootstrap.js"></script>
    <script src="js/sweetalert/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="js/sweetalert/dist/sweetalert2.min.css">
</head>
<style>
    a{text-decoration: none;}
    a:link,a:visited,a:hover,a:active{
        color:white;
    }
    #top1{
        background-color:white;
        font-size:12px;
        color:#828282;
        padding-left:10px;
        padding-right:10px;
        height:35px;
        line-height: 35px;
    }

    #top2{
        background-color:#3385FF;
        padding-left:20px;
        height:60px;
        line-height:60px;
    }

    #conter{
        margin:0;
        padding:0;
        width:100%;
        height:1090px;
    }

    #bottom{background-color:black;}

    #title li{
        padding-left:30px;
        padding-right:30px;
    }

    #category{
        list-style: none;;
        padding: 0;
        margin: 0;
    }
    #category li{
        color:#7B7E81;
        font-size:13px;
        padding-left:50px;
        padding-top:3px;
        padding-bottom:3px;
    }

    .iconfont{
        font-family: 'iconfont';
        font-style: normal;
    }

    #shoppingCart{
        border:0;
        position:fixed;
        bottom:30px;
        right:30px;
        box-shadow:2px 2px 5px #9F9F9A;

        border-radius:80px;
        z-index:10;
        padding:10px 15px 10px 15px;
        background-color:#EBEBE4;
        color:#BFBFBB;
    }

    .foodImg{
        display: inline-block;
        max-width: 100%;
        height: auto;
        padding: 4px;
        line-height: 1.42857143;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 4px;
        -webkit-transition: all .2s ease-in-out;
        -o-transition: all .2s ease-in-out;
        transition: all .2s ease-in-out;
    }
</style>


<body>
<div id="all" style="width:100%">
    <jsp:include page="head/customerHead.jsp" />
    <div id="conter">
        <button id="shoppingCart" onclick="location.href='../../shoppingCartAction_user_showShoppingCartList.action'">
            <i class="iconfont" style="font-size:30px;color:#757575">&#xe6e6;</i>
        </button>

        <div style="float:right;color:white;font-size:15px;width:15%;height:100%;margin:0;padding:0;">
            <div style="padding-top:8px;padding-left:2px;">
                <input type="text" placeholder="请输入..." style="width:150px;height:25px;border:1px solid #E4E4E4"/> <button style="background-color:#5B9BF9;box-shadow: none;border:0px;padding-top:5px;padding-bottom:5px;padding-left:6px;padding-right:6px;color:white">搜索</button>
            </div>
            <div style="padding-top:8px;">
                <div style="background-color:#5B9BF9;text-align: center;padding-top:8px;padding-bottom:8px;">
                    <strong>温馨提示</strong>
                </div>
                <div style="color:black">
                    营业时间: 8:00-20:00<br/>
                </div>
            </div>
            <div style="padding-top:10px;">
                <div style="background-color:#5B9BF9;text-align: center;padding-top:8px;padding-bottom:8px;">
                    <strong>餐厅公告</strong>
                </div>
                <div style="color:black;font-size:12px;color:#757575">
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/>
                </div>
            </div>
            <div style="padding-top:10px;">
                <div style="background-color:#5B9BF9;text-align: center;padding-top:8px;padding-bottom:8px;">
                    <strong>关于我们</strong>
                </div>
                <div style="color:black;font-size:12px;color:#757575;line-height: 20px;">

                </div>
            </div>
        </div>
        <div style="margin-top:5px;float:right;width:69%;color:black;height:100%;padding-left:5px;padding-right:5px;">
            <img src="img/bg.png" width="98%" style="margin-left:10px;">
            <div>
                <div style="background-color:#3385FF;font-size:13px;color:white;padding:8px 5px 8px 5px;">
                    所有菜系 &gt;&gt;&gt;
                </div>
                <style>
                    #goodList li{
                        margin-left:20px;margin-right:20px;
                        text-align: center;
                    }
                </style>
                <div style="padding-top:10px;padding-bottom:10px;padding-left:5px;padding-right:5px;">
                    <ul  id="goodList" width="100%" style=" list-style: none;font-size:13px;color:#676565;padding:10px;">
                        <c:forEach items="${requestScope.goods}" var="good">
                            <li style="height: 200px;float:left;" valign="top">
                                <c:choose>
                                    <c:when test="${good.imgFileName!=null}">
                                        <img class="foodImg" src="img/${good.imgFileName}" style="padding:0;margin: 0;width:100px;height:110px"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img class="foodImg" src="img/aa.jpg" style="padding:0;margin: 0;width:100px;height:110px" />
                                    </c:otherwise>
                                </c:choose>
                                <br/>
                                <center>${good.name} &nbsp;&nbsp;&nbsp;￥${good.price}</center>
                                <div style="margin-top:5px;">
                                    <button style="color:white;background-color:#3385FF;border:0;padding:5px 10px 5px 10px" onclick="location.href='good/detail/${good.id}'">详情</button>
                                    <button style="color:white;background-color:#3385FF;border:0;padding:5px 10px 5px 10px" onclick="addShoppingCart(${good.id})">添加</button>
                                </div>
                            </li>
                        </c:forEach>

                        <div class="clearfix"></div>
                    </ul>
                    <div style="padding-bottom: 10px;float:right;margin-right:25px">
                        <c:choose>
                            <c:when test="requestScope.categoryID != null">
                                <c:choose>
                                    <c:when test="requestScope.pageNo <= 1">
                                        <button onclick="location.href='good/index?pageNo=1&categoryID=${requestScope.categoryID}'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">&lt;上一页
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="location.href='good/index?pageNo=${requestScope.pageNo - 1}&categoryID=${requestScope.categoryID}'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">&lt;上一页
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="requestScope.pageNo <= 1">
                                        <button onclick="location.href='good/index?pageNo=1'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">&lt;上一页
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="location.href='good/index?pageNo=${requestScope.pageNo - 1}'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">&lt;上一页
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${requestScope.pageNo == null}">
                                <span>1/${requestScope.goodTotalPageNum}页</span>
                            </c:when>
                            <c:otherwise>
                                <span>${requestScope.pageNo}/${requestScope.goodTotalPageNum}页</span>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="requestScope.categoryID != null">
                                <c:choose>
                                    <c:when test="requestScope.pageNo >= requestScope.goodTotalPageNum">
                                        <button onclick="location.href='good/index?pageNo=${requestScope.goodTotalPageNum}&categoryID=${requestScope.categoryID}'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">下一页&gt;
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="location.href='good/index?pageNo=${requestScope.pageNo + 1}&categoryID=${requestScope.categoryID}'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">下一页&gt;
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="requestScope.pageNo >= requestScope.goodTotalPageNum">
                                        <button onclick="location.href='good/index?pageNo=${requestScope.goodTotalPageNum}'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">下一页&gt;
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="location.href='good/index?pageNo=${requestScope.pageNo + 1}'"
                                                style="border:0;padding:8px 10px 8px 10px;background-color:#3385FF;color:white">下一页&gt;
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

        </div>
        <!--
            作者：offline
            时间：2018-03-22
            描述：
            position:relative;top:-8;在ie浏览器下出现问题
        -->

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
                    }else if (msg.result == "not_login") {
                        swal({
                            title:'温馨提示',
                            type:'error',
                            text:'暂未登录,无法加入购物车!'
                        });
                    } else {
                        swal( {
                            title:'温馨提示',
                            type:'error',
                            text:'加入购物车异常'
                            });
                    }
                });
            }
        </script>
        <div style="position:relative;top:-8px;float:left;color:white;font-size:15px;width:15%;height:100%;">
            <div>
                <div style="background-color:#5B9BF9;text-align: center;padding-top:8px;padding-bottom:8px;">
                    <strong>菜单分类</strong>
                </div>>
                <ul id="category" >
                    <li onclick="location.href='good/index'" style="background-color:#CED0D2;color:black">* 所有菜系</li>
                    <c:forEach items="${requestScope.categories}" var="category">
                        <li onclick="location.href='good/index?categoryID=${category.id}'">* ${category.name}</li>
                    </c:forEach>>
                </ul
            </div>
        </div>
    </div>
</div>
</body>
</html>
