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
	
	//���ɾ��������һ������Ҫô�ɹ���Ҫôʧ��
	@Transactional
	public Integer deleteRoleById(SysRole role) {
		//�ж��Ƿ����û���ʹ�ý�ɫ
		Integer count=um.queryUserCountByRoleId(role.getRole_id());
		if(count==0) {//��ʾ��ɫû����ʹ�ã�����ɾ��
			//��ɾ���м������
			sysRoleMapper.deleteRoleRightByRoleId(role.getRole_id());
			//��ɾ����ɫ
			sysRoleMapper.deleteRoleById(role);
			return 1;
		}
		return 0;
	}
	//�޸Ľ�ɫ��Ȩ��
	@Transactional
	public Integer updateRole(SysRole role,Integer[] rightId) {
		//�h�����g���е�����
		Integer num1=sysRoleMapper.deleteRoleRightByRoleId(role.getRole_id());
		//�޸Ľ�ɫ
		Integer num2=sysRoleMapper.updateRole(role);
		//����м�������
		Integer num3=sysRoleMapper.saveRoleAndRight(rightId, role.getRole_id());
		System.out.println(num1+"/"+num2+"/"+num3);
		return 1;
	}

}
