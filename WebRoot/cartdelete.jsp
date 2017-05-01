<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>


<%
Cart cart = (Cart) session.getAttribute("cart");

if(cart == null) {
	out.println("There is no items in the shop cart.");
	return;
}

List<CartItem> items = cart.getItems();
String strPid = request.getParameter("pid");
int pid = Integer.parseInt(strPid);

cart.remove(pid);


%>