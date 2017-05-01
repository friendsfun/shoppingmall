<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.serena.shopping.*"%>
<%@page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
List<User> users = User.getUsers();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	    
    <title>User List</title>
    
	
  </head>
  
  <body>
  
  	<div class="container">
    <div class="row col-xs-10 col-xs-offset-1 custyle">
    <table class="table table-striped custab">
    <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Register Date</th>
            <th>Action</th>
        </tr>
    </thead>
    <%
    for(int i = 0; i < users.size(); i++) {
    	User u = users.get(i);
     %>
       <tr>
           <td><%= u.getId() %></td>
           <td><%= u.getUsername() %></td>
           <td><%= u.getPhone() %></td>
           <td><%= u.getAddr() %></td>
           <td><%= u.getRdate() %></td>
           <td>
           	   <a href="userdelete.jsp?id=<%= u.getId() %>" target="main">Delete</a>
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
