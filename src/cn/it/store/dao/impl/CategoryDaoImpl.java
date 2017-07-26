package cn.it.store.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.it.store.dao.ICategoryDao;
import cn.it.store.entity.Category;
import cn.it.store.entity.User;
import cn.it.store.util.MyJdbcUtils;

public class CategoryDaoImpl implements ICategoryDao {

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
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "select * from category";
		return runner.query(sql, new BeanListHandler<Category>(Category.class));
	}
	
}
