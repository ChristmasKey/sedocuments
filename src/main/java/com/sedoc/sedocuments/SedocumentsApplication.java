package com.sedoc.sedocuments;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@ServletComponentScan
public class SedocumentsApplication {

    public static void main(String[] args) {
        SpringApplication.run(SedocumentsApplication.class, args);
    }

    @Value("${posyspath}")
    String poSysPath;

    @Bean
    public ServletRegistrationBean servletRegistrationBean(){
        com.zhuozhengsoft.pageoffice.poserver.Server poserver=new com.zhuozhengsoft.pageoffice.poserver.Server();
        //设置PageOffice注册成功后，license.lic文件存放的目录
        poserver.setSysPath(poSysPath);
        ServletRegistrationBean srb=new ServletRegistrationBean(poserver);
        srb.addUrlMappings("/poserver.zz");
        srb.addUrlMappings("/posetup.exe");
        srb.addUrlMappings("/pageoffice.js");
        srb.addUrlMappings("/jquery.min.js");
        srb.addUrlMappings("/pobstyle.css");
        srb.addUrlMappings("/sealsetup.exe");
        return srb;
    }
}
