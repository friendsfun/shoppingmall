<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.serena.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
User u = (User) session.getAttribute("user");
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
<!-- css needed for select -->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.5.4/bootstrap-select.min.css"
	rel="stylesheet">
<!--  Font Awesome -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">

<style>
/* Profile container */
.profile {
  margin: 20px 0;
}

/* Profile sidebar */
.profile-sidebar {
  padding: 20px 0 10px 0;
  background: #fff;
}

.profile-userpic img {
  float: none;
  margin: 0 auto;
  width: 50%;
  height: 50%;
  -webkit-border-radius: 50% !important;
  -moz-border-radius: 50% !important;
  border-radius: 50% !important;
}

.profile-usertitle {
  text-align: center;
  margin-top: 20px;
}

.profile-usertitle-name {
  color: #5a7391;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 7px;
}

.profile-usertitle-job {
  text-transform: uppercase;
  color: #5b9bd1;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 15px;
}
    
.profile-usermenu {
  margin-top: 30px;
}

.profile-usermenu ul li {
  border-bottom: 1px solid #f0f4f7;
}

.profile-usermenu ul li:last-child {
  border-bottom: none;
}

.profile-usermenu ul li a {
  color: #93a3b5;
  font-size: 14px;
  font-weight: 400;
}

.profile-usermenu ul li a i {
  margin-right: 8px;
  font-size: 14px;
}

.profile-usermenu ul li a:hover {
  background-color: #fafcfd;
  color: #5b9bd1;
}

.profile-usermenu ul li.active {
  border-bottom: none;
}

.profile-usermenu ul li.active a {
  color: #5b9bd1;
  background-color: #f6f9fb;
  border-left: 2px solid #5b9bd1;
  margin-left: -2px;
}

/* Profile Content */
.profile-content {
  padding: 20px;
  margin-left: 20px;
  background: #fff;
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
				
<div class="container">
    <div class="row profile">
		<div class="col-md-3">
			<div class="profile-sidebar">
				<!-- SIDEBAR USERPIC -->
				<div class="profile-userpic">
					<img src="http://keenthemes.com/preview/metronic/theme/assets/admin/pages/media/profile/profile_user.jpg" class="img-responsive" alt="">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name">
						Marcus Doe
					</div>
					<div class="profile-usertitle-job">
						Developer
					</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->
				
				<!-- SIDEBAR MENU -->
				<div class="profile-usermenu">
					<ul class="nav">
						<li class="active">
							<a href="#bioInfo">
							<i class="glyphicon glyphicon-user"></i>
							Account Information </a>
						</li>
						<li>
							<a href="#myOrder">
							<i class="glyphicon glyphicon-list"></i>
							My Orders </a>
						</li>
		
					</ul>
				</div>
				<!-- END MENU -->
			</div>
		</div>
		<div class="col-md-9">
			<div id="bioInfo" class="profile-content">
            	<p>Hello</p>
            </div>
            <div id="myOrder" class="profile-content">
			   <p>Some user related content goes here...</p>
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
</body>
</html>
