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
	}
	#myRoleUL{
		list-style: none;
	}
	
	#myRoleUL li{
		float: left;
		margin-bottom: 10px;
		margin-top: 20px;
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
			 		var bt=$("<li><a onclick='queryRoleById("+data[i].role_id+",this)' href='javascript:'class='myButton'>"+data[i].role_name+"</a></li>");
			 		$("#myRoleUL").append(bt);
			 	}
			},
			"json"
		);
	})
	//根据ID查询角色
	function queryRoleById(rid,obj){
		//选中角色的样式
		$(".myButton").css("background-color","white");
		$(obj).css("background-color","pink");
		
		$.get(
				"../../role/queryRoleAndRightByRoleId", 
				{role_id:rid},
				function(data){
					var rights=data.rights;
					for(i=0;i<rights.length;i++){
						/* var node = $('#rights').tree('find',rights[i].right_code);
						$('#rights').tree('select', node.target); */
					}
					
				},
				"json"
		);
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
</script>
</head>
<body>
	
	<!-- 自定义工具 -->
	<div id="panelTool">
		<a style="text-decoration:none; margin-top:-6px; height:30px;width: 108px;background-position: 0px 6px" href="javascript:alert('edit')" class="icon-add">
			<span style="font-weight:bold;margin-left: 18px;line-height: 28px;font-size: 15px">添加新角色</span>
		</a>
	</div>
	<!-- 角色面板 -->
	<DIV style="position: sticky;width: 100%;top:8px">
		<div id="rolePanel" class="easyui-panel" title="角色管理"
			style="width: 100%;padding-bottom: 10px;padding-top: 5px;"
			data-options="tools:'#panelTool'">
			<ul id="myRoleUL">
			</ul>
		</div>
	</DIV>
	<ul id="rights"></ul>  
</body>
</html>