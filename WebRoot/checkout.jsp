<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
// check session to see if a user has logged in
User u = (User) session.getAttribute("user");
if(u == null) {
	response.sendRedirect("register.jsp");
}
// check session to see if there is a cart in it
Cart cart = (Cart) session.getAttribute("cart");
if(cart == null) {
	cart = new Cart();
	session.setAttribute("cart", cart);
}
%>


<%
int id = Integer.parseInt(request.getParameter("id"));
CartItem ci = new CartItem();
Product p = ProductMgr.getInstance().loadById(id);
ci.setProduct(p);
ci.setPrice(u == null ? p.getNormalPrice() : p.getMemberPrice()); // need to check if the user logged in
ci.setCount(1);
cart.add(ci);

response.sendRedirect("confirm.jsp");
%>

