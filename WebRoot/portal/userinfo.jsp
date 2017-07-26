<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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



<script type="text/javascript">
	
	//自定义校验规则
	$.validator.addMethod(
		//规则的名称
		"checkUsername",
		//校验的函数
		function(value,element,params){
			//定义一个标志
			var flag = false;
			
			//value:输入的内容
			//element:被校验的元素对象
			//params：规则对应的参数值
			//目的：对输入的username进行ajax校验
			$.ajax({
				"async":false,
				"url":"${pageContext.request.contextPath}/UserServlet?method=checkUserName",
				"data":{"username":value},
				"type":"POST",
				"dataType":"json",
				"success":function(data){
				flag = data.isExist;
				}
			});
			//返回false代表该校验器不通过
			return !flag;
		}
		
	);


	$(function(){
		$("#myform").validate({
			//禁止输入停止输入键后就认证,发送多条ajax请求
			onkeyup:false,
			rules:{
				"username":{
					"required":true,
					"checkUsername":true
				},
				"password":{
					"required":true,
					"rangelength":[6,12]
				},
				"repassword":{
					"required":true,
					"rangelength":[6,12],
					"equalTo":"#password"
				},
				"email":{
					"required":true,
					"email":true
				},
				"sex":{
					"required":true
				}
			},
			messages:{
				"username":{
					"required":"用户名不能为空",
					"checkUsername":"用户名已存在"
				},
				"password":{
					"required":"密码不能为空",
					"rangelength":"密码长度6-12位"
				},
				"repassword":{
					"required":"密码不能为空",
					"rangelength":"密码长度6-12位",
					"equalTo":"两次密码不一致"
				},
				"email":{
					"required":"邮箱不能为空",
					"email":"邮箱格式不正确"
				}
			}
		});
	});

</script>

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
				<font>个人信息</font>USER INFO
				<form id="myform" class="form-horizontal" action="${store}/UserServlet?method=getUserInfo" method="post" style="margin-top: 5px;">
					<input type="hidden" name="uid" value="${loginUser.uid}"/>
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-6">
								${loginUser.username}
						</div>
					</div>
					
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-6">
							${loginUser.email}
						</div>
					</div>
					
										
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">Telephone</label>
						<div class="col-sm-6">
							${loginUser.telephone}
						</div>
					</div>
					
					<div class="form-group">
						<label for="usercaption" class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-6">
								${loginUser.name}
						</div>
					</div>
					<div class="form-group opt">
						<label for="inlineRadio1" class="col-sm-2 control-label">性别</label>
							<c:choose>
								<c:when test="${loginUser.sex=='male'}">
									<div class="col-sm-6">
										男
									</div>
								</c:when>
								<c:otherwise>
									<div class="col-sm-6">
										女
									</div>
								</c:otherwise>
							</c:choose>
					</div>
					<div class="form-group">
						<label for="date" class="col-sm-2 control-label">出生日期</label>
						<div class="col-sm-6">
							<fmt:formatDate type="date" value="${loginUser.birthday}"/>
						</div>
					</div>


					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" width="100" value="更改个人信息" name="submit"
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




