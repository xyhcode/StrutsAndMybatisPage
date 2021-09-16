<%--
  Created by IntelliJ IDEA.
  User: 羡羡
  Date: 2021/9/15
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>英雄</title>
    <script src="JS/jquery-1.10.2.js"></script>
    <script src="layui/layui.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script>
        var table = layui.table;
        //转换静态表格
        table.init('demo', {
            height: 500 //设置高度
            ,limit: 10
        });
    </script>
</head>
<body style="text-align: center">
<h1 style="margin-top: 15px">LOL英雄</h1>
<div style="margin-top: 25px;margin-left: 180px;width: 80%" id="toolbarDemo">
    <div style="display: table-cell">

        <div class="layui-input-block" style="display: table-cell">
            <!--            <label>&emsp;接&emsp;口&emsp;</label>-->
            搜索name：<div class="layui-input-inline" style="width: 260px">
            <input type="text" id="cpk" name="cnumber" placeholder="请输入name 支持模糊查询"
                   autocomplete="off" class="layui-input">
        </div>

        </div>
        <div style="display: table-cell" class="layui-form-item">
            <button class="layui-btn layui-btn-sm layui-btn-danger" data-type="reload" id="sear" lay-submit="" lay-filter="search"
                    style="margin-left: 15px"><i class="layui-icon" >&#xe615;</i>搜&emsp;索
            </button>
            <button type="reset" class="layui-btn layui-btn-primary layui-btn-sm" onclick="res()">
                <i class="layui-icon">&#xe631;</i>重&emsp;置
            </button>
        </div>

    </div>
    <div style="display: table-cell">
        <div style="display: table">
            <!--新增-->
            <div style="display: table-cell">
                <button id="add" onclick="tj()" class="layui-btn layui-btn-sm" style="margin-left: 15px">
                    <i class="layui-icon">&#xe608;</i> 新&emsp;增
                </button>
            </div>
            <!--刷新-->
            <div style="display: table-cell;">
                <button id="refresh" onclick="cx()" class="layui-btn layui-btn-normal layui-btn-sm" style="margin-left: 15px">
                    <i class="layui-icon">&#xe669;</i> 刷&emsp;新
                </button>
            </div>
        </div>
    </div>
</div>
<div align="center">
    <table class="layui-table" lay-filter="test" lay-even style="width: 1200px;margin-top:5px;text-align:center;" align="center">
        <thead>
        <tr>
            <th style="text-align: center">Name</th>
            <th style="text-align: center">Nickname</th>
            <th style="text-align: center">Sex</th>
            <th style="text-align: center">First</th>
            <th style="text-align: center">Img</th>
            <th style="text-align: center">Operation</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pa.list}" var="he">
            <tr>
                <td>${he.name}</td>
                <td>${he.nickname}</td>
                <c:if test="${he.sex==0}">
                    <td>女</td>
                </c:if>
                <c:if test="${he.sex==1}">
                    <td>男</td>
                </c:if>
                <td>${he.first}</td>
                <td style="width: 80px;height: 80px">
                    <c:if test="${he.img==null}">
                        <img src="herosimg/xxx.png" style="width: 80px;height: 80px">
                    </c:if>
                    <c:if test="${he.img!=null}">
                        <img src="herosimg/${he.img}" style="width: 80px;height: 80px">
                    </c:if>
                </td>
                <td style="width: 100px">
                    <a class="layui-btn layui-btn-xs" lay-event="edit" onclick="edit('${he.id}','${he.name}','${he.nickname}','${he.sex}','${he.first}','${he.img}')">编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" onclick="del('${he.id}')">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div id="demo6"></div>
