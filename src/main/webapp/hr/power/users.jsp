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
<script type="text/javascript">
	$(function() {
		//展示用户信息
		$('#dg').datagrid({
			url : '../../users/queryUsersAndRole',
			fitColumns : true,
			pagination : true,//显示分页
			pageNumber : 1,//第一次加载时显示第几页
			pageSize : 3,//每页显示的条数
			pageList : [ 1, 2, 3, 4, 5 ],//可以每页显示的条数
			idField : "u_id",
			sortName : "u_id",
			sortOrder : "desc",
			toolbar : [ {
				iconCls : 'icon-add',
				text : '添加用户',
				handler : function() {
					//初始化角色下拉列表
					$('#roleSelect').combobox({    
					    url:'../../role/queryRoleJson',    
					    valueField:'role_id',    
					    textField:'role_name',
					    loadFilter:function (data){
					    	var obj={};//new Object();
					    	obj.role_id=-1;
					    	obj.role_name="请选择";
					    	obj.selected=true;//设置selected=true表示选中
					    	data.splice(0,0,obj); //第一个参数是插入的下标,第二个参数是是否替换，0表示不替换,第三个参数是插入的数据
					    	return data;
					    }
					}); 
					//打开添加模态框
					$("#insertDiv").dialog("open");
				}
			} ],
			columns : [ [ {
				field : "u_id",
				title : "编号",
				width : 100
			}, 
			{
				field : "u_password",
				title : "密码",
				width : 100,
				hidden:true
			}, 
			{
				field : "u_name",
				title : "账号",
				width : 100
			}, {
				field : "u_true_name",
				title : "真实姓名",
				width : 100
			}, {
				field : "role",
				title : "角色",
				width : 100,
				formatter : function(v, r, i) {
					return v.role_name;
				}
			}, {
				field : "操作",
				title : "操作",
				width : 100,
				formatter : function(v, r, i) {
					var id = r.u_id;
					var msg=JSON.stringify(r);
					console.log(msg); 
					return "<a href='#'>删除</a> <a href='javascript:updateUser("+msg+")'>修改</a>";
					//return "<a href='#'>删除</a> <a href=\"javascript:updateUser('"+r.u_name+"','"+r.u_true_name+"','"+r.u_password+"',"+r.role.role_id+")\">修改</a>";
				}
			} ] ]
		});
		//初始化添加表单
		$('#insertUser').form({    
		    url:"../../users/insertUser",   
		    success:function(data){    
		       // alert(data); //data就是服务器返回的信息  
		       if(data==1){
		    	   //添加成功
		    	   //重置表单
		    	   $('#insertUser').form("reset");
		    	   
		    	   $("#insertDiv").dialog("close");//关闭模态框
		    	   //刷新页面
		    	   location.reload();
		       }else{
		    	   $.messager.alert('消息','添加用户失败','error');
		       }
		    }    
		});
		
	})
	
	//添加的时候验证用户是否可用
	$("#insertUserIdTextbox").on("blur",function (){
		alert(1);
	})
	
	//提交用户信息
	function insertUser(){
		$('#insertUser').submit(); 
	}
	//添加模态框中取消按钮功能
	function resetUserForm(){
		 $('#insertUser').form("reset");
  	     $("#insertDiv").dialog("close");//关闭模态框
	}
	
	$(function (){
		//初始化修改模态框
		$('#updateUserForm').form({    
		    url:"../../users/updateUserByUname",   
		    success:function(data){    
		       // alert(data); //data就是服务器返回的信息  
		       if(data==1){
		    	   //修改成功
		    	   //重置表单
		    	  	resetUserForm2();
		    	   //刷新页面
		    	   location.reload();
		       }else{
		    	   $.messager.alert('消息','修改用户失败','error');
		       }
		    }    
		});
	})
	
	
	//打开修改模态框
	//function updateUser(name,trueName,pwd,roleId){
	function updateUser(msg){
		//alert(msg);
	    //设置密码 为密码框
	    $('#u_password').textbox({    
			type:"password"  
		});
		 $('#u_name').textbox({    
			   value:msg.u_name  
		});
		$('#u_true_name').textbox({    
		   value:msg.u_true_name 
		});
		$('#u_password').textbox({    
		   value:msg.u_password  
		});
		//初始化角色下拉列表
		$('#roleSelect2').combobox({    
		    url:'../../role/queryRoleJson',    
		    valueField:'role_id',    
		    textField:'role_name',
		    loadFilter:function (data){
		    	for(i=0;i<data.length;i++){
		    		if(data[i].role_id==msg.role.role_id){
		    			data[i].selected=true;
		    			break;
		    		}
		    	}
		    	var obj={};//new Object();
		    	obj.role_id=-1;
		    	obj.role_name="请选择";
		    	//obj.selected=true;//设置selected=true表示选中
		    	data.splice(0,0,obj); //第一个参数是插入的下标,第二个参数是是否替换，0表示不替换,第三个参数是插入的数据
		    	return data;
		    }
		}); 
		//打开添加模态框
		$("#updateDiv").dialog("open"); 
	}
	//点击修改模态框中的取消
	function resetUserForm2(){
		 $('#updateUserForm').form("reset");//重置表单数据
  	     $("#updateDiv").dialog("close");//关闭模态框
	}
	//重置密码的超链接功能
	function setPassWrod2(){
		$('#u_password').textbox({    
			type:"text",   
			value:"123456"    
		});
		
	}
	//点击修改按钮
	function clickUpdateBt(){
		$('#updateUserForm').submit(); 
	}
