<%--
  Created by IntelliJ IDEA.
  User: 雨木林风
  Date: 2019/11/14
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户注册</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all" />
</head>
<body>
<div style="padding: 20px;">
    <a type="button" class="layui-btn" href="${ctx}">去登录</a>
</div>
<form class="layui-form" style="text-align:center;padding-top: 100px;" lay-filter="userInfoFrm" id="userInfoFrm">
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline">
                <input type="text" name="username" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号码</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" required  lay-verify="required|phone" placeholder="请输入手机号码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
                <input type="password" id="pwd" name="password" required lay-verify="required" placeholder="密码长度最少为6位" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline">
                <input type="password" id="rpwd" name="repassword" required lay-verify="required" placeholder="请再次输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="email" required  lay-verify="required|email" placeholder="请输入邮箱地址" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="gender" value="1" title="男" checked>
                <input type="radio" name="gender" value="2" title="女">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">生日</label>
            <div class="layui-input-inline">
                <input type="date" name="birthday" required  lay-verify="required" placeholder="请选择生日" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学校</label>
            <div class="layui-input-inline">
                <select name="school" id="schoolSelect" lay-search="" lay-filter="schoolSelect" lay-verify="required"></select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">专业</label>
            <div class="layui-input-inline">
                <select name="major" id="majorSelect" lay-search="" lay-filter="majorSelect" lay-verify="required"></select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学号</label>
            <div class="layui-input-inline">
                <input type="text" name="stuid" required  lay-verify="required" placeholder="请输入学号" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="button" class="layui-btn layui-btn-normal" lay-submit="" lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','layer'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var layer=layui.layer;
        window.onload=SchoolSelectorDataBind();

        function SchoolSelectorDataBind() {
            var schoolSelect=$("#schoolSelect");
            schoolSelect.empty();
            schoolSelect.append("<option value=''>无</option>");
            //绑定Ajax取得的数据
            $.post("${ctx}/dropdown/queryAllSchools",function (obj) {
                // console.log(obj[0].schoolname);
                for (var i = 0, len = obj.length; i < len; i++) {
                    schoolSelect.append("<option value='"+obj[i].schoolid+"'>"+obj[i].schoolname+"</option>");
                }
                form.render("select","userInfoFrm");
            });
        }

        form.on('select(schoolSelect)',function (data) {
            var schoolid=data.value;
            var majorSelect=$("#majorSelect");
            majorSelect.empty();
            majorSelect.append("<option value=''>无</option>");
            //绑定Ajax取得的数据
            $.post("${ctx}/dropdown/queryMajorBySchoolId",{schoolid:schoolid},function (obj) {
                for (var i = 0, len = obj.length; i < len; i++) {
                    majorSelect.append("<option value='"+obj[i].majorid+"'>"+obj[i].majorname+"</option>");
                }
                form.render("select","userInfoFrm");
            });
        });

        form.on("submit(formDemo)",function (data) {
            var reg= /^[\w]{6,12}$/;
            if (!$("#pwd").val().match(reg)) {
                layer.msg("密码长度应为6~12位");
            }else{
                if ($('#pwd').val() !== $('#rpwd').val()){
                    layer.msg("两次输入密码不一致!");
                } else{
                    //注册账号
                    //layer.msg("注册账号");
                    var params=$("#userInfoFrm").serialize();
                    $.post("${ctx}/register/registerAccount",params,function (obj) {
                        layer.msg(obj.msg);
                    })
                }
            }
        });
    });
</script>
</body>
</html>
