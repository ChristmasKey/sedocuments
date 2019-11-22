<%--
  Created by IntelliJ IDEA.
  User: 24486
  Date: 2019/11/12
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all">
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/font/dtreefont.css">
    <style type="text/css">
        .select-test{position: absolute;max-height: 500px;height: 350px;overflow: auto;width: 100%;z-index: 123;display: none;border:1px solid silver;top: 42px;}
        .layui-show{display: block!important;}
    </style>
</head>
<body>
<form class="layui-form" action="" style="text-align: center;padding-top: 100px;" id="form1" lay-filter="form1">
    <div class="layui-inline">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" id="#username" name="username" readonly="readonly">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号码</label>
        <div class="layui-input-block">
            <input type="text" id="#phone" name="phone" readonly="readonly">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block">
            <input type="text" id="#email" name="email" readonly="readonly">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            <input type="radio" name="#gender" value="1" checked="checked" title="男">
            <input type="radio" name="#gender" value="2" title="女">
        </div>
    </div>
    </div>
    <div class="layui-inline">
    <div class="layui-form-item">
        <label class="layui-form-label">生日</label>
        <div class="layui-input-block">
            <input type="text" id="#birthday" name="birthday" readonly="readonly">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">学校</label>
        <div class="layui-input-block">
            <input type="text" id="#school" name="school" readonly="readonly">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">专业</label>
        <div class="layui-input-block">
            <input type="text" id="#major" name="major" readonly="readonly">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">学号</label>
        <div class="layui-input-block">
            <input type="text" id="#stuid" name="stuid" readonly="readonly">
        </div>
    </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="button" id="updateBtn" lay-event="update" class="layui-btn layui-btn-sm">修改</button>
        </div>
    </div>
</form>

<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 5px" id="UpdateDiv">
    <form class="layui-form" method="post" lay-filter="dataFrm" id="dataFrm">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户姓名:</label>
                <div class="layui-input-inline">
                    <input type="hidden" name="uid">
                    <input type="text" name="username" placeholder="请输入用户姓名" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户性别:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="gender" value="1" checked="checked" title="男">
                    <input type="radio" name="gender" value="2" title="女">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">联系电话:</label>
                <div class="layui-input-inline">
                    <input type="text" name="phone" id="phone" lay-verify="required|phone" lay-event="isExist"
                           maxlength="11" placeholder="请输入新的联系电话"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户生日:</label>
                <div class="layui-input-inline">
                    <input type="date" name="birthday" placeholder="请输入生日:如1970-01-01" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户邮箱:</label>
                <div class="layui-input-inline">
                    <input type="text" name="email" lay-verify="required|email" placeholder="请输入用户邮箱" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户学校:</label>
                <div class="layui-input-inline">
                    <select name="school" lay-verify="required">
                        <option value=""></option>
                        <option value="淮阴工学院">淮阴工学院</option>
                        <option value="盐城工学院">盐城工学院</option>
                        <option value="徐海学院">徐海学院</option>
                        <option value="中国矿业大学">中国矿业大学</option>
                        <option value="淮阴师范学院">淮阴师范学院</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户专业:</label>
                <div class="layui-input-inline">
                    <select name="major" lay-verify="required">
                        <option value=""></option>
                        <option value="计算机科学与技术（微软合作）">计算机科学与技术（微软合作）</option>
                        <option value="土木工程">土木工程</option>
                        <option value="徐海学院">徐海学院</option>
                        <option value="商学院">商学院</option>
                        <option value="计算机科学与技术">计算机科学与技术</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户学号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="stuid" placeholder="请输入用户学号" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <div class="layui-input-block">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release"
                        lay-filter="doSubmit" lay-submit="">提交
                </button>
                <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">重置
                </button>
            </div>
        </div>
    </form>
</div>
<!-- 弹出层结束 -->

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    var tableIns;
    layui.extend({
        dtree: '${ctx}/resources/layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['jquery', 'form', 'table', 'layer', 'dtree'], function () {
        var $ = layui.jquery;
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
        var dtree = layui.dtree;

        window.onload = loadUserInfo();
        function loadUserInfo(){
            // layer.msg("456");
            $.post("${ctx}/userInfo/showAll",function (data) {
                // layer.msg(123);
                console.log(data.data[0]);
                form.val("form1",data.data[0]);
            });
        }

        $('#updateBtn').on('click',function () {
            // var data=$("#form1").serialize();
            // layer.msg(data);
            openUpdateUserLayer()
        });

        var mainIndex;
        //打开修改的弹出层
        function openUpdateUserLayer(data) {

            mainIndex = layer.open({
                type: 1,
                content: $("#UpdateDiv"),
                area: ['800px', '400px'],
                title: '修改用户',
                success: function (index) {
                    form.val("dataFrm", data);
                    url = "${ctx}/userInfo/userInfoUpdate";
                }
            });
        }

        form.on("submit(doSubmit)", function (data) {
            $.post(url, data.field, function (res) {
                if (res.code == 200) {
                    window.location.reload();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            })
            return false;
        })
    });
</script>
</body>


</html>
