package cn.it.store.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import cn.it.store.dao.ICompanyDao;
import cn.it.store.dao.IOrderDao;
import cn.it.store.dao.IProductDao;
import cn.it.store.dao.impl.CompanyDaoImpl;
import cn.it.store.dao.impl.OrderDaoImpl;
import cn.it.store.dao.impl.ProductDaoImpl;
import cn.it.store.entity.Company;
import cn.it.store.entity.Order;
import cn.it.store.service.ICompanyService;
import cn.it.store.util.MyJdbcUtils;

public class CompanyServiceImpl implements ICompanyService {
	ICompanyDao companyDao=new CompanyDaoImpl();
	IOrderDao orderDao=new OrderDaoImpl();
	IProductDao productDao=new ProductDaoImpl();
	@Override
	public void save(Company company) throws SQLException {
		// TODO Auto-generated method stub
		companyDao.save(company);
	}

	@Override
	public void deleteByIds(String ids) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = MyJdbcUtils.getConnection();
		conn.setAutoCommit(false);
		try {
			List<Order> orders = orderDao.getByCId(ids);
			if(!orders.isEmpty()){
				for(Order order:orders)
				{
					orderDao.deleteOrderItem(conn, order.getId());
				}
				orderDao.deleteByCompanyIds(conn, ids);
			}
			productDao.deleteByCompanyIds(conn, ids);
			companyDao.deleteByIds(conn, ids);
			conn.commit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			conn.rollback();
			e.printStackTrace();
		}finally{
			conn.close();
		}
	}

	@Override
	public void update(Company company) throws SQLException {
		// TODO Auto-generated method stub
		companyDao.update(company);
	}

	@Override
	public Company getById(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Company> queryCompany(int pageNumber, int size,String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		return companyDao.queryCompany(pageNumber, size,searchWord);
	}

	@Override
	public int getCount(String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		return companyDao.getCount(searchWord);
	}

	@Override
	public boolean checkName(String name) throws SQLException {
		// TODO Auto-generated method stub
		return companyDao.checkName(name)>0?true:false;
	}

	@Override
	public boolean checkCompanyName(String name) throws SQLException {
		// TODO Auto-generated method stub
		return companyDao.checkCompanyName(name)>0?true:false;
	}

}
