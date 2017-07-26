package cn.it.store.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import org.json.JSONObject;

import cn.it.store.entity.Category;
import cn.it.store.entity.PageBean;
import cn.it.store.entity.Product;
import cn.it.store.service.IProductService;
import cn.it.store.service.impl.ProductServiceImpl;
import cn.it.store.util.CommonsUtils;


public class ProductServlet extends BaseServlet {
	private IProductService productService=new ProductServiceImpl();
	
	public String getById(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
		if(id!=null)
		{
			try {
				Product product = productService.getById(Integer.parseInt(id));
				if(product!=null)
				{
					request.setAttribute("product",product);
					return "portal/product_info.jsp";
				}else{
					request.setAttribute("msg","错误,找不到商品的详细信息");
					return "portal/msg.jsp";
				}
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	
	public String getByCid(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String category_id = request.getParameter("category_id");
		if(category_id!=null)
		{
			int cid=Integer.parseInt(category_id);
			PageBean<Product> pageBean =new PageBean<Product>();
			//第一次访问置当前页为第一页
			//设置当前页
			String currPage = request.getParameter("currPage");
			if(currPage==null)
			{
				pageBean.setCurrPage(1);
			}else{
				pageBean.setCurrPage(Integer.parseInt(currPage));
			}
			try {
				//设置pagebean数据
				productService.getByCid(cid, pageBean);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("pageBean", pageBean);
		}
		return "portal/product_list.jsp";
	}
	
	public String getBySearchWord(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String searchWord = request.getParameter("searchWord");
		if(searchWord!=null&&!"".equals(searchWord))
		{
			PageBean<Product> pageBean =new PageBean<Product>();
			//第一次访问置当前页为第一页
			//设置当前页
			String currPage = request.getParameter("currPage");
			if(currPage==null)
			{
				pageBean.setCurrPage(1);
			}else{
				pageBean.setCurrPage(Integer.parseInt(currPage));
			}
			try {
				//设置pagebean数据
				productService.getBySearchWord(searchWord, pageBean);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("productSW", searchWord);
			request.setAttribute("pageBean", pageBean);
		}else{
			request.setAttribute("pageBean",new PageBean());
		}
		return "portal/product_list.jsp";
	}
	
	
	
	public String queryByCId(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		String size = request.getParameter("rows");
		String pageNumber=request.getParameter("page");
		String searchWord = request.getParameter("searchWord");
		String company_id=request.getParameter("company_id");
		int companyId=Integer.parseInt(company_id);
		//设置response格式
		response.setContentType("text/html;charset=utf-8");
		if(size!=null&&pageNumber!=null)
		{
			try {
				List<Product> productList = productService.queryByCId(Integer.parseInt(pageNumber), Integer.parseInt(size),
										searchWord,companyId);
				JSONObject json=new JSONObject();
				JSONArray rows=new JSONArray();
				for(Product product:productList)
				{
					rows.put(new JSONObject(product));
				}
				//设置rows内容
				json.put("rows", rows);
				//设置total内容
				//设置total的内容
				int total = productService.getCount(searchWord,companyId);
				json.put("total", total);
				response.getWriter().write(json.toString());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return super.execute(request, response);
	}
	
	
	public String queryCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//设置response格式
		response.setContentType("text/html;charset=utf-8");
		try {
			List<Category> categoryList = productService.queryCategory();
			JSONArray array=new JSONArray();
			for(Category category:categoryList)
			{
				array.put(new JSONObject(category));
			}
			response.getWriter().write(array.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return super.execute(request, response);
	}
	
	public String save(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Product product=new Product();
		//为商品设置上架时间
		product.setCreateDate(new Date());
		

		//下面是fileupload组件
		try {
			//第一步 创建diskFileItem工厂
			DiskFileItemFactory factory=new DiskFileItemFactory();
			//第二步 创建fileUpload对象
			ServletFileUpload upload=new ServletFileUpload(factory);
			//设置编码格式
			upload.setHeaderEncoding("utf-8");
			//设置上传文件总大小
			upload.setFileSizeMax(1024*1024*20);
			List<FileItem> fileItems = upload.parseRequest(request);
			for(FileItem item:fileItems)
			{
				//不是表单项
				if(!item.isFormField())
				{
						//图片项上传文件到productimages目录下
						if("img".equals(item.getFieldName()))
						{
							//获得文件后缀名
							String fileName = item.getName();
							String extension=fileName.substring(fileName.lastIndexOf("."));
							//为商品图片设置一个唯一字符串值
							String imguuid = CommonsUtils.getUUID();
							product.setImg(imguuid+extension);
							System.out.println(product.getImg());
							
							//图片输入流
							InputStream inputStream = item.getInputStream();
							//图片保存路径
							//调试项目时保存到工作空间 真正部署项目的时候会使用ftp服务器
							String filePath ="D:/git_repository/StoreProject/WebRoot/productimages";
							File file=new File(filePath,imguuid+extension);
							//图片输出流
							FileOutputStream outputSteam=new FileOutputStream(file);
							int len=0;
							byte[] b=new byte[1024];
							while((len=inputStream.read(b))!=-1)
							{
								outputSteam.write(b, 0, len);
							}
							inputStream.close();
							outputSteam.close();
						}
				}
				//是表单项
				else
				{
					//设置product的属性
					if("name".equals(item.getFieldName()))
					{
						product.setName(item.getString("utf-8"));
					}else if("cprice".equals(item.getFieldName()))
					{
						product.setCprice(Integer.parseInt(item.getString("utf-8")));
					}else if("xprice".equals(item.getFieldName()))
					{
						product.setXprice(Integer.parseInt(item.getString("utf-8")));
					}else if("hot".equals(item.getFieldName()))
					{
						product.setHot(Integer.parseInt(item.getString("utf-8")));
					}else if("desc".equals(item.getFieldName()))
					{
						product.setDesc(item.getString("utf-8"));
					}else if("state".equals(item.getFieldName()))
					{
						product.setState(Integer.parseInt(item.getString("utf-8")));
					}else if("category_id".equals(item.getFieldName()))
					{
						product.setCategory_id(Integer.parseInt(item.getString("utf-8")));
					}else if("company_id".equals(item.getFieldName()))
					{
						product.setCompany_id(Integer.parseInt(item.getString("utf-8")));
					}
				}
			}
			
			productService.save(product);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return super.execute(request, response);
	}
	
	
	public String update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Product product=new Product();
		//为商品设置上架时间
		
		//下面是fileupload组件
		try {
			//第一步 创建diskFileItem工厂
			DiskFileItemFactory factory=new DiskFileItemFactory();
			//第二步 创建fileUpload对象
			ServletFileUpload upload=new ServletFileUpload(factory);
			//设置编码格式
			upload.setHeaderEncoding("utf-8");
			//设置上传文件总大小
			upload.setFileSizeMax(1024*1024*20);
			boolean imgChange=false;
			List<FileItem> fileItems = upload.parseRequest(request);
			//判断是否上传了新的图片文件
			for(FileItem item:fileItems)
			{
				if("imgChange".equals(item.getFieldName()))
				{
					String imgC = item.getString("utf-8");
					if("true"==imgC)
					{
						imgChange=true;
						break;
					}
				}
			}
			
			//获取旧图片的名字
			String filePath ="D:/git_repository/StoreProject/WebRoot/productimages";
			String oldImg=null;
			for(FileItem item:fileItems)
			{
				if("oldImg".equals(item.getFieldName()))
				{
					oldImg=item.getString("utf-8");
					break;
				}
			}
			//设置商品旧图片名字
			product.setImg(oldImg);
			//如果上传了新的商品图片 删除旧的商品图片
			if(imgChange)
			{
				File file=new File(filePath,oldImg);
				if(file.exists())
				{
					file.delete();
				}
			}
			
			//设置product的属性
			for(FileItem item:fileItems)
			{
				//不是表单项
				if(!item.isFormField())
				{
						//图片项上传文件到productimages目录下
						if("img".equals(item.getFieldName())&&imgChange)
						{
							//获得文件后缀名
							String fileName = item.getName();
							String extension=fileName.substring(fileName.lastIndexOf("."));
							//为商品图片设置一个唯一字符串值
							String imguuid = CommonsUtils.getUUID();
							product.setImg(imguuid+extension);
							//图片输入流
							InputStream inputStream = item.getInputStream();
							//图片保存路径
							//调试项目时保存到工作空间 真正部署项目的时候会使用ftp服务器
							File file=new File(filePath,imguuid+extension);
							
							//获得旧的文件名并删除文件
							//图片输出流
							FileOutputStream outputSteam=new FileOutputStream(file);
							int len=0;
							byte[] b=new byte[1024];
							while((len=inputStream.read(b))!=-1)
							{
								outputSteam.write(b, 0, len);
							}
							inputStream.close();
							outputSteam.close();
						}
				}
				//是表单项
				else
				{
					//设置product的属性
					if("name".equals(item.getFieldName()))
					{
						product.setName(item.getString("utf-8"));
					}else if("cprice".equals(item.getFieldName()))
					{
						product.setCprice(Integer.parseInt(item.getString("utf-8")));
					}else if("xprice".equals(item.getFieldName()))
					{
						product.setXprice(Integer.parseInt(item.getString("utf-8")));
					}else if("hot".equals(item.getFieldName()))
					{
						product.setHot(Integer.parseInt(item.getString("utf-8")));
					}else if("desc".equals(item.getFieldName()))
					{
						product.setDesc(item.getString("utf-8"));
					}else if("state".equals(item.getFieldName()))
					{
						product.setState(Integer.parseInt(item.getString("utf-8")));
					}else if("category_id".equals(item.getFieldName()))
					{
						product.setCategory_id(Integer.parseInt(item.getString("utf-8")));
					}else if("company_id".equals(item.getFieldName()))
					{
						product.setCompany_id(Integer.parseInt(item.getString("utf-8")));
					}else if("id".equals(item.getFieldName()))
					{
						product.setId(Integer.parseInt(item.getString("utf-8")));
					}
				}
			}
			System.out.println(product);
			productService.update(product);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return super.execute(request, response);
	}
	
	public void deleteByIds(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String ids = request.getParameter("ids");
		try {
			productService.deleteByIds(ids);
			response.getWriter().write("true");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			response.getWriter().write("false");
			e.printStackTrace();
		}
	}
}
