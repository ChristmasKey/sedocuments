<%--
  Created by IntelliJ IDEA.
  User: 雨木林风
  Date: 2019/10/17
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>平台首页</title>
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
</head>
<body class="childrenBody">
<%--搜索条件开始--%>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>查询条件</legend>
</fieldset>
<form class="layui-form" method="post" id="searchFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">项目名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="proname" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">开始时间:</label>
            <div class="layui-input-inline">
                <input type="text" name="startTime" id="startTime" readonly="readonly" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">结束时间:</label>
            <div class="layui-input-inline">
                <input type="text" name="endTime" id="endTime" readonly="readonly" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" class="layui-btn layui-btn-normal  layui-icon layui-icon-search" id="doSearch">查询</button>
            <button type="reset" class="layui-btn layui-btn-warm  layui-icon layui-icon-refresh">重置</button>
        </div>
    </div>
</form>
<%--搜索条件结束--%>

<%--数据表格开始--%>
<table class="layui-hide" id="templateProTable" lay-filter="templateProTable"></table>
<div id="previewDiv" style="display: none;">
    <a class="layui-btn layui-btn-xs" lay-event="preview">预览</a>
</div>
<%--数据表格结束--%>

<%--预览弹出层开始--%>
<div style="display: none;" id="previewProjectDiv">
    <div style="overflow: auto;float: left;width: 100%;height: 100%;" id="templateProTreeDiv">
        <ul id="templateProTree" class="dtree" data-id="0"></ul>
    </div>
</div>
<%--预览弹出层结束--%>
<script type="text/javascript" src="${ctx}/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/pageoffice.js" id="po_js_main"></script>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    var tableIns;
    layui.extend({
        dtree:'${ctx}/resources/layui_ext/dist/dtree'
    }).use(['jquery','layer','form','table','dtree','laydate'],function () {
        var $=layui.jquery;
        var layer=layui.layer;
        var form=layui.form;
        var table=layui.table;
        var dtree=layui.dtree;
        var laydate=layui.laydate;
        var mainIndex;
        var tempTree;
        //渲染时间
        laydate.render({
            elem:'#startTime',
            type:'datetime'
        });
        laydate.render({
            elem:'#endTime',
            type:'datetime'
        });
        //渲染数据表格
        tableIns=table.render({
            elem:'#templateProTable',
            url:'${ctx}/project/queryTemplates',
            title:'模板项目表',
            height:'full-200',
            cellMinWidth:100,
            page:true,
            cols:[[
                {field:'projectid',title:'编号',align:'center',width:'80'},
                {field:'proname',title:'项目名称',align:'center',width:'200'},
                {field:'createtime',title:'创建时间',align:'center',width:'200'},
                {field:'remark',title:'备注',align:'center',width:'440'},
                {field:'docnumber',title:'文档数量',align:'center',width:'100'},
                {fixed:'right',title:'操作',toolbar:'#previewDiv',align:'center',width:'100'}
            ]]
        });
        //模糊查询
        $("#doSearch").click(function () {
            var params=$("#searchFrm").serialize();
            tableIns.reload({
                url:"${ctx}/project/queryTemplates?"+params,
                page:{curr:1}
            })
        });
        //监听行工具事件
        table.on('tool(templateProTable)',function (obj) {
           var data=obj.data;
           var layEvent=obj.event;
           if (layEvent === 'preview') {
               // layer.msg("预览操作");
               console.log(data);
               mainIndex=layer.open({
                   type:1,
                   title:"项目预览",
                   content:$("#previewProjectDiv"),
                   area:['300px','400px'],
                   success:function (index) {
                       //初始化项目树
                       tempTree=dtree.render({
                           elem:"#templateProTree",
                           dataStyle:'layuiStyle',
                           response:{message:"msg",statusCode:0},
                           url:'${ctx}/project/loadTemplateProjectTreeJson?projectid='+data.projectid,
                           icon:"7",
                           record:true,
                           scroll:'#templateProTreeDiv'
                       });
                   }
               });
           }
        });
        //监听节点的点击事件
        dtree.on("node(templateProTree)",function (obj) {
            if (!obj.param.leaf) {
                var $div=obj.dom;
                tempTree.clickSpread($div);
            }else{
                // layer.msg("以只读模式打开文档");
                var docid=obj.param.nodeId.substring(3,obj.param.nodeId.length);
                // layer.msg(docid);
                POBrowser.openWindowModeless("${ctx}/document/openTemplate?docid="+docid,"width=1200px;height=600px;");

            }
        })
    });
</script>
</body>
</html>
