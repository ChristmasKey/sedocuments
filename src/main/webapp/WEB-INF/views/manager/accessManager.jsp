<%--
  Created by IntelliJ IDEA.
  User: 雨木林风
  Date: 2019/10/18
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>权限管理</title>
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
<body class="childrenBody">
<!-- 搜索条件开始 -->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>查询条件</legend>
</fieldset>
<form class="layui-form" method="post" id="searchFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">权限名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="title"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" class="layui-btn layui-btn-normal  layui-icon layui-icon-search" id="doSearch">查询</button>
            <button type="reset" class="layui-btn layui-btn-warm  layui-icon layui-icon-refresh">重置</button>
        </div>
    </div>
</form>
<!-- 搜索条件结束 -->

<!-- 数据表格开始 -->
<table class="layui-hide" id="accessTable" lay-filter="accessTable"></table>
<div style="display: none;" id="accessToolBar">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="add">增加</button>
</div>
<div  id="accessBar" style="display: none;">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
<!-- 数据表格结束 -->

<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 20px" id="saveOrUpdateDiv" >
    <form class="layui-form"  lay-filter="dataFrm" id="dataFrm">
        <div class="layui-form-item">
            <label class="layui-form-label">父级权限:</label>
            <div class="layui-input-block">
                <div class="layui-unselect layui-form-select" id="pid_div">
                    <div class="layui-select-title">
                        <input type="hidden" name="pid"  id="pid">
                        <input type="text" name="pid_str" id="pid_str" placeholder="请选择" readonly="" class="layui-input layui-unselect">
                        <i class="layui-edge"></i>
                    </div>
                </div>
                <div class="layui-card select-test" id="accessSelectDiv">
                    <div class="layui-card-body">
                        <div id="toolbarDiv"><ul id="accessTree" class="dtree" data-id="0" style="width: 100%;"></ul></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限名称:</label>
            <div class="layui-input-block">
                <input type="hidden" name="accessid">
                <input type="text" name="title"  placeholder="请输入权限名称" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限地址:</label>
            <div class="layui-input-block">
                <input type="text" name="href" placeholder="请输入权限地址" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">权限图标:</label>
                <div class="layui-input-inline">
                    <input type="text" name="icon"   placeholder="请输入权限图标" lay-verify="required" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">TARGET:</label>
                <div class="layui-input-inline">
                    <input type="text" name="target"  placeholder="请输入TRAGET"  autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">是否展开:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="spread" value="0" title="展开">
                    <input type="radio" name="spread" value="1" title="不展开"  checked="checked">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <div class="layui-input-block">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release" lay-filter="doSubmit" lay-submit="">提交</button>
                <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh" >重置</button>
            </div>
        </div>
    </form>

</div>
<!-- 添加和修改的弹出层结束 -->

