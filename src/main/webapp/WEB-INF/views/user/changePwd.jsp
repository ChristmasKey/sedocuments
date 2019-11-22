<%--
  Created by IntelliJ IDEA.
  User: 24486
  Date: 2019/11/14
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx }/resources/css/index.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form layui-row changePwd">
    <div class="layuiWindownContent">
        <div class="layui-form" lay-filter="indexUPdatePWFrom">
            <div class="layui-form-item">
                <label class="layui-form-label">原密码<font color="red">*</font></label>
                <div class="layui-input-block">
                    <input type="password" id="sysOldPWInp" name="sysOldPWInp"
                           lay-verify="pass" placeholder="请填写原密码" autocomplete="off"
                           class="layui-input" maxlength="14">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">新密码<font color="red">*</font></label>
                <div class="layui-input-block">
                    <input type="password" id="sysNewPWInp" name="sysNewPWInp"
                           placeholder="请填写新密码" autocomplete="off" class="layui-input"
                           maxlength="14">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">确认密码<font color="red">*</font></label>
                <div class="layui-input-block">
                    <input type="password" id="sysConfirmPWInp" name="sysConfirmPWInp"
                           placeholder="请填写确认密码" autocomplete="off" class="layui-input"
                           maxlength="14">
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" id="showIndexUpdatePW">确定</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-sm">取消</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/cache.js"></script>
<script type="text/javascript" src="${ctx}/jquery.min.js"></script>
<script type="text/javascript">

    //确认按钮
    $("#showIndexUpdatePW").click(function(){
        var oldPassword = $("#sysOldPWInp").val();
        var newPassword= $("#sysNewPWInp").val();
        var newPassword1 = $("#sysConfirmPWInp").val();
        if(newPassword !== newPassword1){
            layer.msg("俩次密码不一致");
        }else {
            $.ajax({
                url: "${ctx}/password/updatePassword",
                dataType: 'json',
                type: 'post',
                async: false,
                data:
                    {
                        oldPassword:oldPassword,
                        newPassword:newPassword
                    },
                success:function(res){
                    layer.msg(res.msg);
                    $("#sysOldPWInp").val("");
                    $("#sysNewPWInp").val("");
                    $("#sysConfirmPWInp").val("");
                }

            });
        }

    });
</script>
</body>
</html>
