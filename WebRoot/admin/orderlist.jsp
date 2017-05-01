<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.serena.shopping.*"%>
<%@page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%!
private static final int PAGE_SIZE = 3;
%>

<%
String strPageNo = request.getParameter("pageno");
int pageNo = 1;
if(strPageNo != null) {
	pageNo = Integer.parseInt(strPageNo);
}

if(pageNo < 1) {
	pageNo = 1;
}

List<SalesOrder> orders = new ArrayList<SalesOrder>(); 
int pageCount = OrderMgr.getInstance().getOrders(orders, pageNo, PAGE_SIZE);

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
            <th>Order ID</th>
            <th>Username</th>
            <th>Address</th>
            <th>Order Date</th>
            <th>Status</th>
            
            <th>Action</th>
        </tr>
    </thead>
    <%
    for(Iterator<SalesOrder> it = orders.iterator(); it.hasNext(); ) {
    	SalesOrder so = it.next();
     %>
       <tr>
           <td><%= so.getId() %></td>
           <td><%= so.getUser().getUsername() %></td> 
           <td><%= so.getAddr() %></td> 
           <td><%= so.getoDate() %></td>          
           <td><%= so.getStatus() %></td>        
          
           <td>
           	   <a href="orderdetailshow.jsp?id=<%= so.getId() %>" target="main">Detail</a>
           	   &nbsp; &nbsp;
           	   <a href="ordermodify.jsp?id=<%= so.getId() %>" target="main">Modify</a>
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
	<a href="orderlist.jsp?pageno=<%= 1 %>" > First Page</a> &nbsp;
	<% if(pageNo != 1) { %>
	<a href="orderlist.jsp?pageno=<%= pageNo -1 %>" > Previous Page</a> &nbsp;
	<% }  %>
	
	<% if(pageNo != pageCount) { %>
	<a href="orderlist.jsp?pageno=<%= pageNo + 1 %>" > Next Page</a> &nbsp;
	<% } %>
	<a href="orderlist.jsp?pageno=<%= pageCount %>">Last Page</a>
	</center>
  
   <!-- jQuery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

 <!-- Bootstrap Core JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
  </body>
</html>
