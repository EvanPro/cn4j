package com.evan.cn4j.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.evan.cn4j.common.core.constant.Constants;
import com.evan.cn4j.common.core.utils.DateUtils;
import com.evan.cn4j.system.beans.domain.SysMessageReceiver;
import com.evan.cn4j.system.mapper.SysMessageReceiverMapper;
import com.evan.cn4j.system.service.ISysMessageReceiverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SysMessageReceiverServiceImpl extends ServiceImpl<SysMessageReceiverMapper, SysMessageReceiver> implements ISysMessageReceiverService {
    @Autowired
    private SysMessageReceiverMapper sysMessageReceiverMapper;

    /**
     * 更改消息状态
     *
     * @param sysMessageReceiver
     * @return
     */
    @Override
    public int changeMessageStatus(SysMessageReceiver sysMessageReceiver) {
        // 要标记为已读
        if (Constants.SYS_MESSAGE_STATUS_READ.equals(sysMessageReceiver.getStatus())) {
            sysMessageReceiver.setReadTime(DateUtils.getNowDate());
        } else {
            sysMessageReceiver.setReadTime(null);
        }
        return sysMessageReceiverMapper.updateMessageStatus(sysMessageReceiver);
    }
}
