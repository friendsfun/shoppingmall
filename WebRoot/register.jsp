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
  		var usernameExist = false;
    	function checkUsernameExsit() {
    		var usernameField = document.getElementById("userid");
    		var username = usernameField.value;
    		var url = "validate.jsp?username=" + escape(usernameField.value);
    		var xhr = createXmlHttp();
    		xhr.onreadystatechange = function(){
				if(xhr.readyState == 4){
					if(xhr.status == 200){
						document.getElementById("spanMsg").innerHTML = xhr.responseText;
						// alert(typeof xhr.responseText) //string
						var res = xhr.responseText;
						if(res.length == 52) {							
							usernameExist = true;
						} else {
							usernameExist = false;
						}
					}
				}			
			}		
    		
			xhr.open("GET", url, true);
			xhr.send(null);
    	}
    	
    	function createXmlHttp() {
    		var xmlHttp;
    		try { // Firefox, Opera 8.0+, Safari
    			xmlHttp = new XMLHttpRequest();
    		} catch (e) {
    			try { // Internet Explorer
    				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    			} catch (e) {
    				try {
    					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    				} catch (e) {}
    			}
    		} 
    		return xmlHttp;
    	}
    	
function checkdata() {
	var usr = form.username.value.toLowerCase();
	var password = form.password.value;
	var password2 = form.password2.value;
	var phone = form.phone.value;
	var addr = form.addr.value;
	if(!checkUserName(usr)) {
		return false; 
	}
	if(!checkPassword(usr, password, password2)) {
		return false;
	}

	if(!checkPhone(phone)) {
		return false;
	}
	if(!checkAddr(addr)) {
		return false;
	}	
	if(usernameExist) {
		return false;
	}
	return true;
}


function checkPhone(phone) {
	if(phone == "") {
		alert("\Please enter your phone number!")
		form.phone.focus()
		return false;
	}
	return true;
}

function checkAddr(addr) {
	if(addr == "") {
		alert("\Please enter your address!")
		form.addr.focus()
		return false;
	}
	return true;
}


function checkUserName(usr) {
	if (usr.length <3 || usr.length > 18) {
		alert("\Invalid username! The length of the username must be greater than 2 and less than 19.")
		form.username.focus()
		return false;
	}
	if (isWhiteSpace(usr)){
		alert("\Invalid username! Spaces are not allowed in your username.")
		form.username.focus()
		return false;
	}
	if (!isUsrString(usr)){
		alert("Invalid username!\n Only the 26 english characters, digits of 0~9 and the specialcharacters are allowed in username.")
		form.username.focus()
		return false;
	}
	return true;
}

function checkPassword(usr, password, password2) {
	if( strlen(password)<6 || strlen(password)>16 ) {
		alert("\The length of password must be between 6 and 16!")
		form.password.focus()
		return false;
	}
	if( strlen2(password) ) {
		alert("\Invalid characters are used in your password!")
		form.password.focus()
		return false;
	}
	if( password == usr ) {
		alert("\Password can not be the same with username.")
		form.password.focus()
		return false;
	}
	if( password2 =="" ) {
		alert("\Please enter the password again to confirm!")
		form.password2.focus()
		return false;
	}
	if( password2 != password ) {
		alert("\The two passwords are not matched!")
		form.password.focus()
		return false;
	}
	return true;
}

function strlen(str) {
	var len;
	var i;
	len = 0;
	for(i = 0; i < str.length; i++) {
		if(str.charCodeAt(i) > 255) {
			len = len + 2;
		} else {
			len++;
		}
	}
	return len;
}

function strlen2(str) {
	var i;
	for(i = 0; i < str.length; i++) {
		if(str.charCodeAt(i) > 255) {
			return true;
		}
	}
	return false;
}

function isWhiteSpace(s) {
	var whitespace = " \t\n\r";
	var i;
	for(i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if(whitespace.indexOf(c) >= 0) {
			return true;
		}
	}
	return false;
}

function isUsrString(usr) {
	var re = /^[0-9a-z][\w-.]*[0-9a-z]$/i;
	if(re.test(usr)) {
		return true;
	} else {
		return false;
	}
}
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
					<li class="dropdown"><span style="font-size: 16px;"><a href="userprofile.jsp"
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
													<a href="#" tabindex="5" class="forgot-password">Forgot Password?</a>
												</div>
											</div>
										</div>
									</div>
								</form>
								<form name="form" id="register-form" action="register.jsp" method="post" role="form" onSubmit="return checkdata()" style="display: none;">
									<input type="hidden" name="action" value="register">
									<div class="form-group">
										<input type="text" name="username" id="userid" tabindex="1" class="form-control" placeholder="Username" value="" onblur="checkUsernameExsit()">
										<span id="spanMsg" style="color: red; font-size: 16px;"></span>
										
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
 <script>
 	
 </script>
</body>

</html>