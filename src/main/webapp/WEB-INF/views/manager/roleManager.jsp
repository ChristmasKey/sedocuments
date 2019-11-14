<%--
  Created by IntelliJ IDEA.
  User: 汪松
  Date: 2019/10/30
  Time: 19:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/dtree.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/font/dtreefont.css" media="all" />
</head>
<body class="childrenBody">
<!-- 查询条件开始 -->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
    <legend>查询条件</legend>
</fieldset>
<blockquote class="layui-elem-quote">
    <form action="" method="post" id="searchFrm" lay-filter="searchFrm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">角色名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="rolename"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <div class="layui-input-block" style="text-align: center;">
                    <button type="button" class="layui-btn" lay-submit="" lay-filter="doSearch"><span class="layui-icon layui-icon-search"></span>查询</button>
                    <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh-1"></span>重置</button>
                </div>
            </div>
        </div>
    </form>
</blockquote>
<!-- 查询条件结束-->


<!-- 数据表格开始 -->
<div>
    <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
    <div id="roleToolBar" style="display: none;">
        <button type="button" lay-event="add" class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加角色</button>
    </div>

    <div id="roleRowBar" style="display: none;">
        <button type="button" lay-event="update" class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-edit"></span>更新</button>
        <button type="button" lay-event="delete" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
        <button type="button" lay-event="selectPermission" class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-about"></span>分配权限</button>
    </div>
</div>


<!-- 数据表格结束 -->


<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" class="layui-form layui-form-pane" id="dataFrm" lay-filter="dataFrm">
        <div class="layui-form-item">
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-block">
                <input type="hidden" name="roleid">
                <input type="text" name="rolename" lay-verify="required" autocomplete="off" placeholder="请输入标题" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">角色备注</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" name="roledesc" id="remark"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否可用</label>
            <div class="layui-input-block">
                <input type="radio" name="isDel" checked="" value="1" title="可用" >
                <input type="radio" name="isDel" value="0" title="不可用" >
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center;">
                <button type="button" class="layui-btn" lay-submit="" lay-filter="doSubmit" id="doSubmit" ><span class="layui-icon layui-icon-add-1"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh-1"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<!-- 添加和修改的弹出层结束 -->


<!-- 分配权限的弹出层 开始 -->
<div style="display: none;" id="selectRolePermissionDiv">
    <ul id="permissionTree" class="dtree" data-id="0"></ul>
</div>
<!-- 分配权限的弹出层 结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.extend({
        dtree: '${ctx}/resources/layui_ext/dtree/dtree'
    }).use(['jquery','form','table','layer','dtree'],function(){
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var dtree=layui.dtree;
        //加载 数据
        var tableIns=table.render({
            elem: '#roleTable'
            ,url:'${ctx}/roleManager/initRoleList'
            ,toolbar: '#roleToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '角色数据表'
            ,height:'full-220'
            ,page: true
            ,cols: [ [
                {field:'roleid', title:'ID',align:'center'}
                ,{field:'rolename', title:'角色名称',align:'center'}
                ,{field:'roledesc', title:'角色备注',align:'center'}
                ,{field:'isDel', title:'是否可用',align:'center',templet:function(d){
                        return d.isDel==1?'<font color=blue>可用</font>':'<font color=red>不可用</font>';
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#roleRowBar',align:'center',width:'300'}
            ] ]
        });

        //模糊查询
        form.on("submit(doSearch)",function(data){
            tableIns.reload({
                where:data.field,
                page:{
                    curr:1
                }
            });
            return false;
        });

        //监听工具条的事件
        table.on("toolbar(roleTable)",function(obj){
            switch(obj.event){
                case 'add':
                    openAddLayer();
                    break;
            };
        });

        //监听行工具条的事件
        table.on("tool(roleTable)",function(obj){
            var data = obj.data; //获得当前行数据
            switch(obj.event){
                case 'update':
                    openUpdateRoleLayer(data);
                    break;
                case 'delete':
                    deleteRole(data);
                    break;
                case 'selectPermission':
                    selectPermission(data);
                    break;
            };
        });

        var mainIndex;
        var url;
        //打开添加的弹出层
        function openAddLayer(){
            mainIndex=layer.open({
                type:1,
                content:$("#addOrUpdateDiv"),
                area:['800px','400px'],
                title:'添加角色',
                success:function(){
                    $("#dataFrm")[0].reset();
                    url="${ctx}/roleManager/addRole";
                }
            });
        }

        //打开修改的弹出层
        function openUpdateRoleLayer(data){
            mainIndex=layer.open({
                type:1,
                content:$("#addOrUpdateDiv"),
                area:['800px','400px'],
                title:'修改角色',
                success:function(){
                    $("#dataFrm")[0].reset();
                    //装载新的数据
                    form.val("dataFrm",data);
                    url="${ctx}/roleManager/updateRoleById";
                }
            });
        }

        form.on("submit(doSubmit)",function(data){
            $.post(url,data.field,function(res){
                if(res.code==200){
                    tableIns.reload();
                }
                if(res.msg!=null){
                    tableIns.reload();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            })
            return false;
        });
        //删除
        function deleteRole(data){
            layer.confirm('你确定要删除【'+data.rolename+'】这条角色吗?', {icon: 3, title:'提示'}, function(index){
                $.post("${ctx}/roleManager/deleteRoleById",{roleid:data.roleid},function(res){
                    if(res.msg!=null){
                        tableIns.reload();
                    }
                    layer.msg(res.msg);
                })
                layer.close(index);
            });
        }

        //打开分配角色的页面
        function selectPermission(data){
            mainIndex=layer.open({
                type:1,
                content:$("#selectRolePermissionDiv"),
                area:['400px','500px'],
                title:'分配【'+data.rolename+'】的权限',
                btn: ['<span class=layui-icon>&#xe605;确认分配</span>', '<span class=layui-icon>&#x1006;关闭窗口</span>'],
                yes: function(index, layero){
                    //得到树选中的所有节点
                    var permissionData = dtree.getCheckbarNodesParam("permissionTree");
                    var params="roleid="+data.roleid;
                    $.each(permissionData,function(index,item){
                        params+="&ids="+item.nodeId;
                    });
                    $.post("${ctx}/roleManager/saveRoleAccess",params,function(res){
                        layer.msg(res.msg);
                        layer.close(index);
                    })
                },
                btn2: function(index, layero){
                    //return false 开启该代码可禁止点击该按钮关闭
                },
                btnAlign: 'c',
                success:function(){
                    //根据角色ID请求权限和菜单tree的json数据
                    dtree.render({
                        elem: "#permissionTree",
                        url: '${ctx}/roleManager/loadRoleAccessTree?roleid='+data.roleid,
                        dataStyle: "layuiStyle",  //使用layui风格的数据格式
                        dataFormat: "list",  //配置data的风格为list
                        response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
                        checkbar: true,
                        checkbarType: "all" // 默认就是all，其他的值为： no-all  p-casc   self  only
                    });
                }
            });
        }
    });
</script>
</body>
</html>