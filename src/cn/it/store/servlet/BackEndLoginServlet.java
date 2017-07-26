package cn.it.store.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.it.store.dao.impl.AccountDaoImpl;
import cn.it.store.dao.impl.CompanyDaoImpl;
import cn.it.store.entity.Account;
import cn.it.store.entity.Company;

/**
 * Servlet implementation class BackEndLoginServlet
 */
public class BackEndLoginServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String role = request.getParameter("role");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		HttpSession session = request.getSession();
		
		try {
			if("account".equals(role))
			{
				AccountDaoImpl dao=new AccountDaoImpl();
				Account account = dao.login(name, password);
				if(account!=null)
				{
					session.setAttribute("bAccount", account);
					response.sendRedirect(request.getContextPath()+"/backend/accountIndex.jsp");
				}else{
					request.setAttribute("msg","用户名或密码错误,请重新登录");
					request.getRequestDispatcher("/backend/login.jsp").forward(request, response);
				}
					
			}else if("company".equals(role))
			{
				CompanyDaoImpl dao=new CompanyDaoImpl();
				Company company = dao.login(name, password);
				if(company!=null)
				{
					session.setAttribute("bCompany", company);
					response.sendRedirect(request.getContextPath()+"/backend/companyIndex.jsp");
				}else{
					request.setAttribute("msg","用户名或密码错误,请重新登录");
					request.getRequestDispatcher("/backend/login.jsp").forward(request, response);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
