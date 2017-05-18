<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*"%>
<%@ page import="java.sql.*"%>

<%
	// check session to see if a user has logged in
	User u = (User) session.getAttribute("user");
	if (u == null) {
		out.println(
				"<p class='text-center' style='font-size: 18px; padding-top: 70px;'>You have not logged in.</p>");
		out.println("<p class='text-center' style='font-size: 18px;'>Please login to pay for your order if you have an account.</p>");
		out.println("<p class='text-center' style='font-size: 18px;'>If you do not have an account, you can sign up for free!</p>");
		out.println(
				"<p class='text-center' style='font-size: 18px;'><a href=register.jsp>Log In / Sign Up</a></p><br>");
	}

	Cart cart = (Cart) session.getAttribute("cart");

	if (cart == null) {
		out.println("<br><p class='text-center' style='font-size: 18px;'>There is no items in the shopcart.</p>");
		return;
	}
	List<CartItem> items = cart.getItems();
	int id = 0;
	String name = "";
	double price = 0;
	double ciTotalPrice = 0;
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title></title>

<!-- Bootstrap Core CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">


<!-- Custom CSS -->
<link href="css/productshowdetail.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body style="font-family: Times; padding-top: 70px;">
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp"><span
					style="font-size: 22px;">One-Stop Shopping Website</span></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp"><span style="font-size: 18px;">Home</span></a>
					</li>
					<li><a href="about.html"><span style="font-size: 18px;">About</span></a>
					</li>
					<li><a href="contact.jsp"><span style="font-size: 18px;">Contact</span></a>
					</li>
				</ul>
				<div class="col-sm-4 col-md-4">
					<form class="navbar-form" action="searchresultshow.jsp"
						method="post">
						<input type="hidden" name="action" value="simplesearch">
						<div class="input-group">
							<input type="text" style="font-size: 16px;" name="keyword"
								class="form-control" placeholder="Search">
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
					<li><a href="register.jsp"><span style="font-size: 16px;">Sign
								in / Register</span></a></li>
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

					<li><a href="logout.jsp"><span style="font-size: 16px;">Log
								out</span></a></li>
					<%
						}
					%>
					<li><a href="cart.jsp"> <span
							style="margin-right:10px; color: #0099cc;"
							class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
							<span style="color: #0099cc; font-size:16px;">Cart</span>
					</a></li>
				</ul>
			</div>
 <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-md-10 col-md-offset-1">
						<table class="table table-hover">
							<thead>
								<tr>
									<th class="text-center">Product Information</th>
									<th class="text-center">Quantity</th>
									<th class="text-center">Unit Price</th>
									<th class="text-center">Total Price</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (int i = 0; i < items.size(); i++) {
										CartItem ci = items.get(i);
										Product p = ci.getProduct();
										id = p.getId();
										name = p.getName();
										ci.setPrice(u == null ? p.getNormalPrice() : p.getMemberPrice());
										price = ci.getPrice();
										ciTotalPrice = ci.getTotalPrice();
								%>
								<tr>
									<td class="col-sm-6">
										<div class="media">
											<a class="thumbnail pull-left"
												href="productshowdetail.jsp?id=<%=id%>"> <img
												class="media-object" src="images/product/<%=id%>.jpg"
												style="width: 72px; height: 72px;">
											</a>
											<div class="media-body">
												<h4 class="media-heading">
													<a href="productshowdetail.jsp?id=<%=id%>">&nbsp;
														&nbsp; <%=name%></a>
												</h4>
												<h5 class="media-heading">
													&nbsp; &nbsp; ID:
													<%=id%></h5>
											</div>
										</div>
									</td>
									<td class="col-sm-2 col-md-1 col-md-right-offset-1"
										style="text-align: center"><input type="text"
										name="<%="p" + p.getId()%>" class="form-control"
										value="<%=ci.getCount()%>"></td>
									<td class="col-sm-2 col-md-2 text-center"><span
										style="font-size: 18px">$ <%=new java.text.DecimalFormat("#.00").format(price)%></span></td>
									<td class="col-sm-2 col-md-2 text-center"><span
										style="font-size: 18px">$ <%=new java.text.DecimalFormat("#.00").format(ciTotalPrice)%></span></td>
								</tr>
								<%
									}
								%>
								<tr>
									<td> </td>
									<td> </td>
									<td><h4>Subtotal</h4></td>
									<td class="text-right"><span
										style="font-size: 20px; font-family: Times;">$ </span> <span
										id="subtotal" style="font-size: 20px; font-family: Times;"><%=new java.text.DecimalFormat("#.00").format(cart.getTotalPrice())%></span>
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td><h4>Estimated shipping</h4></td>
									<%
										if (cart.getTotalPrice() < 50) {
									%>
	
									<td class="text-right">
									<span
									style="font-size: 20px; font-family: Times;">$ </span><span
									id="shippingfee" style="font-size: 20px; font-family: Times;">10.00</span>
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td><h3>Total</h3></td>
									<td class="text-right"><h3>
											<span style="font-size: 22px; font-family: Times;">$ </span>
											<span id="total" style="font-size: 22px; font-family: Times;"><%=new java.text.DecimalFormat("#.00").format(cart.getTotalPrice() + 10)%></span>
										</h3></td>
								</tr>
								<%
									} else {
								%>
									<td class="text-right"><span
									style="font-size: 20px; font-family: Times;">$ </span><span
									id="shippingfee" style="font-size: 20px; font-family: Times;">0.00</span>
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td><h3>Total</h3></td>
									<td class="text-right"><h3>
											<span style="font-size: 22px; font-family: Times;">$ </span>
											<span id="total" style="font-size: 22px; font-family: Times;"><%=new java.text.DecimalFormat("#.00").format(cart.getTotalPrice())%></span>
										</h3></td>
								</tr>
								<% 
									}
								%>
							</tbody>
						</table>
						<br>

						<%
							if (u != null) {
						%>
						<p style="font-family: Times; font-size: 18px;"> Welcome, <%=u.getUsername()%>! Please confirm the
							address information of your order.
						</p> 						
						<%
							}
						%>
						<br>
						<form action="order.jsp" method="post">
							<table class="table table-hover">
								<tr>
									<td style="font-family: Times; font-size: 18px;"><p>Shipping Address: &nbsp; &nbsp;</p><textarea
											name="addr" rows="10" cols="60"><%=(u == null ? "" : u.getAddr())%></textarea>
									</td>
									<td class="text-right"><input type="submit"
										class="btn btn-primary" value="Order"></td>
								</tr>
							</table>
						</form>

					</div>
				</div>
			</div>
</body>
</html>