package com.evan.cn4j.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.evan.cn4j.common.core.constant.Constants;
import com.evan.cn4j.common.core.constant.UserConstants;
import com.evan.cn4j.system.beans.domain.SysMessage;
import com.evan.cn4j.system.beans.domain.SysMessageReceiver;
import com.evan.cn4j.system.beans.domain.SysUser;
import com.evan.cn4j.system.mapper.SysMessageMapper;
import com.evan.cn4j.system.service.ISysMessageReceiverService;
import com.evan.cn4j.system.service.ISysMessageService;
import com.evan.cn4j.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SysMessageServiceImpl extends ServiceImpl<SysMessageMapper, SysMessage> implements ISysMessageService {
    @Autowired
    private SysMessageMapper sysMessageMapper;
    @Autowired
    private ISysMessageReceiverService sysMessageReceiverService;
    @Autowired
    private ISysUserService sysUserService;

    /**
     * 分页查询
     *
     * @param page
     * @param senderId
     * @return
     */
    @Override
    public IPage<SysMessage> selectSysMessageByPage(IPage<SysMessage> page, Long senderId) {
        return sysMessageMapper.selectSysMessageByPage(page, senderId);
    }

    /**
     * 获取某个用户的未读通知
     *
     * @param receiverId
     * @return
     */
    @Override
    public List<SysMessage> unread(Long receiverId) {
        return sysMessageMapper.selectSysMessageByReceiverId(receiverId, Constants.SYS_MESSAGE_STATUS_UNREAD);
    }

    /**
     * 向某些用户发布消息
     *
     * @param userIds
     * @param sysMessage
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void publishUser(Long[] userIds, SysMessage sysMessage) {
        Long senderId = sysMessage.getSenderId();
        SysUser sender = sysUserService.getById(senderId);
        String senderUserName = sender.getUserName();
        sysMessage.setCreateBy(senderUserName);
        sysMessageMapper.insert(sysMessage);
        List<SysMessageReceiver> receivers = Lists.newArrayListWithCapacity(userIds.length);
        for (Long userId : userIds) {
            SysMessageReceiver sysMessageReceiver = new SysMessageReceiver();
            sysMessageReceiver.setMsgId(sysMessage.getMsgId());
            sysMessageReceiver.setReceiverId(userId);
            sysMessageReceiver.setCreateBy(senderUserName);
            receivers.add(sysMessageReceiver);
        }
        sysMessageReceiverService.saveBatch(receivers);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void publishToAdmin(SysMessage sysMessage) {
        sysMessage.setCreateBy(UserConstants.SYSTEM);
        sysMessageMapper.insert(sysMessage);

        List<SysUser> adminUserList = sysUserService.getAdminList();
        List<SysMessageReceiver> receivers = Lists.newArrayListWithCapacity(adminUserList.size());
        for (SysUser admin : adminUserList) {
            SysMessageReceiver sysMessageReceiver = new SysMessageReceiver();
            sysMessageReceiver.setMsgId(sysMessage.getMsgId());
            sysMessageReceiver.setReceiverId(admin.getUserId());
            sysMessageReceiver.setCreateBy(UserConstants.SYSTEM);
            receivers.add(sysMessageReceiver);
        }
        sysMessageReceiverService.saveBatch(receivers);
    }

    /**
     * 向某个机构下所有用户发布消息
     *
     * @param deptId
     * @param sysMessage
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void publishDept(Long deptId, SysMessage sysMessage) {
        Long senderId = sysMessage.getSenderId();
        SysUser sender = sysUserService.getById(senderId);
        String senderUserName = sender.getUserName();
        sysMessage.setCreateBy(senderUserName);
        sysMessageMapper.insert(sysMessage);
        List<SysUser> users = sysUserService.getUserByDeptId(deptId);
        List<SysMessageReceiver> receivers = Lists.newArrayListWithCapacity(users.size());
        for (SysUser user : users) {
            SysMessageReceiver sysMessageReceiver = new SysMessageReceiver();
            sysMessageReceiver.setMsgId(sysMessage.getMsgId());
            sysMessageReceiver.setReceiverId(user.getUserId());
            sysMessageReceiver.setCreateBy(senderUserName);
            receivers.add(sysMessageReceiver);
        }
        sysMessageReceiverService.saveBatch(receivers);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteMessages(List<Long> msgIds) {
        LambdaQueryWrapper<SysMessageReceiver> queryWrapper = Wrappers.lambdaQuery(SysMessageReceiver.class)
                .in(SysMessageReceiver::getMsgId, msgIds);
        sysMessageReceiverService.remove(queryWrapper);

        sysMessageMapper.deleteBatchIds(msgIds);
    }
}
