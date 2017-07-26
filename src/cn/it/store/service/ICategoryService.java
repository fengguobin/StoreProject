package cn.it.store.service;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Category;
import cn.it.store.entity.User;

public interface ICategoryService {
	public void save(User user) throws SQLException ;
	public void deleteById(int id) throws SQLException;
	public void update(User user) throws SQLException;
	public User getById(int id) throws SQLException;
	public List<Category> getAll() throws SQLException;
}
