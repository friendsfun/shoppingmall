<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
User u = (User) session.getAttribute("user");
%>

<%!
private static final int PAGE_SIZE = 3;
%>

<%

List<Category> categories = Category.getCategories();

String action = request.getParameter("action");

int pageNo = 1;
int pageCount = 0;
List<Product> products = new ArrayList<Product>();
String keyword = null;
int categoryId = 0;
int[] idArray;

double lowNormalPrice = -1;
double highNormalPrice = -1;
double lowMemberPrice = -1;
double highMemberPrice = -1;
Timestamp startDate;
Timestamp endDate;
String strStartDate = null;
String strEndDate = null;

if(action != null) {
	String strPageNo = request.getParameter("pageno");
	if(strPageNo != null && !strPageNo.trim().equals("")) {
		pageNo = Integer.parseInt(strPageNo);
	}
	keyword = request.getParameter("keyword");
	
	if(action.trim().equals("simplesearch")) {				
		if(categoryId == 0) {
			idArray = null;
		} else {
			idArray = new int[1];
			idArray[0] = categoryId;
		}						
		pageCount = ProductMgr.getInstance().findProducts(products,idArray, keyword, pageNo, PAGE_SIZE);
	}
}	
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

    <!-- Page Content -->
    <div class="container">
		<!-- Showing the products of searching result starting here -->
		<h3 style="font-family: Times;">Show results for "<span style="color:#0099cc;"><%= keyword %></span>"</h3>
		<hr>
		&nbsp;
		<div class="row">		
			<%
			for(Iterator<Product> it = products.iterator(); it.hasNext(); ) {
	    		Product p = it.next();
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
		&nbsp;
		<div class="text-center">
			Page <%= pageNo %> &nbsp;
			Total <%= pageCount %> &nbsp;
			<a href="searchresultshow.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= 1 %>" > First Page</a> &nbsp;
			<% if(pageNo != 1) { %>
			<a href="searchresultshow.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= pageNo -1 %>" > Previous Page</a> &nbsp;
			<% }  %>
			
			<% if(pageNo != pageCount) { %>
			<a href="searchresultshow.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= pageNo + 1 %>" > Next Page</a> &nbsp;
			<% } %>
			<a href="searchresultshow.jsp?action=<%= action%>&keyword=<%= keyword%>&categoryid=<%= categoryId%>&pageno=<%= pageCount %>">Last Page</a>
		</div>
	</div>
		
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

