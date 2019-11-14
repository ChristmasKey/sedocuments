package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.model.Document;
import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.DocumentService;
import com.sedoc.sedocuments.service.ProjectService;
import com.sedoc.sedocuments.utils.*;
import com.sedoc.sedocuments.vo.DocumentVo;
import com.sedoc.sedocuments.vo.ProjectVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

    /**
     *  加载项目树
     */
    @RequestMapping("loadProjectManagerTreeJson")
    public DataGridView loadProjectManagerTreeJson(ProjectVo projectVo){
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);//设置查询条件：未删除
        User user=(User)WebUtils.getHttpSession().getAttribute("user");
        projectVo.setUid(user.getUid());
//        projectVo.setIsTemplate(SysConstast.CODE_ZERO);//设置查询条件：是模板
//        projectVo.setIsOfficial(SysConstast.CODE_ZERO);//设置查询条件：属官方
        List<Project> projects=projectService.queryAllProjectForList(projectVo);
        List<ProjectNode> proNodes=new ArrayList<>();
        for(Project project:projects){
            Integer id=project.getProjectid();
            String title=project.getProname();
            String createtime=new SimpleDateFormat("yyyy-MM-dd").format(project.getCreatetime());
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

    /**
     *  添加项目
     */
    @RequestMapping("addProject")
    public ResultObj addProject(ProjectVo projectVo){
        projectVo.setCreatetime(new Date());
        projectVo.setDocnumber(1);
        User user=(User)WebUtils.getHttpSession().getAttribute("user");
        projectVo.setUid(user.getUid());
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        try{
            projectService.addProject(projectVo);
            //添加样本文档（子节点）
            DocumentVo documentVo=new DocumentVo();
            documentVo.setProjectid(projectVo.getProjectid());
            documentVo.setDoctitle("可行性研究报告");
            documentVo.setDoctype(0);
            documentVo.setIsDel(SysConstast.AVAILABLE_TRUE);
            documentService.addDocument(documentVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     *  修改项目信息
     */
    @RequestMapping("updateProject")
    public ResultObj updateProject(ProjectVo projectVo){
        try{
            projectService.updateProject(projectVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     *  删除项目
     */
    @RequestMapping("deleteProject")
    public ResultObj deleteProject(ProjectVo projectVo){
        try{
            projectService.deleteProject(projectVo);
            documentService.deleteDocumentByProjectId(projectVo);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 根据projectid判断当前项目中有没有文档
     * 有 返回code>=0
     * 没有 返回code<0
     */
    @RequestMapping("checkDocnumber")
    public ResultObj checkDocnumber(ProjectVo projectVo){
        Integer count=documentService.queryDocnumberByProjectId(projectVo.getProjectid());
        if (count>1){
            return ResultObj.STATUS_TRUE;
        }else{
            return ResultObj.STATUS_FALSE;
        }
    }

    /**
     * 删除文档
     */
    @RequestMapping("deleteDocument")
    public ResultObj deleteDocument(DocumentVo documentVo){
        try{
            documentVo.setIsDel(SysConstast.AVAILABLE_FALSE);
            documentService.updateDocument(documentVo);
            projectService.updateDocnumberMinus(documentVo.getProjectid());
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 文档重命名
     */
    @RequestMapping("renameDocument")
    public ResultObj renameDocument(DocumentVo documentVo){
        try {
            documentService.updateDocument(documentVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     * 根据projectid添加文档
     */
    @RequestMapping("addDocumentByProjectId")
    public ResultObj addDocumentByProjectId(DocumentVo documentVo){
        try{
            //项目docnumber+1
            projectService.updateDocnumber(documentVo.getProjectid());
            //文档的doctype为查最大+1
//            Integer doctype=documentService.queryMaxDoctype(documentVo.getProjectid());
            documentVo.setDoctype(0);
            documentVo.setIsDel(SysConstast.AVAILABLE_TRUE);
            //插入数据表
            documentService.addDocument(documentVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     * 创建项目
     */
    @RequestMapping("createProject")
    public ResultObj createProject(ProjectVo projectVo){
        projectVo.setCreatetime(new Date());
        projectVo.setDocnumber(0);
        projectVo.setIsTemplate(1);
        projectVo.setIsOfficial(1);
        User user=(User)WebUtils.getHttpSession().getAttribute("user");
        projectVo.setUid(user.getUid());
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        try{
            projectService.addProject(projectVo);
            WebUtils.getHttpSession().setAttribute("createprojectid",projectVo.getProjectid());
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     * 根据前端传过来的projectid查询文档，
     * 并结合createprojectid对取到的数据进行编辑
     * 重新插入表中
     */
    @RequestMapping("addDocumentByDocument")
    public ResultObj addDocumentByDocument(Integer projectid){
        Integer createprojectid=(Integer)WebUtils.getHttpSession().getAttribute("createprojectid");
        try {
            if(projectid==0){
                DocumentVo documentVo=new DocumentVo();
                documentVo.setDoctitle("可行性研究报告");
                documentVo.setDoctype(0);
                documentVo.setProjectid(createprojectid);
                documentVo.setIsDel(SysConstast.AVAILABLE_TRUE);
                documentService.addDocument(documentVo);
                projectService.updateDocnumber(createprojectid);
            }else {
                DocumentVo documentVo=new DocumentVo();
                documentVo.setProjectid(projectid);
                documentVo.setIsDel(SysConstast.AVAILABLE_TRUE);
                List<Document> documents=documentService.queryAllDocumentForList(documentVo);
                for(Document document:documents){
                    DocumentVo docVo=new DocumentVo();
                    docVo.setDoctitle(document.getDoctitle());
                    docVo.setDoctype(document.getDocid());
                    docVo.setProjectid(createprojectid);
                    docVo.setIsDel(SysConstast.AVAILABLE_TRUE);
                    documentService.addDocument(docVo);
                    projectService.updateDocnumber(createprojectid);
                }
            }
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    @RequestMapping("loadNewProjectTreeJson")
    public DataGridView loadNewProjectTreeJson(ProjectVo projectVo){
        projectVo.setProjectid((Integer)WebUtils.getHttpSession().getAttribute("createprojectid"));
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        List<Project> projects=projectService.queryAllProjectForList(projectVo);
        List<ProjectNode> proNodes=new ArrayList<>();
        for(Project project:projects){
            Integer id=project.getProjectid();
            String title=project.getProname();
            String createtime=new SimpleDateFormat("yyyy-MM-dd").format(project.getCreatetime());
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

    /**
     * 首页的模糊查询
     */
    @RequestMapping("queryTemplates")
    public DataGridView queryTemplates(ProjectVo projectVo){
        projectVo.setIsTemplate(SysConstast.CODE_ZERO);
        projectVo.setIsOfficial(SysConstast.CODE_ZERO);
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        return projectService.queryTempProjects(projectVo);
    }

    /**
     * 首页的预览树
     */
    @RequestMapping("loadTemplateProjectTreeJson")
    public DataGridView loadTemplateProjectTreeJson(ProjectVo projectVo){
        List<Project> projects=projectService.queryAllProjectForList(projectVo);
        List<ProjectNode> proNodes=new ArrayList<>();
        for (Project project:projects){
            Integer id=project.getProjectid();
            String title=project.getProname();
            String createtime=new SimpleDateFormat("yyyy-MM-dd").format(project.getCreatetime());
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
