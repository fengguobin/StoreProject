<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>商品列表</title>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="${store}/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="${store}/css/style.css" type="text/css" />

<script src="${store}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="${store}/js/bootstrap.min.js" type="text/javascript"></script>

<style>
body {
	margin-top: 20px;
	margin: 0 auto;
	width: 100%;
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


	<div class="row" style="width: 1210px; margin: 0 auto;">
		<div class="col-md-12">
			<ol class="breadcrumb">
				<c:choose>
					<c:when test="${not empty productSW}">
						<li>搜索结果</li>
					</c:when>
					<c:when test="${pageBean.data[0].category_id==1}">
						<li>手机通信</li>
					</c:when>
					<c:when test="${pageBean.data[0].category_id==2}">
						<li>手机配件</li>
					</c:when>
					<c:when test="${pageBean.data[0].category_id==3}">
						<li>电脑配件</li>
					</c:when>
				</c:choose>
			</ol>
		</div>

<!-- 		<div class="col-md-2">
			<a href="product_info.htm"> <img src="products/1/cs10001.jpg"
				width="170" height="170" style="display: inline-block;">
			</a>
			<p>
				<a href="product_info.html" style='color: green'>冬瓜</a>
			</p>
			<p>
				<font color="#FF0000">商城价：&yen;299.00</font>
			</p>
		</div> -->
		
		<c:forEach items="${pageBean.data}" var="product">
			<div class="col-md-2">
			<a href="${store}/ProductServlet?method=getById&id=${product.id}"> <img src="/StoreProject/productimages/${product.img}"
				width="170" height="170" style="display: inline-block;">
			</a>
			<p>
				商品编号:${product.id}
			</p>
			<p>
				<a href="product_info.html" style='color: green'>${product.name }</a>
			</p>
			<p>
				<font color="#FF0000">商城价:&yen;${product.xprice}</font>
			</p>
		</div>
		</c:forEach>

	</div>

	<!--分页 -->
	<div style="width: 380px; margin: 0 auto; margin-top: 50px;">
		<ul class="pagination" style="text-align: center; margin-top: 10px;">
		
			<!-- 上一页 -->
			<!-- 判断当前页是否为第一页 -->
			<c:if test="${pageBean.currPage==1 }">
				<li class="disabled">
					<a href="javascript:void(0);" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
			</c:if>
			<c:if test="${pageBean.currPage!=1 }">
				<!-- 判断否有搜索字段 -->
				<c:choose>
					<c:when test="${not empty productSW}">
						<li>
							<a href="${store}/ProductServlet?method=getBySearchWord&searchWord=${productSW}&currPage=${pageBean.currPage-1 }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${store}/ProductServlet?method=getByCid&category_id=${pageBean.data[0].category_id}&currPage=${pageBean.currPage-1 }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:if>
			
		
			<!-- 显示每一页 -->
			<c:forEach begin="1" end="${pageBean.totalPage}" var="page">
				<!-- 判断是否是当前页 -->
				<c:if test="${page==pageBean.currPage }">
					<li class="active"><a href="javascript:void(0);">${page }</a></li>
				</c:if>
				<c:if test="${page!=pageBean.currPage }">
					<c:choose>
						<c:when test="${not empty productSW}">
								<li><a href="${store}/ProductServlet?method=getBySearchWord&searchWord=${productSW}&currPage=${page}">${page }</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${store}/ProductServlet?method=getByCid&category_id=${pageBean.data[0].category_id}&currPage=${page}">${page }</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
			
			
			<!-- 下一页 -->
			<c:if test="${pageBean.currPage==pageBean.totalPage }">
				<li class="disabled">
					<a href="javascript:void(0);" aria-label="Next"> 
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:if>
			<c:if test="${pageBean.currPage!=pageBean.totalPage }">
				<!-- 判断是否含有搜索关键字 -->
				<c:choose>
					<c:when test="${not empty productSW}">
						<li>
							<a href="${store}/ProductServlet?method=getBySearchWord&searchWord=${productSW}&currPage=${pageBean.currPage+1 }" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${store}/ProductServlet?method=getByCid&category_id=${pageBean.data[0].category_id}&currPage=${pageBean.currPage+1 }" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:if>
			
		</ul>
	</div>
	<!-- 分页结束 -->

	<!-- 引入footer.jsp -->
	<jsp:include page="/footer.jsp"></jsp:include>

</body>

</html>