<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%

String action = request.getParameter("action");

String strCategoryId = request.getParameter("categoryid");
int categoryId = 0;
if(strCategoryId != null && !strCategoryId.trim().equals("")) {
	categoryId = Integer.parseInt(strCategoryId);
}


if(action != null && action.trim().equals("add")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
	double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
	
	Category c = Category.loadById(categoryId);
	if(!c.isLeaf()) {
		out.println("非叶子节点下不能添加商品！");
		return;
	}
	
	Product p = new Product();
	p.setId(-1);
	p.setName(name);
	p.setDescr(descr);
	p.setNormalPrice(normalPrice);
	p.setMemberPrice(memberPrice);
	p.setPdate(new Timestamp(System.currentTimeMillis()));
	p.setCategoryId(categoryId);
	
	ProductMgr.getInstance().addProduct(p);
	
	out.println("Add Operation Succeeded!");
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
    <title></title>
    
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript">
	var leafArray
	<!--
	function checkLeaf() {
	
	}
	-->
</script>


  </head>
  
  <body>
  	<center>添加产品</center>
    <form action="productadd.jsp" method="post" onsubmit="checkLeaf()" name="form">
    	<input type="hidden" name=action value="add">
   
    	<table>
    		<tr>
    			<td>name: </td>
    			<td><input type="text" name="name"></td>
    		</tr>
    		<tr>
    			<td>Description: </td>
    			<td><textarea rows="8" cols="60" name="descr"></textarea></td>
    		</tr>
    		<tr>
    			<td>Normal Price: </td>
    			<td><input type="text" name="normalprice"></td>
    		</tr>
    		<tr>
    			<td>Member Price: </td>
    			<td><input type="text" name="memberprice"></td>
    		</tr>
    		<tr>
    			<td>Category: &nbsp; &nbsp;</td>
    			<td>
	    			<select name="categoryid">
				  			<option value="0">Select </option>
								<%
								List<Category> categories = Category.getCategories();
								
								for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
									Category c = it.next();
									String preStr = "";
									if(c.isLeaf()) {
										for(int i=1; i<c.getGrade(); i++) {
											preStr = preStr + "--";
										}
									
								%>					
										<option value="<%= c.getId() %>" <%= c.getId() == categoryId ? "selected" : "" %> ><%= preStr + c.getName() %></option>
								<%
									}
								}
								%>
				  		</select> &nbsp; &nbsp;
    			</td>
    		</tr>
    		<tr>
    			<td colspan=2><input type="submit" value="Submit"></td>
    		</tr>
    		
    	</table>
    </form>
    
    
  </body>
</html>
