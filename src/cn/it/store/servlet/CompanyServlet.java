package cn.it.store.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import cn.it.store.entity.Company;
import cn.it.store.service.ICompanyService;
import cn.it.store.service.impl.CompanyServiceImpl;
import cn.it.store.util.MyBeanUtils;

public class CompanyServlet extends BaseServlet {
	ICompanyService service=new CompanyServiceImpl();
	
	public String queryCompany(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String size = request.getParameter("rows");
		String pageNumber=request.getParameter("page");
		String searchWord = request.getParameter("searchWord");
		response.setContentType("text/html;charset=utf-8");
		
		if(size!=null&&pageNumber!=null)
		{
			try {
				List<Company> companys = service.queryCompany(Integer.parseInt(pageNumber), Integer.parseInt(size),searchWord);
				System.out.println(companys);
				JSONObject json=new JSONObject();
				JSONArray rows=new JSONArray();
				for(Company company:companys)
				{
					rows.put(new JSONObject(company));
				}
				//设置rows内容
				json.put("rows", rows);
				//设置total内容
				//设置total的内容
				int total = service.getCount(searchWord);
				json.put("total", total);
				System.out.println(json.toString());
				response.getWriter().write(json.toString());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return super.execute(request, response);
	}
	
	public void checkName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		try {
			boolean isExist = service.checkName(name);
			JSONObject json=new JSONObject();
			json.put("isExist", isExist);
			response.getWriter().write(json.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void checkCompanyName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String company_name = request.getParameter("company_name");
		try {
			boolean isExist = service.checkName(company_name);
			JSONObject json=new JSONObject();
			json.put("isExist", isExist);
			response.getWriter().write(json.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void save(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		Company company = MyBeanUtils.getBean(Company.class, request.getParameterMap());
		try {
			service.save(company);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Company company = MyBeanUtils.getBean(Company.class, request.getParameterMap());
		try {
			service.update(company);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deleteByIds(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String ids = request.getParameter("ids");
		try {
			service.deleteByIds(ids);
			response.getWriter().write("true");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			response.getWriter().write("false");
			e.printStackTrace();
		}
	}
}
