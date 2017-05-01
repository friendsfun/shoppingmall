<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.serena.shopping.*" %>
<%@page import="java.sql.*" %>

<%
User u = (User) session.getAttribute("user");
if(u == null) {
	out.println("You haven't logged in!");
	response.sendRedirect("register.jsp");
	return;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
    <title>Self Service Page</title>
    
	

  </head>
  
  <body>
    <a href="usermodify.jsp">Change My Information</a>
  </body>
</html>
