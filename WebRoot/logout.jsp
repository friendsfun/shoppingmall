<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>

<%
session.removeAttribute("user");
response.sendRedirect("index.jsp");
%>
