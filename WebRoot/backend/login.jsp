<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>后台系统登录页面</title>
<STYLE TYPE="text/css">
BODY {
background-repeat: no-repeat;
background-size:100% 100%;  
}
form table{
	margin:200 auto;
}
</STYLE>
  </head>

<body background="/StoreProject/background.jpg" >
	<form action="${pageContext.request.contextPath}/BackEndLoginServlet" method="post">
			<table align="center">
				<tr>
					<td>用户名:</td>
					<td><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input type="password" name="password"/></td>
				</tr>
				<tr>
					<td>登录角色选择:</td>
					<td>
						
						<label for="account">管理员</label>
						<input id="account" type="radio" name="role" value="account"/>
						<label for="company">商家</label>
						<input id="company" type="radio" name="role" value="company"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="登录"/></td>
				</tr>
				<tr>
					<td colspan="2">
						${msg}
					</td>
				</tr>
				
			</table>
	</form>
</body>  
</html>
