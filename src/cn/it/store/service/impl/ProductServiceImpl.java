package cn.it.store.service.impl;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.dao.IProductDao;
import cn.it.store.dao.impl.ProductDaoImpl;
import cn.it.store.entity.Category;
import cn.it.store.entity.PageBean;
import cn.it.store.entity.Product;
import cn.it.store.service.IProductService;

public class ProductServiceImpl implements IProductService {
	IProductDao productDao=new ProductDaoImpl();
	@Override
	public void save(Product product) throws SQLException {
		// TODO Auto-generated method stub
		productDao.save(product);
	}

	@Override
	public void deleteById(int id) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(Product product) throws SQLException {
		// TODO Auto-generated method stub
		productDao.update(product);
	}

	@Override
	public Product getById(int id) throws SQLException {
		// TODO Auto-generated method stub
		return productDao.getById(id);
	}

	@Override
	public List<Product> getAll() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> getByHot() throws SQLException {
		// TODO Auto-generated method stub
		return productDao.getByHot();
	}

	@Override
	public List<Product> getByNew() throws SQLException {
		// TODO Auto-generated method stub
		return productDao.getByNew();
	}

	@Override
	public void getByCid(int cid, PageBean<Product> pagebean)
			throws SQLException {
		// TODO Auto-generated method stub
		int count = productDao.getCountByCid(cid);
		pagebean.setTotalRecord(count);
		
		List<Product> byCid = productDao.getByCid(cid, pagebean.getStratIndex(), pagebean.getSize());
		
		pagebean.setData(byCid);
	}
	
	public void getBySearchWord(String searchWord, PageBean<Product> pagebean)
			throws SQLException {
		// TODO Auto-generated method stub
		int count = productDao.getCountBySearchWord(searchWord);
		pagebean.setTotalRecord(count);
		
		List<Product> bySearchWord = productDao.getBySearchWord(searchWord, pagebean.getStratIndex(), pagebean.getSize());
		
		pagebean.setData(bySearchWord);
	}

	@Override
	public List<Product> queryByCId(int pageNumber, int size, String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		return productDao.queryByCId(pageNumber, size, searchWord, companyId);
	}

	@Override
	public int getCount(String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		return productDao.getCount(searchWord, companyId);
	}

	@Override
	public List<Category> queryCategory() throws SQLException {
		// TODO Auto-generated method stub
		return productDao.queryCategory();
	}

	@Override
	public void deleteByIds(String ids) throws SQLException {
		// TODO Auto-generated method stub
		productDao.deleteByIds(ids);
	}
	
}
