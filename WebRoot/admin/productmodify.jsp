<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%

String action = request.getParameter("action");

String strId = request.getParameter("id");
int id = 0;
if(strId != null && !strId.trim().equals("")) {
	id = Integer.parseInt(strId);
}
Product p = ProductMgr.getInstance().loadById(id);

if(action != null && action.trim().equals("modify")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
	double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
	int categoryId = Integer.parseInt(request.getParameter("categoryid"));
	
	p.setName(name);
	p.setDescr(descr);
	p.setNormalPrice(normalPrice);
	p.setMemberPrice(memberPrice);
	p.setCategoryId(categoryId);
	
	ProductMgr.getInstance().updateProduct(p);
	
	//out.println("Modifying Product Succeeded!");
	response.sendRedirect("productlist.jsp");
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


  </head>
  
  <body>
  	<center>Modify Product</center>
    <form action="productmodify.jsp" method="post" name="form">
    	<input type="hidden" name=action value="modify">
    	<input type="hidden" name=id value="<%= id %>">
   
    	<table>
    		<tr>
    			<td>name: </td>
    			<td><input type="text" name="name" value="<%= p.getName() %>"></td>
    		</tr>
    		<tr>
    			<td>Description: </td>
    			<td><textarea rows="8" cols="60" name="descr"><%= p.getDescr() %></textarea></td>
    		</tr>
    		<tr>
    			<td>Normal Price: </td>
    			<td><input type="text" name="normalprice" value="<%= p.getNormalPrice() %>"></td>
    		</tr>
    		<tr>
    			<td>Member Price: </td>
    			<td><input type="text" name="memberprice" value="<%= p.getMemberPrice() %>"></td>
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
										<option value="<%= c.getId() %>" <%= c.getId() == p.getCategoryId() ? "selected" : "" %> ><%= preStr + c.getName() %></option>
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
