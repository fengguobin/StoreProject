package cn.it.store.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.it.store.entity.Cart;
import cn.it.store.entity.Product;
import cn.it.store.service.IProductService;
import cn.it.store.service.impl.ProductServiceImpl;


public class CartServlet extends BaseServlet {
	private IProductService productService=new ProductServiceImpl();
	public String addCartItem(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//获得商品id和数量
		String product_id = request.getParameter("product_id");
		String count = request.getParameter("count");
		//获得session域对象
		HttpSession session = request.getSession();
		if(product_id!=null&&count!=null)
		{
			try {
				//获得商品对象
				Product product = productService.getById(Integer.parseInt(product_id));
				Cart cart= (Cart) session.getAttribute("cart");
				if(cart==null)
				{
					cart=new Cart();
				}
				cart.addCartItem(product, count);
				System.out.println(cart.getCartTotalPrice());
				session.setAttribute("cart", cart);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				throw new RuntimeException(e);
			}
		}
		//重定向回cart.jsp页面
		response.sendRedirect(request.getContextPath()+"/portal/cart.jsp");
		return null;
	}
	
	//清空购物车项
	public String clearCart(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Cart cart=new Cart();
		session.setAttribute("cart", cart);
		response.sendRedirect(request.getContextPath()+"/portal/cart.jsp");
		return super.execute(request, response);
	}
	
	//移除购物车中的购物车项
	public String removeCartItem(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Cart cart=(Cart) session.getAttribute("cart");
		String product_id = request.getParameter("product_id");
		if(cart!=null&&product_id!=null)
		{
			cart.removeCartItem(product_id);
		}
		session.setAttribute("cart", cart);
		response.sendRedirect(request.getContextPath()+"/portal/cart.jsp");
		return null;
	}
}
