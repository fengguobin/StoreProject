<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head></head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员注册</title>
<link rel="stylesheet" href="${store}/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="${store}/css/style.css" type="text/css" />
<script src="${store}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<!-- 引入表单校验jquery插件 -->
<script src="${store}/js/jquery.validate.min.js" type="text/javascript"></script>
<script src="${store}/js/bootstrap.min.js" type="text/javascript"></script>
<!-- 引入自定义css文件 style.css -->

<style>
body {
	margin-top: 20px;
	margin: 0 auto;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}

font {
	color: #3164af;
	font-size: 18px;
	font-weight: normal;
	padding: 0 10px;
}

.error{
	color:red
}
</style>

</head>
<body>

	<!-- 引入header.jsp -->
	<jsp:include page="/header.jsp"></jsp:include>

	<div class="container"
		style="width: 100%; background: url('${store}/image/regist_bg.jpg');">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8"
				style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
				<font>信息更新</font>INFO UPDATE
				<form id="myform" class="form-horizontal" action="${store}/UserServlet?method=portalUpdate" method="post" style="margin-top: 5px;">
					<input type="hidden" value="${recallUser.uid}" name="uid"/>
					<input type="hidden" value="${recallUser.username}" name="username"/>
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-6">
								${loginUser.username}
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" id="password" name="password" value="${recallUser.password}" placeholder="请输入密码">
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-6">
							<input type="email" class="form-control" id="inputEmail3" name="email"
								placeholder="Email" value="${recallUser.email }">
						</div>
					</div>
					<div class="form-group">
						<label for="usercaption" class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="usercaption" name="name"
								placeholder="请输入姓名" value="${recallUser.name }">
						</div>
					</div>
					
					<div class="form-group">
						<label for="usercaption" class="col-sm-2 control-label">电话</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="telephone" name="telephone"
								placeholder="请输入电话" value="${recallUser.telephone}">
						</div>
					</div>
					
					
					<div class="form-group opt">
						<label for="inlineRadio1" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-6">
							<!-- 根据返回的sex值回显男女选择按钮 -->
							<c:choose>
								<c:when test="${recallUser.sex=='male'}">
									<label class="radio-inline"> 
										<input type="radio" name="sex" id="sex1" value="male" checked="checked">男
									</label>
									<label class="radio-inline"> 
										<input type="radio" name="sex" id="sex2" value="female">女
									</label> 
								</c:when>
								
								<c:otherwise>
									<label class="radio-inline"> 
										<input type="radio" name="sex" id="sex1" value="male">男
									</label>
									<label class="radio-inline"> 
										<input type="radio" name="sex" id="sex2" value="female" checked="checked">女
									</label>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					
					<div class="form-group">
						<label for="date" class="col-sm-2 control-label">出生日期</label>
						<div class="col-sm-6">
							<input type="date" class="form-control" name="birthday" value="${recallUser.birthday}">
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" width="100" value="更新" name="submit"
								style="background: url('${store}/img/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0); height: 35px; width: 100px; color: white;">
						</div>
					</div>
				</form>
			</div>

			<div class="col-md-2"></div>

		</div>
	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>

</body>
</html>




