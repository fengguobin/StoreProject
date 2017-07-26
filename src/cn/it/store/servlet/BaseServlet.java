package cn.it.store.servlet;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BaseServlet extends HttpServlet {
	
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			//解决中文乱码问题
			request.setCharacterEncoding("utf-8");
			//获得跳转的方法名
			String methodName=request.getParameter("method");
			if(methodName==null)
			{
				methodName="execute";
			}
				Method method = this.getClass().getMethod(methodName, HttpServletRequest.class,HttpServletResponse.class);
				String jspPath=(String) method.invoke(this,request,response);
				if(jspPath!=null)
				{
					request.getRequestDispatcher(jspPath).forward(request, response);
				}
		} catch (Exception e) {
			throw new RuntimeException(e);
		} 
	}
	
	public String execute(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		return null;
	}
}
