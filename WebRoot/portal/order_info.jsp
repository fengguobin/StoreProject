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

<script type="text/javascript">
	function confirmOrder(){
		//提交表单
		$("#orderForm").submit();
	}
</script>
</head>

<body>
	<!-- 引入header.jsp -->
	<jsp:include page="/header.jsp"></jsp:include>
	
	<div class="container">
		<div class="row">
			<div style="margin: 0 auto; margin-top: 10px; width: 950px;">
				<strong>订单详情</strong>
				<table class="table table-bordered">
					<tbody>
						<tr class="warning">
							<th>图片</th>
							<th>商品</th>
							<th>价格</th>
							<th>数量</th>
							<th>小计</th>
						</tr>
						<c:forEach items="${cart.cartItems}" var="cartItem">
							<tr class="active">
								<td width="60" width="40%"><input type="hidden" name="id" value="22"> 
									<img src="${store}/productimages/${cartItem.product.img}" width="70" height="60">
								</td>
								<td width="30%"><a target="_blank">${cartItem.product.name}</a></td>
								<td width="20%">￥${cartItem.product.xprice}</td>
								<td width="10%">${cartItem.count}</td>
								<td width="15%"><span class="subtotal">￥${cartItem.itemTotalPrice}</span></td>
							</tr>
						</c:forEach>
						<%-- 
							<tr class="active">
								<td width="60" width="40%"><input type="hidden" name="id"
									value="22"> <img src="${store}/image/dadonggua.jpg" width="70"
									height="60"></td>
								<td width="30%"><a target="_blank"> 有机蔬菜 大冬瓜...</a></td>
								<td width="20%">￥298.00</td>
								<td width="10%">5</td>
								<td width="15%"><span class="subtotal">￥596.00</span></td>
							</tr> --%>
					</tbody>
				</table>
			</div>

			<div style="text-align: right; margin-right: 120px;">
				商品金额: <strong style="color: #ff6600;">￥${cart.cartTotalPrice }</strong>
			</div>

		</div>

		<div>
			<hr />
			<form class="form-horizontal" id="orderForm" style="margin-top: 5px; margin-left: 150px;" method="post"
			action="${store}/OrderServlet?method=addOrder">
				<input type="hidden" value="${loginUser.uid}" name="userid">
				<div class="form-group">
					<label for="username" class="col-sm-1 control-label">地址</label>
					<div class="col-sm-5">
						<input type="text" class="form-control"  placeholder="请输入收货地址" name="address">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword3" class="col-sm-1 control-label">收货人</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" placeholder="请输收货人" name="name" value="${loginUser.name}">
					</div>
				</div>
				<div class="form-group">
					<label for="confirmpwd" class="col-sm-1 control-label" >电话</label>
					<div class="col-sm-5">
						<input type="text" class="form-control"  placeholder="请输入联系方式" name="telephone" value="${loginUser.telephone}">
					</div>
				</div>
			</form>

			<hr/>

			<div style="margin-top: 5px; margin-left: 150px;">
				<p style="text-align: right; margin-right: 100px;">
					<a href="javascript:void(0)" onclick="confirmOrder()">
						<img src="${store}/img/finalbutton.gif" width="204" height="51"
						border="0" />
					</a>
				</p>
				<hr/>
			</div>
		</div>

	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>

</body>

</html>