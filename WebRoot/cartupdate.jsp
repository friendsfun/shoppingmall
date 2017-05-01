<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>


<%
Cart cart = (Cart) session.getAttribute("cart");

if(cart == null) {
	out.println("There is no items in the shopcart.");
	return;
}

List<CartItem> items = cart.getItems();
String strPid = request.getParameter("pid");
String strCount = request.getParameter("count");
 
for(int i = 0; i < items.size(); i++) {
	CartItem ci = items.get(i);
	Product p = ci.getProduct();
	if(p.getId() == Integer.parseInt(strPid)) {
		if(strCount != null && !strCount.trim().equals("")) {
			ci.setCount(Integer.parseInt(strCount));
		}
	}
	
}

// response.sendRedirect("cart.jsp");
%>