package cn.it.store.service;

import java.sql.SQLException;
import java.util.List;

import cn.it.store.entity.Company;
import cn.it.store.entity.User;

public interface IUserService {
	public boolean checkUsername (String username)throws Exception;
	public void save(User user)throws Exception;
	public User getById(int id) throws SQLException;
	public boolean sendEmail(String email, String emailMsg);
	public boolean avtivce(String activeCode) throws SQLException;
	public User login(String username, String password) throws SQLException;
	public void deleteByIds(String ids) throws SQLException;
	public void update(User user) throws SQLException;
	public List<User> queryCompany(int pageNumber,int size,String searchWord) throws SQLException;
	public int getCount(String searchWord) throws SQLException;
}
