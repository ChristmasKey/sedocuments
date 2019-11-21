<%--
  Created by IntelliJ IDEA.
  User: 24486
  Date: 2019/10/23
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>新用户注册</title>
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all" />
</head>
<body>
<div style="width:100%;text-align: center">
<form class="layui-form" action="" style="text-align: center;padding-top: 100px;">
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
            <input type="text"  id="phone" name="phone" required  lay-verify="required" placeholder="请输入手机号码" autocomplete="off" class="layui-input">
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
            <input type="text" name="email" required  lay-verify="required" placeholder="请输入邮箱地址" autocomplete="off" class="layui-input">
        </div>
    </div>
    </div>
    <div class="layui-inline">
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="gender" value="男" title="男">
            <input type="radio" name="gender" value="女" title="女" checked>
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
            <select name="school" lay-verify="required">
                <option value=""></option>
                <option value="0">淮阴工学院</option>
                <option value="1">盐城工学院</option>
                <option value="2">徐海学院</option>
                <option value="3">中国矿业大学</option>
                <option value="4">淮阴师范学院</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">专业</label>
        <div class="layui-input-inline">
            <select name="major" lay-verify="required">
                <option value=""></option>
                <option value="0">计算机科学与技术（微软合作）</option>
                <option value="1">土木工程</option>
                <option value="2">徐海学院</option>
                <option value="3">商学院</option>
                <option value="4">计算机科学与技术</option>
            </select>
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
            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</div>

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/cache.js"></script>
<script type="text/javascript">
    //Demo
    layui.use('form', function(){
        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return false;
        });

        // 为密码添加正则验证
        $('#pwd').blur(function() {
            var reg = /^[\w]{6,12}$/;
            if(!($('#pwd').val().match(reg))){
                //layer.msg('请输入合法密码');
                $('#pwr').removeAttr('hidden');
                $('#pri').attr('hidden','hidden');
                layer.msg('请输入合法密码');
            }else {
                $('#pri').removeAttr('hidden');
                $('#pwr').attr('hidden','hidden');
            }
        });

        //验证两次密码是否一致
        $('#rpwd').blur(function() {
            if($('#pwd').val() != $('#rpwd').val()){
                $('#rpwr').removeAttr('hidden');
                $('#rpri').attr('hidden','hidden');
                layer.msg('两次输入密码不一致!');
            }else {
                $('#rpri').removeAttr('hidden');
                $('#rpwr').attr('hidden','hidden');
            };
        });
        form.verify({
            password:[/^[\S]{6,12}$/
            ,'密码必须6到12位，且不能出现空格']
            ,phone:[/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/
            ,'手机号码格式不正确']
            ,email:[/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{3})$/
            ,'邮箱格式不正确']
        });
    });
</script>
</body>
</html>
