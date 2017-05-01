<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.serena.shopping.*"%>
<%@page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
List<Category> categories = Category.getCategories();
 

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	    
    <title></title>
    
	
  </head>
  
  <body>
  	<div class="container">
    <div class="row col-sm-12 custyle">
    <table class="table table-striped custab">
    <thead>
        <tr>
            <th>CategoryID</th>
            <th>Name</th>
            <th>PID</th>
            <th>Grade</th>
            <th>Action</th>
            <th>Add Product</th>
        </tr>
    </thead>
    <%
    for(int i = 0; i < categories.size(); i++) {
    	Category c = categories.get(i);
    	String preStr = "";
    	for(int j = 1; j < c.getGrade(); j++) {
    		preStr = preStr + "----";
    	}
     %>
       <tr>
           <td><%= c.getId() %></td>
           <td><%= preStr + c.getName() %></td> 
           
           <td><%= c.getPid() %></td>
           <td><%= c.getGrade() %></td>
         
           <td>
           	   <a href="categoryadd.jsp?pid=<%= c.getId() %>" target="main">Add Subcategory</a> &nbsp
           	   <a href="categorymodify.jsp?id=<%= c.getId() %>" target="main">Modify</a> &nbsp
           	   <a href="categorydelete.jsp?id=<%= c.getId() %>" target="main">Delete</a>
           </td>
           <td>
           	 <%
           		if(c.isLeaf()) {
           	 %>
           	 <a href="productadd.jsp?categoryid=<%= c.getId() %>" target="main">Add New Product</a>
           	 <%
           		 } else {          		 
           	 %>
           	 <em>N/A</em>
           	 <%
           	 	}
           	 %>
           </td>      
       </tr> 
    <%
    }
    %>   
                 
    </table>
    </div>
</div>
  
   <!-- jQuery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

 <!-- Bootstrap Core JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
  </body>
</html>
