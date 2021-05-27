package com.evan.cn4j.system.api;

import com.evan.cn4j.common.core.domain.R;
import com.evan.cn4j.system.beans.model.LoginUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * 用户服务
 */
@FeignClient(contextId = "remoteSysUserService", value = "system", url = "${local.feign.server.system.url:}")
public interface RemoteSysUserService {

    /**
     * 通过用户名查询用户信息
     *
     * @param username 用户名
     * @return 结果
     */
    @GetMapping(value = "/user/info/{username}")
    R<LoginUser> getUserInfo(@PathVariable("username") String username);
}
