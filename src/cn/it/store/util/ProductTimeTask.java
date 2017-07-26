package cn.it.store.util;

import java.sql.SQLException;
import java.util.List;
import java.util.TimerTask;

import javax.servlet.ServletContext;

import cn.it.store.dao.IProductDao;
import cn.it.store.dao.impl.ProductDaoImpl;
import cn.it.store.entity.Product;
public class ProductTimeTask extends TimerTask {
	private ServletContext application;
	
	public ProductTimeTask(ServletContext application) {
		this.application = application;
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
		IProductDao productDao=new ProductDaoImpl();
		try {
			List<Product> byHot = productDao.getByHot();
			List<Product> byNew = productDao.getByNew();
			
			//设置最热和最新商品信息
			application.setAttribute("byHot", byHot);
			application.setAttribute("byNew", byNew);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
