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
<!-- 头部导航页面 -->
<!-- 登录 注册 购物车... -->
<div class="container-fluid">
	<div class="col-md-4">
		<c:if test="${not empty loginUser}">
			<ol class="list-inline">
				<li>欢迎你,亲爱的顾客<em>${loginUser.username}</em></li>
			</ol>
		</c:if>
	</div>
	<div class="col-md-5">
		<img src="${store}/img/header.png" />
	</div>
	<div class="col-md-3" style="padding-top:20px">
			<c:choose>
				<c:when test="${not empty loginUser}">
						<ol class="list-inline">
							<li><a href="${store}/portal/cart.jsp">购物车</a></li>
							<li><a href="${store}/OrderServlet?method=getOrderList&userid=${loginUser.uid}">我的订单</a></li>
							<li><a href="${store}/portal/userinfo.jsp">个人信息</a></li>
							<li><a href="${store}/UserServlet?method=loginOut">退出登录</a></li>
						</ol>
				</c:when>
				<c:otherwise>
					<ol class="list-inline">
							<li><a href="${store}/portal/login.jsp">登录</a></li>
							<li><a href="${store}/portal/register.jsp">注册</a></li>
					</ol>
				</c:otherwise>
			</c:choose>
	</div>
</div>
<!-- 导航条 -->
<div class="container-fluid">
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${store}/index.jsp">首页</a>
			</div>
			
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<!-- 通过监听器来初始化数据 -->
					<c:forEach items="${applicationScope.categoryList}" var="category">
						<li><a href="${store}/ProductServlet?method=getByCid&category_id=${category.id}">${category.name}</a></li>
					</c:forEach>
					
					<%-- <li class="active"><a href="${store}/portal/product_list.jsp">手机数码</a></li>
					<li><a href="${store}/p">电脑办公</a></li>
					<li><a href="#">电脑办公</a></li>
					<li><a href="#">电脑办公</a></li> --%>
				</ul>
				
				
				<script type="text/javascript">
					$(function(){
						$("#search").click(function(){
							var searchWord=$("#searchWord").val();
							$("#form").attr("action","${store}/ProductServlet?method=getBySearchWord&searchWord="+searchWord);
							$("#form").submit();
						});
					});
				</script>
				
				
				<form id="form" class="navbar-form navbar-right" method="post" action=" ">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="请输入要搜索的商品名字" id="searchWord" value="${productSW}">
					</div>
					<button class="btn btn-default" id="search" type="submit" >Submit</button>
				</form>
			</div>
		</div>
	</nav>
</div>


	<div class="container"
		style="width: 100%; background: url('${store}/image/regist_bg.jpg');">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8"
				style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
				<font>会员注册</font>USER REGISTER
				<form id="myform" class="form-horizontal" action="${store}/UserServlet?method=register" method="post" style="margin-top: 5px;">
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="username" name="username"
								placeholder="请输入用户名">
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" id="password" name="password"
								placeholder="请输入密码">
						</div>
					</div>
					<div class="form-group">
						<label for="confirmpwd" class="col-sm-2 control-label">确认密码</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" id="confirmpwd" name="repassword"
								placeholder="请输入确认密码">
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-6">
							<input type="email" class="form-control" id="inputEmail3" name="email"
								placeholder="Email">
						</div>
					</div>
					<div class="form-group">
						<label for="usercaption" class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="usercaption" name="name"
								placeholder="请输入姓名">
						</div>
					</div>
					<div class="form-group">
						<label for="usercaption" class="col-sm-2 control-label">电话</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="usercaption" name="telephone"
								placeholder="请输入用户电话">
						</div>
					</div>
					
					
					<div class="form-group opt">
						<label for="inlineRadio1" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-6">
							<label class="radio-inline"> 
								<input type="radio" name="sex" id="sex1" value="male" >男
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="sex" id="sex2" value="female">女
							</label>
							<label class="error" for="sex" style="display:none ">性别选择为空</label>
						</div>
					</div>
					<div class="form-group">
						<label for="date" class="col-sm-2 control-label">出生日期</label>
						<div class="col-sm-6">
							<input type="date" class="form-control" name="birthday">
						</div>
					</div>


					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" width="100" value="注册" name="submit"
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




