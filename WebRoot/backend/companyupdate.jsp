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
			var row=parent.$("iframe[title='商家管理']").get(0).contentWindow.$("#dg").datagrid("getSelections")[0];
			$("#ff").form("load",{
				id:row.id,
				name:row.name,
				password:row.password,
				company_name:row.company_name
			});
			//存储原来商家用户名和店铺名,如果没有值更改的话验证返回true
			var yname=row.name;
			var ycompany_name=row.company_name;
			//自定义电话号码验证
			$.extend($.fn.validatebox.defaults.rules, 
			{    
				//规则名{validator:处理函数(value input标签 value值,param 传入的参数),message:"返回消息"}
				checkName:
				{
					validator:function(value,param)
						{
							var flag = false;
							if(value==yname)
							{
								return true;
							}
							//value:输入的内容
							//params：规则对应的参数值
							//目的：对输入的name进行ajax校验
							$.ajax({
								"async":false,
								"url":"${pageContext.request.contextPath}/CompanyServlet?method=checkName",
								"data":{"name":value},
								"type":"POST",
								"dataType":"json",
								"success":function(data){
									flag = data.isExist;
								}
							});
							//返回false代表该校验器不通过
							return !flag;
						},
					message: '商家用户名已存在'
				},
			   	checkCompanyName: 
			   	{
						validator:function(value,param)
							{
								var flag = false;
								//value:输入的内容
								//params：规则对应的参数值
								//目的：对输入的name进行ajax校验
								if(value==ycompany_name)
								{
									return true;
								}
								$.ajax({
									"async":false,
									"url":"${pageContext.request.contextPath}/CompanyServlet?method=checkCompanyName",
									"data":{"company_name":value},
									"type":"POST",
									"dataType":"json",
									"success":function(data){
										flag = data.isExist;
									}
								});
								//返回false代表该校验器不通过
								return !flag;
							},
						message: '商家公司名已存在'
				}
			});
			
			
			
			//使用easyui的validatebox对表单进行验证
			$("#name").validatebox({
		 		required:true,
		 		missingMessage:"商家用户名为空",
		 		validType:"checkName",
		 		delay:1000
		 	});
		 	$("#password").validatebox({
		 		required:true,
		 		missingMessage:"商家密码为空",
		 	});
		 	
		 	$("#company_name").validatebox({
		 		required:true,
		 		missingMessage:"商家公司名称为空",
		 		validType:"checkCompanyName",
		 		//获得焦点1秒后验证,默认为0.2s
		 		delay:1000
		 	});
			
			
			
			
			  
			//1.先关闭表单验证，免得一打开页面就弹出错误信息
			$("#ff").form("disableValidation");
			  
			$("#submit").click(function(){
				$("#ff").form("enableValidation");
 				if($("#ff").form("validate"))
				{	
					//验证成功后移除name的disableed属性
					$("#user_name").removeAttr("disabled");
					$("#ff").form("submit",{
						url:"${store}/CompanyServlet?method=update",
						success:function()
						{
							parent.$("#win").window("close");
							parent.$("iframe[title='商家管理']").get(0).contentWindow.$("#dg").datagrid("reload");
						}
					});
				}
			});
			
			$("#reset").click(function(){
				$("#ff").form("disableValidation");
				$("#ff").form("reset");
			});
		});
     </script>

  </head>
  
  <body>
  	<form id="ff" method="post">
  		
	  		<input type="hidden" name="id"/>
	  		<div>
	  			<label for="name">商家用户名</label>
	  			<input type="text" id="name" name="name"/>
	  		</div>
	  		 <div>
	  			<label for="password">商家密码</label>
	  			<input type="text" id="password" name="password"/>
	  		</div>
	  		 <div>
	  			<label for="company_name">商家公司名称</label>
	  			<input type="text" id="company_name" name="company_name"/>
	  		</div>
	  		
			<div>
				<a id="submit" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">更新</a>
	    	 		<a id="reset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">重置</a>  
			</div>
  	</form>
  </body>
</html>
