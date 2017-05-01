<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
// TODO first validate the id
int id = Integer.parseInt(request.getParameter("id"));
Category.deleteById(id); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   
    <title></title>
    
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <script type="text/javascript">
    	window.parent.main.document.write("Delete Successfully!");	
    </script>
  </body>
</html>
