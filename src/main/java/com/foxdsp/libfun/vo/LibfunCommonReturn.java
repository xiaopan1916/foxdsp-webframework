package com.foxdsp.libfun.vo;

/**
 * Created by briceli on 15/9/9.
 * 定义了一些基本的请求返回
 */
public class LibfunCommonReturn<T> {
    public static final int CODE_OK = 0;
    public static final int CODE_ERROR = 1;

    private int code;
    private T data;
    private String message;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static LibfunCommonReturn genOkReturn(){
        LibfunCommonReturn rtn = new LibfunCommonReturn();
        rtn.setCode(LibfunCommonReturn.CODE_OK);
        rtn.setMessage("操作成功");
        return rtn;
    }

    public static LibfunCommonReturn genErrorReturn(String message){
        LibfunCommonReturn rtn = new LibfunCommonReturn();
        rtn.setCode(LibfunCommonReturn.CODE_ERROR);
        rtn.setMessage(message);
        return rtn;
    }
}
