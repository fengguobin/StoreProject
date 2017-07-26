<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>用户查询</title>
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
	            $('#dg').datagrid({     
	                //请求数据的url地址，后面会改成请求我们自己的url  
	                url:'${store}/OrderServlet',  
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
							iconCls: 'icon-edit',
							text:'改变订单状态',
							handler: function(){
								var rows=$("#dg").datagrid("getSelections");
								if(rows.length==0)
								{
										$.messager.show({
										title:'更新错误提示',
										msg:'没有选择需要改变状态的订单信息,请选择一条需要改变状态的订单信息',
										timeout:2000,
										showType:'slide'
										});
								}else if(rows.length>1)
								{
										$.messager.show({
										title:'更新错误提示',
										msg:'每次只能改变一条订单信息',
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
											title:"订单状态改变",
											content:'<iframe src="${store}/backend/orderchange.jsp" frameborder="0" width="100%" height="100%"></iframe>'
										});
	
								}
							}
						},'-',
						{
							iconCls: 'icon-search',
							text:'查看订单详情',
							handler: function(){
								var rows=$("#dg").datagrid("getSelections");
								if(rows.length==0)
								{
										$.messager.show({
										title:'查看订单详情错误提示',
										msg:'没有选择需要查看的订单信息,请选择一条需要查看的订单信息',
										timeout:2000,
										showType:'slide'
										});
								}else if(rows.length>1)
								{
										$.messager.show({
										title:'查看订单详情错误提示',
										msg:'每次只能查看一条订单信息',
										timeout:2000,
										showType:'slide'
										});	
								}else
								{
										parent.$("#win").window({
											width:"500",
											height:"300",
											collapsible:false,
											minimizable:false,
											maximizable:false,
											draggable:false,
											resizable:false,
											modal:true,
											title:"订单详情查看",
											content:"<iframe src='${store}/OrderServlet?method=orderDetail&id="+rows[0].id+"' frameborder='0' width='100%' height='100%'></iframe>"
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
	                    {field:'id',title:'订单编号',width:200}                   
	                ]],  
	                //配置datagrid的列字段   
	                //field：列字段的名称，与json的key捆绑  
	                //title：列标题，是显示给人看的  
	                columns:[[                       
	                    {
	                    	field:'address',title:'订单地址',width:100,
	                	},      
	                    {
	                    	field:'name',title:'用户昵称',width:100,  
	                    },
	                    {
	                    	field:'telephone',title:'用户电话',width:100
	                    },
	                    {
	                    	field:'totalPrice',title:'订单总价钱',width:100,  
	                    },
	                    {
	                    	field:'state',title:'订单状态',width:100,
	                    	formatter: function(value,row,index)
	                    	{
		                    	if(value==0){
		                    		return"未发货";
		                    	}else if(value==10){
		                    		return"已发货";
		                    	}else if(value==20){
		                    		return "交易完成";
		                    	}
		                    		
	                    	}
	                    }
	                ]]      
	            }); 
	            
	        	//把文本框变成搜索文本框
	             $("#ss").searchbox({
	             	searcher:function(value,name){
	             		//按下搜索按钮时调用datagrid的load函数重载User信息
	             		$("#dg").datagrid("load",{searchWord:value,method:"queryByCId",company_id:"${bCompany.id}"})
	             	},
	             	prompt:'请输入要搜索的用户昵称'
	             });
	        });  
		</script> 
</head>
<body>
    <table id="dg"></table>  
</body>
</html>