package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.model.Document;
import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.service.DocumentService;
import com.sedoc.sedocuments.service.ProjectService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.utils.DocNode;
import com.sedoc.sedocuments.utils.ProjectNode;
import com.sedoc.sedocuments.vo.DocumentVo;
import com.sedoc.sedocuments.vo.ProjectVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * 项目管理控制器
 * 包括：用户的项目管理、系统的模板管理
 *
 * 丁佳男
 */
@RestController
@RequestMapping("project")
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private DocumentService documentService;

    @RequestMapping("loadProjectManagerTreeJson")
    public DataGridView loadProjectManagerTreeJson(ProjectVo projectVo){
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);//设置查询条件：未删除
        projectVo.setIsTemplate(SysConstast.CODE_ZERO);//设置查询条件：是模板
        projectVo.setIsOfficial(SysConstast.CODE_ZERO);//设置查询条件：属官方
        List<Project> projects=projectService.queryAllProjectForList(projectVo);
        List<ProjectNode> proNodes=new ArrayList<>();
        for(Project project:projects){
            Integer id=project.getProjectid();
            String title=project.getProname();
            String createtime=project.getCreatetime().toString();
            String remark=project.getRemark();
            Integer docnumber=project.getDocnumber();
            Integer isTemplate=project.getIsTemplate();
            Integer isOfficial=project.getIsOfficial();
            Integer uid=project.getUid();
            ProjectNode proNode=new ProjectNode(id,title,createtime,remark,docnumber,isTemplate,isOfficial,uid);
            //根据id查询document,并把结果放到叶子（文档）节点中
            DocumentVo documentVo = new DocumentVo();
            documentVo.setIsDel(SysConstast.AVAILABLE_TRUE);//设置查询条件：未删除
            documentVo.setProjectid(id);//设置查询条件：父节点
            List<Document> documents=documentService.queryAllDocumentForList(documentVo);
            for (Document document:documents){
                String docid="doc"+document.getDocid();
                String doctitle=document.getDoctitle();
                Integer doctype=document.getDoctype();
                proNode.getChildren().add(new DocNode(docid,id,doctitle,doctype));
            }
            proNodes.add(proNode);
        }
        return new DataGridView(proNodes);
    }
}
