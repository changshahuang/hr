package com.huarui.hr.entity;

import java.io.Serializable;
import java.util.List;

public class SysRole implements Serializable{
	private Integer role_id; 
	private String role_name;
	private String role_desc;
	private Integer role_flag;
	private List<SysRight> rights;
	
	public Integer getRole_id() {
		return role_id;
	}

	public void setRole_id(Integer role_id) {
		this.role_id = role_id;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getRole_desc() {
		return role_desc;
	}

	public void setRole_desc(String role_desc) {
		this.role_desc = role_desc;
	}

	public Integer getRole_flag() {
		return role_flag;
	}

	public void setRole_flag(Integer role_flag) {
		this.role_flag = role_flag;
	}

	public List<SysRight> getRights() {
		return rights;
	}

	public void setRights(List<SysRight> rights) {
		this.rights = rights;
	}

	@Override
	public String toString() {
		return "SysRole [role_id=" + role_id + ", role_name=" + role_name + ", role_desc=" + role_desc + ", role_flag="
				+ role_flag + ", rights=" + rights + "]";
	}
	
}
