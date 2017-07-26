package cn.it.store.service;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Company;

public interface ICompanyService {
	public void save(Company company) throws SQLException ;
	public void deleteByIds(String ids) throws SQLException ;
	public void update(Company company) throws SQLException;
	public Company getById(int id) throws SQLException;
	public List<Company> queryCompany(int pageNumber,int size,String searchWord) throws SQLException;
	public int getCount(String searchWord) throws SQLException;
	public boolean checkName(String name) throws SQLException;
	public boolean checkCompanyName(String name) throws SQLException;

}
