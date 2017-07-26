package cn.it.store.service;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Order;
import cn.it.store.entity.OrderItem;

public interface IOrderService {
	public List<Order> getOrdersByUid(int userid) throws SQLException;
	public void save(Order order)throws SQLException;
	
	//easyui用到的
	public List<Order> queryByCId(int pageNumber,int size,String searchWord,int companyId) throws SQLException;
	public int getCount(String searchWord,int companyId) throws SQLException;
	public void changeState(String orderId,int state) throws SQLException ;
	public List<OrderItem> getByOId(String orderId) throws SQLException;
}
