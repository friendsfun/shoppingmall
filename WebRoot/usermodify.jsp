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

<%
String action = request.getParameter("action");

if(action != null && action.trim().equals("modify")) {
	String username = request.getParameter("username");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	u.setUsername(username);
	u.setPhone(phone);
	u.setAddr(addr);
	u.update();
	out.println("Congratulations! Information Updated.");
	//return;
}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/register-style.css" rel="stylesheet">
    
    <title>Change User Information Page</title>	

  </head>
  
  <body>
    <div class="container">
    	<div class="row">
    		<div class="col-xs-offset-2 col-xs-7">
    		<h4>Change User Information</h4>
    		</div>
    	</div>
    	<div class="row">
	    	<div class="col-xs-offset-2 col-xs-7">
	    		<form name="form" id="register-form" action="usermodify.jsp" method="post" role="form" onSubmit="return checkdata()" >
					<input type="hidden" name="action" value="modify">
					<div class="form-group">
						<input type="text" name="username" value="<%= u.getUsername() %>" id="username" tabindex="1" class="form-control" placeholder="Username">
					</div>
		
					<div class="form-group">
						<input type="text" name="phone" value="<%= u.getPhone() %>" id="phone" tabindex="2" class="form-control" placeholder="Phone">
					</div>
					<div class="form-group">
						<textarea name="addr" rows="12" cols="90" placeholder="Address"><%= u.getAddr() %></textarea>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-6 col-sm-offset-3">
								<input type="submit" name="change-submit" id="change-submit" tabindex="4" class="form-control btn btn-register" value="Change">
							</div>
						</div>
					</div>
				</form>
	    	</div>
    	</div>
    </div>
    
  <!-- jQuery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

 <!-- Bootstrap Core JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="js/regcheckdata.js"></script>   
  </body>
</html>
