<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%

String action = request.getParameter("action");
Product p = null;

String strId = request.getParameter("id");
int id = -1;
if(strId != null && !strId.trim().equals("")) {
	id = Integer.parseInt(strId);
	p = ProductMgr.getInstance().loadById(id);
}

String strCategoryId = request.getParameter("categoryid");
int categoryId = -1;
if(strCategoryId != null && !strCategoryId.trim().equals("")) {
	categoryId = Integer.parseInt(strCategoryId);
}



if(action != null && action.trim().equals("delete")) {
	if(id != -1) {
		
		ProductMgr.getInstance().deleteProductById(id);
		out.println("Deleting By Product ID Succeeded!");
	}
	
	if(categoryId != -1) {
		ProductMgr.getInstance().deleteProductByCategoryId(categoryId);
		out.println("Deleting By Category Succeeded!");
	}	

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
  	<center>Delete Product Page</center>
  	<br>
  	<center>Delete By ProductId</center>
    <form action="productdelete.jsp" method="post" name="form">
    	<input type="hidden" name=action value="delete">
   
    	<table>
    		<tr>
    			<td>Product ID: &nbsp; &nbsp;</td>
    			<td>
    			<%
    			if(p == null) {
    			%>
    				<input type="text" name="id" > &nbsp; &nbsp;
    			<%
    			} else {
    			%>
	    			<input type="text" name="id" value="<%= p.getId() %>"> &nbsp; &nbsp;
    			<%
    			}
    			%>
    			</td>
    		</tr>
    		<tr>
    			<td colspan=2><input type="submit" value="Delete"></td>
    		</tr>
    	</table>
    </form>
    <center>Delete By Category</center>
    <form action="productdelete.jsp" method="post" name="form">
    	<input type="hidden" name=action value="delete">
    	<table>
    		<tr>
    			<td>Delete By Category: &nbsp; &nbsp;</td>
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
									if(p == null) {
								%>	
									<option value="<%= c.getId() %>"><%= preStr + c.getName() %></option>								
								<%
									} else {
								%>				
									<option value="<%= c.getId() %>" <%= c.getId() == p.getCategoryId() ? "selected" : "" %> ><%= preStr + c.getName() %></option>
								<%
										}
									}
								}
								%>
				  		</select> &nbsp; &nbsp;
    			</td>
    		</tr>
    		<tr>
    			<td colspan=2><input type="submit" value="Delete"></td>
    		</tr>
    		
    	</table>
    </form>
    
    
  </body>
</html>
