package com.evan.cn4j.common.core.constant;

public class Constants {
    /**
     * 成功标记
     */
    public static final Integer SUCCESS = 200;

    /**
     * http请求
     */
    public static final String HTTP = "http://";

    /**
     * https请求
     */
    public static final String HTTPS = "https://";

    /**
     * 失败标记
     */
    public static final Integer FAIL = 500;

    /**
     * 登录成功
     */
    public static final String LOGIN_SUCCESS = "Success";

    /**
     * 注销
     */
    public static final String LOGOUT = "Logout";

    /**
     * 注册
     */
    public static final String REGISTER = "Register";

    /**
     * 登录失败
     */
    public static final String LOGIN_FAIL = "Error";

    /**
     * 令牌有效期（分钟）
     */
    public final static long TOKEN_EXPIRE = 720;

    /**
     * 字典管理 cache key
     */
    public static final String SYS_DICT_KEY = "sys_dict:";

    /**
     * 站内信状态 未读
     */
    public static final String SYS_MESSAGE_STATUS_UNREAD = "0";

    /**
     * 站内信状态 已读
     */
    public static final String SYS_MESSAGE_STATUS_READ = "1";

    /**
     * 逻辑删除 未删除
     */
    public static final String NOT_DELETED_FLAG = "0";

    /**
     * 逻辑删除 已删除
     */
    public static final String DELETED_FLAG = "2";
    /**
     * 校验成功
     */
    public static final String VLID_SUCCESS = "1";
    /**
     * 校验失败
     */
    public static final String VLID_ERROR = "0";

    /**
     * feign接口调用的超时时间(20s)
     * connectTimeout, readTimeout设定用一个值
     */
    public static final int FEIGN_CLIENT_TIMEOUT = 1000 * 20;
}
