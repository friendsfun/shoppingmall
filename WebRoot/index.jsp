<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
User u = (User) session.getAttribute("user");
%>

<%
List<Category> topCategories = Category.getTopCategories();
List<Category> subCategories = null; 
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
    
<style type="text/css">
.dropdown-submenu {
    position: relative;
}

.dropdown-submenu>.dropdown-menu {
    top: 0;
    left: 100%;
    margin-top: -6px;
    margin-left: -1px;
    -webkit-border-radius: 0 6px 6px 6px;
    -moz-border-radius: 0 6px 6px;
    border-radius: 0 6px 6px 6px;
}

.dropdown-submenu:hover>.dropdown-menu {
    display: block;
}

.dropdown-submenu>a:after {
    display: block;
    content: " ";
    float: right;
    width: 0;
    height: 0;
    border-color: transparent;
    border-style: solid;
    border-width: 5px 0 5px 5px;
    border-left-color: #ccc;
    margin-top: 5px;
    margin-right: -10px;
}

.dropdown-submenu:hover>a:after {
    border-left-color: #fff;
}

.dropdown-submenu.pull-left {
    float: none;
}

.dropdown-submenu.pull-left>.dropdown-menu {
    left: -100%;
    margin-left: 10px;
    -webkit-border-radius: 6px 0 6px 6px;
    -moz-border-radius: 6px 0 6px 6px;
    border-radius: 6px 0 6px 6px;
}  
</style>

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
					<li class="dropdown"><span style="font-size: 16px;">Hello, <a href="userprofile.jsp"
						class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-haspopup="true" aria-expanded="false"><%=u.getUsername()%></span>
							<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">My Account</a></li>
							<li><a href="#">My Orders</a></li>
						</ul></li>

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

    <!-- Page Content -->
    <div class="container">
        <div class="row">
            <div class="col-md-3">
            	<p class="lead">Shop By Department</p>
            	<%
            	for(int i = 0; i < topCategories.size(); i++) {
            		Category topc = topCategories.get(i);
            	%>
				<div class="dropdown-submenu ">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><a href="productsofcategory.jsp?categoryid=<%= topc.getId() %>"><span style="font-size:18px;font-family:Times;"><%= topc.getName() %></span></a></a>
					<ul class="dropdown-menu">
						<%
						subCategories = Category.getSubCategories(topc.getId());
						for(int j = 0; j < subCategories.size(); j++) {
							Category subc = subCategories.get(j);
						%>
						<li><a href="productsofcategory.jsp?categoryid=<%= subc.getId() %>"><%= subc.getName() %></a></li>
						<%
						}
						%>
					</ul>
				</div>
				&nbsp;
				<%  
				}
				%>
				<div class="dropdown-submenu ">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span style="font-size:18px;font-family:Times;">Dropdown2 Link 4</span></a>
					<ul class="dropdown-menu">
						<li><a href="#">Dropdown2 Submenu Link 4.1</a></li>
						<li><a href="#">Dropdown2 Submenu Link 4.2</a></li>
						<li><a href="#">Dropdown2 Submenu Link 4.3</a></li>
						<li><a href="#">Dropdown2 Submenu Link 4.4</a></li>

					</ul>
				</div>
            </div>
			<div class="col-md-9">
				<div class="row carousel-holder">
					<div class="col-md-12">
						<div id="carousel-example-generic" class="carousel slide"
							data-ride="carousel">
							<ol class="carousel-indicators">
								<li data-target="#carousel-example-generic" data-slide-to="0"
									class="active"></li>
								<li data-target="#carousel-example-generic" data-slide-to="1"></li>
								<li data-target="#carousel-example-generic" data-slide-to="2"></li>
							</ol>
							<div class="carousel-inner">
								<div class="item active">
									<img class="slide-image" src="http://placehold.it/800x300"
										alt="">
								</div>
								<div class="item">
									<img class="slide-image" src="http://placehold.it/800x300"
										alt="">
								</div>
								<div class="item">
									<img class="slide-image" src="http://placehold.it/800x300"
										alt="">
								</div>
							</div>
							<a class="left carousel-control" href="#carousel-example-generic"
								data-slide="prev"> <span
								class="glyphicon glyphicon-chevron-left"></span>
							</a> <a class="right carousel-control"
								href="#carousel-example-generic" data-slide="next"> <span
								class="glyphicon glyphicon-chevron-right"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		&nbsp;
		&nbsp;
		<!-- Showing the latest products starting here -->
		<button type="button" class="btn btn-default btn-lg btn-block">New Arrivals</button>
			&nbsp;
			&nbsp;
		<div class="row">
			
			<%
				int latestCount = 8;
				List<Product> latestProducts = ProductMgr.getInstance().getLatestProducts(latestCount);
				for (int i = 0; i < latestProducts.size(); i++) {
					Product p = latestProducts.get(i);
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
							<span style="color:red;">Member Price: $<%=new java.text.DecimalFormat("#.00").format(p.getMemberPrice())%></span>
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
		&nbsp;
		&nbsp;
		<!-- Showing the bestseller products starting here -->
		<button type="button" class="btn btn-default btn-lg btn-block">Bestsellers</button>
		&nbsp;
		&nbsp;
		<div class="row">
			<%
				int bestsellerCount = 8;
				List<Product> bestsellerProducts = ProductMgr.getInstance().getBestsellerProducts(bestsellerCount);
				for (int i = 0; i < bestsellerProducts.size(); i++) {
					Product p = bestsellerProducts.get(i);
			%>
			<div class="col-sm-4">
				<div class="thumbnail">
					<a href="productshowdetail.jsp?id=<%=p.getId()%>"><img
						class="img-responsive" src="images/product/<%=p.getId()%>.jpg"
						alt="product: <%=p.getName()%>"></a>
					<div class="caption">
						<h6 class="text-center">
							<a href="productshowdetail.jsp?id=<%=p.getId()%>"><%=p.getName()%></a>
						</h6>
						<h6 class="text-center">
							<span style="color:red;">Member Price: $<%=new java.text.DecimalFormat("#.00").format(p.getMemberPrice())%></span>
						</h6>
						<p class="pull-right">
							<a href="buy.jsp?id=<%=p.getId()%>"><button type="button"
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

