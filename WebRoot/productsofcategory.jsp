<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
User u = (User) session.getAttribute("user");
%>

<%
	String strCategoryid = request.getParameter("categoryid");
	int categoryid = 0;
	if (strCategoryid != null && !strCategoryid.trim().equals("")) {
		categoryid = Integer.parseInt(strCategoryid);
	}
	Category c = Category.loadById(categoryid);
	
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="ABC Online Store">
    <meta name="author" content="Shenglan Xiao">

    <title>ABC One-Stop Shopping Website Homepage</title>

    <!-- Bootstrap Core CSS -->
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
  

    <!-- Custom CSS -->
    <link href="css/shop-homepage.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body style="font-family: Times;">
    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp"><span style="font-size: 22px;">One-Stop Shopping Website</span></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                	<li>
                		<a href="index.jsp"><span style="font-size: 18px;">Home</span></a>
                	</li>
                    <li>
                        <a href="about.html"><span style="font-size: 18px;">About</span></a>
                    </li>
                    <li>
                        <a href="contact.jsp"><span style="font-size: 18px;">Contact</span></a>
                    </li>
                </ul>
				<div class="col-sm-4 col-md-4">
					<form class="navbar-form" action="searchresultshow.jsp" method="post">
						<input type="hidden" name="action" value="simplesearch">
						<div class="input-group">
							<input type="text" style="font-size: 16px;" name="keyword" class="form-control" placeholder="Search">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				
				<ul class="nav navbar-nav navbar-right">
					<%
						if (u == null) {
					%>
					<li><a href="register.jsp"><span style="font-size: 16px;">Sign in / Register</span></a></li>
					<%
						} else {
					%>
					<a href="userprofile.jsp"
						class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-haspopup="true" aria-expanded="false">
					<li class="dropdown">
						<span style="font-size: 16px;"><%=u.getUsername()%></span>
						<span class="caret"></span>					
						<ul class="dropdown-menu">
							<li><a href="userprofile.jsp">My Account</a></li>
							<li><a href="userprofile.jsp#myOrder">My Orders</a></li>
							<li><a href="userprofile.jsp#settings">Settings</a></li>
						</ul>
					</li></a>

					<li><a href="logout.jsp"><span style="font-size: 16px;">Log out</span></a></li>
					<%
						}
					%>
					<li><a href="cart.jsp"> <span style="margin-right:10px; color: #0099cc;"
							class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
							<span style="color: #0099cc; font-size:16px;">Cart</span>		
					</a></li>
				</ul>										
			</div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
	&nbsp;
	<!-- Breadcrumb -->
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<ol class="breadcrumb">
					<li><a href="index.jsp"><span style="font-family:Times; font-size: 20px">Home</span></a></li>
					<%
					if(c.isLeaf()) {
						Category pc = Category.loadById(c.getPid());
					%>
					<li><span style="font-family:Times; font-size: 18px">
					<a href="productsofcategory.jsp?categoryid=<%=pc.getId() %>"><%=pc.getName()%></a></span></li>
					<%
					}
					%>
					<li class="active"><span style="font-family:Times; font-size: 16px"><%=c.getName()%></span></li>
				</ol>
			</div>
		</div>
	</div>
	&nbsp;&nbsp;
    <!-- Page Content -->
    <div class="container">
		<!-- Showing the latest products starting here -->
		<div class="row">		
			<%
			List<Product> products = null;
			if(c.isLeaf()) {
				products = ProductMgr.getInstance().getProductsBySubCategoryid(categoryid);
			} else {
				products = ProductMgr.getInstance().getProductsByTopCategoryid(categoryid);
			}
			for(int i = 0; i < products.size(); i++) {
				Product p = products.get(i);	
			%>
			<div class="col-sm-4">
				<div class="thumbnail">
					<a href="productshowdetail.jsp?id=<%=p.getId()%>"><img
		
						class="img-responsive"
						src="images/product/<%=p.getId()%>.jpg"
						alt="product: <%= p.getName() %>"></a>
					<div class="caption">
						<h6 class="text-center">
							<a href="productshowdetail.jsp?id=<%=p.getId()%>"><%=p.getName()%></a>
						</h6>
						<h6 class="text-center">
							<span style="color:red;">Member Price: $<%=p.getMemberPrice()%></span>
						</h6>
						<p class="pull-right">
							<a href="buy.jsp?id=<%= p.getId() %>"><button type="button"
									class="btn btn-success btn-xs">Buy</button></a>
						</p>
					</div>
				</div>
			</div>
		<%
		}
		%>
		</div>
	</div>
    <!-- /.container -->

    <div class="container">
        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p class="text-center">Copyright &copy; Your Website 2017</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>

</html>