<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="_sessionCheck.jsp" %>

<!DOCTYPE html>
<html>
  <head>
    <title>商城管理后台</title>
	
    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
<frameset rows="29,*" frameborder="0" border="0" framespacing="0" cols="*">
  <frame name="top" scrolling="NO" noresize src="top.html">
  <frameset cols="20%,*" frameborder="0" border="0" framespacing="0" rows="*" scrolling="NO" name="mleft">
    <frame src="menu.html" frameborder=NO border="0" scrolling="NO" >
    <frameset rows="20, 100%,*" name="content" frameborder="1" framespacing="1" cols="*">
      <frame src="title.html" frameborder=0 noresize scrolling="NO" name="mtitle">
      <frame src="" frameborder=0  name="main" marginwidth="0" marginheight="0" scrolling="YES">
      <frame src="" frameborder=0  name="detail">
    </frameset>
  </frameset>
</frameset>

<noframes>
    <body>
    你的浏览器不支持frame.
    </body>
</noframes>

</html>
