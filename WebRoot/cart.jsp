<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*"%>
<%@ page import="java.sql.*"%>


<%
	User u = (User) session.getAttribute("user");

	Cart cart = (Cart) session.getAttribute("cart");

	if (cart == null) {
		response.sendRedirect("emptycart.jsp");
		return;
	}

	List<CartItem> items = cart.getItems();
	if(items.size() == 0) {
		response.sendRedirect("emptycart.jsp");
		return;
	}
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
<link href="css/shop-homepage.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">

<!--  Font Awesome -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">

<style type="text/css">
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

	<div class="container">
		<div class="row">
			<div class="col-sm-12 col-md-10 col-md-offset-1">
				<form action="cartupdate.jsp">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="text-center">Product Information</th>
								<th class="text-center">Quantity</th>
								<th class="text-center">Unit Price</th>
								<th class="text-center">Total Price</th>
								<th class="text-center">Action</th>
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
							<tr id="tr_p<%=id %>">
								<td class="col-sm-6 col-md-4">
									<div class="media">
										<a class="thumbnail pull-left"
											href="productshowdetail.jsp?id=<%=id%>"> <img
											class="media-object" src="images/product/<%=id%>.jpg"
											style="width: 72px; height: 72px;">
										</a>
										<div class="media-body">
											<h4 class="media-heading">
												<a href="productshowdetail.jsp?id=<%=id%>">&nbsp; &nbsp;
													<%=name%></a>
											</h4>
											<h5 class="media-heading">
												&nbsp; &nbsp; ID:
												<%=id%></h5>
										</div>
									</div>
								</td>
								<td class="col-sm-1 col-md-1" style="text-align: center">
									<div class="input-group spinner">
										<input type="text" class="form-control" id="count_p<%=id%>"
											value="<%=ci.getCount()%>" min="1" max="10">
										<div class="input-group-btn-vertical">
											<button class="btn btn-default" type="button"
												onclick="addOne(<%=id%>, 10)">
												<i class="fa fa-caret-up"></i>
											</button>
											<button class="btn btn-default" type="button"
												onclick="minusOne(<%=id%>, 1)">
												<i class="fa fa-caret-down"></i>
											</button>
										</div>
									</div>
								</td>
								<td class="col-sm-2 col-md-2 text-center td_unitPrice"><span style="font-size: 16px">$ </span><span
									id="unitPrice_p<%=id%>" style="font-size: 16px"><%=new java.text.DecimalFormat("#.00").format(price)%></span></td>
								<td class="col-sm-2 col-md-2 text-center td_totalPrice"><span style="font-size: 16px">$ </span><span class="itemprice"
									id="totalPrice_p<%=id%>" style="font-size: 16px"><%=new java.text.DecimalFormat("#.00").format(ciTotalPrice)%></span></td>
								<td class="col-sm-1 col-md-1 text-center">
									<button type="button" class="btn btn-danger" onclick="deleteProduct(<%= id %>)"><span style="font-size: 12px"><span
											class="glyphicon glyphicon-remove"></span> Remove
									</span> </button></td>
							</tr>
							<%
								}
							%>
							<tr>
								<td> </td>
								<td> </td>
								<td> </td>
								<td><h4>Subtotal</h4></td>
								<td class="text-right"><span
									style="font-size: 20px; font-family: Times;">$ </span><span
									id="subtotal" style="font-size: 20px; font-family: Times;"><%=new java.text.DecimalFormat("#.00").format(cart.getTotalPrice())%></span>
								</td>
							</tr>
							<tr>
								<td> </td>
								<td> </td>
								<td> </td>
								<td><h4>Estimated shipping</h4></td>
								<%
									if(cart.getTotalPrice() < 50) {
								%>
								<td class="text-right"><span
									style="font-size: 20px; font-family: Times;">$ </span><span
									id="shippingfee" style="font-size: 20px; font-family: Times;">10.00</span>
								</td>
							</tr>
							<tr>
								<td> </td>
								<td> </td>
								<td> </td>
								<td><h3>Total</h3></td>
								<td class="text-right"><h3>
										<span style="font-size: 22px; font-family: Times;">$ </span> <span
											id="total" style="font-size: 22px; font-family: Times;"><%=new java.text.DecimalFormat("#.00").format(cart.getTotalPrice() + 10)%></span>
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
								<td> </td>
								<td><h3>Total</h3></td>
								<td class="text-right"><h3>
										<span style="font-size: 22px; font-family: Times;">$ </span> <span
											id="total" style="font-size: 22px; font-family: Times;"><%=new java.text.DecimalFormat("#.00").format(cart.getTotalPrice())%></span>
									</h3></td>
							</tr>
								<% 
									}
								%>
														
						</tbody>
					</table>
				</form>
				<br>
	
				<div class="row">
					<div class="col-xs-6 col-sm-3 col-sm-offset-6 col-lg-2 col-lg-offset-7">
						<button type="button" onclick="window.history.back()" class="btn btn-default">
								<span class="glyphicon glyphicon-shopping-cart"></span> Continue
								Shopping
							</button>
					</div>
					<div class="col-xs-6 col-sm-3 col-lg-2 col-lg-offset-1">
						<a href="confirm.jsp"><button type="button"
								class="btn btn-success">
								Checkout <span class="glyphicon glyphicon-play"></span>
							</button></a>
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
		function addOne(id, max) {
			var count = $("#count_p" + id);
			var countVal = parseInt(count.val());
			if (countVal < max) {
				count.val(parseInt(count.val()) + 1);
				var unitPrice = $("#unitPrice_p" + id);
				$("#totalPrice_p" + id).text((parseInt(count.val()) * parseFloat(unitPrice.text()) * 100 / 100).toFixed(2));
				updatePrice();
				// update cart
				var url = "cartupdate.jsp";
				var data = {
					"pid" : id,
					"count" : parseInt(count.val())
				};
				var success = function(response) {
					if (response.errno == 0) {
	
					}
				}
				$.post(url, data, success, "json");
			} else {
				alert("The maximum number of this product you are allowed to buy is " + max);
			}
	
	
		}
	
		function minusOne(id, min) {
			var count = $("#count_p" + id);
			if (parseInt(count.val()) > min) {
				count.val(parseInt(count.val()) - 1);
				var unitPrice = $("#unitPrice_p" + id);
				$("#totalPrice_p" + id).text((parseInt(count.val()) * parseFloat(unitPrice.text()) * 100 / 100).toFixed(2));
				updatePrice();
	
				// update cart
				var url = "cartupdate.jsp";
				var data = {
					"pid" : id,
					"count" : parseInt(count.val())
				};
				var success = function(response) {
					if (response.errno == 0) {
	
					}
				}
				$.post(url, data, success, "json");
			}
	
		}
	
		function updatePrice() {
			var subtotalPrice = 0;
			var shippingFee = 0;
			$(".td_totalPrice").each(function() {
				subtotalPrice += parseFloat($(this).find(".itemprice").text()) * 100 / 100;
			});
			$("#subtotal").text(subtotalPrice.toFixed(2));
			if (subtotalPrice >= 50) {
				$("#shippingfee").text(shippingFee.toFixed(2));
				$("#total").text(subtotalPrice.toFixed(2));
			} else {
				shippingFee = 10;
				$("#shippingfee").text(shippingFee.toFixed(2));
				$("#total").text((subtotalPrice + 10).toFixed(2));
			}
		}
		
		function deleteProduct(id) {
			var url = "cartdelete.jsp";
			var data = {
				"pid" : id
			};
			var success = function(response) {
				if (response.errno == 0) {
					$("#tr_p" + id).remove();
					updatePrice();
				}
			}
			$.post(url, data, success, "json");
			location.reload();
		}
	
		/*	
				$(function() {
					
					$('.spinner .btn:first-of-type').on('click', function() {
						var btn = $(this);
						var input = btn.closest('.spinner').find('input');
						if (input.attr('max') == undefined || parseInt(input.val()) < parseInt(input.attr('max'))) {
							var newCount = parseInt(input.val(), 10) + 1;
							input.val(newCount);
					
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
		*/
	</script>

</body>
</html>
