package cn.it.store.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.it.store.entity.Account;
import cn.it.store.entity.Company;

/**
 * Servlet Filter implementation class BackEndLoginFilter
 */
public class BackEndLoginFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest) req;
		HttpServletResponse response=(HttpServletResponse) res;
		HttpSession session = request.getSession();
		
		if(request.getRequestURI().endsWith("login.jsp"))
		{
			chain.doFilter(request, response);
			return ;
		}
		
		
		Account bAccount = (Account) session.getAttribute("bAccount");
		Company bCompany = (Company) session.getAttribute("bCompany");
		if(bAccount==null&&bCompany==null)
		{
			request.setAttribute("msg","请先进行登录验证");
			request.getRequestDispatcher("/backend/login.jsp").forward(request,response);
			return ;
		}

		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
