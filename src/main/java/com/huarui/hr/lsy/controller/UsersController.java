package com.huarui.hr.lsy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huarui.hr.entity.Users;
import com.huarui.hr.lsy.mapper.MyMapper;
import com.huarui.hr.lsy.service.UsersService;
import com.huarui.hr.lsy.util.MyPage;

@Controller
@RequestMapping("users")
public class UsersController {
	@Autowired
	private UsersService us;
	@Autowired
	private MyMapper mm;
	
	@RequestMapping("insertUser")
	@ResponseBody
	public int insertUser(Users user) {
		System.out.println("添加用户："+user);
		Integer num=us.insertUser(user);
		return num;
	}
	
	@RequestMapping("/queryUsersByNameAndPwd")
	public String queryUsersByNameAndPwd(HttpSession session,Users user) {
		System.out.println("登录："+user);
		Users u=us.queryUsersByNameAndPwd(user);
		if(u!=null) {
			session.setAttribute("user", u);
		}else {
			//账号密码错误
			//给出提示
			return "redirect:../login.jsp";
		}
		return "redirect:../hr/main.jsp";
	}
	
	@RequestMapping("/queryUsersAndRole")
	@ResponseBody
	public Map queryUsersAndRole(MyPage page) {
		System.out.println("查询全部的用户:"+page);
		List<Users> users= us.queryUsersAndRole(page);
		Integer count=mm.getTableCount("users");
		/*
		 * {total:10,rows:数据"}
		 * */
		Map map=new HashMap();
		map.put("total",count);
		map.put("rows",users);
		System.out.println(users);
		return map;
	}
	//修改用户信息
	@RequestMapping("/updateUserByUname")
	@ResponseBody
	public Integer updateUserByUname(Users user) {
		System.out.println("修改用户："+user);
		
		return us.updateUserByUname(user);
	}
}




