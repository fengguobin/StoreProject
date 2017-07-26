package cn.it.store.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.it.store.dao.IProductDao;
import cn.it.store.entity.Category;
import cn.it.store.entity.Order;
import cn.it.store.entity.Product;
import cn.it.store.util.MyJdbcUtils;

public class ProductDaoImpl implements IProductDao {

	@Override
	public void save(Product product) throws SQLException {
		String sql="insert into `product`(`name`,`cprice`,`xprice`,"
				+ "`img`,`createDate`,`hot`,`desc`,`state`,`category_id`,"
				+ "`company_id`) "
				+ "values(?,?,?,?,?,?,?,?,?,?)";
		Object[] params=new Object[]{product.getName(),product.getCprice(),
				product.getXprice(),product.getImg(),product.getCreateDate(),
				product.getHot(),product.getDesc(),product.getState(),
				product.getCategory_id(),product.getCompany_id()};
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		qr.update(sql, params);
	}

	@Override
	public void deleteById(int id) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(Product product) throws SQLException {
		// TODO Auto-generated method stub
		String sql="update `product` set name=?,cprice=?,xprice=?,"
				+ "img=?,hot=?,`desc`=?,`state`=?,`category_id`=? where id=?";
		Object[] params=new Object[]{product.getName(),product.getCprice(),
				product.getXprice(),product.getImg(),product.getHot(),
				product.getDesc(),product.getState(),product.getCategory_id(),
				product.getId()};
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		qr.update(sql, params);
	}

	@Override
	public Product getById(int id) throws SQLException {
		// TODO Auto-generated method stub
		String sql="select * from product where id=?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return qr.query(sql, new BeanHandler<Product>(Product.class),id);
	}

	@Override
	public List<Product> getAll() throws SQLException {
		// TODO Auto-generated method stub
		//state 0 未下架  
		//hot 1 热门
		//limit 查9条数据
		String sql="select * from product where state=? and hot=? orderby createdate desc limit ?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return qr.query(sql, new BeanListHandler<Product>(Product.class),0,1,9);
	}

	@Override
	public List<Product> getByHot() throws SQLException {
		//state 0 未下架  
		//hot 1 热门
		//limit 查9条数据
		String sql="select * from product where state=? and hot=? order by createdate desc limit ?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return qr.query(sql, new BeanListHandler<Product>(Product.class),0,1,9);
	}

	@Override
	public List<Product> getByNew() throws SQLException {
		//state 0 未下架  
		//hot 1 热门
		//limit 查9条数据
		String sql="select * from product where state=? order by createdate desc limit ?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return qr.query(sql, new BeanListHandler<Product>(Product.class),0,9);
	}

	@Override
	public List<Product> getByCid(int cid,int index,int size) throws SQLException {
		String sql="select * from product where category_id=? limit ?,?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return qr.query(sql, new BeanListHandler<Product>(Product.class),cid,index,size);
	}
	

	@Override
	public int getCountByCid(int cid) throws SQLException {
		// TODO Auto-generated method stub
		String sql="select count(1) from product where category_id=?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return ((Number)qr.query(sql,new ScalarHandler(),cid)).intValue();
	}
	
	
	public List<Product> getBySearchWord(String searchWord,int index,int size) throws SQLException {
		String sql="select * from product where name like ? limit ?,?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return qr.query(sql, new BeanListHandler<Product>(Product.class),"%"+searchWord+"%",index,size);
	}
	

	public int getCountBySearchWord(String searchWord) throws SQLException {
		// TODO Auto-generated method stub
		String sql="select count(1) from `product` where name like ?";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return ((Number)qr.query(sql,new ScalarHandler(),"%"+searchWord+"%")).intValue();
	}
	

	@Override
	public void deleteByCompanyIds(Connection conn,String ids) throws SQLException {
		// TODO Auto-generated method stub
		String sql="delete from `product` where company_id in ("+ids+")";
		QueryRunner qr=new QueryRunner();
		qr.update(conn, sql);
	}
	
	@Override
	public List<Product> queryByCId(int pageNumber, int size, String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select * from `product` where company_id=? limit?,?";
			return qr.query(sql, new BeanListHandler<Product>(Product.class),companyId,(pageNumber-1)*size,size);
		}else{
			searchWord="%"+searchWord+"%";
			sql="select * from `product` where company_id=? and name like ? limit?,?";
			return qr.query(sql, new BeanListHandler<Product>(Product.class),companyId,searchWord,(pageNumber-1)*size,size);
		}
	}
	
	@Override
	public int getCount(String searchWord, int companyId) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		String sql=null;
		if("".equals(searchWord))
		{
			sql="select count(1) from `product` where company_id=?";
			return ((Number)qr.query(sql, new ScalarHandler(),companyId)).intValue();
		}else{
			searchWord="%"+searchWord+"%";
			sql="select count(1) from `product` where company_id=? and name like ?";
			return ((Number)qr.query(sql, new ScalarHandler(),companyId,searchWord)).intValue();
		}
	}
	
	@Override
	public List<Category> queryCategory() throws SQLException {
		// TODO Auto-generated method stub
		String sql="select * from `category`";
		QueryRunner qr=new QueryRunner(MyJdbcUtils.getDataSource());
		return qr.query(sql, new BeanListHandler<Category>(Category.class));
	}
	
	public void deleteByIds(String ids) throws SQLException {
		// TODO Auto-generated method stub
		QueryRunner qr = new QueryRunner(MyJdbcUtils.getDataSource());
		String sql = "delete from `product` where id in ("+ids+")";
		qr.update(sql);
	}
	public static void main(String[] args) throws SQLException {
		IProductDao dao=new ProductDaoImpl();
		int count = dao.getCountBySearchWord("苹果");
		List<Product> products = dao.getBySearchWord("苹果",0, 2);
		System.out.println(count);
		System.out.println(products);
		return ;
	}
	

}
