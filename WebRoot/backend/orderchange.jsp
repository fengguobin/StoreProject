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
			var row=parent.$("iframe[title='订单管理']").get(0).contentWindow.$("#dg").datagrid("getSelections")[0];
			$("#ff").form("load",{
				id:row.id,
				state:row.state
			});
			
		 	
			  
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
						url:"${store}/OrderServlet?method=changeState",
						success:function()
						{
							parent.$("#win").window("close");
							parent.$("iframe[title='订单管理']").get(0).contentWindow.$("#dg").datagrid("reload");
						}
					});
				}
			});
		});
     </script>

  </head>
  
  <body>
  	<form id="ff" method="post">
  		
  		<input type="hidden" name="id"/>
  		<div>
  			订单状态:
  			<select name="state">
  				<option value="0">未发货</option>
  				<option value="10">已发货</option>
  				<option value="20">交易完成</option>
  			</select>
  		</div>
  		
		<div>
		      <a id="submit" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">更新订单状态</a>
		</div>
  	</form>
  </body>
</html>
