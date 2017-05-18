<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*"%>
<%@ page import="java.sql.*"%>

<%
	User u = (User) session.getAttribute("user");
%>

<%
	String strId = request.getParameter("id");
	int id = 0;
	if (strId != null && !strId.trim().equals("")) {
		id = Integer.parseInt(strId);
	}
	Product p = null;
	p = ProductMgr.getInstance().loadById(id);
	Category c = Category.loadById(p.getCategoryId());
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Shenglan Xiao">

<title></title>

<!-- Bootstrap Core CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="css/shop-homepage.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">

<!--  Font Awesome -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<style>
select {
	border: solid 2px #E7E7E7;
	background: transparent;
	padding: 5px;
	width: 90px;
	font-size: 12px;
	appearance: none;
	-moz-appearance: none;
	-webkit-appearance: none;
	background: url("http://ourjs.github.io/static/2015/arrow.png")
		no-repeat scroll right center transparent;
}

select::-ms-expand {
	display: none;
}

.spinner input {
	text-align: center;
}

.input-group-btn-vertical {
	position: relative;
	white-space: nowrap;
	width: 2%;
	vertical-align: middle;
	display: table-cell;
}

.input-group-btn-vertical>.btn {
	display: block;
	float: none;
	width: 100%;
	max-width: 100%;
	padding: 8px;
	margin-left: -1px;
	position: relative;
	border-radius: 0;
}

.input-group-btn-vertical>.btn:first-child {
	border-top-right-radius: 4px;
}

.input-group-btn-vertical>.btn:last-child {
	margin-top: -2px;
	border-bottom-right-radius: 4px;
}

