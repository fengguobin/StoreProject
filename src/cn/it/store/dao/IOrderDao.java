package cn.it.store.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Order;
import cn.it.store.entity.OrderItem;


public interface IOrderDao {	
	public void save(Order order,Connection conn) throws SQLException ;
	public void save(OrderItem orderItem,Connection conn) throws SQLException ;
	public void deleteById(int id) throws SQLException;
	public void update(Order order) throws SQLException;
	public Order getById(int id) throws SQLException;
	public List<Order> getByUId(int id) throws SQLException;
	public List<OrderItem> getByOId(String orderId) throws SQLException;
	public void deleteByCompanyIds(Connection conn,String ids) throws SQLException;
	public List<Order> getByCId(String ids) throws SQLException;
	public void deleteOrderItem(Connection conn,String orderid) throws SQLException;
	
	//easyui用到的方法
	public List<Order> queryByCId(int pageNumber,int size,String searchWord,int companyId) throws SQLException;
	public int getCount(String searchWord,int companyId) throws SQLException;
	public void changeState(String orderId,int state) throws SQLException ;
}
