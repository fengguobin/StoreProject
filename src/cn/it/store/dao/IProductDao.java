package cn.it.store.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Category;
import cn.it.store.entity.Product;

public interface IProductDao {
	public void save(Product product) throws SQLException ;
	public void deleteById(int id) throws SQLException;
	public void update(Product product) throws SQLException;
	public Product getById(int id) throws SQLException;
	public List<Product> getAll() throws SQLException;
	public List<Product> getByHot() throws SQLException;
	public List<Product> getByNew() throws SQLException;
	public List<Product> getByCid(int cid,int index,int size) throws SQLException;
	public int getCountByCid(int cid) throws SQLException;
	public void deleteByCompanyIds(Connection conn,String ids) throws SQLException;
	//前台搜索用到的方法
	public int getCountBySearchWord(String searchWord) throws SQLException;
	public List<Product> getBySearchWord(String searchWord,int index,int size) throws SQLException;
	
	
	//下面是easyui用的方法
	public List<Product> queryByCId(int pageNumber,int size,String searchWord,int companyId) throws SQLException;
	public int getCount(String searchWord,int companyId) throws SQLException;
	public List<Category> queryCategory() throws SQLException;
	public void deleteByIds(String ids) throws SQLException;
}
