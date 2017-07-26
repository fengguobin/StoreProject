package cn.it.store.dao;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.User;

public interface IUserDao {
	public void save(User user) throws SQLException ;
	public void deleteById(int id) throws SQLException;
	public void update(User user) throws SQLException;
	public User getById(int id) throws SQLException;
	public Long checkUsername(String username) throws SQLException;
	public int active(String activeCode) throws SQLException;
	public void deleteActiveCode(String activeCode) throws SQLException;
	public User login(String username, String password) throws SQLException;
	public List<User> queryUser(int pageNumber,int size,String searchWord) throws SQLException;
	public int getCount(String searchWord) throws SQLException;
	public void deleteByIds(String ids) throws SQLException;
}
