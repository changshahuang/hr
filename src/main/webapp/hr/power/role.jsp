<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="../../easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="../../easyui/themes/icon.css">
<script type="text/javascript" src="../../easyui/jquery.min.js"></script>
<script type="text/javascript" src="../../easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../easyui/easyui-lang-zh_CN.js"></script>
<style type="text/css">
	.myButton{
		color:green;
		border: 2px solid #797979;
		padding: 8px;
		text-decoration: none;
		border-radius: 20px;
		box-shadow: 5px 5px 5px #888888;
		font-weight: bold;
		margin-top:-20px;
	}
	#myRoleUL{
		list-style: none;
	}
	
	#myRoleUL li{
		float: left;
		margin-bottom: 10px;
		margin-top: 10px;
		margin-right: 10px;
	}
	
</style>
<script type="text/javascript">
	//加载角色
	$(function (){
		$.get(
			"../../role/queryRoleJson", 
			function(data){
			 	for(i=0;i<data.length;i++){
			 		var thisRole=JSON.stringify(data[i]);
			 		var bt;
			 		if(data[i].role_flag==1){
			 			bt=$("<li><button onclick='queryRoleById("+thisRole+",this)' class='myButton'>"+data[i].role_name+"</button></li>");
			 		}else{
			 			bt=$("<li><button style='color:red' onclick='queryRoleById("+thisRole+",this)' class='myButton'>"+data[i].role_name+"</button></li>");
			 		}
			 		$("#myRoleUL").append(bt);
			 	}
			},
			"json"
		);
	})
	//根据ID查询角色 点击角色按钮
	function queryRoleById(thisRole,obj){
		//console.info(thisRole);
		var rid=thisRole.role_id;
		//选中角色的样式
		$(".myButton").css("background-color","white");
		$(obj).css("background-color","pink");
		//得到页面全部的权限
		var allRights=$("input[name=allRight]");
		//清空上一个角色的权限
		allRights.each(function (){
				$(this).prop("checked","");
		});
		//选中当前角色的权限
		$.get(
				"../../role/queryRoleAndRightByRoleId", 
				{role_id:rid},
				function(data){
					//得到当前角色的权限
					var rights=data.rights;
					for(i=0;i<rights.length;i++){
						/* var node = $('#rights').tree('find',rights[i].right_code);
						$('#rights').tree('select', node.target);*/
						allRights.each(function (){
							//得到指定页面的权限的value值
							var va=$(this).val()
							if(va==rights[i].right_code){
								$(this).prop("checked","checked");
							}
						})
						
					} 
					
				},
				"json"
		);
		//显示自己相关的数据
		$("#roleUpdatePanel").panel("open");
		//修改模态框中角色赋值
		$("#update_role_name").textbox({value:thisRole.role_name});
		$("#update_role_desc").textbox({value:thisRole.role_desc?thisRole.role_desc:''});
		$("#update_role_flag").combobox("select",thisRole.role_flag);
	}
	//加载所有的权限
	$(function (){
		$('#rights').tree({    
		    url:'../../sysRight/queryRightAll',
		    animate:true,
		    lines:true,
		    formatter:function(node){
		    	return "<input type='checkbox' name='allRight' id='right"+node.id+"' value='"+node.id+"'/>"+node.text;
		    }
		}); 
	})
	
	//弹出添加角色模态框
	function showSaveRole(){
		$("#insertRoleDiv").dialog("open"); 
	}
	//重置添加角色表单关闭模态窗
	function reSetRoleForm(){
		 $('#insertRoleForm').form("reset");//重置表单数据
  	     $("#insertRoleDiv").dialog("close");//关闭模态框
	}
	//点击添加角色
	function insertRoleSubmit(){
		$('#insertRoleForm').submit();  
	}
	//初始化表单
	$(function (){
		$('#insertRoleForm').form({    
		    url:"../../role/insertRole",  
		    success:function(data){    
		       if(data==1){
		    	   alert("添加成功！");
		    	   location.reload();
		       }else{
		    	   alert("添加失败！");
		       }
		    }    
		});  
	})
	//清空所有的权限
	function clearMenu(){
		//得到页面全部的权限
		var allRights=$("input[name=allRight]");
		//清空上一个角色的权限
		allRights.each(function (){
				$(this).prop("checked","");
		});
	}
