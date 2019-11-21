package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.service.MajorService;
import com.sedoc.sedocuments.service.SchoolService;
import com.sedoc.sedocuments.service.UserService;
import com.sedoc.sedocuments.utils.ResultObj;
import com.sedoc.sedocuments.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 注册控制器
 *
 * 丁佳男
 */
@RestController
@RequestMapping("register")
public class RegisterController {

    @Autowired
    private UserService userService;
    @Autowired
    private SchoolService schoolService;
    @Autowired
    private MajorService majorService;

    @RequestMapping("registerAccount")
    public ResultObj registerAccount(UserVo userVo){
        try {
            userVo.setIsDel(SysConstast.AVAILABLE_TRUE);
            userVo.setRoleid(SysConstast.USER_TYPE_NORMAL);
            //查学校名称
            Integer schoolid = Integer.parseInt(userVo.getSchool());
            userVo.setSchool(schoolService.querySchoolNameBySchoolId(schoolid));
            //查专业名称
            Integer majorid = Integer.parseInt(userVo.getMajor());
            userVo.setMajor(majorService.queryMajorNameByMajorId(majorid));
            //查重
            if (userService.checkDuplicate(userVo)>0){
                return ResultObj.DUPLICATE_INFO;
            }else{
                userService.register(userVo);
                return ResultObj.REGISTER_SUCCESS;
            }
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.REGISTER_ERROR;
        }
    }
}
