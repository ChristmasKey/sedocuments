package com.sedoc.sedocuments.controller;

import com.zhuozhengsoft.pageoffice.FileSaver;
import com.zhuozhengsoft.pageoffice.OfficeVendorType;
import com.zhuozhengsoft.pageoffice.OpenModeType;
import com.zhuozhengsoft.pageoffice.PageOfficeCtrl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Map;

/**
 * 文档管理控制器
 *
 * 丁佳男
 */
@Controller
@RequestMapping("document")
public class DocumentController {

    @RequestMapping("openDoc")
    public String openDoc(HttpServletRequest request,Integer docid, Map<String,Object> map){
        //创建核心对象
        PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
        //自动启动客户机上最先安装的Office软件
//        poCtrl.setOfficeVendor(OfficeVendorType.WPSOffice);
        //设置服务器页面
        poCtrl.setServerPage("/SEDocument/poserver.zz");
        //隐藏自定义工具栏
        poCtrl.setCustomToolbar(false);
        //设置保存页面
        poCtrl.setSaveFilePage("/SEDocument/document/saveFile?docid="+docid);
        File file=new File(request.getSession().getServletContext().getRealPath("docLib/")+"\\document"+docid+".docx");
        if (!file.exists()){
            //打开样板文档
            poCtrl.webOpen(request.getContextPath()+"/docLib/test.docx", OpenModeType.docNormalEdit,"雨木林风");
        }else{
            //打开正式文档
            poCtrl.webOpen(request.getContextPath()+"/docLib/document"+docid+".docx",OpenModeType.docNormalEdit,"雨木林风");
        }
        map.put("pageoffice",poCtrl.getHtmlCode("pageofficeCtrl1"));
        return "word";
    }

    @RequestMapping("saveFile")
    public void saveFile(HttpServletRequest request, HttpServletResponse response,Integer docid){
        FileSaver fs=new FileSaver(request,response);
        fs.saveToFile(request.getSession().getServletContext().getRealPath("docLib/")+"\\document"+docid+".docx");
        fs.close();
    }

}
