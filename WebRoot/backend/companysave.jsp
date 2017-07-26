<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>添加商家</title>
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
			//新增自定义检查用户名的规则
			$.extend($.fn.validatebox.defaults.rules, 
			{
		   		 checkName: 
		   		 {
						validator:function(value,param)
						{
							var flag = false;
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
			   	},
			    equals: {
					validator: function(value,param){
						return value == $(param[0]).val();
					},
					message: '两次密码不一致'
			    }
			});
			
			
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
		 	
		 	$("#repassword").validatebox({
		 		required:true,
		 		missingMessage:"商家密码为空",
		 		validType:"equals['#password']",
		 	});
		 	
		 	$("#company_name").validatebox({
		 		required:true,
		 		missingMessage:"商家公司名称为空",
		 		validType:"checkCompanyName",
		 		//获得焦点1秒后验证,默认为0.2s
		 		delay:1000
		 	});

		 	
			$("#ff").form("disableValidation");
			$("#submit").click(function(){
				$("#ff").form("enableValidation");
				if($("#ff").form("validate"))
				{
					$("#ff").form("submit",{
						url:"${store}/CompanyServlet?method=save",
						success:function(){
							parent.$("#win").window("close");
							parent.$("iframe[title='商家管理']").get(0).contentWindow.$("#dg").datagrid("reload");
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
  	<form id="ff" method="post" >
  		<div>
  			<label for="name">商家用户名</label>
  			<input type="text" id="name" name="name"/>
  		</div>
  		 <div>
  			<label for="password">商家密码</label>
  			<input type="password" id="password" name="password"/>
  		</div>
  		 <div>
  			<label for="password">确认密码</label>
  			<input type="password" id="repassword" name="repassword"/>
  		</div>
  		 <div>
  			<label for="company_name">商家公司名称</label>
  			<input type="text" id="company_name" name="company_name"/>
  		</div>
  		
		<div>
		      <a id="submit" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
		      <a id="reset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">重置</a>   
		</div>
  	</form>
  </body>
</html>
