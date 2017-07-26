<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
<script src="${store}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<!DOCTYPE html>
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