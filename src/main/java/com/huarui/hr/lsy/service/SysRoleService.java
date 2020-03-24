package com.huarui.hr.lsy.service;

import java.util.List;

import com.huarui.hr.entity.SysRole;

public interface SysRoleService {
	public List<SysRole> queryRole();
	public SysRole queryRoleAndRightByRoleId(SysRole role);
}
