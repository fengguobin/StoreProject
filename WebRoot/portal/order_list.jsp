<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员登录</title>
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
</style>

</head>
<body>


	<!-- 引入header.jsp -->
	<jsp:include page="/header.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<div style="margin: 0 auto; margin-top: 10px; width: 950px;">
				<strong>我的订单</strong>
					<!-- 每个订单项一份表单 -->
					<c:forEach items="${orderList}" var="order">
						<form action="${store}/OrderServlet?method=confirmOrder&id=${order.id}&state=20" method="post" onsubmit="confirm('确认收货?')">
						<table class="table table-bordered">
									<tr class="success">
										<th colspan="5">订单编号:${order.id}</th>
									</tr>
									<tr class="success">
										<td colspan="5">订单总价钱:${order.totalPrice}</td>
									</tr>
									<tr class="success">
										<c:choose>
											<c:when test="${order.state==0}">
												<td colspan="5">订单状态:未发货</td>
											</c:when>
											<c:when test="${order.state==10}">
												<td colspan="5">订单状态:已发货</td>
											</c:when>
											<c:when test="${order.state==20}">
												<td colspan="5">订单状态:交易完成</td>
											</c:when>
										</c:choose>
									</tr>
									<!-- 如果订单是已发货的状态 给用户一个可以确定收货的按钮 -->
									<c:if test="${order.state==10}">
										<tr class="success">
											<td colspan="5"><input id="1" type="submit" value="确认收货" onclick="confirmOrder()"></td>
										</tr>
									</c:if>
									<tr class="warning">
										<th>图片</th>
										<th>商品</th>
										<th>价格</th>
										<th>数量</th>
										<th>小计</th>
									</tr>
									<c:forEach items="${order.orderItems}" var="orderItem">
										<tr class="active">
											<td width="60" width="40%"><input type="hidden" name="id" value="22"> 
												<img src="${store}/productimages/${orderItem.product_img}" width="70"height="60">
											</td>
											<td width="30%"><a target="_blank">${orderItem.product_name}</a></td>
											<td width="20%">￥${orderItem.product_price}</td>
											<td width="10%">${orderItem.count}</td>
											<td width="15%"><span class="subtotal">￥${orderItem.itemTotalPrice}</span></td>
										</tr>
									</c:forEach>
						</table>
						</form>
					</c:forEach>
			</div>
		</div>
	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>
	
</body>

</html>