package cn.it.store.service.impl;


import java.sql.SQLException;
import java.util.List;

import cn.it.store.dao.IUserDao;
import cn.it.store.dao.impl.UserDaoImpl;
import cn.it.store.entity.User;
import cn.it.store.service.IUserService;
import cn.it.store.util.MailUtils;

public class UserServiceImpl implements IUserService{
	private IUserDao userDao=new UserDaoImpl();
	@Override
	public void save(User user) throws Exception {
		// TODO Auto-generated method stub
		userDao.save(user);
	}
	@Override
	public boolean sendEmail(String email, String emailMsg) {
		// TODO Auto-generated method stub
		try {
			MailUtils.sendMail(email, emailMsg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return false;
		}
		return true;
	}

	@Override
	//用户名存在返回ture 不存在返回false
	public boolean checkUsername(String username) throws Exception {
		// TODO Auto-generated method stub
		Long resultCount = userDao.checkUsername(username);
		if(resultCount>0)
		{
			return true;
		}else
		{
			return false;
		}
	}

	//激活成功返回ture,激活失败返回false
	@Override
	public boolean avtivce(String activeCode) throws SQLException {
		// TODO Auto-generated method stub
		int resultCount = userDao.active(activeCode);
		if(resultCount==0)
		{
			return false;
		}
			userDao.deleteActiveCode(activeCode);
			return true;
	}

	@Override
	public User login(String username, String password) throws SQLException {
		// TODO Auto-generated method stub
		return userDao.login(username,password);
	}


	@Override
	public void deleteByIds(String ids) throws SQLException {
		// TODO Auto-generated method stub
		userDao.deleteByIds(ids);
	}

	@Override
	public void update(User user) throws SQLException {
		// TODO Auto-generated method stub
		userDao.update(user);
	}
	@Override
	public List<User> queryCompany(int pageNumber, int size, String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		return userDao.queryUser(pageNumber, size, searchWord);
	}
	@Override
	public int getCount(String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		return userDao.getCount(searchWord);
	}
	@Override
	public User getById(int id) throws SQLException {
		// TODO Auto-generated method stub
		return userDao.getById(id);
	}
}