</script>
</head>
<body> 
    <!-- 添加角色模态框 -->
	<div id="insertRoleDiv" class="easyui-dialog" title="添加"
		style="width: 600px; height: 400px;"
		data-options="closable:false,top:30,draggable:false,iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:[{text:'添加',handler:function (){insertRoleSubmit()}},{text:'取消',handler:function (){reSetRoleForm()}}]">
		<form style="margin-top: 20px;" id="insertRoleForm" class="easyui-form"
			method="post">
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input id="role_name" class="easyui-textbox" name="role_name" style="width: 300px"
					data-options="label:'角色名称:',required:true">
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input id="role_desc" class="easyui-textbox" name="role_desc" style="width: 300px"
					data-options="label:'角色备注:',required:true">
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<select  data-options="label:'是否启用:'" id="role_flag" class="easyui-combobox" name="role_flag" style="width:300px;">   
				    <option value="0">禁用</option>
				    <option value="1">启用</option>    
				</select> 
			</div>
		</form>
	</div>
	
	<!-- 自定义工具:添加 -->
	<div id="panelTool">
		<a style="text-decoration:none; margin-top:-6px; height:30px;width: 108px;background-position: 0px 6px" href="javascript:showSaveRole()" class="icon-add">
			<span style="font-weight:bold;margin-left: 18px;line-height: 28px;font-size: 15px">添加新角色</span>
		</a>
	</div>
	<!-- 自定义工具:修改 -->
	<div id="panelTool2">
		<a style="text-decoration:none; margin-top:-6px; height:30px;width: 108px;background-position: 0px 6px" href="javascript:clearMenu()" class="icon-remove">
			<span style="font-weight:bold;margin-left: 18px;line-height: 28px;font-size: 15px">清空所选权限</span>
		</a>
	</div>
	<!-- 自定义底部:修改 -->
	<div id="panelTool3" style="height: 40px;padding: 4px">
		<button style="float: right;" type="button" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">删除</button>
		<button style="float: right;margin-right: 20px" type="button" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改角色及其权限</button>
	</div>
	<!-- 所有角色面板 -->
	<DIV style="position: sticky;width: 100%;top:8px">
		<div id="rolePanel" class="easyui-panel" title="角色管理"
			style="width: 100%;padding-bottom: 10px;padding-top: 5px;"
			data-options="tools:'#panelTool'">
			<ul id="myRoleUL">
			</ul>
		</div>
		<!-- 修改角色的面板 -->
		<div style="float: right;">
			<div id="roleUpdatePanel" class="easyui-panel" title="修改角色及其权限"
				style="width: 500px;padding-bottom: 10px;padding-top: 5px;"
				data-options="closed:true,openAnimation:'slide',footer:'#panelTool3',tools:'#panelTool2'">
				<form style="margin-top: 20px;" id="updateRoleForm"  class="easyui-form"
					method="post">
					<div style="margin-bottom: 20px; margin-left: 30px;">
						<input id="update_role_name" class="easyui-textbox" name="role_name" style="width: 300px"
							data-options="label:'角色名称:',required:true">
					</div>
					<div style="margin-bottom: 20px; margin-left: 30px;">
						<input id="update_role_desc" class="easyui-textbox" name="role_desc" style="width: 300px"
							data-options="label:'角色备注:',required:true">
					</div>
					<div style="margin-bottom: 20px; margin-left: 30px;">
						<select id="update_role_flag" data-options="label:'是否启用:'" class="easyui-combobox" name="role_flag" style="width:300px;">   
						    <option value="0">禁用</option>
						    <option value="1">启用</option>    
						</select> 
					</div>
				</form>
			</div>
		</div>
	</DIV>
	
	<!-- 展示所有的权限 -->
	<ul id="rights"></ul>  
</body>
</html>