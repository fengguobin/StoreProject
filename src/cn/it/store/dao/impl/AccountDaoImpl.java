package cn.it.store.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import cn.it.store.entity.Account;
import cn.it.store.util.MyJdbcUtils;

public class AccountDaoImpl {
	public Account login(String accountname,String password) throws SQLException{
		QueryRunner runner = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "select * from `account` where accountname=? and password=?";
		return runner.query(sql,new BeanHandler<Account>(Account.class),accountname,password);
	}; 
	
	public static void main(String[] args) throws SQLException {
		AccountDaoImpl dao=new AccountDaoImpl();
		Account account = dao.login("admin", "admin");
	}
	
}
