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
	<link rel="StyleSheet" href="dtree.css" type="text/css" />
   	  
	<script type="text/javascript" src="dtree.js"></script>
	
    <title></title>
    
	
  </head>
  
  <body>
  	
  	<div class="dtree">

	<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>


<script>
		var d = new dTree('d');

		d.add(0,-1,'All Categories Tree');
		

		<% 	for(int i=0; i<categories.size(); i++) {
				Category c = categories.get(i);
				int id = c.getId();
				int pid = c.getPid();
				String name = c.getName();
		%>
		d.add(<%= id %>, <%= pid %>, '<%= name %>', "javascript:onClickTreeNode(<%= id %>, <%= pid %>, '<%= name %>');");
		<%
			}
		%>
function onClickTreeNode(id, pid, name) {
	getData(id, pid, name);
}

	document.write(d);

</script>

</div>


  </body>
</html>