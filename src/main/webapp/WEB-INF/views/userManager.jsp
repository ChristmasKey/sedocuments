<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 汪松
  Date: 2019/10/18
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body class="childrenBody">
<!-- 查询条件 -->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px">
    <legend>查询条件</legend>
</fieldset>
<blockquote class="layui-elem-quote">
    <form action="" method="post" id="searchFrm" lay-filter="searchFrm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户名称</label>
                <div id="items" class="layui-input-inline">
                    <input type="text" name="username" id="username" autocomplete="off" class="layui-input"
                           style="float: left">
                </div>
                <button type="button" class="layui-btn" lay-submit="" lay-filter="doSearch">
                    <span class="layui-icon layui-icon-search"></span>查询
                </button>
                <button type="reset" onclick="javascript:document.getElementById('username').value=''"
                        class="layui-btn layui-btn-warm">
                    <span class="layui-icon layui-icon-refresh-1"></span>重置
                </button>
            </div>
        </div>
    </form>
</blockquote>
<!-- 查询条件结束-->


<!-- 数据表格开始 -->
<div>
    <table class="layui-hide" id="userTable" lay-filter="userTable"></table>
    <div id="userToolBar" style="display: none;">
        <button type="button" lay-event="add" class="layui-btn layui-btn-sm"><span
                class="layui-icon layui-icon-add-1"></span>添加用户
        </button>
        <button type="button" class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleteBatch">
            <span class="layui-icon layui-icon-delete"></span>批量删除
        </button>
    </div>
    <div id="userRowBar" style="display: none;">
        <button type="button" lay-event="update" class="layui-btn layui-btn-sm"><span
                class="layui-icon layui-icon-edit"></span>编辑
        </button>
        <button type="button" lay-event="delete" class="layui-btn layui-btn-sm layui-btn-danger"><span
                class="layui-icon layui-icon-delete"></span>删除
        </button>
        <button type="button" lay-event="selectRole" class="layui-btn layui-btn-sm layui-btn-danger layui-bg-blue"><span
                class="layui-icon layui-icon-share"></span>分配角色
        </button>
    </div>
</div>

<!-- 数据表格结束 -->

<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
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
                           maxlength="11" placeholder="请输入用户联系电话"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户密码:</label>
                <div class="layui-input-inline">
                    <input type="password" name="password" layui-verify="required" placeholder="请输入用户密码(6-18位)"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户生日:</label>
                <div class="layui-input-inline">
                    <input type="date" name="birthday" placeholder="请输入生日:如1970-01-01" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户邮箱:</label>
                <div class="layui-input-inline">
                    <input type="text" name="email" lay-verify="required|email" placeholder="请输入用户邮箱" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户学校:</label>
                <div class="layui-input-inline">
                    <input type="text" name="school" placeholder="请输入用户学校" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户专业:</label>
                <div class="layui-input-inline">
                    <input type="text" name="major" placeholder="请输入用户专业" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
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
<!-- 添加和修改的弹出层结束 -->


<!-- 用户分配角色弹出层  开始 -->
<div style="display: none;padding: 5px" id="selectUserRoleDiv">
    <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
</div>


