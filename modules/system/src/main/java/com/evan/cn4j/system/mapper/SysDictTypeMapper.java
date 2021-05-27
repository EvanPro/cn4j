package com.evan.cn4j.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.evan.cn4j.system.domain.SysDictType;

/**
 * 字典表 数据层
 */
public interface SysDictTypeMapper extends BaseMapper<SysDictType> {
    /**
     * 修改字典类型信息
     *
     * @param dictType 字典类型信息
     * @return 结果
     */
    int updateDictType(SysDictType dictType);
}
