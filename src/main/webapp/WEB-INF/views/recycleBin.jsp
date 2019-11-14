<%--
  Created by IntelliJ IDEA.
  User: wangsong
  Date: 2019/11/14
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>回收站</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all">
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px">
    <legend>回收站</legend>
</fieldset>

<!-- 数据表格开始 -->
<div>
    <table class="layui-hide" id="proTable" lay-filter="proTable"></table>
    <div id="proRowBar" style="display: none;">
        <button type="button" class="layui-btn layui-btn-normal" lay-event="restore"><span
                class="layui-icon layui-icon-refresh-1"></span>恢复
        </button>
    </div>
</div>
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
            elem: '#proTable'
            , url: '${ctx}/project/DelProList?uid='+2
            , toolbar: '#proToolBar' //开启头部工具栏，并为其绑定左侧模板
            , title: '已删除项目数据表'
            , height: 'full-75'
            , cellMinWidth: 100
            , page: true
            , cols: [[
                {field:'projectid', title:'项目ID',align:'center',width:'200'}
                ,{field: 'proname', title: '项目名称', align: 'center', width: '406'}
                , {
                    field: 'isTemplate', title: '是否模板', align: 'center', width: '406', templet: function (d) {
                        return d.isTemplate == '0' ? '<font color=red><b>模板文档</b></font>' : '<font color=blue>普通文档</font>';
                    }
                }
                , {fixed: 'right', title: '操作', toolbar: '#proRowBar', align: 'center', width: '300'}
            ]]
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

        //监听行工具条的事件
        table.on("tool(proTable)", function (obj) {
            var data = obj.data; //获得当前行数据
            switch (obj.event) {
                case 'restore':
                    restore(data);
                    break;
            }
            ;
        });
        function restore(data) {
            layer.confirm('你确定要恢复【 ' + data.proname + ' 】项目吗?', {icon: 3, title: '提示'}, function (index) {
                $.post("${ctx}/project/restoreProByProId", {projectid: data.projectid}, function (res) {
                    tableIns.reload();
                    layer.msg(res.msg);
                })
                layer.close(index);
            });
        }
    });
</script>
</body>
</html>