<script>
    //分页
    layui.use(['laypage', 'layer'], function(){
        var laypage = layui.laypage
            ,layer = layui.layer;
        //自定义首页、尾页、上一页、下一页文本
        laypage.render({
            elem: 'demo6'
            ,count:"${pa.getTotal()}"
            ,first: '首页'
            ,last: '尾页'
            ,limit:5
            ,groups:10
            ,hash:true
            ,curr: "${page}" //获取起始页
            ,hash: 'fenye' //自定义hash值
            ,prev: '<em>←</em>'
            ,next: '<em>→</em>'
            ,jump: function(obj, first) {//分页回调 每次都会触发
                if(!first){
                    location.href="Herosshow?page="+obj.curr;
                }
            }
        });
    });

    //删除
    function del(hj){
        layer.confirm('确认删除嘛？', function(index){
            location.href="Herosdel?id="+hj+"";
            var ii = layer.load();
            //此处用setTimeout演示ajax的回调
            setTimeout(function(){
                layer.close(ii);
            }, 500);
            layer.msg("删除成功！");
        });
    }
    //头部重置
    function res(){
        $("#cpk").val("");
    }

    //刷新
    function cx(){
        location.href="Herosshow?page=1";
    }

    //添加
    function tj(){
        layer.open({
            type : 1,
            title : '添加英雄信息',
            area : [ '600px', '480px' ],//宽高
            shadeClose : true, //点击遮罩关闭
            content : $('#df2'),
        });
    }

    //编辑
    var aid="";
    var aname="";
    var anickname="";
    var asex="";
    var afirst="";
    var aimg="";
    //编辑
    function edit(id,name,nickname,sex,first,img){
        aid=id;
        aname=name;
        anickname=nickname;
        asex=sex;
        afirst=first;
        aimg=img;
        $("#heid").val(id);
        $("#name").val(name);
        $("#nickname").val(nickname);
        $("#sex").val(sex);
        $("#first").val(first);
        $("#tp").attr("src","herosimg/"+img+"");
        $("#fn").val(img)
        layer.open({
            type : 1,
            title : '编辑英雄信息',
            area : [ '600px', '480px' ],//宽高
            shadeClose : true, //点击遮罩关闭
            content : $('#df'),
        });
    }

    //编辑重置
    function updare(){
        $("#name").val(aname);
        $("#nickname").val(anickname);
        $("#sex").val(asex);
        $("#first").val(afirst);
        $("#tp").attr("src","herosimg/"+aimg+"");
        $("#fn").val(aimg);
    }
    //点击图片
    function fils(){
        $("#finp").click();
    }

    function infils(){
        $("#infinp").click();
    }

    //点击图片
    function wj(ev){
        var sr=document.getElementById("tp");
        //获取文件对象
        let file = ev.files[0];
        //获取文件阅读器
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function(){
            //给img的src设置图片url
            sr.setAttribute("src", this.result);
        }
    }

    function inwj(ev){
        var sr=document.getElementById("intp");
        //获取文件对象
        let file = ev.files[0];
        //获取文件阅读器
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function(){
            //给img的src设置图片url
            sr.setAttribute("src", this.result);
        }
    }
</script>


<a href="Herosshow?page=1">首页</a>
<a href="Herosshow?page=${pa.prePage}">上一页</a>
<c:forEach items="${pa.navigatepageNums}" var="p">
    <a href="Herosshow?page=${p}">${p}</a>
</c:forEach>
<a href="Herosshow?page=${pa.nextPage}">下一页</a>
<a href="Herosshow?page=${pa.pages}">尾页</a>
</body>
<%--修改--%>
<div style="padding: 20px; display: none" id="df">
    <form action="Herosupdate" method="post" enctype="multipart/form-data">
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">Name：</label>
            <div class="layui-input-block">
                <input type="text" name="name" id="name" placeholder="请输入Name"
                       autocomplete="off" class="layui-input" lay-verify="required">
                <input  type="hidden" name="herid" id="heid"/>
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">Nickname：</label>
            <div class="layui-input-block">
                <input type="text" name="nickname" id="nickname" placeholder="请输入Nickname"
                       autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">Sex：</label>
            <div class="layui-input-block">
                <input type="text" name="sex" id="sex" placeholder="请输入Sex(0:女 1:男)"
                       autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">First：</label>
            <div class="layui-input-block">
                <input type="text" name="first" id="first" placeholder="请输入First"
                       autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%;margin-bottom: 20px" >
            <label class="layui-form-label">img：</label>
            <div class="layui-input-block">
                <img src="images/mrtx.png" id="tp" style="width:80px;height: 80px;margin-bottom: 20px" onclick="fils()"/>
                <input type="file" name="myFile" style="display:none;" id="finp" onchange="wj(this)"/>
                <input type="hidden" name="filnae" id="fn"/>
            </div>
        </div>
        <div class="layui-form-item" id="bu3">
            <div class="layui-btn-group">
                <button class="layui-btn" lay-submit="" lay-filter="update_submit">提&ensp;交</button>
                <button type="button" class="layui-btn layui-btn-primary" onclick="updare()">重&ensp;置</button>
            </div>
        </div>
    </form>
</div>

<%--//添加--%>
<div style="padding: 20px; display: none" id="df2">
    <form action="Herosinshero" method="post" enctype="multipart/form-data">
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">Name：</label>
            <div class="layui-input-block">
                <input type="text" name="name" id="inname" placeholder="请输入Name"
                       autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">Nickname：</label>
            <div class="layui-input-block">
                <input type="text" name="nickname" id="innickname" placeholder="请输入Nickname"
                       autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">Sex：</label>
            <div class="layui-input-block">
                <input type="text" name="sex" id="insex" placeholder="请输入Sex(0:女 1:男)"
                       autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%">
            <label class="layui-form-label">First：</label>
            <div class="layui-input-block">
                <input type="text" name="first" id="infirst" placeholder="请输入First"
                       autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <br>
        <div class="layui-form-item" style="display: table-cell; width: 50%;margin-bottom: 20px" >
            <label class="layui-form-label">img：</label>
            <div class="layui-input-block">
                <img src="images/mrtx.png" id="intp" style="width:80px;height: 80px;margin-bottom: 20px" onclick="infils()"/>
                <input type="file" name="myFile" style="display:none;" id="infinp" onchange="inwj(this)"/>
            </div>
        </div>
        <div class="layui-form-item" id="inbu3">
            <div class="layui-btn-group">
                <button class="layui-btn" lay-submit="" lay-filter="update_submit">添&ensp;加</button>
                <button type="reset" class="layui-btn layui-btn-primary">重&ensp;置</button>
            </div>
        </div>
    </form>
</div>
</html>
