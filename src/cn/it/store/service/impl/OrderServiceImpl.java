package cn.it.store.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import cn.it.store.dao.IOrderDao;
import cn.it.store.dao.impl.OrderDaoImpl;
import cn.it.store.entity.Order;
import cn.it.store.entity.OrderItem;
import cn.it.store.service.IOrderService;
import cn.it.store.util.MyJdbcUtils;

public class OrderServiceImpl implements IOrderService {
	IOrderDao orderDao=new OrderDaoImpl();
	@Override
	public void save(Order order) throws SQLException{
		// TODO Auto-generated method stub
		IOrderDao orderDao=new OrderDaoImpl();
		Connection conn = MyJdbcUtils.getConnection();
		try {
			List<OrderItem> orderItems = order.getOrderItems();
			if(!orderItems.isEmpty())
			{
				for(OrderItem orderItem:orderItems)
				{
					orderDao.save(orderItem,conn);
				}
				
			}
			orderDao.save(order, conn);
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}

	public List<Order> getOrdersByUid(int userid) throws SQLException {
		// TODO Auto-generated method stub
		List<Order> orders = orderDao.getByUId(userid);
		for(Order order:orders)
		{
			List<OrderItem> orderItem = orderDao.getByOId(order.getId());
			order.setOrderItems(orderItem);
		}
		return orders;
	}
	//easyui用到的
	@Override
	public List<Order> queryByCId(int pageNumber, int size, String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		return orderDao.queryByCId(pageNumber, size, searchWord, companyId);
	}

	@Override
	public int getCount(String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		return orderDao.getCount(searchWord, companyId);
	}

	@Override
	public void changeState(String orderId, int state) throws SQLException {
		// TODO Auto-generated method stub
		orderDao.changeState(orderId, state);
	}

	@Override
	public List<OrderItem> getByOId(String orderId) throws SQLException {
		// TODO Auto-generated method stub
		return orderDao.getByOId(orderId);
	}
}
