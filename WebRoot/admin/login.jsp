<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String action = request.getParameter("action");
String username = "";
if(action != null && action.trim().equals("login")) {
	username = request.getParameter("username");
	// check username is valid or not
	String password = request.getParameter("password");
	if(username == null || !username.trim().equals("admin")) {
		out.println("username not correct!");
	} else if(password == null || !password.trim().equals("admin")) {
		out.println("password not correct!");
	} else {
		session.setAttribute("adminLogined", "true");
		response.sendRedirect("index.jsp");
	}		
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    
    <title>Admin Login Page</title>
    	
  </head>
  
  <body>
    <div class="container">
		<div class="row">
			<div class="col-md-offset-4 col-md-3">
		        <h4>Admin Login</h4>
		        <form action="login.jsp" method="post">
		<input type="hidden" name="action" value="login" />
		
		<input type="text" name="username" value="<%= username %>" placeholder="Username"/><br>
		<br>
		<input type="password" name="password" placeholder="Password"/>
		<br><br>
		<input type="submit" value="login"/>
    </form>         
		    </div>
		</div>
	</div>
  </body>
</html>
