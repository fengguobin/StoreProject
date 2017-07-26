package cn.it.store.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Account;
import cn.it.store.entity.Company;

public interface ICompanyDao {
	public void save(Company company) throws SQLException ;
	public void deleteById(int id) throws SQLException;
	public void update(Company company) throws SQLException;
	public Company getById(int id) throws SQLException;
	
	//下面是后台easyui用的方法
	public List<Company> queryCompany(int pageNumber,int size,String searchWord) throws SQLException;
	public int getCount(String searchWord) throws SQLException;
	public int checkName(String name)  throws SQLException;
	public int checkCompanyName(String name)  throws SQLException;
	public void deleteByIds(Connection conn,String ids) throws SQLException;
	public Company login(String name,String password) throws SQLException;

}