<script src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    var tableIns;
    layui.extend({
        dtree:'${ctx}/resources/layui_ext/dist/dtree'
    }).use(['jquery','layer','form','table','dtree'],function () {
        var $=layui.jquery;
        var layer=layui.layer;
        var form=layui.form;
        var table=layui.table;
        var dtree=layui.dtree;
        //渲染数据表格
        tableIns=table.render({
            elem:'#accessTable',
            url:'${ctx}/access/loadAllAccess',
            title:'权限表',
            toolbar:'#accessToolBar',
            height:'full-150',
            cellMinWidth:100,
            page:true,
            cols:[[
                {type:'checkbox',fixed:'left'},
                {field:'accessid',title:'ID',align:'center',width:'80'},
                {field:'pid',title:'父节点ID',align:'center',width:'120'},
                {field:'title',title:'权限名称',align:'center',width:'120'},
                {field:'href',title:'权限地址',align:'center',width:'230'},
                {field:'spread',title:'是否展开',align:'center',width:'120',templet:function (d) {
                    return d.spread=='0'?'<a style="color: blue">展开</a>':'<a style="color: red">不展开</a>';
                    }},
                {field:'target',title:'TARGET',align:'center',width:'120'},
                {field:'icon',title:'权限图标',align:'center',width:'100',templet:function (d) {
                        return '<div class="layui-icon">'+d.icon+'</div>';
                    }},
                {fixed:'right',title:'操作',toolbar:'#accessBar',width:180,align:"center"}
            ]]
        });
        //模糊查询
        $("#doSearch").click(function () {
            var params=$("#searchFrm").serialize();
            tableIns.reload({
                url:'${ctx}/access/loadAllAccess?'+params,
                page:{curr:1}
            })
        });
        //监听头部工具栏事件
        table.on("toolbar(accessTable)",function (obj) {
            if (obj.event==='add'){
                openAddAccess();
            }
        });
        //监听行工具事件
        table.on("tool(accessTable)",function (obj) {
            var data = obj.data;
            var layEvent=obj.event;
            if (layEvent === 'del') {
                $.post("${ctx}/access/checkAccessHasChildren?accessid="+data.accessid,function (obj) {
                    if (obj.code >= 0) {
                        layer.msg("当前权限有子节点，请先删除子节点");
                    }else{
                        layer.confirm('确定删除【'+data.title+'】这个权限吗',function (index) {
                            $.post('${ctx}/access/deleteAccess',{accessid:data.accessid},function (res) {
                                layer.msg(res.msg);
                                //刷新数据表格
                                tableIns.reload();
                                //刷新添加和修改的下拉树
                                accessTree.reload();
                            })
                        });
                    }
                });
            }else if (layEvent === 'edit') {
                openUpdateAccess(data);
            }

        });

        var url;
        var mainIndex;
        //打开添加页面
        function openAddAccess() {
            // alert("即将弹出添加窗口");
            mainIndex=layer.open({
                type:1,
                title:'添加权限',
                content:$("#saveOrUpdateDiv"),
                area:['800px','450px'],
                success:function (index) {
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    $("#accessSelectDiv").removeClass("layui-show");
                    url="${ctx}/access/addAccess";
                }
            });
        }
        //打开修改页面
        function openUpdateAccess(data) {
            // alert("即将弹出修改窗口");
            mainIndex=layer.open({
                type:1,
                title:'修改权限',
                content:$("#saveOrUpdateDiv"),
                area:['800px','450px'],
                success:function (index) {
                    form.val("dataFrm",data);
                    url="${ctx}/access/updateAccess";
                    //反选下拉树
                    var pid=data.pid;
                    var params=dtree.dataInit("accessTree",pid);
                    //移除打开的样式
                    $("#accessSelectDiv").removeClass("layui-show");
                    //给下拉框的text框赋值
                    // console.log(params);
                    if(typeof (params)!="undefined"){
                        $("#pid_str").val(params.context);
                    }else{
                        $("#pid_str").val("");
                    }
                    accessTree.reload();
                }
            });
        }
        //保存
        form.on("submit(doSubmit)",function (obj) {
            //序列化表单数据
            var params=$("#dataFrm").serialize();
            $.post(url,params,function (obj) {
                layer.msg(obj.msg);
                //关闭弹出层
                layer.close(mainIndex);
                //刷新数据表格
                tableIns.reload();
                //刷新添加和修改的下拉树
                accessTree.reload();
            })
        });
        //初始化添加和修改页面的下拉树
        var accessTree=dtree.render({
            elem:'#accessTree',
            dataStyle:'layuiStyle',
            response:{message:'msg',statusCode:0},
            dataFormat:'list',
            url:'${ctx}/access/loadAccessManagerTreeJson?spread=1',
            icon:'2',
            accordion:true
        });
        $("#pid_div").on("click",function () {
            $(this).toggleClass("layui-form-selected");
            $("#accessSelectDiv").toggleClass("layui-show layui-anim layui-anim-upbit");
        });
        dtree.on("node(accessTree)",function (obj) {
           $("#pid_str").val(obj.param.context);
           $("#pid").val(obj.param.nodeId);
           $("#pid_div").toggleClass("layui-form-selected");
           $("#accessSelectDiv").toggleClass("layui-show layui-anim layui-anim-upbit")
        });
    });
</script>
</body>
</html>
