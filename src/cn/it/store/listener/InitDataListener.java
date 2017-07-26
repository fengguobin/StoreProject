package cn.it.store.listener;

import java.sql.SQLException;
import java.util.List;
import java.util.Timer;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import cn.it.store.dao.ICategoryDao;
import cn.it.store.dao.impl.CategoryDaoImpl;
import cn.it.store.entity.Category;
import cn.it.store.util.ProductTimeTask;

public class InitDataListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub

	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		try {
			ServletContext application = sce.getServletContext();
			
			//初始化分类数据
			ICategoryDao categoryDao=new CategoryDaoImpl();
			List<Category> categoryList = categoryDao.getAll();
			application.setAttribute("categoryList", categoryList);
			
			//创建一个把最新和最热放入application域的TimerTask
			ProductTimeTask productTimeTask = new ProductTimeTask(application);
			//创建一个定时器,每隔一个小时刷新一次最热和最新的商品数据
			new Timer(true).schedule(productTimeTask, 0, 1000*60*60);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch blocks
			System.out.println("初始化数据失败");
			throw new RuntimeException(e);
		}
	}

}
