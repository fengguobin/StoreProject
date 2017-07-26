package cn.it.store.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import cn.it.store.entity.Cart;
import cn.it.store.entity.CartItem;
import cn.it.store.entity.Order;
import cn.it.store.entity.OrderItem;
import cn.it.store.entity.User;
import cn.it.store.service.IOrderService;
import cn.it.store.service.impl.OrderServiceImpl;
import cn.it.store.util.CommonsUtils;


public class OrderServlet extends BaseServlet {
	
	IOrderService orderService=new OrderServiceImpl();
	public String addOrder(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		//获得order属性
		String userid = request.getParameter("userid");
		String address = request.getParameter("address");
		String telephone = request.getParameter("telephone");
		String name=request.getParameter("name");
		
		
		if(cart!=null)
		{
			Set<Integer> companyIdset=new LinkedHashSet<Integer>();
			Collection<CartItem> cartItems = cart.getCartItems();
			//获得店铺id,根据为不同店铺的id建立不同的订单
			for(CartItem cartItem:cartItems)
			{
				int company_id = cartItem.getProduct().getCompany_id();
				companyIdset.add(company_id);
			}
			
			for(Integer companyId:companyIdset)
			{
				Order order=new Order();
				List<OrderItem> orderItemList = order.getOrderItems();
				//设置订单属性
				String orderId = CommonsUtils.getUUID();
				order.setId(orderId);
				order.setUser_id(Integer.parseInt(userid));
				order.setAddress(address);
				order.setTelephone(telephone);
				order.setName(name);
				order.setCompany_id(companyId);
				//在不同店铺id下为order设置orderItems
				for(CartItem cartItem:cartItems)
				{
					if(companyId.equals(cartItem.getProduct().getCompany_id()))
					{
						OrderItem orderItem=new OrderItem();
						orderItem.setOrder_id(orderId);
						orderItem.setProduct_name(cartItem.getProduct().getName());
						orderItem.setProduct_price(cartItem.getProduct().getXprice());
						orderItem.setProduct_img(cartItem.getProduct().getImg());
						orderItem.setCount(cartItem.getCount());
						orderItem.setItemTotalPrice(cartItem.getItemTotalPrice());
						orderItemList.add(orderItem);
					}
				}
				//保存订单
				orderService.save(order);
				//设置新的购物车对象
				Cart newCart=new Cart();
				session.setAttribute("cart",newCart);
			}
			response.sendRedirect(request.getContextPath()+"/OrderServlet?method=getOrderList&userid="+userid);
		}
		return null;
	}
	
	public String getOrderList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		IOrderService orderService=new OrderServiceImpl();
		HttpSession session = request.getSession();
		String userid = request.getParameter("userid");
		//根据用户Id获得订单列表
		if(userid!=null)
		{
			try {
				List<Order> orderList = orderService.getOrdersByUid(Integer.parseInt(userid));
				session.setAttribute("orderList", orderList);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//查询
		response.sendRedirect(request.getContextPath()+"/portal/order_list.jsp");
		return null;
	}
	
	//easyui填充数据的方法
	public String queryByCId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String size = request.getParameter("rows");
		String pageNumber=request.getParameter("page");
		String searchWord = request.getParameter("searchWord");
		String company_id=request.getParameter("company_id");
		int companyId=Integer.parseInt(company_id);
		//设置response格式
		response.setContentType("text/html;charset=utf-8");
		if(size!=null&&pageNumber!=null)
		{
			try {
				List<Order> OrderList = orderService.queryByCId(Integer.parseInt(pageNumber), Integer.parseInt(size),
										searchWord,companyId);
				JSONObject json=new JSONObject();
				JSONArray rows=new JSONArray();
				for(Order order:OrderList)
				{
					rows.put(new JSONObject(order));
				}
				//设置rows内容
				json.put("rows", rows);
				//设置total内容
				//设置total的内容
				int total = orderService.getCount(searchWord,companyId);
				json.put("total", total);
				response.getWriter().write(json.toString());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return super.execute(request, response);
	}
	
	
	public String changeState(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String orderId = request.getParameter("id");
		String state = request.getParameter("state");
		try {
			orderService.changeState(orderId, Integer.parseInt(state));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return super.execute(request, response);
	}
	
	//用户确认收货的方法
	public void confirmOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String orderId = request.getParameter("id");
		String state = request.getParameter("state");
		HttpSession session = request.getSession();
		User loginUser=(User) session.getAttribute("loginUser");
		int userid=loginUser.getUid();
		try {
			//改变订单状态
			orderService.changeState(orderId, Integer.parseInt(state));
			//跳转到订单页面
			List<Order> orderList = orderService.getOrdersByUid(userid);
			session.setAttribute("orderList", orderList);
			response.sendRedirect(request.getContextPath()+"/portal/order_list.jsp");
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public String orderDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		String orderId = request.getParameter("id");
		List<OrderItem> bOrderItems = orderService.getByOId(orderId);
		request.setAttribute("bOrderItems", bOrderItems);
		request.getRequestDispatcher("/backend/orderdetail.jsp").forward(request, response);
		return super.execute(request, response);
	}
}
