<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>

<%

Cart cart = (Cart) session.getAttribute("cart");

if(cart == null) {

%>

<html>
<head>

	<script language="JavaScript1.2" type="text/javascript">
	<!--
	//  Place this in the 'head' section of your page.  
	
	function delayURL(url) {
		var delay = document.getElementById("time").innerHTML;
		if(delay > 0) {
			delay--;
			document.getElementById("time").innerHTML = delay;
		} else {
			window.top.location.href = url;
		}
		setTimeout("delayURL('" + url + "')", 1000);
	}
	//-->
	
	</script>

</head>

<body class="text-center">
	<p style="font-size: 20px; font-family: Times;">There is no items in the shopcart.</p>

<!-- Place this in the 'body' section -->
After <span id="time" style="background:red" >3</span> second it will automatically go to the shop home page. If not, please click the link below:
<br><a href="index.jsp">Home Page</a>
<script type="text/javascript">
	delayURL("index.jsp");
</script>
</body>
</html>

<%
}
%>