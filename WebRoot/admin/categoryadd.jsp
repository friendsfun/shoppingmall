<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
String strPid = request.getParameter("pid");
int pid = 0;
if(strPid != null && !strPid.trim().equals("")) {
	pid = Integer.parseInt(strPid);
}

String action = request.getParameter("action");

if(action != null && action.trim().equals("add")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	if(pid == 0) {
		Category.addTopCategory(name, descr);
	} else {
		Category.addChildCategory(pid, name, descr);
	}
	out.println("Add Operation Succeeded!");
}

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
  	<center>添加类别</center>
    <form action="categoryadd.jsp" method="post">
    	<input type="hidden" name=action value="add">
    	<input type="hidden" name="pid" value="<%= pid %>">
    	<table>
    		<tr>
    			<td>Category Name: </td>
    			<td><input type="text" name="name"></td>
    		</tr>
    		<tr>
    			<td>Category Description: </td>
    			<td><textarea rows="8" cols="60" name="descr"></textarea></td>
    		</tr>
    		<tr>
    			<td colspan=2><input type="submit" value="Submit"></td>
    		</tr>
    		
    	</table>
    
    </form>
  </body>
</html>
