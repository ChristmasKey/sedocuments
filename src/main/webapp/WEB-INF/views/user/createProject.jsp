<%--
  Created by IntelliJ IDEA.
  User: 雨木林风
  Date: 2019/11/7
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>新建项目</title>
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
    <link rel="stylesheet" href="${ctx}/resources/css/step.css">
</head>
<body>
<%--步骤条--%>
<div class="layui-step" id="step">
    <div class="layui-step-content layui-clear">
        <div class="layui-step-content-item">
            <div style="padding: 20px;" id="projectInfoDiv">
                <form class="layui-form layui-form-pane" lay-filter="proinfoFrm" id="proinfoFrm">
                    <div class="layui-form-item">
                        <label class="layui-form-label">项目名称:</label>
                        <div class="layui-input-block">
                            <input type="text" name="proname" placeholder="请输入项目名称" lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">备注内容:</label>
                        <div class="layui-input-block">
                            <textarea name="remark" placeholder="请输入备注内容" class="layui-textarea"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item" style="text-align: center;">
                        <button type="button" class="layui-btn layui-btn-normal layui-icon layui-icon-release" lay-filter="toTemp" lay-submit="">下一步</button>
                        <button type="reset" class="layui-btn layui-btn-warm layui-icon layui-icon-refresh">重置</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="layui-step-content-item">
            <div style="padding: 20px;" id="templateDiv">
                <form class="layui-form layui-form-pane" lay-filter="tempFrm" id="tempFrm">
                    <div class="layui-form-item">
                        <div class="layui-block">
                            <label class="layui-form-label">项目模板:</label>
                            <div class="layui-input-block">
                                <select name="projectid" lay-search="" id="projectTemp" lay-filter="projectTemp"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item" style="text-align: center;">
                        <button type="button" class="layui-btn layui-btn-normal layui-icon layui-icon-release" lay-filter="toDoc" lay-submit="">下一步</button>
                        <button type="reset" class="layui-btn layui-btn-warm layui-icon layui-icon-refresh">重置</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="layui-step-content-item">
            <!--左侧树开始-->
            <div style="overflow: auto;float: left;width: 22%;height: 80%;" id="newprojectTreeDiv">
                <ul id="newprojectTree" class="dtree" data-id="0"></ul>
            </div>
            <!--左侧树结束-->
            <!--头部工具栏开始-->
            <blockquote class="layui-elem-quote layui-quote-nm quoteBox" style="float: left;width: 74%;">
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
                    </div>
                </form>
            </blockquote>
            <!--头部工具栏结束-->
            <!--右侧内容开始-->
            <div style="float: left;width: 74%;" id="contentDiv">
                <form class="layui-form layui-form-pane" lay-filter="contentFrm" id="contentFrm">
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
                    <div class="layui-form-item" style="text-align: center;">
                        <button type="button" class="layui-btn layui-btn-normal layui-icon layui-icon-release" lay-filter="toFinish" lay-submit="">下一步</button>
                    </div>
                </form>
            </div>
            <!--右侧内容结束-->
        </div>
        <div class="layui-step-content-item">
            <div class="layui-col-md6 layui-col-md-offset3">
                <div class="layui-card">
                    <div class="layui-card-header" style="text-align: center;">
                        <h2>Congratulations！</h2>
                    </div>
                    <div class="layui-card-body" style="text-align: center;">
                        <h1>项目文档已经成功生成!</h1><br>
                        <h4>点击上一步，返回文档编辑；点击确定，完成项目创建</h4>
                    </div>
                </div>
                <div style="text-align: center;">
                    <button type="button" class="layui-btn layui-btn-normal layui-icon layui-icon-release" id="backDoc">上一步</button>
                    <button type="button" class="layui-btn layui-icon layui-icon-ok-circle" id="reloadPage">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--步骤条--%>
