package com.huarui.hr.lsy.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.huarui.hr.entity.SysRight;

public class MyUtil {
	/**
	 * 根据父id得到相关的权限
	 * 
	 */
	public static List<SysRight> getRightByParentId(List<SysRight> list, Integer parentId) {
		List<SysRight> meun = new ArrayList<SysRight>();
		for (SysRight r : list) {
			if (r.getRight_parent_code() == parentId) {
				meun.add(r);
			}
		}
		return meun;
	}

	/**
	 * 菜单找儿子的方法
	 */
	public static void getSon(List<SysRight> list, Map<String, Object> fatherMap, Integer fatherId) {
		// 存放儿子的集合
		List<Map<String, Object>> sons = new ArrayList<Map<String, Object>>();
		for (SysRight sr : list) {
			// 判断是不是指定的儿子
			if (sr.getRight_parent_code() == fatherId) {
				Map<String, Object> son = new HashMap<String, Object>();
				son.put("id", sr.getRight_code());
				son.put("text", sr.getRight_text());
				// 此儿子节点还是别人的父亲,sr.getRight_parent_code()!=0 表示不是最大根节点
				if ("parent".equals(sr.getRight_type()) && sr.getRight_parent_code() != 0) {
					son.put("state", "open");
					// 找当前对象的儿子
					getSon(list, son, sr.getRight_code());
				}
				// 把儿子存放到儿子集合
				sons.add(son);
			}
		}
		// 把儿子绑定到父亲
		fatherMap.put("children", sons);
	}
}
