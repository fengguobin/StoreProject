<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员登录</title>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="${store}/css/style.css" type="text/css"/>
<link rel="stylesheet" href="${store}/css/bootstrap.min.css" type="text/css"/>
<script src="${store}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${store}/js/bootstrap.min.js" type="text/javascript"></script>

<style>
body {
	margin-top: 20px;
	margin: 0 auto;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}
</style>

<script type="text/javascript">
	function addCart(){
		//获得购买的商品的数量
		var count = $("#count").val();
		//跳转到CartServlet 要加入购物车的商品的id和数量
		location.href="${store}/CartServlet?method=addCartItem&product_id=${product.id}&count="+count;
	}
</script>
</head>

<body>
	<!-- 引入header.jsp -->
	<jsp:include page="/header.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			
			<!-- 商品照片 -->
			<div style="margin: 0 auto; width: 950px;">
				<div class="col-md-6">
					<img style="opacity: 1; width: 400px; height: 350px;" title=""class="medium"
						src="${store}/productimages/${product.img}">
				</div>
				
				<!-- 商品名字 -->		
				<div class="col-md-6">
					<div>
						<strong>${product.name}</strong>
					</div>
					<div
						style="border-bottom: 1px dotted #dddddd; width: 350px; margin: 10px 0 10px 0;">
						<div>商品编号:${product.id}</div>
					</div>

					<div style="margin: 10px 0 10px 0;">
						参考价:<del>￥${product.cprice}</del>&nbsp;&nbsp;
						现价:<strong style="color: #ef0101;">￥${product.xprice}</strong>
					</div>
					
					<div
						style="padding: 10px; border: 1px solid #e7dbb1; width: 330px; margin: 15px 0 10px 0;; background-color: #fffee6;">
						<div style="margin: 5px 0 10px 0;">白色</div>

						<div
							style="border-bottom: 1px solid #faeac7; margin-top: 20px; padding-left: 10px;">
							购买数量: <input id="count" name="count" value="1"
								maxlength="4" size="10" type="text">
						</div>

						<div style="margin: 20px 0 10px 0;; text-align: center;">
							<a href=javascript:void(0)" onclick="addCart()">
							<input
								style="background: url('${store}/images/product.gif') no-repeat scroll 0 -600px rgba(0, 0, 0, 0); height: 36px; width: 127px;"
								value="加入购物车" type="button"/>
							</a> &nbsp;收藏商品
						</div>
					</div>
				</div>
			</div>
			<div class="clear"></div>
			<div style="width: 950px; margin: 0 auto;">
				<div
					style="background-color: #d3d3d3; width: 930px; padding: 10px 10px; margin: 10px 0 10px 0;">
					<strong>商品介绍</strong>
				</div>
				<div>
					${product.desc}
				</div>

			</div>

		</div>
	</div>


	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>

</body>

</html>