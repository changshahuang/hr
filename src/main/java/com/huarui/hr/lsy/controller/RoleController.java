package com.huarui.hr.lsy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huarui.hr.entity.SysRole;
import com.huarui.hr.lsy.service.SysRoleService;

@Controller
@RequestMapping("role")
public class RoleController {
	@Autowired
	private SysRoleService roleService;

	@RequestMapping("/queryRoleJson")
	@ResponseBody
	public List queryRoleJson() {
		System.out.println("查询全部的角色");
		List<SysRole> list = roleService.queryRole();
		return list;
	}

	@RequestMapping("/queryRoleAndRightByRoleId")
	@ResponseBody
	public SysRole queryRoleAndRightByRoleId(SysRole role) {
		System.out.println("查询角色和角色Id:"+role);
		SysRole sysRole = roleService.queryRoleAndRightByRoleId(role);
		return sysRole;
	}

}
