<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>添加商家</title>
    	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
 	 	<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/icon.css" type="text/css"></link>  
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/default/easyui.css" type="text/css"></link>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script>
	<style type="text/css">
		form div{
			margin:5px
		}
	</style>
	
	
	<script type="text/javascript">
		$(function(){
 		 	//获取商品类别
			$("#category_id").combobox({   
				//将请求发送给accountAction中的query方法处理，这里需要将处理好的数据返回到这边来显示了 ，所以后台需要将数据打包成json格式发过来
			    url:'${store}/ProductServlet?method=queryCategory',  
			    valueField:'id',    
			    textField:'name', //我们下拉列表中显示的是管理员的登录名
			    panelHeight:'auto', //自适应高度
			    panelWidth:120,//下拉列表是两个组件组成的
			    width:120, //要同时设置两个宽度才行
			    editable:false //下拉框不允许编辑
			});
 		 	
 		 	
			//数据回显
			var row=parent.$("iframe[title='商品管理']").get(0).contentWindow.$("#dg").datagrid("getSelections")[0];
			$("#ff").form("load",{
				id:row.id,
				name:row.name,
				cprice:row.cprice,
				xprice:row.xprice,
				oldImg:row.img,
				createDate:row.createDate,
				hot:row.hot,
				desc:row.desc,
				state:row.state,
				category_id:row.category_id
			});
 		 	//商品图片回显
 		 	$("#previewImg").attr("src","/StoreProject/productimages/"+row.img);
 		 	
 		 	//获得用户上传商品图片回显
 		 	//用户上传了新图片
 		 	$("#img").change(function(){
 		 		$("#previewImg").attr("src",$("#img").val());
 		 		$("#imgChange").attr("value","true");
 		 	});
 		 	
			//新增自定义验证规则,验证上传图片后缀名
			$.extend($.fn.validatebox.defaults.rules, 
			{    
			     format:{    
       			 validator: function(value,param){
       			 	var ext=value.substring(value.lastIndexOf(".")+1);
       			 	var row=param[0].split(",");
       			 	for(var i=0;i<row.length;i++)
       			 	{
       			 		if(row[i]==ext)
       			 		{
       			 			return true;
       			 		}
       			 	} 
       			 	return false;   
       			 },    
        		message:"请上传图片后缀为{0}的图片"   
   			 }     
			});
 		 	
			
		 	$("#name").validatebox({
		 		required:true,
		 		missingMessage:"商家用户名为空",
		 		validType:"checkName",
		 		delay:1000
		 	});
		 	
		 	$("#cprice").numberbox({
		 		required:true,
		 		missingMessage:"参考价为空",
		 	});
		 	
		 	$("#xprice").numberbox({
		 		required:true,
		 		missingMessage:"现价为空",
		 	});
		 	
			$("#img").validatebox(
					{
	                	validType:"format['jpg,jepg,gif,png']"
					}
				);
		 	
		 	
			$("#ff").form("disableValidation");
			$("#submit").click(function(){
				$("#ff").form("enableValidation");
				if($("#ff").form("validate"))
				{
					$("#ff").form("submit",{
						url:"${store}/ProductServlet?method=update",
						success:function(){
							parent.$("#win").window("close");
							parent.$("iframe[title='商品管理']").get(0).contentWindow.$("#dg").datagrid("reload");
						}
					});
				}
			});
			//重置按钮设置
			$("#reset").click(function(){
				$("#ff").form("disableValidation");
				$("#ff").form("reset");
			});
			
		});
		
     </script>

  </head>
  <body>
  	<form id="ff" method="post" enctype="multipart/form-data">
  		<input type="hidden" name="id">
  		<input type="hidden" name="imgChange" id="imgChange"/>
  		<input type="hidden" name="oldImg"/>
  		<div>
  			<label for="name">商品名称</label>
  			<input type="text" id="name" name="name"/>
  		</div>
  		 <div>
  			<label for="cprice">商家参考价</label>
  			<input type="text" id="cprice" name="cprice"/>
  		</div>
  		 <div>
  			<label for="xprice">商品现价</label>
  			<input type="text" id="xprice" name="xprice"/>
  		</div>
  		
  		商品描述<br/>
  		<textarea rows="5" cols="40" name="desc"></textarea>
  		
  		 <div>
  			商品图片<input type="file" id="img" name="img"/>
  			<img id="previewImg" src="${store}/productimages/preview.jpg" width="80" height="80"/>
  		</div>
  		<div>
  			是否热卖：
  			<label for="rm">是</label>
  			<input type="radio" id="rm" name="hot" value="1"/>&nbsp;&nbsp;
  			<label for="mrm">否</label>
  			<input type="radio" id="mrm" name="hot" value="0"/>
  		</div>  
  		
  		<div>
  			商品状态：
  			<label for="state">正常上架</label>
  			<input type="radio" id="state" name="state" value="0"/>&nbsp;&nbsp;
  			<label for="nostate">下架</label>
  			<input type="radio" id="nostate" name="state" value="1"/>
  		</div>
  		  
  		<div>
  			<input id="category_id" name="category_id"/>
  		</div>
  				
		<div>
		      <a id="submit" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">更新</a>
		      <a id="reset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'">重置</a>   
		</div>
  	</form>
  </body>
</html>
