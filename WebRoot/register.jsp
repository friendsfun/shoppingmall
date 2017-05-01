<%@ page pageEncoding="UTF-8"%>
<%@page import="com.serena.shopping.*" %>
<%@page import="java.sql.*" %>

<%
User user = (User) session.getAttribute("user");
%>

<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");

Cart cart = (Cart) session.getAttribute("cart");

// register
if(action != null && action.trim().equals("register")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	User u = new User();
	u.setUsername(username);
	u.setPassword(password);
	u.setPhone(phone);
	u.setAddr(addr);
	u.setRdate(new Timestamp(System.currentTimeMillis()));
	u.save2DB();
	//out.println("Congratulations! Registered Successfully.");
	//return;
}

// login
if(action != null && action.trim().equals("login")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	User u = null;
	
	try {
	    u = User.validate(username, password);
	} catch (UserNotFoundException e) {
		out.println("User not Found!");
		return;
	} catch (PasswordNotCorrectException e) {
		out.println("Password not Correct!");
		return;
	} 
	
	session.setAttribute("user", u);
	if(cart == null) {
		response.sendRedirect("index.jsp");
	} else {
		response.sendRedirect("confirm.jsp");
	}
}
%>

<!DOCTYPE html>
<html>

<head>
     <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head 
         content must come *after* these tags -->
    <title> Register Page</title>
        <!-- Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/register-style.css" rel="stylesheet">
    
    <script type="text/javascript">
    <!--
    	var req;
    	function validate() {
    		var idField = document.getElementById("userid");
    		var url = "validate.jsp?id=" + escape(idField.value);
    		if(window.XMLHttpRequest()) {
    			req = new XMLHttpRequest();
    		} else {
    			req = new ActiveXObject("Microsoft.XMLHTTP");
    		}
    		req.onreadystatechange = callback;
    		req.open("GET", url, true); // asynchronous
    		
    		req.send(); 
    		
    	}
    	
    	function callback() {
    		if(req.readyState == 4 && req.status == 200) {
    			var msg = req.responseXML.getElementsByTagName("msg")[0];
    			setMsg(msg.childNodes[0].nodeValue);
    		}
    	}
    	
    	function setMsg(msg) {
    		if(msg == "invalid") {
    			document.getElementById("usermsg").innerHTML = "<font color='red'>this username already exists!</font>";    			
    		}
    	}
    -->
    </script>

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
						if (user == null) {
					%>
					<li><a href="register.jsp"><span style="font-size: 16px;">Sign in / Register</span></a></li>
					<%
						} else {
					%>
					<li class="dropdown"><span style="font-size: 16px;">Hello, <a href="userprofile.jsp"
						class="dropdown-toggle" data-toggle="dropdown" role="button"
						aria-haspopup="true" aria-expanded="false"><%=user.getUsername()%></span>
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
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="#" class="active" id="login-form-link">Login</a>
							</div>
							<div class="col-xs-6">
								<a href="#" id="register-form-link">Register</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="login-form" action="register.jsp" method="post" role="form" style="display: block;">
									<input type="hidden" name="action" value="login" >
									<div class="form-group">
										<input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" value="">
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password">
									</div>
									<div class="form-group text-center">
										<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
										<label for="remember"> Remember Me</label>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Log In">
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-lg-12">
												<div class="text-center">
													<a href="http://phpoll.com/recover" tabindex="5" class="forgot-password">Forgot Password?</a>
												</div>
											</div>
										</div>
									</div>
								</form>
								<form name="form" id="register-form" action="register.jsp" method="post" role="form" onSubmit="return checkdata()" style="display: none;">
									<input type="hidden" name="action" value="register">
									<div class="form-group">
										<input type="text" name="username" id="userid" tabindex="1" class="form-control" placeholder="Username" value="" onblur="validate()">
										<div id="usermsg"></div>
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password" tabindex="1" class="form-control" placeholder="Password" value="">
									</div>
									<div class="form-group">
										<input type="password" name="password2" id="password2" tabindex="2" class="form-control" placeholder="Confirm Password">
									</div>
									<div class="form-group">
										<input type="text" name="phone" id="phone" tabindex="2" class="form-control" placeholder="Phone">
									</div>
									<div class="form-group">
										<textarea name="addr" rows="12" cols="70" placeholder="Address"></textarea>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="Register Now">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
</div>

 <!-- jQuery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

 <!-- Bootstrap Core JavaScript -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="js/registerui.js"></script>
 <script type="text/javascript" src="js/regcheckdata.js"></script>
</body>

</html>