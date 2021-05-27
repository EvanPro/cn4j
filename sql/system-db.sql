create schema cn4j default character set utf8mb4 collate utf8mb4_unicode_ci;

-- ----------------------------
-- 用户信息表
-- ----------------------------
drop table if exists sys_user;
create table sys_user
(
    user_id     bigint(20)  not null auto_increment comment '用户ID',
    dept_id     bigint(20)   default null comment '组织机构ID',
    user_name   varchar(30) not null comment '用户账号',
    nick_name   varchar(30) not null comment '用户昵称',
    user_type   varchar(2)   default '00' comment '用户类型（00系统用户）',
    email       varchar(50)  default '' comment '用户邮箱',
    avatar      varchar(100) default '' comment '头像地址',
    password    varchar(100) default '' comment '密码',
    status      char(1)      default '0' comment '帐号状态（0正常 1停用）',
    del_flag    char(1)      default '0' comment '删除标志（0代表存在 2代表删除）',
    login_date  datetime comment '最后登录时间',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(500) default null comment '备注',
    primary key (user_id)
) engine = innodb comment = '用户信息表';

insert into sys_user
values (1, 1, 'admin', '管理员', '00', 'admin@evan.com', '',
        '$2a$10$iWHBPjpueXFaiTBNLLJMgucGlyd8rjwJFlYCCMmz11TvNUqavb2zK', '0', '0', '2020-10-13 11-33-00',
        'admin', '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '管理员');

-- ----------------------------
-- 角色信息表
-- ----------------------------
drop table if exists sys_role;
create table sys_role
(
    role_id     bigint(20)   not null auto_increment comment '角色ID',
    role_name   varchar(30)  not null comment '角色名称',
    role_key    varchar(100) not null comment '角色权限字符串',
    role_sort   int(4)       not null comment '显示顺序',
    status      char(1)      not null comment '角色状态（0正常 1停用）',
    del_flag    char(1)      default '0' comment '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(500) default null comment '备注',
    primary key (role_id)
) engine = innodb comment = '角色信息表';

insert into sys_role
values ('1', '管理员', 'admin', 1, '0', '0', 'admin', '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '管理员');

-- ----------------------------
-- 用户和角色关联表  用户N-1角色
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role
(
    user_id bigint(20) not null comment '用户ID',
    role_id bigint(20) not null comment '角色ID',
    primary key (user_id, role_id)
) engine = innodb comment = '用户和角色关联表';

insert into sys_user_role
values (1, 1);

-- ----------------------------
-- 组织机构表
-- ----------------------------
drop table if exists sys_dept;
create table sys_dept
(
    dept_id     bigint(20) not null auto_increment comment '组织机构id',
    parent_id   bigint(20)  default 0 comment '父组织机构id',
    ancestors   varchar(50) default '' comment '祖级列表',
    dept_name   varchar(30) default '' comment '组织机构名称',
    order_num   int(4)      default 0 comment '显示顺序',
    status      char(1)     default '0' comment '组织机构状态（0正常 1停用）',
    del_flag    char(1)     default '0' comment '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64) default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64) default '' comment '更新者',
    update_time datetime comment '更新时间',
    primary key (dept_id)
) engine = innodb comment = '组织机构表';

insert into sys_dept
values (1, 0, '0', '根节点', 0, '0', '0', 'admin', '2020-10-13 11-33-00', 'admin',
        '2020-10-13 11-33-00');

-- ----------------------------
-- 菜单权限表
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu
(
    menu_id     bigint(20)  not null auto_increment comment '菜单ID',
    menu_name   varchar(50) not null comment '菜单名称',
    parent_id   bigint(20)   default 0 comment '父菜单ID',
    order_num   int(4)       default 0 comment '显示顺序',
    path        varchar(200) default '' comment '路由地址',
    component   varchar(255) default null comment '组件路径',
    is_frame    int(1)       default 1 comment '是否为外链（0是 1否）',
    is_cache    int(1)       default 0 comment '是否缓存（0缓存 1不缓存）',
    menu_type   char(1)      default '' comment '菜单类型（M目录 C菜单 F按钮）',
    visible     char(1)      default 0 comment '菜单状态（0显示 1隐藏）',
    status      char(1)      default 0 comment '菜单状态（0正常 1停用）',
    perms       varchar(100) default null comment '权限标识',
    icon        varchar(100) default '#' comment '菜单图标',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(500) default '' comment '备注',
    primary key (menu_id)
) engine = innodb comment = '菜单权限表';

-- 一级菜单
insert into sys_menu
values ('1', '系统管理', '0', '1', 'system', null, 1, 0, 'M', '0', '0', '', 'flaticon2-gear', 'admin',
        '2020-10-13 11-33-00', 'admin',
        '2020-10-13 11-33-00', '系统管理目录');

-- 二级菜单
insert into sys_menu
values ('100', '用户管理', '1', '1', 'user', 'system/user/index', 1, 0, 'C', '0', '0', 'system:user:list', '', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '用户管理菜单');
insert into sys_menu
values ('101', '角色管理', '1', '2', 'role', 'system/role/index', 1, 0, 'C', '1', '0', 'system:role:list', '',
        'admin', '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '角色管理菜单');
insert into sys_menu
values ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', 1, 0, 'C', '0', '0', 'system:menu:list', '',
        'admin', '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '菜单管理菜单');
insert into sys_menu
values ('103', '组织机构管理', '1', '4', 'dept', 'system/dept/index', 1, 0, 'C', '0', '0', 'system:dept:list', '',
        'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '组织机构管理菜单');
insert into sys_menu
values ('104', '字典管理', '1', '5', 'dict', 'system/dict/index', 1, 0, 'C', '0', '0', 'system:dict:list', '', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '字典管理菜单');
insert into sys_menu
values ('105', '字典数据', '1', '6', 'dict/type/data/:dictId(\\d+)', 'system/dict/data', 1, 0, 'C', '1', '0',
        'system:dict:list', '', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '数据字典数据详情');
insert into sys_menu
values ('106', '站内信', '1', '7', 'message', 'system/message/index', 1, 0, 'C', '1', '0', 'system:message:list', '',
        'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '站内信菜单');

-- 三级菜单
-- 用户管理按钮
insert into sys_menu
values ('1001', '用户查询', '100', '1', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1002', '用户新增', '100', '2', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2020-10-13 11-33-00',
        'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1003', '用户修改', '100', '3', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1004', '用户删除', '100', '4', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1005', '用户导出', '100', '5', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1006', '用户导入', '100', '6', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1007', '重置密码', '100', '7', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
-- 角色管理按钮
insert into sys_menu
values ('1011', '角色查询', '101', '1', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1012', '角色新增', '101', '2', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2020-10-13 11-33-00',
        'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1013', '角色修改', '101', '3', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1014', '角色删除', '101', '4', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
-- 菜单管理按钮
insert into sys_menu
values ('1021', '菜单查询', '102', '1', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1022', '菜单新增', '102', '2', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2020-10-13 11-33-00',
        'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1023', '菜单修改', '102', '3', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1024', '菜单删除', '102', '4', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
-- 部门管理按钮
insert into sys_menu
values ('1031', '部门查询', '103', '1', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1032', '部门新增', '103', '2', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2020-10-13 11-33-00',
        'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1033', '部门修改', '103', '3', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1034', '部门删除', '103', '4', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
-- 字典管理按钮
insert into sys_menu
values ('1041', '字典查询', '104', '1', '#', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1042', '字典新增', '104', '2', '#', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1043', '字典修改', '104', '3', '#', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1044', '字典删除', '104', '4', '#', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
-- 站内信按钮
insert into sys_menu
values ('1061', '站内信查询', '106', '1', '#', '', 1, 0, 'F', '0', '0', 'system:message:query', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1062', '站内信新增', '106', '2', '#', '', 1, 0, 'F', '0', '0', 'system:message:add', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1063', '站内信状态修改', '106', '3', '#', '', 1, 0, 'F', '0', '0', 'system:message:edit', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');
insert into sys_menu
values ('1064', '站内信删除', '106', '4', '#', '', 1, 0, 'F', '0', '0', 'system:message:remove', '#', 'admin',
        '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '');

-- ----------------------------
-- 角色和菜单关联表  角色1-N菜单
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu
(
    role_id bigint(20) not null comment '角色ID',
    menu_id bigint(20) not null comment '菜单ID',
    primary key (role_id, menu_id)
) engine = innodb comment = '角色和菜单关联表';

-- ----------------------------
-- 管理员 --
-- 系统管理
insert into sys_role_menu
values (1, 1);
insert into sys_role_menu
values (1, 100);
insert into sys_role_menu
values (1, 101);
insert into sys_role_menu
values (1, 102);
insert into sys_role_menu
values (1, 103);
insert into sys_role_menu
values (1, 104);
insert into sys_role_menu
values (1, 105);
insert into sys_role_menu
values (1, 106);

insert into sys_role_menu
values (1, 1001);
insert into sys_role_menu
values (1, 1002);
insert into sys_role_menu
values (1, 1003);
insert into sys_role_menu
values (1, 1004);
insert into sys_role_menu
values (1, 1005);
insert into sys_role_menu
values (1, 1006);
insert into sys_role_menu
values (1, 1007);

insert into sys_role_menu
values (1, 1011);
insert into sys_role_menu
values (1, 1012);
insert into sys_role_menu
values (1, 1013);
insert into sys_role_menu
values (1, 1014);

insert into sys_role_menu
values (1, 1021);
insert into sys_role_menu
values (1, 1022);
insert into sys_role_menu
values (1, 1023);
insert into sys_role_menu
values (1, 1024);

insert into sys_role_menu
values (1, 1031);
insert into sys_role_menu
values (1, 1032);
insert into sys_role_menu
values (1, 1033);
insert into sys_role_menu
values (1, 1034);

insert into sys_role_menu
values (1, 1041);
insert into sys_role_menu
values (1, 1042);
insert into sys_role_menu
values (1, 1043);
insert into sys_role_menu
values (1, 1044);
insert into sys_role_menu
values (1, 1061);
insert into sys_role_menu
values (1, 1062);
insert into sys_role_menu
values (1, 1063);
insert into sys_role_menu
values (1, 1064);

-- 字典类型表
-- ----------------------------
drop table if exists sys_dict_type;
create table sys_dict_type
(
    dict_id     bigint(20) not null auto_increment comment '字典主键',
    dict_name   varchar(100) default '' comment '字典名称',
    dict_type   varchar(100) default '' comment '字典类型',
    status      char(1)      default '0' comment '状态（0正常 1停用）',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(500) default null comment '备注',
    primary key (dict_id),
    unique (dict_type)
) engine = innodb comment = '字典类型表';

insert into sys_dict_type
values (1, '菜单状态', 'sys_show_hide', '0', 'admin', '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '菜单状态列表');
insert into sys_dict_type
values (2, '系统开关', 'sys_normal_disable', '0', 'admin', '2020-10-13 11-33-00', 'admin', '2020-10-13 11-33-00', '系统开关列表');

-- ----------------------------
-- 字典数据表
-- ----------------------------
drop table if exists sys_dict_data;
create table sys_dict_data
(
    dict_code   bigint(20) not null auto_increment comment '字典编码',
    dict_sort   int(4)       default 0 comment '字典排序',
    dict_label  varchar(100) default '' comment '字典标签',
    dict_value  varchar(100) default '' comment '字典键值',
    dict_type   varchar(100) default '' comment '字典类型',
    css_class   varchar(100) default null comment '样式属性（其他样式扩展）',
    list_class  varchar(100) default null comment '表格回显样式',
    is_default  char(1)      default 'N' comment '是否默认（Y是 N否）',
    status      char(1)      default '0' comment '状态（0正常 1停用）',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(500) default null comment '备注',
    primary key (dict_code)
) engine = innodb comment = '字典数据表';

insert into sys_dict_data
values (1, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2020-10-13 11-33-00', 'admin',
        '2020-10-13 11-33-00', '显示菜单');
insert into sys_dict_data
values (2, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2020-10-13 11-33-00', 'admin',
        '2020-10-13 11-33-00', '隐藏菜单');
insert into sys_dict_data
values (3, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2020-10-13 11-33-00', 'admin',
        '2020-10-13 11-33-00', '正常状态');
insert into sys_dict_data
values (4, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2020-10-13 11-33-00', 'admin',
        '2020-10-13 11-33-00', '停用状态');

-- ----------------------------
-- 站内信表
-- ----------------------------
drop table if exists sys_message;
create table sys_message
(
    msg_id      bigint(20)  not null auto_increment comment '通知表ID',
    msg_title   varchar(50) not null comment '通知标题',
    msg_content longblob     default null comment '通知内容',
    sender_id   bigint(20)  not null comment '发送用户ID',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(255) default null comment '备注',
    primary key (msg_id)
) engine = innodb comment = '通知表';

-- ----------------------------
-- 站内信接收表
-- ----------------------------
drop table if exists sys_message_receiver;
create table sys_message_receiver
(
    msg_id      bigint(20) not null comment '通知表ID',
    receiver_id bigint(20) not null comment '接收用户ID',
    status      char(1)      default '0' comment '通知状态（0未读 1已读）',
    read_time   datetime comment '已读时间',
    create_by   varchar(64)  default '' comment '创建者',
    create_time datetime comment '创建时间',
    update_by   varchar(64)  default '' comment '更新者',
    update_time datetime comment '更新时间',
    remark      varchar(255) default null comment '备注',
    primary key (msg_id, receiver_id)
) engine = innodb comment = '通知接收表';
