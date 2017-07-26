<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商城首页</title>
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
		<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
	</head>

	<body>
		<div class="container-fluid">

			<!-- 引入header.jsp -->
			<jsp:include page="/header.jsp"></jsp:include>

			<!-- 热门商品 -->
			<div class="container-fluid">
				<div class="col-md-12">
					<h2>热门商品&nbsp;&nbsp;<img src="img/title2.jpg"/></h2>
				</div>
				<div class="col-md-2" style="border:1px solid #E7E7E7;border-right:0;padding:0;">
					<img src="img/big01.jpg" width="205" height="404" style="display: inline-block;"/>
				</div>
				<div class="col-md-10">
					<div class="col-md-6" style="text-align:center;height:200px;padding:0px;">
							<img src="img/middle01.jpg" width="516px" height="200px" style="display: inline-block;">
					</div>
					
					<c:forEach items="${byHot}" var="product">
						<div class="col-md-2" style="text-align:center;height:200px;padding:10px 0px;">
							<a href="${store}/ProductServlet?method=getById&id=${product.id}">
								<img src="/StoreProject/productimages/${product.img}" width="130" height="130" style="display: inline-block;">
							</a>
							<p><a href="${store}/ProductServlet?method=getById&id=${product.id}" style='color:#666'>${product.name}</a></p>
							<p><font color="#E4393C" style="font-size:16px">&yen;${product.xprice}</font></p>
						</div>
					</c:forEach>
					
					
				<!-- 	<div class="col-md-2" style="text-align:center;height:200px;padding:10px 0px;">
						<a href="product_info.htm">
							<img src="products/hao/small03.jpg" width="130" height="130" style="display: inline-block;">
						</a>
						<p><a href="product_info.html" style='color:#666'>冬瓜</a></p>
						<p><font color="#E4393C" style="font-size:16px">&yen;299.00</font></p>
					</div> -->
	
				</div>
			</div>
			
			<!-- 广告条 -->
            <div class="container-fluid">
				<img src="img/ad.jpg" width="100%"/>
			</div>
			
			<!-- 最新商品 -->
			<div class="container-fluid">
				<div class="col-md-12">
					<h2>最新商品&nbsp;&nbsp;<img src="img/title2.jpg"/></h2>
				</div>
				<div class="col-md-2" style="border:1px solid #E7E7E7;border-right:0;padding:0;">
					<img src="img/big01.jpg" width="205" height="404" style="display: inline-block;"/>
				</div>
				<div class="col-md-10">
					<div class="col-md-6" style="text-align:center;height:200px;padding:0px;">
							<img src="img/middle01.jpg" width="516px" height="200px" style="display: inline-block;">
					</div>
					
					<c:forEach items="${byNew}" var="product">
						<div class="col-md-2" style="text-align:center;height:200px;padding:10px 0px;">
							<a href="${store}/ProductServlet?method=getById&id=${product.id}">
								<img src="/StoreProject/productimages/${product.img}" width="130" height="130" style="display: inline-block;">
							</a>
							<p><a href="${store}/ProductServlet?method=getById&id=${product.id}" style='color:#666'>${product.name}</a></p>
							<p><font color="#E4393C" style="font-size:16px">&yen;${product.xprice}</font></p>
						</div>
					</c:forEach>
	
				</div>
			</div>			
			
			<!-- 引入footer.jsp -->
			<jsp:include page="/footer.jsp"></jsp:include>
			
		</div>
	</body>

</html>