package com.evan.cn4j.system.api;

import com.evan.cn4j.common.core.domain.R;
import com.evan.cn4j.system.beans.domain.SysMessage;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * 站内信服务
 */
@FeignClient(contextId = "remoteSysMessageService", value = "system", url = "${local.feign.server.system.url:}")
public interface RemoteSysMessageService {

    /**
     * 向某些用户发布消息
     *
     * @param userIds
     * @param sysMessage
     * @return
     */
    @PostMapping("/message/publish/user/{userIds}")
    R<SysMessage> publishUser(@PathVariable("userIds") Long[] userIds, SysMessage sysMessage);

    /**
     * 向某个机构下所有用户发布消息
     *
     * @param deptId
     * @param sysMessage
     */
    @PostMapping("/message/publish/dept/{deptId}")
    R<SysMessage> publishDept(@PathVariable("deptId") Long deptId, @RequestBody SysMessage sysMessage);

    /**
     * 向某管理员发布消息
     *
     * @param sysMessage
     */
    @PostMapping("/message/publish/admin")
    R<SysMessage> publishToAdmin(@RequestBody SysMessage sysMessage);
}
