package com.sedoc.sedocuments.constast;

/**
 * 常量接口
 *
 * 丁佳男
 */
public interface SysConstast {

    String USER_LOGIN_ERROR_MSG="用户名或密码不正确";

    /**
     * 可用状态
     */
    Integer AVAILABLE_TRUE=1;
    Integer AVAILABLE_FALSE=0;

    /**
     * 用户类型
     */
    Integer USER_TYPE_NORMAL=1;
    Integer USER_TYPE_SUPER=2;
    Integer USER_TYPE_USERMANAGER=3;
    Integer USER_TYPE_TEMPLATEMANAGER=4;

    /**
     * 是否展开
     */
    Integer SPREAD_TRUE=0;
    Integer SPREAD_FALSE=1;

    /**
     * 操作状态
     */
    String ADD_SUCCESS="添加成功";
    String ADD_ERROR="添加失败";

    String RESTORE_SUCCESS="还原成功";
    String RESTORE_ERROR="还原失败";

    String UPDATE_SUCCESS="更新成功";
    String UPDATE_ERROR="更新失败";

    String DELETE_SUCCESS="删除成功";
    String DELETE_ERROR="删除失败";

    String RESET_SUCCESS="重置成功";
    String RESET_ERROR="重置失败";

    String DISPATCH_SUCCESS="分配成功";
    String DISPATCH_ERROR="分配失败";

    String ISEXISTPPHONE="该账户(电话)已存在,请重新填写!";

    String REGISTER_SUCCESS="注册成功";
    String REGISTER_ERROR="注册失败";
    String DUPLICATE_INFO="重复的手机号码、电子邮箱或学号";

    Integer CODE_SUCCESS=0; //操作成功
    Integer CODE_ERROR=-1;//失败

    /**
     * 公用常量
     */
    Integer CODE_ZERO = 0;
    Integer CODE_ONE = 1;
    Integer CODE_TWO = 2;
    Integer CODE_THREE = 3;

    /**
     * 默认密码配置
     */
    String USER_DEFAULT_PWD="123456";
}
