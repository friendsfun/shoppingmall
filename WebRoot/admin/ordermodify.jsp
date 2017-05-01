<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.serena.shopping.*"%>
<%@page import="java.sql.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
SalesOrder so = OrderMgr.getInstance().loadById(id);

String action = request.getParameter("action");
if (action != null && action.equals("modify")) {
	int status = Integer.parseInt(request.getParameter("status"));
	so.setStatus(status);
	so.updateStatus();
%>
<script>
alert('Modification Succeeded! Press Ok to go to the order list page.');
window.location.href = 'orderlist.jsp'
</script>
<%
}
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
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
  

    <!-- Custom CSS -->
    <link href="css/productshowdetail.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    

</head>

<body>

<div class="container">
	<center>
	<h4>Order Owner: <%= so.getUser().getUsername() %></h4>
    <h4>Order Detail: </h4>
	</center>
    <div class="row">
        <div class="col-sm-12 col-md-10 col-md-offset-1">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th class="text-center">Product Name</th>                         
                        <th class="text-center">Quantity</th>
                        <th class="text-center">Price</th>
                    </tr>
                </thead>
                <tbody>
              	<%
              	List<SalesItem> items = so.getItems();
              	for(int i = 0; i < items.size(); i++) {
              		SalesItem si = items.get(i);
                    Product p = si.getProduct();  		
              	%>  
                    <tr>
                        <td class="col-sm-2 col-md-2"><%= p.getId() %></td>
                        <td onmouseover="showProductInfo('<%= p.getDescr() %>')" class="col-sm-4 col-md-4" style="text-align: center"><%= p.getName() %></td>
                        <td class="col-sm-2 col-md-2 text-center"><%= si.getCount() %></td>
                        <td class="col-sm-4 col-md-2 text-center"><strong>$<%= Math.round(100 * si.getUnitPrice()) / 100.0 %></strong></td>
                       
                    </tr>
                <%
                }
                %>
                </tbody>
            </table>
        </div>
    </div>
    
   	<form name="form" action="ordermodify.jsp" method="post">
	  	<input type="hidden" name="action" value="modify">
	  	<input type="hidden" name="id" value="<%= id %>">
	  		<select name="status">
	  			<option value="0">To-do Order</option>
	  			<option value="1">Done Order</option>
	  			<option value="2">Invalid Order</option>
	  		</select>
  		<br>
  		<br>
  		<input type="submit" value="Modify">
    </form>
       
</div>

<script type="text/javascript">
	for(var opyion in document.forms("form").status.options) {
		if(option.value = <%= so.getStatus() %>) {
			document.forms("form").status.selectedIndex = option.index;
		}
	}
</script>


</body>
</html>

