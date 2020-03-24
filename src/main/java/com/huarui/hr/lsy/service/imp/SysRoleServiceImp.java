package com.huarui.hr.lsy.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huarui.hr.entity.SysRole;
import com.huarui.hr.lsy.mapper.SysRoleMapper;
import com.huarui.hr.lsy.service.SysRoleService;
@Service
public class SysRoleServiceImp implements SysRoleService {
	@Autowired
	private SysRoleMapper sysRoleMapper;
	@Override
	public List<SysRole> queryRole() {
		// TODO Auto-generated method stub
		return sysRoleMapper.queryRole();
	}
	@Override
	public SysRole  queryRoleAndRightByRoleId(SysRole role) {
		
		return sysRoleMapper.queryRoleById(role.getRole_id());
	}

}
