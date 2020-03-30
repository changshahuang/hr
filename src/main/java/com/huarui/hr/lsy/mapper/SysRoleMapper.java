package com.huarui.hr.lsy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.huarui.hr.entity.SysRole;

@Repository
public interface SysRoleMapper {
	public SysRole queryRoleById(Integer roleId);

	public SysRole queryRoleById2(Integer roleId);

	public List<SysRole> queryRole();

	public Integer insertRole(SysRole role);

	public Integer deleteRoleById(SysRole role);

	public Integer deleteRoleRightByRoleId(Integer roleId);

	public Integer updateRole(SysRole role);
	
	public Integer saveRoleAndRight(@Param("rightId") Integer[] rightId,@Param("roleId") Integer roleId);
}
