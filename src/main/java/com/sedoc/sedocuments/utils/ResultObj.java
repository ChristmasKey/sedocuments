package com.sedoc.sedocuments.utils;

import com.sedoc.sedocuments.constast.SysConstast;

/**
 * 对页面操作结果的状态进行描述的常量类
 */
public class ResultObj {
    private Integer code=0;
    private String msg;

    /**
     * 添加成功
     */
    public static final ResultObj ADD_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.ADD_SUCCESS);
    /**
     * 添加失败
     */
    public static final ResultObj ADD_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.ADD_ERROR);
    /**
     * 更新成功
     */
    public static final ResultObj UPDATE_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.UPDATE_SUCCESS);
    /**
     * 更新失败
     */
    public static final ResultObj UPDATE_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.UPDATE_ERROR);
    /**
     * 删除成功
     */
    public static final ResultObj DELETE_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.DELETE_SUCCESS);
    /**
     * 删除失败
     */
    public static final ResultObj DELETE_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.DELETE_ERROR);

    /**
     * 重置成功
     */
    public static final ResultObj RESET_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.RESET_SUCCESS);
    /**
     * 重置失败
     */
    public static final ResultObj RESET_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.RESET_ERROR);
    /**
     * 分配成功
     */
    public static final ResultObj DISPATCH_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS, SysConstast.DISPATCH_SUCCESS);
    /**
     * 分配失败
     */
    public static final ResultObj DISPATCH_ERROR=new ResultObj(SysConstast.CODE_ERROR, SysConstast.DISPATCH_ERROR);

    /**
     * 还原成功
     */
    public static final  ResultObj RESTORE_SUCCESS=new ResultObj(SysConstast.CODE_SUCCESS,SysConstast.RESTORE_SUCCESS);
    /**
     * 还原失败
     */
    public static final  ResultObj RESTORE_ERROR=new ResultObj(SysConstast.CODE_ERROR,SysConstast.RESTORE_ERROR);
    /**
     * 状态码0
     */
    public static final ResultObj STATUS_TRUE=new ResultObj(SysConstast.CODE_SUCCESS);

    /**
     * 状态码-1
     */
    public static final ResultObj STATUS_FALSE=new ResultObj(SysConstast.CODE_ERROR);
    /**
     * 判断账号重复
     */
    public static final ResultObj ISEXISTPPHONE=new ResultObj(SysConstast.CODE_SUCCESS,SysConstast.ISEXISTPPHONE);

    private ResultObj(Integer code,String msg){
        super();
        this.code=code;
        this.msg=msg;
    }

    private ResultObj(Integer code){
        super();
        this.code=code;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
