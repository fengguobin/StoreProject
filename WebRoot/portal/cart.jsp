<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>商城购物车</title>
	<!-- 引入自定义css文件 style.css -->
	<link rel="stylesheet" href="${store}/css/style.css" type="text/css" />
	<link rel="stylesheet" href="${store}/css/bootstrap.min.css" type="text/css" />
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
		
		font {
			color: #3164af;
			font-size: 18px;
			font-weight: normal;
			padding: 0 10px;
		}
	</style>
</head>

	<body>
		<!-- 引入header.jsp -->
		<jsp:include page="/header.jsp"></jsp:include>

		<div class="container">
			<div class="row">

				<div style="margin:0 auto; margin-top:10px;width:950px;">
					<strong style="font-size:16px;margin:5px 0;">购物车详情</strong>
					<table class="table table-bordered">
						<tbody>
							<tr class="warning">
								<th>图片</th>
								<th>商品</th>
								<th>价格</th>
								<th>数量</th>
								<th>小计</th>
								<th>操作</th>
							</tr>
<%-- 							<tr class="active">
								<td width="60" width="40%">
									<input type="hidden" name="id" value="22">
									<img src="${store}/image/dadonggua.jpg" width="70" height="60">
								</td>
								<td width="30%">
									<a target="_blank"> 有机蔬菜      大冬瓜...</a>
								</td>
								<td width="20%">
									￥298.00
								</td>
								<td width="10%">
									<input type="text" name="quantity" value="1" maxlength="4" size="10">
								</td>
								<td width="15%">
									<span class="subtotal">￥596.00</span>
								</td>
								<td>
									<a href="javascript:;" class="delete">删除</a>
								</td>
							</tr> --%>
							 
							<c:forEach items="${cart.cartItems}" var="cartItem">
								<tr class="active">
									<td width="60" width="40%">
										<input type="hidden" name="id" value="22">
										<img src="${store}/productimages/${cartItem.product.img}" width="70" height="60">
									</td>
									<td width="30%">
										<a target="_blank">${cartItem.product.name}</a>
									</td>
									<td width="20%">
										¥ ${cartItem.product.xprice}
									</td>
									<td width="10%">
										<input type="text" name="quantity" value="${cartItem.count}" maxlength="4" size="10">
									</td>
									<td width="15%">
										<span class="subtotal">¥ ${cartItem.itemTotalPrice}</span>
									</td>
									<td>
										<a href="${store}/CartServlet?method=removeCartItem&product_id=${cartItem.product.id}" class="delete">删除</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div style="margin-right:130px;">
				<div style="text-align:right;">
					商品金额: <strong style="color:#ff6600;">¥ ${cart.cartTotalPrice}</strong>
				</div>
				<div style="text-align:right;margin-top:10px;margin-bottom:10px;">
					<a href="${store}/CartServlet?method=clearCart" id="clear" class="clear">清空购物车</a>
					<a href="${store}/portal/order_info.jsp">
						<input type="submit" width="100" value="提交订单" name="submit" border="0" style="background: url('${store}/img/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
						height:35px;width:100px;color:white;">
					</a>
				</div>
			</div>

		</div>

		<!-- 引入footer.jsp -->
		<jsp:include page="/footer.jsp"></jsp:include>

	</body>

</html>