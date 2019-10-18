package com.sedoc.sedocuments.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 丁佳男
 */
@Controller
@RequestMapping("desk")
public class DeskController {
    /**
     * 跳转到平台的首页面
     */
    @RequestMapping("toDeskManager")
    public String toDeskManager(){
        return "deskManager";
    }
}
