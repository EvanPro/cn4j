package com.evan.cn4j.common.core.utils;

public class VersionUtils {

    /**
     * 生成版本号
     *
     * @param prefix
     * @param content
     * @param suffix
     * @return
     */
    public static String produceVersion(String prefix, String content, String suffix) {
        return new StringBuilder().append(prefix).append(content).append(suffix).toString();
    }
}
