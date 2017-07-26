package cn.it.store.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.it.store.dao.ICompanyDao;
import cn.it.store.entity.Account;
import cn.it.store.entity.Company;
import cn.it.store.util.MyJdbcUtils;

public class CompanyDaoImpl implements ICompanyDao{

	@Override
	public void save(Company company) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="insert into `company`(name,password,company_name) values(?,?,?)";
		qr.update(sql, company.getName(),company.getPassword(),company.getCompany_name());
	}

	@Override
	public void deleteById(int id) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Company company) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="update `company` set name=?,password=?,company_name=? where id=?";
		qr.update(sql, company.getName(),company.getPassword(),company.getCompany_name(),company.getId());
	}

	@Override
	public Company getById(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Company> queryCompany(int pageNumber,int size,String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select * from `company` limit?,?";
			return qr.query(sql, new BeanListHandler<Company>(Company.class),(pageNumber-1)*size,size);
		}else{
			searchWord="%"+searchWord+"%";
			sql="select * from `company` where company_name like ? limit?,?";
			return qr.query(sql, new BeanListHandler<Company>(Company.class),searchWord,(pageNumber-1)*size,size);
		}
	}
	
	@Override
	public int getCount(String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select count(1) from `company`";
			return ((Number)qr.query(sql, new ScalarHandler())).intValue();
		}else{
			searchWord="%"+searchWord+"%";
			sql="select count(1) from `company` where company_name like ?";
			return ((Number)qr.query(sql, new ScalarHandler(),searchWord)).intValue();
		}
	}
	
	@Override
	public int checkName(String name) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="select count(1) from `company` where name=?";
		return ((Number)qr.query(sql, new ScalarHandler(),name)).intValue();
	}
	
	@Override
	public int checkCompanyName(String name) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql="select count(1) from `company` where company_name=?";
		return ((Number)qr.query(sql, new ScalarHandler(),name)).intValue();
	}
	

	@Override
	public void deleteByIds(Connection conn,String ids) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner();
		String sql="delete from `company` where id in("+ids+")";
		qr.update(conn, sql);
	}

	@Override
	public Company login(String name, String password) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "select * from `company` where name=? and password=?";
		return runner.query(sql,new BeanHandler<Company>(Company.class),name,password);
	}
	
	public static void main(String[] args) throws SQLException {
		ICompanyDao dao=new CompanyDaoImpl();
		Company company = dao.login("xiaomi", "xiaomi");
		System.out.println(company);
	}
}