</script>
				
</head>
<body>
    <!-- 修改模态框 -->
    <div id="updateDiv" class="easyui-dialog" title="修改"
		style="width: 600px; height: 400px;"
		data-options="closable:false,top:30,draggable:false,iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:[{text:'修改',handler:function (){clickUpdateBt()}},{text:'取消',handler:function (){resetUserForm2()}}]">
		<form style="margin-top: 20px;" id="updateUserForm" class="easyui-form"
			method="post">
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input readonly="readonly" id="u_name" class="easyui-textbox" name="u_name" style="width: 300px"
					data-options="label:'账号:',required:true">
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input readonly="readonly" id="u_true_name" class="easyui-textbox" name="u_true_name" style="width: 300px"
					data-options="label:'姓名:',required:true">
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input type="password"  id="u_password" readonly="readonly" class="easyui-textbox" name="u_password" style="width: 300px"
					data-options="label:'密码:'">
				<a href="javascript:setPassWrod2()">重置密码:123456</a>
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input id="roleSelect2" name="role.role_id" style="width: 300px" data-options="label:'角色:'"/> 
			</div>
		</form>
	</div>
    
	<!-- 添加的模态框 -->
	<div id="insertDiv" class="easyui-dialog" title="添加"
		style="width: 600px; height: 400px;"
		data-options="closable:false,top:30,draggable:false,iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:[{text:'保存',handler:function (){insertUser()}},{text:'取消',handler:function (){resetUserForm()}}]">
		<form style="margin-top: 20px;" id="insertUser" class="easyui-form"
			method="post">
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input  id="insertUserIdTextbox" class="easyui-textbox" name="u_name" style="width: 300px"
					data-options="label:'账号:',required:true">
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input class="easyui-textbox" name="u_true_name" style="width: 300px"
					data-options="label:'姓名:',required:true">
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input value="123456" readonly="readonly" class="easyui-textbox" name="u_password" style="width: 300px"
					data-options="label:'密码:',required:true">
			</div>
			<div style="margin-bottom: 20px; margin-left: 30px;">
				<input id="roleSelect" name="role.role_id" style="width: 300px" data-options="label:'角色:'"/> 
			</div>
		</form>
	</div>
	<table id="dg"></table>
</body>
</html>