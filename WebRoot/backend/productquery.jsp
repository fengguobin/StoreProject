<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>产品查询</title>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
 	 	<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/icon.css" type="text/css"></link>  
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/default/easyui.css" type="text/css"></link>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script>
		
		<!-- 读取页面的时候查询用户数据 -->
		<script type="text/javascript">
		 $(function(){
			 	
			 	//获得表单数据
	            $('#dg').datagrid({     
	                //请求数据的url地址，后面会改成请求我们自己的url  
	                url:'${store}/ProductServlet',  
	                loadMsg:'Loading......',  
	                queryParams:{searchWord:"",method:"queryByCId",company_id:"${bCompany.id}"},//参数  
	                //width:300,  
	                fitColumns:true,//水平自动展开，如果设置此属性，则不会有水平滚动条，演示冻结列时，该参数不要设置  
	                //显示斑马线  
	                striped:true,  
	                //当数据多的时候不换行  
	                nowrap:true,  
	               // singleSelect:true, //如果为真，只允许单行显示，全选功能失效  
	                //设置分页  
	                pagination:true,
	                //工具栏
	                toolbar: 
	               	[
						{
							iconCls: 'icon-add',
							text:'添加商品',
							handler: function(){
								parent.$("#win").window({
									title:"添加商品",
									width:500,
									height:300,
									resizable:true,
									collapsible:false,
									minimizable:false,
									maximizable:false,
									draggable:false,
									modal:true,
									content:'<iframe src="${store}/backend/productsave.jsp" width="100%" height="100%" frameborder="0"></iframe>'
								});
							}
						},'-',
						{
							iconCls: 'icon-edit',
							text:'编辑商品',
							handler: function(){
								var rows=$("#dg").datagrid("getSelections");
								if(rows.length==0)
								{
										$.messager.show({
										title:'更新错误提示',
										msg:'没有选择需要编辑的商品信息,请选择一条需要编辑的商品信息。',
										timeout:2000,
										showType:'slide'
										});
								}else if(rows.length>1)
								{
										$.messager.show({
										title:'更新错误提示',
										msg:'每次只能编辑一条商品信息',
										timeout:2000,
										showType:'slide'
										});	
								}else
								{
										parent.$("#win").window({
											width:"350",
											height:"200",
											modal:true,
											resizable:true,
											collapsible:false,
											minimizable:false,
											maximizable:false,
											draggable:false,
											title:"编辑商品",
											content:'<iframe src="${store}/backend/productupdate.jsp" frameborder="0" width="100%" height="100%"></iframe>'
										});
	
								}
							}
						},'-',
						{
							iconCls:'icon-remove',
							text:'删除商品',
							handler: function(){
								var rows=$("#dg").datagrid("getSelections");
								if(rows.length==0)
								{
									$.messager.show({
										title:'删除的错误消息',
										msg:'未选择要删除的数据',
										timeout:2000,
										showType:'slide'
									});
									
								}else{
									$.messager.confirm("删除确定对话框","删除所选数据",function(r){
										if(r)
										{
											var ids="";
											for(var i=0;i<rows.length;i++){
												ids+=rows[i].uid+",";
											}
											
											//除去ids最后的,
											ids=ids.substr(0, ids.lastIndexOf(","));
											//准备发送ajax请求到服务端
											var url="${store}/ProductServlet?method=deleteByIds";
											var content={"ids":ids};
											$.post(url,content,function(result){
												if("true"==result)
												{
													//取消所有选中的行，在当前页面刷新
													$("#dg").datagrid("uncheckAll");
													$("#dg").datagrid("reload");
												}else{
													//
													$.messager.show({
														title:'删除的错误消息',
														msg:'删除操作出现了错误',
														timeout:2000,
														showType:'slide'});
												}
											});
											}
									});
								}
							}
						},'-',
						{
							text:"<input id='ss' name='search'/>"
						}
					],
	                //同列属性，但是这些列将会冻结在左侧,大小不会改变，当宽度大于250时，会显示滚动条，但是冻结的列不在滚动条内  
	                frozenColumns:[[  
	                    {field:'checkbox',checkbox:true},  
	                    {field:'id',title:'商品编号',width:200}                   
	                ]],  
	                //配置datagrid的列字段   
	                //field：列字段的名称，与json的key捆绑  
	                //title：列标题，是显示给人看的  
	                columns:[[                       
	                    {
	                    	field:'name',title:'商品名称',width:100,  
	                    },
	                    {
	                    	field:'cprice',title:'商品参考价',width:100,  
	                    },
	                    {
	                    	field:'xprice',title:'商品现价',width:100
	                    },
	                    {
	                    	field:'createDate',title:'商品上架时间',width:100,  
	                    },
	                    {
	                    	field:'hot',title:'是否热卖',width:100,
		                    formatter: function(value,row,index)
	                    	{
		                    	if(value==1){
		                    		return"<input type='checkbox' checked='checked' disabled='true'>";
		                    	}else{
		                    		return"<input type='checkbox'  disabled='true'>";
		                    	}  
	                    	}
	                    },
	                    {
	                    	field:'state',title:'商品状态',width:100,
	                    	formatter: function(value,row,index)
	                    	{
		                    	if(value==0){
		                    		return"正常上架";
		                    	}else{
		                    		return"已下架";
		                    	}  
	                    	}
	                    }
	                ]]      
	            }); 
	            
	        	//把文本框变成搜索文本框
	             $("#ss").searchbox({
	             	searcher:function(value,name){
	             		//按下搜索按钮时调用datagrid的load函数重载User信息
	             		$("#dg").datagrid("load",{searchWord:value,method:queryByCId,company_id:"${bCompany.id}"})
	             	},
	             	prompt:'请输入要搜索的商品名字'
	             });
	        });  
		</script> 
</head>
<body>
    <table id="dg"></table>  
</body>
</html>