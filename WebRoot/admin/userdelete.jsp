<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
// TODO first validate the id
int id = Integer.parseInt(request.getParameter("id"));
User.deleteUser(id);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   
    <title></title>
    
    <script language="JavaScript1.2" type="text/javascript">
	<!--
	//  Place this in the 'head' section of your page.  
	
	function delayURL(url) {
		var delay = document.getElementById("time").innerHTML;
		if(delay > 0) {
			delay--;
			document.getElementById("time").innerHTML = delay;
		} else {
			window.location.href = url;
		}
		setTimeout("delayURL('" + url + "')", 1000);
	}
	//-->
	
	</script>

  </head>
  
  <body>
  	<p>Delete Successfully!</p>
    <!-- Place this in the 'body' section -->
	After <span id="time" style="background:red" >2</span> seconds it will automatically go to user list page. If not, please click the link below:
	<br><a href="userlist.jsp">User List</a>
	<script type="text/javascript">
		delayURL("userlist.jsp");
	</script>
  </body>
</html>

