package cn.it.store.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.it.store.entity.User;
import cn.it.store.service.IUserService;
import cn.it.store.service.impl.UserServiceImpl;
import cn.it.store.util.CookieUtils;

public class AutoLoginFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest) req;
		HttpServletResponse response=(HttpServletResponse) res;
		
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		
		//先判断session域是否已经有用户登录信息,有的话直接放行返回,不需要自动登录
		if(loginUser!=null)
		{
			chain.doFilter(request, response);
			return;
		}
		
		//判断请求的路径,如果是请求登录的直接放行返回
		String servletPath = request.getServletPath();
		if(servletPath.startsWith("/UserServlet"))
		{
			String method = request.getParameter("method");
			if("login".equals(method))
			{
				chain.doFilter(request, response);
				return;
			}
		}
		
		//判断有无cookie,有才进行自动登录操作
		Cookie autoLoginCookie = CookieUtils.findCookie(request.getCookies(), "autoLoginCookie");
		if(autoLoginCookie==null)
		{
			chain.doFilter(request, response);
			return;
		}
		
		String[] loginMsg = autoLoginCookie.getValue().split("@");
		String username=loginMsg[0];
		String password=loginMsg[1];
		
		IUserService userService=new UserServiceImpl();
		try {
			User user = userService.login(username, password);
			if(user!=null)
			{
				session.setAttribute("loginUser", user);
				chain.doFilter(request, response);
			}else
			{
				chain.doFilter(request, response);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("自动登录异常,自动忽略");
		}
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

}
