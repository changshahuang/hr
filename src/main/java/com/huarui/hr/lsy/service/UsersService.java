package com.huarui.hr.lsy.service;

import java.util.List;

import com.huarui.hr.entity.Users;
import com.huarui.hr.lsy.util.MyPage;


public interface UsersService {
	public Users queryUsersByNameAndPwd(Users user);
	public List<Users> queryUsersAndRole(MyPage page);
	public Integer insertUser(Users user);
	public Integer updateUserByUname(Users user);
}
