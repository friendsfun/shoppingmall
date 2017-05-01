<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.serena.shopping.*"%>
<%@page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%!
private static final int PAGE_SIZE = 3;
%>

<%
// List<Product> products = ProductMgr.getInstance().getProducts();

String strPageNo = request.getParameter("pageno");
int pageNo = 1;
if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}

if(pageNo < 1) {
	pageNo = 1;
}

List<Product> products = new ArrayList<Product>(); 
int pageCount = ProductMgr.getInstance().getProducts(products, pageNo, PAGE_SIZE);

if(pageNo > pageCount) {
	pageNo = pageCount;
}

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
            <th>ProductID</th>
            <th>Name</th>
            <th>Description</th>
            <th>NormalPrice</th>
            <th>MemberPrice</th>
            <th>Pdate</th>
            <th>Category Name</th>
            <th>Operation</th>
        </tr>
    </thead>
    <%
    for(Iterator<Product> it = products.iterator(); it.hasNext(); ) {
    	Product p = it.next();
     %>
       <tr>
           <td><%= p.getId() %></td>
           <td><%= p.getName() %></td> 
           <td><%= p.getDescr() %></td> 
           <td><%= p.getNormalPrice() %></td>
          
           <td><%= p.getMemberPrice() %></td>
           <td><%= p.getPdate() %></td>
           <td><%= p.getCategory().getName() %></td>
          
           <td>
           	   <a href="productmodify.jsp?id=<%= p.getId() %>" target="main">Modify</a> &nbsp; &nbsp; 
           	   <a href="productdelete.jsp?id=<%= p.getId() %>" target="main">Delete</a> &nbsp; &nbsp;
           	   <a href="productimageupload.jsp?id=<%= p.getId() %>" target="main">Image Upload</a>
           </td>
                     
       </tr> 
    <%
    }
    %>   
                 
    </table>
    </div>
</div>

	<center>
	Page <%= pageNo %> &nbsp;
	Total <%= pageCount %>
	<a href="productlist.jsp?pageno=<%= 1 %>" > First Page</a> &nbsp;
	<% if(pageNo != 1) { %>
	<a href="productlist.jsp?pageno=<%= pageNo -1 %>" > Previous Page</a> &nbsp;
	<% }  %>
	
	<% if(pageNo != pageCount) { %>
	<a href="productlist.jsp?pageno=<%= pageNo + 1 %>" > Next Page</a> &nbsp;
	<% } %>
	<a href="productlist.jsp?pageno=<%= pageCount %>">Last Page</a>
	</center>
  
   <!-- jQuery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

 <!-- Bootstrap Core JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
  </body>
</html>
