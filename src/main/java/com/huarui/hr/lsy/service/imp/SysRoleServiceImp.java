package com.huarui.hr.lsy.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.huarui.hr.entity.SysRole;
import com.huarui.hr.lsy.mapper.SysRoleMapper;
import com.huarui.hr.lsy.mapper.UsersMapper;
import com.huarui.hr.lsy.service.SysRoleService;
@Service
public class SysRoleServiceImp implements SysRoleService {
	@Autowired
	private SysRoleMapper sysRoleMapper;
	
	@Autowired
	private UsersMapper um;
	@Override
	public List<SysRole> queryRole() {
		// TODO Auto-generated method stub
		return sysRoleMapper.queryRole();
	}
	@Override
	public SysRole  queryRoleAndRightByRoleId(SysRole role) {
		
		return sysRoleMapper.queryRoleById(role.getRole_id());
	}
	@Override
	public Integer insertRole(SysRole role) {
		// TODO Auto-generated method stub
		return sysRoleMapper.insertRole(role);
	}
	
	//多个删除当成是一个事务，要么成功，要么失败
	@Transactional
	public Integer deleteRoleById(SysRole role) {
		//判断是否有用户在使用角色
		Integer count=um.queryUserCountByRoleId(role.getRole_id());
		if(count==0) {//表示角色没有用使用，可以删除
			//先删除中间表数据
			sysRoleMapper.deleteRoleRightByRoleId(role.getRole_id());
			//再删除角色
			sysRoleMapper.deleteRoleById(role);
			return 1;
		}
		return 0;
	}
	//修改角色贺权限
	@Transactional
	public Integer updateRole(SysRole role,Integer[] rightId) {
		//刪除中間表中的数据
		Integer num1=sysRoleMapper.deleteRoleRightByRoleId(role.getRole_id());
		//修改角色
		Integer num2=sysRoleMapper.updateRole(role);
		//添加中间表的数据
		Integer num3=sysRoleMapper.saveRoleAndRight(rightId, role.getRole_id());
		System.out.println(num1+"/"+num2+"/"+num3);
		return 1;
	}

}
