<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>更新用户</title>
    	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
 	 	<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/icon.css" type="text/css"></link>  
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/default/easyui.css" type="text/css"></link>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script>
		    
	<style type="text/css">
		form div{
			margin:5px
		}
	</style>
	<script type="text/javascript">
		$(function(){
			//数据回显
			var row=parent.$("iframe[title='用户管理']").get(0).contentWindow.$("#dg").datagrid("getSelections")[0];
			$("#ff").form("load",{
				uid:row.uid,
				username:row.username,
				name:row.name,
				password:row.password,
				email:row.email,
				telephone:row.telephone,
				birthday:row.birthday,
				sex:row.sex,
				state:row.state
			});
			
			//自定义电话认证规则
			$.extend($.fn.validatebox.defaults.rules, 
					{    
					     phone:{    
		       			 validator: function(value,param){
		       			 	if(/^1[34578]\d{9}$/.test(value))
		       			 	{
		       			 		return true;
		       			 	}else
		       			 	{
			       			 	return false;   
		       			 	}
		       			 },    
		        		message:"请输入合符规则的11位手机号码"   
		   			 }     
			});
			
			//给表单字段添加验证
		 	$("#name").validatebox({
		 		required:true,
		 		missingMessage:"用户昵称不能为空",
		 	});
			
			$("#email").validatebox({
		 		required:true,
		 		validType:"email",
		 		missingMessage:"用户邮件不能为空",
		 	});
			
		 	$("#telephone").validatebox({
		 		required:true,
		 		validType:"phone",
		 		missingMessage:"用户电话不能为空",
		 	});

			
		 	$('#birthday').datebox({
		 	    required:true
		 	})
		 	
			  
			//1.先关闭表单验证，免得一打开页面就弹出错误信息
			$("#ff").form("disableValidation");
			
			//提交按钮设置
			$("#submit").click(function(){
				$("#ff").form("enableValidation");
 				if($("#ff").form("validate"))
				{	
					//验证成功后移除name的disableed属性
					$("#username").removeAttr("disabled");
					$("#ff").form("submit",{
						url:"${store}/UserServlet?method=update",
						success:function()
						{
							parent.$("#win").window("close");
							parent.$("iframe[title='用户管理']").get(0).contentWindow.$("#dg").datagrid("reload");
						}
					});
				}
			});
			
			//重置按钮设置
			$("#reset").click(function(){
				$("#ff").form("disableValidation");
				$("#ff").form("reset");
			});
		});
     </script>

  </head>
  
  <body>
  	<form id="ff" method="post">
  		
  		<input type="hidden" name="uid"/>
  		<input type="hidden" name="password"/>
  		
  		<div>
  			<label for="username">用户名:</label>
  			<input type="text" id="username" name="username" disabled="disabled"/>
  		</div>
  		<div>
  			<label for="name">用户昵称:</label>
  			<input type="text" id="name" name="name" />
  		</div>
  		<div>
  			<label for="email">用户邮件:</label>
  			<input type="text" id="email" name="email"/>
  		</div>
  		
  		 <div>
  			<label for="telephone">用户电话:</label>
  			<input type="text" id="telephone" name="telephone"/>
  		</div>
  		<div>
  			<label for="birthday">用户生日:</label>
  			<input type="text" id="birthday" name="birthday"/>
  		</div>
  		
  		<div>
  			用户性别：
  			<label for="male">男</label>
  			<input type="radio" id="male" name="sex" value="male"/>&nbsp;&nbsp;
  			<label for="female">女</label>
  			<input type="radio" id="female" name="sex" value="female"/>
  		</div>
  		
  		<div>
  			是否激活：
  			<label for="active">已激活</label>
  			<input type="radio" id="active" name="state" value="1"/>&nbsp;&nbsp;
  			<label for="noactive">未激活</label>
  			<input type="radio" id="noactive" name="state" value="0"/>
  		</div>
  		
		<div>
		      <a id="submit" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
		      <a id="reset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">重置</a>   
		</div>
  	</form>
  </body>
</html>
