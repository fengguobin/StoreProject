package cn.it.store.service;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Category;
import cn.it.store.entity.Order;
import cn.it.store.entity.PageBean;
import cn.it.store.entity.Product;
import cn.it.store.entity.User;

public interface IProductService {
	public void save(Product product) throws SQLException ;
	public void deleteById(int id) throws SQLException;
	public void update(Product product) throws SQLException;
	public Product getById(int id) throws SQLException;
	public List<Product> getAll() throws SQLException;
	public List<Product> getByHot() throws SQLException;
	public List<Product> getByNew() throws SQLException;
	//前台返回数据用的
	public void getByCid(int cid,PageBean<Product> pagebean) throws SQLException;
	public void getBySearchWord(String searchWord,PageBean<Product> pagebean) throws SQLException;
	//easyui返回数据给后台用的
	public List<Product> queryByCId(int pageNumber,int size,String searchWord,int companyId) throws SQLException;
	public int getCount(String searchWord,int companyId) throws SQLException;
	public List<Category> queryCategory() throws SQLException;
	public void deleteByIds(String ids) throws SQLException;
}
