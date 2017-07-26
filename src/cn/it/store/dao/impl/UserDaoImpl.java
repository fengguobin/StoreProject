package cn.it.store.dao.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.it.store.dao.IUserDao;
import cn.it.store.entity.Company;
import cn.it.store.entity.User;
import cn.it.store.util.MyJdbcUtils;

public class UserDaoImpl implements IUserDao{
	public void save(User user) throws SQLException{
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "insert into user(username,password,name,email,telephone,birthday,sex,state,code) values(?,?,?,?,?,?,?,?,?)";
				runner.update(sql,user.getUsername(),user.getPassword(),
				user.getName(),user.getEmail(),user.getTelephone(),user.getBirthday(),
				user.getSex(),user.getState(),user.getCode());
	}
	@Override
	public void deleteById(int id) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void update(User user) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "update user set name=?,email=?,telephone=?,birthday=?,sex=?,state=? where uid=?";
		Object[] params=new Object[]{user.getName(),user.getEmail(),user.getTelephone(),user.getBirthday(),user.getSex(),user.getState(),user.getUid()};
		qr.update(sql, params);
	}

	@Override
	public User getById(int id) throws SQLException {
		QueryRunner qr = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "select * from `user` where uid=?";
		return qr.query(sql, new BeanHandler<User>(User.class), id);
	}
	//激活
	public int active(String activeCode) throws SQLException {
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "update user set state=? where code=?";
		int resultCount = runner.update(sql,1,activeCode);
		return resultCount;
	}

	
	public void deleteActiveCode(String activeCode) throws SQLException {
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "update user set code=null where code=?";
		runner.update(sql,activeCode);
	}
	//检查用户名是否存在
	public Long checkUsername(String username) throws SQLException {
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "select count(username) from user where username=?";
		Long resultCount=(Long) runner.query(sql, new ScalarHandler(), username);
		return resultCount;
	}
	public User login(String username, String password) throws SQLException {
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "select * from user where username=? and password=?";
		return runner.query(sql, new BeanHandler<User>(User.class), username,password);
	}
	@Override
	public void deleteByIds(String ids) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "delete from user where uid in ("+ids+")";
		qr.update(sql);
	}
	@Override
	public List<User> queryUser(int pageNumber, int size, String searchWord) throws SQLException {
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select * from `user` limit?,?";
			return qr.query(sql, new BeanListHandler<User>(User.class),(pageNumber-1)*size,size);
		}else{
			searchWord="%"+searchWord+"%";
			sql="select * from `user` where username like ? limit?,?";
			return qr.query(sql, new BeanListHandler<User>(User.class),searchWord,(pageNumber-1)*size,size);
		}
	}
	
	public int getCount(String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select count(1) from `user`";
			return ((Number)qr.query(sql, new ScalarHandler())).intValue();
		}else{
			searchWord="%"+searchWord+"%";
			sql="select count(1) from `user` where username like ?";
			return ((Number)qr.query(sql, new ScalarHandler(),searchWord)).intValue();
		}
	}
	
	
	public static void main(String[] args) throws SQLException {
		IUserDao dao=new UserDaoImpl();
		dao.deleteActiveCode("e8018915f4cd488ca2f3ecc844cf26b3");
	}
}
