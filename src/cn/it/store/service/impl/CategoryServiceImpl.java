package cn.it.store.service.impl;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.dao.ICategoryDao;
import cn.it.store.dao.impl.CategoryDaoImpl;
import cn.it.store.entity.Category;
import cn.it.store.entity.User;
import cn.it.store.service.ICategoryService;

public class CategoryServiceImpl implements ICategoryService{
	private ICategoryDao categoryDao=new CategoryDaoImpl();

	@Override
	public void save(User user) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteById(int id) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(User user) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User getById(int id) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Category> getAll() throws SQLException {
		// TODO Auto-generated method stub
		return categoryDao.getAll();
	}


}
