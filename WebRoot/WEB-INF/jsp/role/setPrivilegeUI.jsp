<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>配置权限</title>
     <%@ include file="/WEB-INF/jsp/public/head.jsp"%>
	<script language="javascript" src="${pageContext.request.contextPath}/script/jquery_treeview/jquery.treeview.js"></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/blue/file.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/script/jquery_treeview/jquery.treeview.css" />
 <script type="text/javascript">
    $(function(){
		   //为权限复选框绑定单击事件 
			$("input[name=privilegeIds]").click(function(){
					//alert("点击事件 ");
				//选 中某个权限时，同上选中下级权限,取消同
				   $(this).siblings("ul").find("input").attr('checked',this.checked);
				   //当选中某个权限时，同时选 中其直系上级权限
				   if(this.checked){
					   //$(this).parents().siblings("intpug[name=privilegeIds]").attr('checkced',this.checked);
					   $(this).parents("li").children("input").attr('checked',true);
				   }else{
					   //当取消某个权限的时候，如果同级权限都没有选中，则将上级权限也取消
					   if($(this).parent().siblings("li").children("input:checked").size()==0){
						   $(this).parent().parent().siblings("input").attr('checked',false);
					   }
					   }
				})
        })
  
 </script>
</head>
<body>
 
<!-- 标题显示 -->
<div id="Title_bar">
    <div id="Title_bar_Head">
        <div id="Title_Head"></div>
        <div id="Title"><!--页面标题-->
            <img border="0" width="13" height="13" src="${pageContext.request.contextPath}/style/images/title_arrow.gif"/> 配置权限
        </div>
        <div id="Title_End"></div>
    </div>
</div>
 
<!--显示表单内容-->
<div id=MainArea>
    <s:form action="role_setPrivilege" namespace="/" theme="simple">
    <s:hidden name="id"></s:hidden>
        <div class="ItemBlock_Title1"><!-- 信息说明 --><div class="ItemBlock_Title1">
        	<img border="0" width="4" height="7" src="${pageContext.request.contextPath}/style/blue/images/item_point.gif" /> 正在为【${name }】配置权限 </div> 
        </div>
        
        <!-- 表单内容显示 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
                <table cellpadding="0" cellspacing="0" class="mainForm">
					<!--表头-->
					<thead>
						<tr align="LEFT" valign="MIDDLE" id="TableTitle">
							<td width="300px" style="padding-left: 7px;">
								<!-- 如果把全选元素的id指定为selectAll，并且有函数selectAll()，就会有错。因为有一种用法：可以直接用id引用元素 -->
									<input type="CHECKBOX" id="cbSelectAll" onclick="$('input[name=privilegeIds]').attr('checked',this.checked)"/>
									<label for="cbSelectAll">全选</label>
							</td>
						</tr>
					</thead>
                   
			   		<!--显示数据列表-->
					<tbody id="TableData">
						<tr class="TableDetail1">
							<!-- 显示权限树 -->
							<td>
							<!-- 使用struts2标签显示权限，可以回显，但是不能加换行  -->
							<%--<s:checkboxlist list="privilegeList" listKey="id" listValue="name"></s:checkboxlist>--%>
							<!-- 使用html标签 ，可以控制样式，没有回显 -->
							 <%--  
							  <s:iterator value="privilegeList">
							      <input 
							        <s:property value="%{id in privilegeIds ? 'checked':''}"/>
							      type="checkbox" value="${id }" name="privilegeIds"/>${name }
							      <br/>
							   </s:iterator>
							   --%>
							   <!-- 引入tree控件 -->
							  <ul  id="privilegeTree">
								  <s:iterator value="topPrivilegeList">
								  	<li>
									  <input 
									     <s:property value="%{id in privilegeIds ? 'checked':''}"/>
									  type="checkbox" name="privilegeIds" id="cb_${id }" value="${id }"/>
									  <label for="cb_${id }">
										  <span class="folder" id="${id }">${name }</span>
									  </label>
									  <ul>
									      <s:iterator value="children">
										  	<li>
											  <input 
											  		 <s:property value="%{id in privilegeIds ? 'checked':''}"/>
											  type="checkbox" name="privilegeIds" id="cb_${id }"  value="${id }"/>
											  <label for="cb_${id }">
												  <span class="folder" id="${id }">${name }</span>
											  </label>
											  <ul>
											    	<s:iterator value="children">
													  	<li>
														  <input 
														     <s:property value="%{id in privilegeIds ? 'checked':''}"/>
														  type="checkbox" name="privilegeIds" id="cb_${id }" value="${id }"/>
														  <label for="cb_${id }">
															  <span class="folder" id="${id }">${name }</span>
														  </label>
														</li>
													</s:iterator>
											  </ul>
										    </li>
								  		  </s:iterator>
									  </ul>
								    </li>
								  </s:iterator>
							  </ul> 
							   
							</td>
						</tr>
					</tbody>
                </table>
            </div>
        </div>
        
        <!-- 表单操作 -->
        <div id="InputDetailBar">
            <input type="image" src="${pageContext.request.contextPath}/style/images/save.png"/>
            <a href="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/style/images/goBack.png"/></a>
        </div>
    </s:form>
</div>
 
<div class="Description">
	说明：<br />
	1，选中一个权限时：<br />
	&nbsp;&nbsp;&nbsp;&nbsp; a，应该选中 他的所有直系上级。<br />
	&nbsp;&nbsp;&nbsp;&nbsp; b，应该选中他的所有直系下级。<br />
	2，取消选择一个权限时：<br />
	&nbsp;&nbsp;&nbsp;&nbsp; a，应该取消选择 他的所有直系下级。<br />
	&nbsp;&nbsp;&nbsp;&nbsp; b，如果同级的权限都是未选择状态，就应该取消选中他的直接上级，并递归向上做这个操作。<br />
 
	3，全选/取消全选。<br />
	4，默认选中当前岗位已有的权限。<br />
</div>
 <script type="text/javascript">
    $("#privilegeTree").treeview();
 </script>
</body>
</html>

