<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
// TODO first validate the id
int id = 0;
Category c = null;
String name = "";
String descr = "";

String action = request.getParameter("action");
if(action != null && action.trim().equals("modify")) {
	id = Integer.parseInt(request.getParameter("id"));
	name = request.getParameter("name");
	descr = request.getParameter("descr");
	Category.updateById(id, name, descr);
	out.println("Modify Successfully!");
	//return;
} else {
	id = Integer.parseInt(request.getParameter("id"));
	c = Category.loadById(id);
	name = c.getName();
	descr = c.getDescr();
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/register-style.css" rel="stylesheet">
    
    <title>Modify Category Page</title>
    
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  	<div class="container">
    	<div class="row">
    		<div class="col-xs-offset-2 col-xs-7">
    		<h4>Modify Category Information</h4>
    		</div>
    	</div>
    	<div class="row">
	    	<div class="col-xs-offset-2 col-xs-7">
	    		<form name="form" action="categorymodify.jsp" method="post" role="form" >
					<input type="hidden" name="action" value="modify">
					<input type="hidden" name="id" value=<%= id %> >
					<div class="form-group">
						<input type="text" name="name" value="<%= name %>" id="name" tabindex="1" class="form-control" placeholder="name">
					</div>
					<div class="form-group">
						<textarea name="descr" rows="12" cols="70" placeholder="descr"><%= descr %></textarea>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-6 col-sm-offset-3">
								<input type="submit" name="change-submit" id="change-submit" class="form-control btn btn-register" value="Modify">
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
 
  </body>
</html>
