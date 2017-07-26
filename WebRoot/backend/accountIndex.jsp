<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
 	 	<c:set var="store" value="${pageContext.request.contextPath}"></c:set>
  		<link href="${store}/css/backIndex.css" rel="stylesheet" type="text/css"/>
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/icon.css" type="text/css"></link>  
		<link rel="stylesheet" href="${store}/jquery-easyui-1.3.5/themes/default/easyui.css" type="text/css"></link>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>  
		<script type="text/javascript" src="${store}/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script> 
  		<script type="text/javascript" src="${store}/js/backIndex.js"></script>
  		<title>商城后台管理系统</title>
  </head>
  
  <body class="easyui-layout">
  		<div data-options="region:'north',title:'欢迎管理员${bAccount.accountname}来到商城后台管理',split:true" style="height:100px;"></div>     
        <div data-options="region:'west',title:'系统操作',split:true" style="width:200px;">  
            <!-- 此处显示的是系统菜单 -->  
            <div id="menu" class="easyui-accordion" data-options="fit:true">     
                <div title="基本操作" data-options="iconCls:'icon-save'">     
                    <ul>  
                        <li><a href="#" title="${store}/backend/userquery.jsp">用户管理</a>  
                        <li><a href="#" title="${store}/backend/companyquery.jsp">商家管理</a>  
                    </ul>  
                </div>     
            </div>     
        </div>     
        <div data-options="region:'center',title:'后台操作页面'" style="padding:1px;background:#eee;">  
            <div id="tt" class="easyui-tabs" data-options="fit:true,closable:true">     
                <div title="系统缺省页面" style="padding:10px;">  
                   	 此处以后显示相应的系统信息
                </div>     
            </div>                      
        </div> 
               <div id="win" data-options="collapsible:false,minimizable:false,maximizable:false,draggable:false,resizable:false"></div>     
  </body>
</html>
