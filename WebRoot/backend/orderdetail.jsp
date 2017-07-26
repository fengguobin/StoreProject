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
    
	<script type="text/javascript">
		$(function(){
			//数据回显
			var row=parent.$("iframe[title='订单管理']").get(0).contentWindow.$("#dg").datagrid("getSelections")[0];
			$("#totalPrice").html(row.totalPrice);
			
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
	  	<table align="center" border=1 cellspacing="0" cellpadding="0">
	  		<tr align="center">
	  			<td><strong>商品名称</strong></td>
	  			<td><strong>商品价钱</strong></td>
	  			<td><strong>商品数量</strong></td>
	  		</tr>
	  		<c:forEach items="${bOrderItems}" var="orderitem">
	  			<tr align="center">
	  				<td>${orderitem.product_name}</td>
	  				<td>${orderitem.product_price}</td>
	  				<td>${orderitem.count}</td>
	  			</tr>
	  		</c:forEach>
  			<tr align="center">
  				<td>订单总价钱:</td>
  				<td colspan="2" id="totalPrice"></td>
  			</tr>
	  	</table>
  	</form>
  </body>
</html>
