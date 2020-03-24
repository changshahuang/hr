package com.huarui.hr.lsy.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.huarui.hr.entity.Users;
import com.huarui.hr.lsy.util.MyPage;

@Repository
public interface UsersMapper {
	public Users queryUsersByNameAndPwd(Users user);

	public List<Users> queryUsersAndRole(MyPage page);

	public Integer insertUser(Users user);

	public Integer updateUserByUname(Users user);
}
