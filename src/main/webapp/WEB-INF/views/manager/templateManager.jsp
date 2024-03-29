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
<div style="float: left;width: 74%;" id="projectDiv">
    <form class="layui-form layui-form-pane" lay-filter="proFrm" id="proFrm">
        <div class="layui-form-item">
            <label class="layui-form-label">创建日期:</label>
            <div class="layui-input-inline">
                <input type="text" id="createtime" name="createtime" readonly="readonly" class="layui-input">
            </div>
            <label class="layui-form-label">文档数量:</label>
            <label class="layui-input-inline">
                <input type="text" id="docnumber" name="docnumber" readonly="readonly" class="layui-input">
            </label>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">备注内容:</label>
            <div class="layui-input-block">
                <textarea id="remark" name="remark" readonly="readonly" class="layui-textarea"></textarea>
            </div>
        </div>
    </form>
</div>
<!--右侧内容结束-->

<!--模板项目添加弹出框开始-->
<div style="display: none;padding: 20px;" id="docAddDiv">
    <form class="layui-form layui-form-pane" lay-filter="docFrm" id="docFrm">
        <div class="layui-form-item">
            <label class="layui-form-label">文档名称:</label>
            <div class="layui-input-block">
                <input type="hidden" name="projectid">
                <input type="text" name="doctitle" placeholder="请输入文档名称" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release" lay-filter="doAddDoc" lay-submit="">提交</button>
            <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">重置</button>
        </div>
    </form>
</div>
<div style="display: none;padding: 20px;" id="renameDiv">
    <form class="layui-form layui-form-pane" lay-filter="nameFrm" id="nameFrm">
        <div class="layui-form-item">
            <label class="layui-form-label">文档名称:</label>
            <div class="layui-input-block">
                <input type="hidden" name="docid">
                <input type="text" name="doctitle" placeholder="请输入文档名称" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release" lay-filter="doRename" lay-submit="">提交</button>
            <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">重置</button>
        </div>
    </form>
</div>
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
<script type="text/javascript" src="${ctx}/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/pageoffice.js" id="po_js_main"></script>
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
            accordion:true,
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
                        // layer.msg(this.title);
                        layer.confirm('确定删除【'+node.context+'】这个项目吗',function (index) {
                            $.post("${ctx}/project/deleteProject",{projectid:node.nodeId},function (res) {
                                layer.msg(res.msg);
                                tempTree.reload();
                            })
                        });
                    }
                },
                {
                    toolbarId:"documentAdd",icon:"dtree-icon-add-circle",title:"添加项目文档",
                    handler:function (node,$div) {
                        // layer.msg(this.title);
                        var data={};
                        data["projectid"]=node.nodeId;
                        openAddDocument(data);
                    }
                },
                {
                    toolbarId:"renameDoc",icon:"layui-icon layui-icon-edit",title:"重命名",
                    handler:function (node, $div) {
                        // layer.msg(this.title);
                        var data={};
                        data["docid"]=node.nodeId.substring(3,node.nodeId.length);
                        data["doctitle"]=node.context;
                        openRenameDocument(data);

                    }
                },
                {
                    toolbarId:"documentDel",icon:"layui-icon layui-icon-delete",title:"删除此文档",
                    handler:function (node, $div) {
                        // layer.msg(this.title);
                        $.post('${ctx}/project/checkDocnumber',{projectid:node.parentId},function (obj) {
                            if (obj.code >= 0) {
                                var docid=node.nodeId.substring(3,node.nodeId.length);
                                layer.confirm('确定删除【'+node.context+'】这个文档吗',function (index) {
                                    $.post("${ctx}/project/deleteDocument",{docid:docid,projectid:node.parentId},function (res) {
                                        layer.msg(res.msg);
                                        tempTree.reload();
                                    })
                                });
                            }else{
                                layer.msg("项目中至少保留一份文档 ");
                            }
                        });
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
            if (!obj.param.leaf) {
                var $div=obj.dom;
                tempTree.clickSpread($div);
                var prodata=JSON.parse(obj.param.recordData);
                console.log(prodata);
                var data={};
                data["createtime"]=prodata.createtime;
                data["docnumber"]=prodata.docnumber;
                data["remark"]=prodata.remark;
                form.val("proFrm",data);
            }else{
                // layer.msg("这是叶子节点——文档");
                //点击节点后，打开文档（待实现）
                var docid=obj.param.nodeId.substring(3,obj.param.nodeId.length);
                // layer.msg(docid);
                POBrowser.openWindowModeless("${ctx}/document/openDoc?docid="+docid,"width=1200px;height=600px;");
            }
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
                    url="${ctx}/project/addProject";
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
                    url="${ctx}/project/updateProject"
                }
            });
        }
        //打开文档添加页面
        function openAddDocument(data) {
            mainIndex=layer.open({
                type:1,
                title:"添加项目文档",
                content:$("#docAddDiv"),
                area:["400px","200px"],
                success:function (index) {
                    $("#docFrm")[0].reset();
                    form.val("docFrm",data);
                    // $("#proid").value=data.projectid;
                    url="${ctx}/project/addDocumentByProjectId"
                }
            });
        }
        //打开文档重命名页面
        function openRenameDocument(data){
            mainIndex=layer.open({
                type:1,
                title:"重命名",
                content:$("#renameDiv"),
                area:['400px','200px'],
                success:function (index) {
                    form.val("nameFrm",data);
                    url="${ctx}/project/renameDocument"
                }
            });
        }
        //保存
        form.on("submit(doSubmit)",function (obj) {
            var params=$("#dataFrm").serialize();
            $.post(url,params,function (obj) {
                layer.msg(obj.msg);
                layer.close(mainIndex);
                //刷新树
                tempTree.reload();
            })
        });
        //保存文档名称
        form.on("submit(doRename)",function (obj) {
            var params=$("#nameFrm").serialize();
            $.post(url,params,function (obj) {
                layer.msg(obj.msg);
                layer.close(mainIndex);
                //刷新树
                tempTree.reload();
            })
        });
        //添加文档
        form.on("submit(doAddDoc)",function (obj) {
            var params=$("#docFrm").serialize();
            $.post(url,params,function (obj) {
                layer.msg(obj.msg);
                layer.close(mainIndex);
                //刷新树
                tempTree.reload();
            })
        });
    });
</script>
</body>
</html>