<!-- 用户分配角色弹出层  结束 -->


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
        //加载 数据
        tableIns = table.render({
            elem: '#userTable'
            , url: '${ctx}/userManager/findUserList'
            , toolbar: '#userToolBar' //开启头部工具栏，并为其绑定左侧模板
            , title: '用户数据表'
            , height: 'full-150'
            , cellMinWidth: 100
            , page: true
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'uid', title: 'ID', align: 'center', width: '80'}
                , {field: 'username', title: '用户姓名', align: 'center', width: '100'}
                , {
                    field: 'gender', title: '性别', align: 'center', width: '80', templet: function (d) {
                        return d.gender == '1' ? '<font color=blue>男</font>' : '<font color=red>女</font>';
                    }
                }
                , {field: 'phone', title: '联系电话', align: 'center', width: '120'}
                , {field: 'email', title: '电子邮箱', align: 'center', width: '100'}
                , {field: 'school', title: '学校名称', align: 'center', width: '150'}
                , {field: 'major', title: '专业名称', align: 'center', width: '150'}
                , {field: 'stuid', title: '用户学号', align: 'center', width: '180'}
                , {fixed: 'right', title: '操作', toolbar: '#userRowBar', align: 'center', width: '300'}
            ]]
            //,limit:5
            , done: function (res, curr, count) {
                //处理删除某一页最后一条数据的BUG
                if (res.data.length == 0 && curr != 1) {
                    tableIns.reload({
                        page: {
                            curr: (curr - 1)
                        }
                    });
                }
            }
        });
        //模糊查询
        form.on("submit(doSearch)", function (data) {
            var params = $("#username").val();
            tableIns.reload({
                url: '${ctx}/userManager/findUserList?' + params,
                where: data.field,
                page: {
                    curr: 1
                },
            });
            return false;
        });

        //监听工具条的事件
        table.on("toolbar(userTable)", function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddLayer();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }
            ;
        });

        //监听行工具条的事件
        table.on("tool(userTable)", function (obj) {
            var data = obj.data; //获得当前行数据
            switch (obj.event) {
                case 'update':
                    openUpdateUserLayer(data);
                    break;
                case 'delete':
                    deleteUser(data);
                    break;
                case 'selectRole':
                    selectRole(data);
                    break;

            }
            ;
        });

        var mainIndex;
        var url;

        //打开添加的弹出层
        function openAddLayer() {
            mainIndex = layer.open({
                type: 1,
                content: $("#addOrUpdateDiv"),
                area: ['800px', '400px'],
                title: '添加用户',
                success: function () {
                    $("#dataFrm")[0].reset();
                    url = "${ctx}/userManager/addUser";
                }
            });
        }

        //打开修改的弹出层
        function openUpdateUserLayer(data) {
            mainIndex = layer.open({
                type: 1,
                content: $("#addOrUpdateDiv"),
                area: ['800px', '400px'],
                title: '修改用户',
                success: function (index) {
                    form.val("dataFrm", data);
                    url = "${ctx}/userManager/updateUser";
                }
            });
        }

        form.on("submit(doSubmit)", function (data) {
            $.post(url, data.field, function (res) {
                if (res.code == 200) {
                    tableIns.reload();
                }
                if (res.msg != null) {
                    tableIns.reload();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            })
            return false;
        })

        //删除
        function deleteUser(data) {
            layer.confirm('你确定要删除【 ' + data.username + ' 】这条用户吗?', {icon: 3, title: '提示'}, function (index) {
                $.post("${ctx}/userManager/deleteUser", {uid: data.uid}, function (res) {
                    tableIns.reload();
                    layer.msg(res.msg);
                })
                layer.close(index);
            });
        }

        //批量删除
        function deleteBatch() {
            //得到选中的数据行
            var checkStatus = table.checkStatus('userTable');
            var data = checkStatus.data;
            var params = "";
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += "ids=" + item.uid;
                } else {
                    params += "&ids=" + item.uid;
                }
            });
            layer.confirm('真的删除选中的这些用户吗', function (index) {
                //向服务端发送删除指令
                $.post("${ctx}/userManager/deleteBatchUser", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据 表格
                    tableIns.reload();
                })
            });
        }

        //打开分配角色的弹出层
        function selectRole(data) {
            mainIndex = layer.open({
                type: 1,
                content: $("#selectUserRoleDiv"),
                area: ['800px', '400px'],
                title: '分配【' + data.username + '】的角色',
                btn: ['<span class=layui-icon>&#xe605;确认分配</span>', '<span class=layui-icon>&#x1006;关闭窗口</span>'],
                yes: function (index, layero) {
                    var checkStatus = table.checkStatus('roleTable');
                    var params = "uid=" + data.uid;
                    $.each(checkStatus.data, function (index, data) {
                        params += "&roleid=" + data.roleid;
                    });
                    $.post("${ctx}/userManager/updateRoleByUid", params, function (res) {
                        layer.msg(res.msg);
                        layer.close(index);
                    })
                },
                btn2: function (index, layero) {
                    //return false 开启该代码可禁止点击该按钮关闭
                },
                btnAlign: 'c',
                success: function () {
                    initRoleTable(data);
                }
            });
        }

        var roleTableIns;

        //初始化角色列表
        function initRoleTable(data) {
            roleTableIns = table.render({
                elem: '#roleTable'
                , url: '${ctx}/userManager/initRoleList'
                , where: {
                    uid: data.uid
                }
                , cols: [[
                    {type: 'radio', align: 'center'}
                    , {field: 'roleid', title: 'ID', align: 'center'}
                    , {field: 'rolename', title: '角色名称', align: 'center'}
                ]]
            });
        }
        //验证重复账号
        $("#phone").blur(function () {
            var isphone = document.getElementById("phone");
            var datas={"phone":isphone.value}
            $.ajax({
                type: "POST",
                url: '${ctx}/userManager/isExistPhone',
                data: datas,
                success: function (res) {
                    if (res.msg != null) {
                        layer.msg(res.msg);
                    }
                }
            });

        });
    });
</script>

</body>
</html>