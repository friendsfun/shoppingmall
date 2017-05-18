<%@ page import="com.serena.shopping.*"%>

<%
String username = request.getParameter("username");
if(User.exsitUsername(username)) {
	response.setContentType("text/xml");
	response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setDateHeader("Expires", 0); // prevents caching at the proxy server
	response.getWriter().write("<msg> invalid! This username already exsits.</msg>");
}
%>