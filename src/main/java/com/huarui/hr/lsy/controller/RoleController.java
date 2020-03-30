package com.huarui.hr.lsy.controller;

import java.io.Reader;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@RequestMapping("/insertRole")
	@ResponseBody
	public Integer insertRole(SysRole role) {
		System.out.println("添加角色:"+role);
		return roleService.insertRole(role);
	}
	//删除角色
	@RequestMapping("/deleteRoleById")
	@ResponseBody
	public Integer deleteRoleById(SysRole role) {
		System.out.println("删除:"+role);
		Integer num=roleService.deleteRoleById(role);
		return num;
	}
	//修改角色和权限
	@RequestMapping("/updateRoleAndRoleRight")
	@ResponseBody
	public Integer updateRoleAndRoleRight(SysRole role,Integer[] arr) {
		System.out.println("修改角色1:"+role);
		System.out.println(arr+"/"+arr.length);
		Integer num=roleService.updateRole(role, arr);
		return num;
	}
}
