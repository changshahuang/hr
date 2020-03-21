<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="../easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
<script type="text/javascript" src="../easyui/jquery.min.js"></script>
<script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
		<div data-options="region:'north',title:'欢迎'" style="height:150px;">
			${user.u_name}--${user.u_true_name}--${user.role.role_name}
		</div>
		<div data-options="region:'west',title:'菜单'" style="width:200px;">
			<ul id="tt"></ul>  
			<script type="text/javascript">
				$(function (){
					//产生菜单
					$('#tt').tree({    
					    url:'../sysRight/querySysRightJson3',
					    animate:true,
					    lines:true,
					    formatter:function(node){
					    	//node就是当前的节点对象
					    	//console.log(node);
					    	if(node.state=="open"){
					    		return '<a href="javascript:addTabs(\''+node.text+'\',\''+node.attributes.url+'\')">'+node.text+"</a>";
					    	}
					    	return node.text;
					    },
					    onLoadError:function (aa){
					    	//加载不到数据session中没有登录
					    	location.href="../login.jsp";
					    }
					}); 
					
				}) 
				//追加标签页
				function addTabs(name,url){
					var num=0;
					//得到所有的面板[是一个数组接受]
					var ts=$("#tt2").tabs("tabs");
					for(i=0;i<ts.length;i++){
						t=ts[i];
						//得到一个面板对象，从面板对象上得到指定的数据
						var title=t.panel("options").title;
						if(title==name){
							num=1;
							break;
						}
					}
					 //判断是否存在
					 if(num>0){
						 //存在就选中
						 $("#tt2").tabs("select",name);
					 }else{
						 //不存在添加面板
						 $('#tt2').tabs('add',{    
							    title:name,    
							    content:"<iframe style='width:100%;height:100%;border:0px' src='"+url+"'></iframe>",    
							    closable:true  
							});
					 }
				}
			</script>
		</div>
		<div data-options="region:'center'">
			<div id="tt2" class="easyui-tabs" style="width:100%;height:100%;">
				<div title="首页" style="padding:20px;display:none;">
					欢迎
				</div>
			</div>
		</div>
	</body>
</html>