.input-group-btn-vertical i {
	position: absolute;
	top: 0;
	left: 4px;
}
</style>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries-->
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
	<!-- end of Navigation -->
	&nbsp;
	<!-- Breadcrumb -->
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<ol class="breadcrumb">
					<li><span style="font-family: Times; font-size: 20px;"><a href="index.jsp">Home</a></span></li>
					<li><span style="font-family: Times; font-size: 18px;"><a href="productsofcategory.jsp?categoryid=<%=c.getId() %>"><%=c.getName()%></a></span></li>
					<li class="active"><span style="font-family: Times; font-size: 16px;"><%=p.getName()%></span></li>
				</ol>
			</div>
		</div>
	</div>
	&nbsp;&nbsp;
	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-1">
				<img class="img-responsive" src="images/product/<%=p.getId()%>.jpg"
					alt="product: <%=p.getName()%>" />
			</div>

			<!-- main description of a product -->
			<div class="col-xs-12 col-sm-4">
				<div>
					<table>
						<tr>
							<td><h2><%=p.getName()%></h2></td>
						</tr>
						<tr>
							<td><h5>
									Member Price: &nbsp;&nbsp; <span
										style="font-size:16px; color:red">$<%=new java.text.DecimalFormat("#.00").format(p.getMemberPrice())%></span>
								</h5></td>
						</tr>
						<tr>
							<td><h5>
									Normal Price: &nbsp;&nbsp;<span
										style="font-size:16px; color:red">$<%=new java.text.DecimalFormat("#.00").format(p.getNormalPrice())%></span>
								</h5></td>
						</tr>


					</table>
				</div>
				&nbsp;&nbsp;
				<!-- product parameters -->
				<div>
					<form name="" action="" method="post">
						<input type="hidden" name="action" value="simplesearch">
						<table>
							<tr>
								<td>Color: &nbsp; &nbsp;</td>
								<td><select name="color">
										<option value="0">Select</option>
										<%
											
										%>
										<option value="1">Blue</option>
										<%
											
										%>
								</select> &nbsp; &nbsp;</td>
							</tr>
						</table>
						&nbsp;

						<table>
							<tr>
								<td>Capacity: &nbsp; &nbsp;</td>
								<td><select name="capacity">
										<option value="0">Select</option>
										<%
											
										%>
										<option value="1">16GB</option>
										<%
											
										%>
								</select> &nbsp; &nbsp;</td>
							</tr>
						</table>
						&nbsp;
						<div class="row">
							<div class="col-xs-2 col-sm-3 col-lg-2">
								Quantity: &nbsp;&nbsp;
							</div>
							<div class="col-xs-3 col-xs-right-offset-7 col-sm-5 col-sm-right-offset-4 col-lg-4 col-lg-right-offset-6">
								<div class="input-group spinner">
									<input type="text" class="form-control" value="1" min="1"
										max="100">
									<div class="input-group-btn-vertical">
										<button class="btn btn-default" type="button">
											<i class="fa fa-caret-up"></i>
										</button>
										<button class="btn btn-default" type="button">
											<i class="fa fa-caret-down"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				&nbsp;
				<!-- buy button -->
				<div class="row">
					<div class="col-xs-12  col-sm-12">
						<a href="checkout.jsp?id=<%=p.getId()%>"><button
								class="btn btn-success">Check Out</button></a>
					</div>
					&nbsp;
					<div class="col-xs-12 col-sm-12">
						<a href="buy.jsp?id=<%=p.getId()%>"><button
								class="btn btn-success">
								<span style="margin-right:10px"
									class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
								Add to Cart
							</button></a>
					</div>					
				</div>
				&nbsp;
			</div>

			<div class="col-xs-12 col-sm-3">
				<p>Like this product?</p>
				<p>Share it to friends</p>
				<div>
					<div>
						<a class="btn btn-social-icon btn-google-plus"
							href="http://google.com/+"><i class="fa fa-google-plus"></i></a>
						<a class="btn btn-social-icon btn-facebook"
							href="http://www.facebook.com/profile.php?id="><i
							class="fa fa-facebook"></i></a> <a
							class="btn btn-social-icon btn-linkedin"
							href="http://www.linkedin.com/in/"><i class="fa fa-linkedin"></i></a>
						<a class="btn btn-social-icon btn-twitter"
							href="http://twitter.com/"><i class="fa fa-twitter"></i></a> <a
							class="btn btn-social-icon btn-youtube"
							href="http://youtube.com/"><i class="fa fa-youtube"></i></a> <a
							class="btn btn-social-icon" href="mailto:"><i
							class="fa fa-envelope-o"></i></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	&nbsp;&nbsp;

	<!-- product description in detail -->
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<ul class="nav nav-tabs">
							<li role="presentation" class="active"><a
								href="#productDescr" data-toggle="tab">Product Description</a></li>
							<li role="presentation"><a href="#productDetail"
								data-toggle="tab">Product Details</a></li>
							<li role="presentation"><a href="#customerQA"
								data-toggle="tab">Customer Questions & Answers</a></li>

						</ul>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div class="tab-pane fade in active" id="productDescr">Default1</div>
							<div class="tab-pane fade" id="productDetail">Default 2</div>
							<div class="tab-pane fade" id="customerQA">Default 3</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- script for add and minus -->
	<script type="text/javascript">
		$(function() {
	
			$('.spinner .btn:first-of-type').on('click', function() {
				var btn = $(this);
				var input = btn.closest('.spinner').find('input');
				if (input.attr('max') == undefined || parseInt(input.val()) < parseInt(input.attr('max'))) {
					input.val(parseInt(input.val(), 10) + 1);
				} else {
					btn.next("disabled", true);
				}
			});
			$('.spinner .btn:last-of-type').on('click', function() {
				var btn = $(this);
				var input = btn.closest('.spinner').find('input');
				if (input.attr('min') == undefined || parseInt(input.val()) > parseInt(input.attr('min'))) {
					input.val(parseInt(input.val(), 10) - 1);
				} else {
					btn.prev("disabled", true);
				}
			});
	
		});
	</script>

</body>
</html>