<script type="text/javascript" src="${ctx}/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/pageoffice.js" id="po_js_main"></script>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.extend({
        dtree:"${ctx}/resources/layui_ext/dist/dtree",
        step:"${ctx}/resources/layui/lay/mymodules/step"
    }).use(['element','jquery','layer','form','dtree','step'],function () {
        var $=layui.jquery;
        var layer=layui.layer;
        var form=layui.form;
        var dtree=layui.dtree;
        var step=layui.step;
        var newprojectTree;
        step.render({
            elem:"#step",
            title:["项目创建","模板选择","文档编排","创建成功"],
            description:["请填写项目信息","请选择模板项目","请打开每份文档编辑保存","项目生成成功"],
            isOpenStepLevel:false
        });
        form.on("submit(toTemp)",function (obj) {
            //给下拉框动态绑定数据
            var projectTemp=$("#projectTemp");
            projectTemp.empty();
            projectTemp.append("<option value=''>"+"请直接选择或搜索选择"+"</option>");
            projectTemp.append("<option value='0'>"+"不选择模板"+"</option>");
            $.post("${ctx}/dropdown/queryOfficialTemp",function (obj) {
                projectTemp.append("<optgroup label='官方模板'>");
                for(var j=0,len=obj.length;j<len;j++){
                    projectTemp.append("<option value='"+obj[j].projectid+"'>"+obj[j].proname+"</option>");

                }
                projectTemp.append("</optgroup>");
                form.render("select","tempFrm");
            });
            $.post("${ctx}/dropdown/queryMyTemplate",function (obj) {
                console.log(obj);
                projectTemp.append("<optgroup label='我的模板'>");
                for(var j=0,len=obj.length;j<len;j++){
                    projectTemp.append("<option value='"+obj[j].projectid+"'>"+obj[j].proname+"</option>");
                }
                projectTemp.append("</optgroup>");
                form.render("select","tempFrm");
            });
            //跳转下一步
            step.next();
        });
        form.on("submit(toDoc)",function (obj) {
            //1.创建项目：向project表中插入数据返回projectid存储在session中
            var proInfo=$("#proinfoFrm").serialize();
            $.post("${ctx}/project/createProject",proInfo,function (obj) {
                console.log(obj.msg);
                //2.添加文档：前端传值模板项目的projectid，后台查询项目下文档，
                //将取到的文档数据结合session中的projectid重新设置后插入document表中
                //若未选择模板，则生成一份空白文档
                var tempInfo=$("#tempFrm").serialize();
                $.post("${ctx}/project/addDocumentByDocument",tempInfo,function (obj) {
                    console.log(obj.msg);
                    //3.渲染树
                    newprojectTree=dtree.render({
                        elem:"#newprojectTree",
                        url:"${ctx}/project/loadNewProjectTreeJson",
                        scroll:"#newprojectTreeDiv",
                        dataStyle:"layuiStyle",
                        response:{message:"msg",statusCode:0},
                        record:true,
                        icon:"7"
                    });
                });
            });
            //跳转下一步
            step.next();
        });
        form.on("submit(toFinish)",function (obj) {
            //跳转下一步
            step.next();
        });
        $("#backDoc").on("click",function () {
            step.prev();
        });
        $("#reloadPage").on("click",function () {
            // layer.msg("即将刷新整个子页面");
            location.reload();
        });
        //监听节点的单击事件
        dtree.on("node(newprojectTree)",function (obj) {
            if (!obj.param.leaf) {
                // layer.msg("父节点");
                var prodata=JSON.parse(obj.param.recordData);
                var data={};
                data["createtime"]=prodata.createtime;
                data["docnumber"]=prodata.docnumber;
                data["remark"]=prodata.remark;
                form.val("contentFrm",data);
            }else{
                // layer.msg("子节点");
                var docid=obj.param.nodeId.substring(3,obj.param.nodeId.length);
                var doctype=JSON.parse(obj.param.recordData).doctype;
                // layer.msg(docid+" and "+doctype);
                POBrowser.openWindowModeless("${ctx}/document/openNewDoc?docid="+docid+"&doctype="+doctype,"width=1200px;height=600px;");
            }
        });
        //模糊查询（彩蛋）
        $("#doSearch").click(function () {
            layer.msg("当前项目仅有一个！");
        });
    });
</script>
</body>
</html>
