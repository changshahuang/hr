package com.huarui.hr.lsy.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.huarui.hr.entity.Users;
import com.huarui.hr.lsy.mapper.UsersMapper;
import com.huarui.hr.lsy.service.UsersService;
import com.huarui.hr.lsy.util.MyPage;

@Service
public class UsersServiceImp implements UsersService {

	@Autowired
	private UsersMapper um;

	public Users queryUsersByNameAndPwd(Users user) {
		System.out.println("UsersServiceImp-queryUsersByNameAndPwd");
		return um.queryUsersByNameAndPwd(user);
	}

	@Override
	public List<Users> queryUsersAndRole(MyPage page) {
		System.out.println("UsersServiceImp-queryUsersAndRole");
		return um.queryUsersAndRole(page);
	}

	@Transactional
	public Integer insertUser(Users user) {
		Integer num = um.insertUser(user);
		return num;
	}

	@Override
	public Integer updateUserByUname(Users user) {

		return um.updateUserByUname(user);
	}

}
