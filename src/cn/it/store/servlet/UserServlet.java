package cn.it.store.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import cn.it.store.entity.Company;
import cn.it.store.entity.User;
import cn.it.store.service.IUserService;
import cn.it.store.service.impl.UserServiceImpl;
import cn.it.store.util.CommonsUtils;
import cn.it.store.util.MyBeanUtils;


public class UserServlet extends BaseServlet {
	private IUserService userService=new UserServiceImpl();
	
	public String checkUserName(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String username = request.getParameter("username");
			System.out.println(username);
			if(username!=null&&!"".equals(username))
			{
				boolean isExist = userService.checkUsername(username);
				String json = "{\"isExist\":"+isExist+"}";
				response.getWriter().write(json);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return null;
	}
	
	public String register(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			User user = MyBeanUtils.getBean(User.class, request.getParameterMap());
			user.setName(new String(user.getName().getBytes("iso8859-1"),"utf-8"));
			//设置邮件用户邮件激活码
			user.setCode(CommonsUtils.getUUID());
				try {
						String emailMsg="<h3><a href='localhost:8080/StoreProject/UserServlet?method=activeUser&code="+user.getCode()+"'>点击此链接激活用户</a></h3>";
						//注册成功后给用户发送激活邮件
						//设置信息让用户到注册邮箱激活用户
						//邮件发送成功返回true  发送失败返回false,并让用户重新注册
						boolean sendEmail = userService.sendEmail(user.getEmail(),emailMsg);
						if(sendEmail)
						{	
							//邮件发送成功把用户信息入库
							userService.save(user);
							request.setAttribute("msg","激活邮件已发送,请到注册邮箱点击链接激活账户");
						}else{
							//返回失败信息
							request.setAttribute("msg","激活邮件发送失败,请重新注册");
						}
					}catch(Exception e)
					{
						throw new RuntimeException(e);
					}
						
						return "/portal/msg.jsp";
	}
	
	public String activeUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String activeCode = request.getParameter("code");
		try {
			//激活成功返回ture,失败返回false
			boolean avtivceFlag = userService.avtivce(activeCode);
			if(avtivceFlag)
			{
				request.setAttribute("msg","账户激活成功,请登录");
			}else{
				request.setAttribute("msg","账户激活失败,激活码可能已失效");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			request.setAttribute("msg","账户激活失败,系统异常");
		}
		return "/portal/msg.jsp";
	}
	
	
	public String login(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = MyBeanUtils.getBean(User.class, request.getParameterMap());
		try {
			User loginUser = userService.login(user.getUsername(),user.getPassword());
	
			if(loginUser!=null)
			{
				
				//判断用户是否已激活 若state为0则用户未激活
				if(loginUser.getState()==0)
				{
					request.setAttribute("msg", "用户未激活");
					return "/portal/login.jsp";
				}
				
				
				//判断用户是否有勾选登录页面的自动登录功能
				String autoLogin = request.getParameter("autoLogin");
				if("1".equals(autoLogin))
				{
					//有勾选自动登录
					Cookie autoLoginCookie=new Cookie("autoLoginCookie",loginUser.getUsername()+"@"+loginUser.getPassword());
					autoLoginCookie.setPath("/StoreProject");
					//cookie保存一个星期
					autoLoginCookie.setMaxAge(60*60*24*7);
					response.addCookie(autoLoginCookie);
				}else
				{
					//没有勾选自动登录,删除cookie
					Cookie autoLoginCookie=new Cookie("autoLoginCookie","");
					autoLoginCookie.setPath("StoreProject");
					autoLoginCookie.setMaxAge(0);
					response.addCookie(autoLoginCookie);
				}
				
				//有无勾选记住用户名选项
				String rememberUserName = request.getParameter("rememberUserName");
				if("1".equals(rememberUserName))
				{
					//有勾选记住用户名
					Cookie rememberUserNameCookie=new Cookie("rememberUserNameCookie",loginUser.getUsername());
					rememberUserNameCookie.setPath("/StoreProject");
					//cookie保存一个星期
					rememberUserNameCookie.setMaxAge(60*60*24*7);
					response.addCookie(rememberUserNameCookie);
				}else
				{
					//没有勾选记住用户名,删除cookie
					Cookie rememberUserNameCookie=new Cookie("rememberUserNameCookie",loginUser.getUsername());
					rememberUserNameCookie.setPath("/StoreProject");
					//cookie保存一个星期
					rememberUserNameCookie.setMaxAge(60*60*24*7);
					response.addCookie(rememberUserNameCookie);
				}
				
				HttpSession session = request.getSession();
				loginUser.setPassword("");
				session.setAttribute("loginUser",loginUser);
				response.sendRedirect(request.getContextPath()+"/");
				return null;
			}else{
				request.setAttribute("msg", "用户名或密码错误,请重新登录");
				return "/portal/login.jsp";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e);
		}
	}
	
	
	public String loginOut(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		session.removeAttribute("loginUser");
		
		
		//删除cookie
		Cookie autoLoginCookie=new Cookie("autoLoginCookie","");
		autoLoginCookie.setPath("StoreProject");
		autoLoginCookie.setMaxAge(0);
		response.addCookie(autoLoginCookie);
		
		response.sendRedirect(request.getContextPath()+"/");
		return super.execute(request, response);
	}
	
	
	
	public void queryUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String size = request.getParameter("rows");
		String pageNumber=request.getParameter("page");
		String searchWord = request.getParameter("searchWord");
		response.setContentType("text/html;charset=utf-8");
		
		if(size!=null&&pageNumber!=null)
		{
			try {
				List<User> Users = userService.queryCompany(Integer.parseInt(pageNumber), Integer.parseInt(size),searchWord);
				JSONObject json=new JSONObject();
				JSONArray rows=new JSONArray();
				for(User user:Users)
				{
					rows.put(new JSONObject(user));
				}
				//设置rows的内容
				json.put("rows", rows);
				//设置total的内容
				int total = userService.getCount(searchWord);
				json.put("total", total);
				response.getWriter().write(json.toString());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	public void deleteByIds(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		// TODO Auto-generated method stub
		String ids = request.getParameter("ids");
		try {
			userService.deleteByIds(ids);
			response.getWriter().write("true");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			response.getWriter().write("false");
		}
	}
	
	//easyui用的update方法
	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = MyBeanUtils.getBean(User.class, request.getParameterMap());
		System.out.println(user);
		user.setName(new String(user.getName().getBytes("iso8859-1"),"utf-8"));
		try {
			userService.update(user);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//portal用的update方法
	public String portalUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = MyBeanUtils.getBean(User.class, request.getParameterMap());
		try {
			userService.update(user);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);
			request.setAttribute("msg","个人信息更新成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "portal/msg.jsp";
	}
	//前台用户更新数据获取
	public String getUserInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, NumberFormatException, SQLException {
		// TODO Auto-generated method stub
		String uid = request.getParameter("uid");
		User recallUser = userService.getById(Integer.parseInt(uid));
		request.setAttribute("recallUser",recallUser);
		return "/portal/userupdate.jsp";
	}
	
}
