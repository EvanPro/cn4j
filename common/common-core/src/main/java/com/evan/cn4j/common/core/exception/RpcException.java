package com.evan.cn4j.common.core.exception;

/**
 * 服务间调用异常
 */
public class RpcException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    private Integer code;

    private String message;

    public RpcException(String message) {
        this.message = message;
    }

    public RpcException(String message, Integer code) {
        this.message = message;
        this.code = code;
    }

    public RpcException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public Integer getCode() {
        return code;
    }
}
