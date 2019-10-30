<%--
  Created by IntelliJ IDEA.
  User: 雨木林风
  Date: 2019/10/28
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>模板管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/font/dtreefont.css">
</head>
<body>
<!--左侧树开始-->
<div style="overflow: auto;float: left;width: 22%;height: 100%;" id="treeDiv">
    <ul id="templateTree" class="dtree" data-id="0"></ul>
</div>
<!--左侧树结束-->

<!--头部工具栏开始-->
<blockquote class="layui-elem-quote quoteBox" style="float: left;width: 74%;">
    <form class="layui-form" method="post" id="searchFrm">
        <div class="layui-inline">
            <label class="layui-form-label">关键词：</label>
            <div class="layui-input-inline">
                <input type="text" name="proname" autocomplete="off" class="layui-input" placeholder="请输入项目名称">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" class="layui-btn layui-btn-normal layui-icon layui-icon-search" id="doSearch">查询</button>
            <button type="reset" class="layui-btn layui-btn-warm layui-icon layui-icon-refresh">重置</button>
            <button type="button" class="layui-btn layui-icon layui-icon-add-circle" id="addTempProject">添加模板项目</button>
        </div>
    </form>
</blockquote>
<!--头部工具栏结束-->

<!--右侧内容开始-->
<!--右侧内容结束-->

<!--模板项目添加弹出框开始-->
<div style="display: none;padding: 20px;" id="saveOrUpdateDiv">
    <form class="layui-form layui-form-pane" lay-filter="dataFrm" id="dataFrm">
        <div class="layui-form-item">
            <label class="layui-form-label">项目名称:</label>
            <div class="layui-input-block">
                <input type="hidden" name="projectid">
                <input type="text" name="proname" placeholder="请输入项目名称" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">备注内容:</label>
            <div class="layui-input-block">
                <textarea name="remark" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">是否为模板:</label>
            <div class="layui-input-block">
                <input type="radio" name="isTemplate" value="0" title="是" checked="checked">
                <input type="radio" name="isTemplate" value="1" title="否">
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">是否属官方:</label>
            <div class="layui-input-block">
                <input type="radio" name="isOfficial" value="0" title="是" checked="checked">
                <input type="radio" name="isOfficial" value="1" title="否">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release" lay-filter="doSubmit" lay-submit="">提交</button>
            <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">重置</button>
        </div>
    </form>
</div>
<!--模板项目添加弹出框结束-->

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.extend({
        dtree:'${ctx}/resources/layui_ext/dist/dtree'
    }).use(['element','jquery','layer','form','dtree'],function () {
        var $=layui.jquery;
        var layer=layui.layer;
        var form=layui.form;
        var dtree=layui.dtree;
        //初始化树
        var tempTree=dtree.render({
            elem:'#templateTree',
            url:'${ctx}/project/loadProjectManagerTreeJson',
            scroll:'#treeDiv',
            dataStyle:'layuiStyle',
            response:{message:"msg",statusCode:0},
            record:true,
            icon:"7",
            toolbar:true,
            toolbarShow:[],//默认按钮置空
            toolbarExt:[
                {
                    toolbarId:"projectEdit",icon:"dtree-icon-repair",title:"修改项目信息",
                    handler:function (node,$div) {
                        var proData=JSON.parse(node.recordData);
                        var data={};
                        data["projectid"]=node.nodeId;
                        data["proname"]=node.context;
                        data["remark"]=proData.remark;
                        data["isTemplate"]=proData.isTemplate;
                        data["isOfficial"]=proData.isOfficial;
                        // console.log(data);
                        openUpdateProject(data);
                    }
                },
                {
                    toolbarId:"projectDel",icon:"dtree-icon-qrcode1",title:"删除此项目及文档",
                    handler:function (node,$div) {
                        layer.msg(this.title);
                    }
                },
                {
                    toolbarId:"documentAdd",icon:"dtree-icon-add-circle",title:"添加项目文档",
                    handler:function (node,$div) {
                        layer.msg(this.title);
                    }
                },
                {
                    toolbarId:"renameDoc",icon:"layui-icon layui-icon-edit",title:"重命名",
                    handler:function (node, $div) {
                        layer.msg(this.title);
                    }
                },
                {
                    toolbarId:"documentDel",icon:"layui-icon layui-icon-delete",title:"删除此文档",
                    handler:function (node, $div) {
                        layer.msg(this.title);
                    }
                }
            ],
            toolbarFun:{
                loadToolbarBefore:function (buttons, param, $div) {
                    if(param.leaf){//根据节点类型置空toolbar的一些选项
                        buttons.projectEdit="";
                        buttons.projectDel="";
                        buttons.documentAdd="";
                    }else{
                        buttons.documentDel="";
                        buttons.renameDoc="";
                    }
                    return buttons;
                }
            }
        });

        //监听节点的单击事件
        dtree.on("node(templateTree)",function (obj) {
            /*if(obj.param.leaf!==true){
                var recordData=JSON.parse(obj.param.recordData);
                layer.msg(recordData.createtime);
            }*/
        });

        //模糊查询
        $("#doSearch").click(function () {
            var params=$("#searchFrm").serialize();
            // layer.msg(params);
            tempTree.reload({
                url:'${ctx}/project/loadProjectManagerTreeJson?'+params
            })
        });

        //项目添加按钮的点击事件
        $("#addTempProject").click(function(){
            openAddProject();
        });

        var url;
        var mainIndex;
        //打开项目添加页面
        function openAddProject() {
            mainIndex=layer.open({
                type:1,
                title:"添加项目",
                content:$("#saveOrUpdateDiv"),
                area:["800px","450px"],
                success:function (index) {
                    $("#dataFrm")[0].reset();//清空表单数据
                }
            });
        }
        //打开项目修改页面
        function openUpdateProject(data) {
            mainIndex=layer.open({
                type:1,
                title:"修改项目信息",
                content:$("#saveOrUpdateDiv"),
                area:['800px','450px'],
                success:function (index) {
                    form.val("dataFrm",data);
                }
            });
        }
        //保存
        form.on("submit(doSubmit)",function (obj) {
            var params=$("#dataFrm").serialize();
            layer.msg(params);
        })
    });
</script>
</body>
</html>
