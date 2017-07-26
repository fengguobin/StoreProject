package cn.it.store.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.it.store.dao.IOrderDao;
import cn.it.store.entity.Company;
import cn.it.store.entity.Order;
import cn.it.store.entity.OrderItem;
import cn.it.store.util.CommonsUtils;
import cn.it.store.util.MyJdbcUtils;

public class OrderDaoImpl implements IOrderDao {


	@Override
	public void deleteById(int id) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(Order order) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public Order getById(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
	public void save(Order order,Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		conn.setAutoCommit(false);
		String sql="insert into `order`(id,totalPrice,state,address,name,telephone,user_id,company_id) values(?,?,?,?,?,?,?,?)";
		QueryRunner qr=new QueryRunner();
		Object[] parms=new Object[]{order.getId(),order.getTotalPrice(),
				order.getState(),order.getAddress(),order.getName(),order.getTelephone(),order.getUser_id(),order.getCompany_id()};
		qr.update(conn, sql, parms);
	}
	
	public void save(OrderItem orderItem,Connection conn) throws SQLException {
		conn.setAutoCommit(false);
		String sql="insert into `orderitem`(product_name,product_price,product_img,count,itemTotalPrice,order_id) values(?,?,?,?,?,?)";
		QueryRunner qr=new QueryRunner();
		Object[] parms=new Object[]{orderItem.getProduct_name(),orderItem.getProduct_price(),orderItem.getProduct_img(),
									orderItem.getCount(),orderItem.getItemTotalPrice(),orderItem.getOrder_id()};
		qr.update(conn, sql, parms);
	}
	
	@Override
	public List<Order> getByUId(int userid) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="select * from `order` where user_id=?";
		return qr.query(sql, new BeanListHandler<Order>(Order.class),userid);
	}
	
	@Override
	public List<OrderItem> getByOId(String id) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="select * from `orderitem` where order_id=?";
		return qr.query(sql, new BeanListHandler<OrderItem>(OrderItem.class),id);
	}

	@Override
	public void deleteByCompanyIds(Connection conn, String ids) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner();
		String sql="delete from `order` where company_id in ( "+ids+" )";
		qr.update(conn,sql);
	}

	@Override
	public List<Order> getByCId(String ids) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="select * from `order` where company_id in ("+ids+")";
		return qr.query(sql, new BeanListHandler<Order>(Order.class));
	}

	@Override
	public void deleteOrderItem(Connection conn, String orderid) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner();
		String sql="delete from `orderitem` where order_id=?";
		qr.update(conn, sql,orderid);
	}
	
	//easyui使用的两个方法
	@Override
	public List<Order> queryByCId(int pageNumber, int size, String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select * from `order` where company_id=? limit?,?";
			return qr.query(sql, new BeanListHandler<Order>(Order.class),companyId,(pageNumber-1)*size,size);
		}else{
			searchWord="%"+searchWord+"%";
			sql="select * from `order` where company_id=? and name like ? limit?,?";
			return qr.query(sql, new BeanListHandler<Order>(Order.class),companyId,searchWord,(pageNumber-1)*size,size);
		}
	}
	
	@Override
	public int getCount(String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select count(1) from `order` where company_id=?";
			return ((Number)qr.query(sql, new ScalarHandler(),companyId)).intValue();
		}else{
			searchWord="%"+searchWord+"%";
			sql="select count(1) from `order` where company_id=? and name like ?";
			return ((Number)qr.query(sql, new ScalarHandler(),companyId,searchWord)).intValue();
		}
	}
	
	@Override
	public void changeState(String orderId, int state) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="update `order` set state=? where id=?";
		qr.update(sql, state,orderId);
	}
	
	public static void main(String[] args) throws SQLException {
		IOrderDao dao=new OrderDaoImpl();
		List<Order> orders = dao.queryByCId(1, 2, "", 3);
		System.out.println(dao.getCount("", 3));
		System.out.println(orders);
	}



}
